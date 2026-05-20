create or replace procedure usrdrc.dercorp_flextab_pkg_post_save_pr (param_id_empresa varchar ,param_id_flex_tab varchar ,piinidmetarow numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linidrow       numeric;
lstpreescrt    varchar(3000);
lstescrt       varchar(3000);
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
-- estructura de capital social
if param_id_flex_tab = 7 then
call xxtv_capital_soc_pkg_recalcular_estructura_cs_pr(param_id_empresa
,piinidmetarow
);
--ecm 02 septiembre 2015
insert into dercorp_add_campo_valor_tab(
id_add_campo
,id_empresa
,val_valor
)
select  1033,param_id_empresa,to_char(clock_timestamp(),'MM/DD/RRRR')
where   1=1
and
not exists (
select  1
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo  = 1033
and     id_empresa    = param_id_empresa
)
;
--ecm 03 septiembre 2015 jjaq se comenta porque no quieren que se actualize la fecha por si solo
/* update  dercorp_add_campo_valor_tab
set     val_valor = to_char(sysdate,dd/mm/rrrr)
where   1=1
and     id_add_campo  = 1033
and     id_empresa    = param_id_empresa
;*/
end if;/* dmap converted statement start */
--icl 26012016 poderes generales y especiales
if ((param_id_flex_tab = 17) or (param_id_flex_tab = 18))  then
for i in (select *
from   dercorp_metatbl_tab
where  id_empresa    = param_id_empresa
and    id_flex_tbl   = param_id_flex_tab)
loop
if ((nullif(i.val_c8::text, '') is not null) or (i.val_c8 = not null)) then
update dercorp_apoderados_tab
set    des_escritura = i.val_c8
where  id_empresa    = param_id_empresa
and    trim(both des_escritura) =trim(  concat((select val_cat_val from dercorp_add_campo_cat_val_tab where id_catalogo_valor = i.val_c1), '-', coalesce(i.val_c3,'SF'))) ;/* dmap converted statement end */
end if;
end loop;
/* commit; */
end if;
--if param_id_flex_tab
/*
if( ( lrcdmetainfo.val_c86 is null)
or ( lrcdmetainfo.val_c86 = )
or ( lrcdmetainfo.val_c86 = 0)) then  -- escritura
update dercorp_metatbl_tab set val_c86 = n/a
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
*/
/*(param_id_empresa varchar2
,param_id_flex_tab varchar2
,piinidmetarow    number
if((value.equals()||value.equals( )) && (
(flextabid.equals(17) && (param.equals(val_c9) || param.equals(val_c5)) ) ||
(flextabid.equals(18) && (param.equals(val_c9) || param.equals(val_c5)) ) ||
(flextabid.equals(23) && (param.equals(val_107)|| param.equals(val_c107)) ) ||
(param.equals(val_c87)) ||
(param.equals(val_c82))
)){
value = n/a;
}
*/
--
-- requiere rppc
--
update dercorp_metatbl_tab set val_c5 = 'N/A'
where
trim(both val_c5) in ('','No')
and
id_empresa   = param_id_empresa
and    id_flex_tbl  = param_id_flex_tab
and    id_flex_tbl  in (17,18) -- todas las flex de histcorp en donde rppc sea val_c5
and    id_meta_row  = piinidmetarow;
--
-- requiere rppc
--
update dercorp_metatbl_tab set val_c102 = 'N/A'
where
trim(both val_c102) in ('','No')
and
id_empresa   = param_id_empresa
and    id_flex_tbl  = param_id_flex_tab
and    id_flex_tbl  in (23) -- todas las flex de histcorp en donde rppc sea val_c102
and    id_meta_row  = piinidmetarow;
--
-- requiere rppc
--
update dercorp_metatbl_tab set val_c82 = 'N/A'
where
trim(both val_c82) in ('','No')
and
id_empresa   = param_id_empresa
and    id_flex_tbl  = param_id_flex_tab
and    id_flex_tbl  in (20,21,22,27,28,29,30,31,32,33,34,35,41) -- todas las flex de histcorp en donde rppc sea val_c82
and    id_meta_row  = piinidmetarow;
--
-- fecha escritura
--
update dercorp_metatbl_tab set
val_c87 = 'N/A'
where (val_c81 = 'No' or val_c81='N/A')
and (trim(both val_c87) = null or (nullif(val_c87::text, '') is null) or (val_c87='Pendiente'))
and
id_empresa   = param_id_empresa
and    id_flex_tbl  = param_id_flex_tab
and    id_flex_tbl  in (20,21,22,27,28,29,30,31,32,33,34,35,41) -- todas las flex de histcorp en donde fecha escritura sea val_c87
and    id_meta_row  = piinidmetarow;
--setear pendiente cuando este chequeado requiere protocolizacion
update dercorp_metatbl_tab set
val_c87 = 'Pendiente'
where (val_c81 = 'Si')
and (trim(both val_c87) = null or (nullif(val_c87::text, '') is null) or (val_c87='N/A'))
and
id_empresa   = param_id_empresa
and    id_flex_tbl  = param_id_flex_tab
and    id_flex_tbl  in (20,21,22,27,28,29,30,31,32,33,34,35,41) -- todas las flex de histcorp en donde fecha escritura sea val_c87
and    id_meta_row  = piinidmetarow;
--
-- fecha escritura
--
update dercorp_metatbl_tab set
val_c9 = 'N/A'
where (trim(both val_c9) = null or (nullif(val_c9::text, '') is null))
and
id_empresa   = param_id_empresa
and    id_flex_tbl  = param_id_flex_tab
and    id_flex_tbl  in (17,18) -- todas las flex de histcorp en donde fecha escritura sea val_c9
and    id_meta_row  = piinidmetarow;
--
-- fecha escritura
--
update dercorp_metatbl_tab set
val_c107 = 'N/A'
where (val_c101 = 'No' or val_c101='N/A')
and (trim(both val_c107) = null or (nullif(val_c107::text, '') is null) or (val_c107='Pendiente'))
and
id_empresa   = param_id_empresa
and    id_flex_tbl  = param_id_flex_tab
and    id_flex_tbl  in (23) -- todas las flex de histcorp en donde fecha escritura sea val_c107
and    id_meta_row  = piinidmetarow;
--setear pendiente cuando este chequeado requiere protocolizacion
update dercorp_metatbl_tab set
val_c107 = 'Pendiente'
where (val_c101 = 'Si')
and (trim(both val_c107) = null or (nullif(val_c107::text, '') is null) or (val_c107='N/A'))
and
id_empresa   = param_id_empresa
and    id_flex_tbl  = param_id_flex_tab
and    id_flex_tbl  in (23) -- todas las flex de histcorp en donde fecha escritura sea val_c107
and    id_meta_row  = piinidmetarow;end;
$body$
language plpgsql
;
