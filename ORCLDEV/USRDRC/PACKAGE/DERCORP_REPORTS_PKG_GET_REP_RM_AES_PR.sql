create or replace procedure usrdrc.dercorp_reports_pkg_get_rep_rm_aes_pr (lstejerciciosocial varchar ,linumbercreateby numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
meta_rep_rf_aes_cur cursor for
select   meta.id_empresa,
( select  distinct(bus.denom_actual)
from    dercorp_busqueda_view bus
where   1=1
and     nullif(bus.denom_actual::text, '') is not null
and     bus.id_clasificacion in (462,466)
and     bus.id_pais = 624
and     bus.id_empresa = meta.id_empresa
)as denom_actual,
meta.val_c51 as fec_dictamen_fiscal,
meta.val_c46 as fec_dic_finan,
meta.val_c41 as fec_inf_comi,
meta.val_c88 as fec_constancia,
meta.val_c36 as fec_anual,
meta.val_c5  as ejerciciosocial
from dercorp_metatbl_tab meta
where 1=1
and   id_flex_tbl = 23
and   id_empresa in (
select  distinct id_empresa
from dercorp_busqueda_view
where nullif(denom_actual::text, '') is not null
and id_clasificacion in (462,466)
and id_pais = 624
)
and (meta.val_c5 like '%'||lstejerciciosocial||'%'
or nullif(meta.val_c5::text, '') is null
)
/*
union all
select es.id_empresa,
( select  distinct(bus.denom_actual)
from    dercorp_busqueda_view bus
where   1=1
and     bus.denom_actual is not null
and     bus.id_clasificacion in (462,466)
and     bus.id_pais = 624
and     bus.id_empresa = es.id_empresa
)as denom_actual,
to_char(es.fecha_entrega) as fec_dictamen_fiscal,
null as fec_dic_finan,
null as fec_inf_comi,
null as fec_constancia,
null as fec_anual,
null  as ejerciciosocial
from pendium_ejercicio_social_tab es
where 1=1--id_empresa = 776--id_meta_row = 11441
and ejercicio_social = lstejerciciosocial
and tipo_document = df
union all
select es.id_empresa,
( select  distinct(bus.denom_actual)
from    dercorp_busqueda_view bus
where   1=1
and     bus.denom_actual is not null
and     bus.id_clasificacion in (462,466)
and     bus.id_pais = 624
and     bus.id_empresa = es.id_empresa
)as denom_actual,
null as fec_dictamen_fiscal,
to_char(es.fecha_entrega) as fec_dic_finan,
null as fec_inf_comi,
null as fec_constancia,
null as fec_anual,
null  as ejerciciosocial
from pendium_ejercicio_social_tab es
where 1=1--id_empresa = 776--id_meta_row = 11441
and ejercicio_social = lstejerciciosocial
and tipo_document = def
union all
select es.id_empresa,
( select  distinct(bus.denom_actual)
from    dercorp_busqueda_view bus
where   1=1
and     bus.denom_actual is not null
and     bus.id_clasificacion in (462,466)
and     bus.id_pais = 624
and     bus.id_empresa = es.id_empresa
)as denom_actual,
null as fec_dictamen_fiscal,
null as fec_dic_finan,
to_char(es.fecha_entrega) as fec_inf_comi,
null as fec_constancia,
null as fec_anual,
null  as ejerciciosocial
from pendium_ejercicio_social_tab es
where 1=1--id_empresa = 776--id_meta_row = 11441
and ejercicio_social = lstejerciciosocial
and tipo_document = infcom
union all
select es.id_empresa,
( select  distinct(bus.denom_actual)
from    dercorp_busqueda_view bus
where   1=1
and     bus.denom_actual is not null
and     bus.id_clasificacion in (462,466)
and     bus.id_pais = 624
and     bus.id_empresa = es.id_empresa
)as denom_actual,
null as fec_dictamen_fiscal,
null as fec_dic_finan,
null as fec_inf_comi,
null as fec_constancia,
to_char(es.fecha_entrega) as fec_anual,
null  as ejerciciosocial
from pendium_ejercicio_social_tab es
where 1=1--id_empresa = 776--id_meta_row = 11441
and ejercicio_social = lstejerciciosocial
and tipo_document = solicitud
*/
order by denom_actual
;
empresas_restantes_cur cursor for
select  distinct bus.id_empresa, bus.denom_actual
from    dercorp_busqueda_view bus
where   nullif(denom_actual::text, '') is not null
and     id_clasificacion in (462,466)
and     id_pais = 624
and     not exists (select   meta.id_empresa
from dercorp_metatbl_tab meta
where 1=1
and   meta.id_flex_tbl = 23
and   meta.id_empresa = bus.id_empresa
and (meta.val_c5 like '%'||lstejerciciosocial||'%'
or nullif(meta.val_c5::text, '') is null
)
)
;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from usrdrc.pendium_rep_rm_aes_tmp;
begin
for i in meta_rep_rf_aes_cur
loop
insert into usrdrc.pendium_rep_rm_aes_tmp( id_empresa
,denom_actual
,fec_dictamen_fiscal
,fec_dic_finan
,fec_inf_comi
,fec_constancia
,fec_anual
,ejerciciosocial
,num_created_by
,fec_creation_date
)values (
i.id_empresa
,i.denom_actual
,i.fec_dictamen_fiscal
,i.fec_dic_finan
,i.fec_inf_comi
,i.fec_constancia
,i.fec_anual
,i.ejerciciosocial
,linumbercreateby
,clock_timestamp()
);
end loop;
/* commit; */
exception
when no_data_found then
perform dbms_output.put_line('NO_DATA_FOUND');
end;
begin
for i in empresas_restantes_cur
loop
insert into usrdrc.pendium_rep_rm_aes_tmp( id_empresa
,denom_actual
,num_created_by
,fec_creation_date
)values (
i.id_empresa
,i.denom_actual
,linumbercreateby
,clock_timestamp()
);
end loop;
/* commit; */
exception
when no_data_found then
perform dbms_output.put_line('NO_DATA_FOUND');
end;
exception
when others then
rollback;end;
$body$
language plpgsql
;
