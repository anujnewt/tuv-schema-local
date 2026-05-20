create or replace procedure usrdrc.dercorp_poderes_pkg_query_facultades_ep_pr (porcrsresultado inout refcursor ,pinid_opoder_ep_fk numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select
null as "listmancomunados"
,pendium_facultades_ep_tab.*
from pendium_facultades_ep_tab
where id_opoder_ep_fk  =  pinid_opoder_ep_fk
and   ind_status       =  1
order by  id_fac_ep_pk;end;
$body$
language plpgsql
;
