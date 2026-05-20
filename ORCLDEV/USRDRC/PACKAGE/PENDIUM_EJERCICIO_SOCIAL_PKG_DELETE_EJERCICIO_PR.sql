create or replace procedure usrdrc.pendium_ejercicio_social_pkg_delete_ejercicio_pr (param_id_ejercicio_row numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete
from
pendium_ejercicio_social_tab
where
id_ejercicio_row=param_id_ejercicio_row
;end;
$body$
language plpgsql
;
