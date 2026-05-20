create or replace procedure usrdrc.dercorp_reportflex_pkg_delete_row_pr (idrow integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from dercorp_reportflex_s_row_tab
where
id_seccion_row = idrow;
delete from dercorp_reportflex_campo_tab
where
id_seccion_row = idrow;end;
$body$
language plpgsql
;
