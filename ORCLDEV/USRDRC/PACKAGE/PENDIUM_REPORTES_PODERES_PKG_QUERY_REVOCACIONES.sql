create or replace procedure usrdrc.pendium_reportes_poderes_pkg_query_revocaciones (porcrsresultado inout refcursor ,pstin_id_opoder_fk varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select pendium_otorgapoder_ep_tab.id_opoder_ep_pk,
pendium_apoderado_ep_tab.desc_nom_empl,
pendium_apoderado_ep_tab.desc_revoca
from   pendium_apoderado_ep_tab
inner join pendium_otorgapoder_ep_tab
on pendium_otorgapoder_ep_tab.id_opoder_ep_pk = pendium_apoderado_ep_tab.id_opoder_ep_fk
where pendium_otorgapoder_ep_tab.ind_status = 1 and pendium_apoderado_ep_tab.ind_status=2
and pendium_otorgapoder_ep_tab.id_opoder_ep_pk = pstin_id_opoder_fk
order by  (pendium_apoderado_ep_tab.ind_aprevoca)::numeric;end;
$body$
language plpgsql
;
create or replace procedure usrdrc.pendium_reportes_poderes_pkg_query_revocaciones (porcrsresultado inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select pendium_otorgapoder_ep_tab.id_opoder_ep_pk,
pendium_apoderado_ep_tab.desc_nom_empl,
pendium_apoderado_ep_tab.desc_revoca
from   pendium_apoderado_ep_tab
inner join pendium_otorgapoder_ep_tab
on pendium_otorgapoder_ep_tab.id_opoder_ep_pk = pendium_apoderado_ep_tab.id_opoder_ep_fk
where pendium_otorgapoder_ep_tab.ind_status = 1 and pendium_apoderado_ep_tab.ind_status=2
order by   (pendium_apoderado_ep_tab.ind_aprevoca)::numeric;end;
$body$
language plpgsql
;
