create or replace procedure usrdrc.pendium_agregar_otros_pkg_delete_all_temp (param_id_empresa numeric) as $body$
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
id_empresa = param_id_empresa
and
nullif(id_meta_row::text, '') is null
;end;
$body$
language plpgsql
;
