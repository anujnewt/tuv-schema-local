create or replace procedure usrdrc.pendium_reportes_poderes_pkg_query_esc_por_emp_anio_pr (pinid_empresa numeric ,pinanio numeric ,porcrsresultado inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open   porcrsresultado for
select * from (
select des_escritura,ind_tipo_escritura,fec_fecha,val_cat_val
from pendium_escritura_poder_tab inner join dercorp_add_campo_cat_val_tab
on ind_delegado_por=id_catalogo_valor
where id_empresa=pinid_empresa and extract(year from to_timestamp(fec_fecha))=pinanio
and val_cat_val!='Apoderado'
and ind_status=1
and ind_tipo_escritura in ('PG')
and (case pendium_escritura_poder_tab.ind_tipo_escritura when 'ER' then 1
else (select count(distinct esc.ind_tipo_escritura) from pendium_escritura_poder_tab esc inner join pendium_otorgapoder_ep_tab pod
on esc.id_ep_pk = pod.id_ep_fk
where esc.des_escritura = pendium_escritura_poder_tab.des_escritura
and esc.id_empresa=pendium_escritura_poder_tab.id_empresa group by esc.id_empresa)end)=2
union all
select des_escritura,ind_tipo_escritura,fec_fecha,val_cat_val
from pendium_escritura_poder_tab inner join dercorp_add_campo_cat_val_tab
on ind_delegado_por=id_catalogo_valor
where id_empresa=pinid_empresa and extract(year from to_timestamp(fec_fecha))=pinanio
and val_cat_val!='Apoderado'
and ind_status=1
and ind_tipo_escritura in ('PG','PE','ER')
and (case pendium_escritura_poder_tab.ind_tipo_escritura when 'ER' then 1
else (select count(distinct esc.ind_tipo_escritura) from pendium_escritura_poder_tab esc inner join pendium_otorgapoder_ep_tab pod
on esc.id_ep_pk = pod.id_ep_fk
where esc.des_escritura = pendium_escritura_poder_tab.des_escritura
and esc.id_empresa=pendium_escritura_poder_tab.id_empresa group by esc.id_empresa)end)=1
) alias12  order by  to_timestamp(fec_fecha) desc,ind_tipo_escritura desc;end;
$body$
language plpgsql
;
