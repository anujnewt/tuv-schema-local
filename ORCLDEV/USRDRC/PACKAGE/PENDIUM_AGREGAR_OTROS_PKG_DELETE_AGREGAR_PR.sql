create or replace procedure usrdrc.pendium_agregar_otros_pkg_delete_agregar_pr (param_id_agregar_row numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete
from
pendium_agregar_tab
where
id_agregar_row = param_id_agregar_row;end;
$body$
language plpgsql
;
