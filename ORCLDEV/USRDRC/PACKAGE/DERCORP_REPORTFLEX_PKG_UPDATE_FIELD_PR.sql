create or replace procedure usrdrc.dercorp_reportflex_pkg_update_field_pr (reportflexfieldid integer, appflexfieldif integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update dercorp_reportflex_campo_tab set
id_add_campo = appflexfieldif
where
id_campo = reportflexfieldid;end;
$body$
language plpgsql
;
