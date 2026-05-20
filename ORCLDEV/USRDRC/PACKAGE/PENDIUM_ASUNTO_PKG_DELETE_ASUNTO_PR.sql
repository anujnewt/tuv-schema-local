create or replace procedure usrdrc.pendium_asunto_pkg_delete_asunto_pr (param_id_asunto_row numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete
from
pendium_asunto_tab
where
id_asunto_row = param_id_asunto_row;end;
$body$
language plpgsql
;
