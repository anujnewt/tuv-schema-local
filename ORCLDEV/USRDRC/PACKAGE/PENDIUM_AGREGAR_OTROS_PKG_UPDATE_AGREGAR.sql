create or replace procedure usrdrc.pendium_agregar_otros_pkg_update_agregar ( param_id_agregar_row numeric, param_agregar varchar, param_id_agregar varchar, param_id_user numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update
pendium_agregar_tab
set
agregar              =   param_agregar,
id_agregar           =   param_id_agregar,
num_last_updated_by =   param_id_user,
fec_last_update_date=   clock_timestamp()
where id_agregar_row  =   param_id_agregar_row;end;
$body$
language plpgsql
;
