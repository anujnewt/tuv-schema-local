create or replace procedure usrdrc.dercorp_poderes_pkg_query_apoderado_ep_pr (porcrsresultado inout refcursor ,pinid_opoder_ep numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select *
from pendium_apoderado_ep_tab
where id_opoder_ep_fk =  pinid_opoder_ep
and   ind_status in ( 1,2)
and   desc_tipoapoderado!='MANCOMUNADO'
order by  id_apod_ep_pk;end;
$body$
language plpgsql
;
create or replace procedure usrdrc.dercorp_poderes_pkg_query_apoderado_ep_pr (porcrsresultado inout refcursor ,pinind_sonmancomunados numeric ,pinid_opoder_ep numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if pinind_sonmancomunados = 1 then
open porcrsresultado for
select
id_empl_fk as id
,desc_nom_empl as value
,pendium_apoderado_ep_tab.*
from pendium_apoderado_ep_tab
where id_grupo_fk =  pinid_opoder_ep
and   ind_status in (1,2)
and   desc_tipoapoderado = 'MANCOMUNADO'
order by  desc_nom_empl;
else
open porcrsresultado for
select *
from pendium_apoderado_ep_tab
where id_opoder_ep_fk =  pinid_opoder_ep
and   ind_status in ( 1,2)
and   desc_tipoapoderado!='MANCOMUNADO'
order by  id_apod_ep_pk;
end if;end;
$body$
language plpgsql
;
