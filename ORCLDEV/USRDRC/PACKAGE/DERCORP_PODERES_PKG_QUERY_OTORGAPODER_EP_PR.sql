create or replace procedure usrdrc.dercorp_poderes_pkg_query_otorgapoder_ep_pr (porcrsresultado inout refcursor ,pinid_ep_fk numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select
null as "apoderados"
,null as "facultades"
,null as "mancomunados"
,id_opoder_ep_pk
,id_ep_fk
,num_podertipo
,des_podertipo
,num_vigenciatipo
,des_vigenciatipo
,num_vigenciatiempo
,fec_vigenciainicio
,fec_vigenciafin
,desc_caracteristicas
,desc_actosdominio
,desc_actosadmon
,desc_pleitoscobranza
,desc_revocados
,num_created_by
,fec_creation_date
,num_last_updated_by
,fec_last_update_date
,num_last_update_login
,atributo1
,atributo2
,atributo3
,atributo4
,atributo5
,atributo6
,atributo7
,atributo8
,atributo9
,atributo10
,atributo11
,atributo12
,atributo13
,atributo14
,atributo15
,attribute_category
,num_order
,desc_tituloscredito
,desc_vigencia
,ind_status
,desc_descripcion
,des_poder
,desc_apoderados
from pendium_otorgapoder_ep_tab
where
id_ep_fk  = pinid_ep_fk and
ind_status = 1
order by  num_order;end;
$body$
language plpgsql
;
