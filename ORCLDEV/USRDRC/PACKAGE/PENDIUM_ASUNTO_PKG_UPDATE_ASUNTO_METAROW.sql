create or replace procedure usrdrc.pendium_asunto_pkg_update_asunto_metarow ( param_id_meta_row numeric, param_id_empresa numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update
pendium_asunto_tab
set
id_meta_row         = param_id_meta_row
where
id_empresa          = param_id_empresa
and
nullif(id_meta_row::text, '') is null;end;
$body$
language plpgsql
;
