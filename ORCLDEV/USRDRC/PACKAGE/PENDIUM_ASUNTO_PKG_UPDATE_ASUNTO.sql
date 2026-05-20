create or replace procedure usrdrc.pendium_asunto_pkg_update_asunto ( param_id_asunto_row numeric, param_asunto varchar, param_id_asunto varchar, param_id_user numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update
pendium_asunto_tab
set
asunto              =   param_asunto,
id_asunto           =   param_id_asunto,
num_last_updated_by =   param_id_user,
fec_last_update_date=   clock_timestamp()
where id_asunto_row  =   param_id_asunto_row;end;
$body$
language plpgsql
;
