create or replace procedure usrdrc.pendium_ejercicio_social_pkg_update_ejercicio ( param_id_ejercicio_row numeric, param_ejercicio varchar, param_no_documentum varchar, param_fecha_documentum varchar, param_fecha_entrega varchar, param_id_user numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update
pendium_ejercicio_social_tab
set
tipo_document    =   param_ejercicio,
no_documentum       =   param_no_documentum,
fecha_documentum    =   param_fecha_documentum,
fecha_entrega       =   param_fecha_entrega,
num_last_updated_by =   param_id_user,
fec_last_update_date=   clock_timestamp()
where id_ejercicio_row  =   param_id_ejercicio_row
;end;
$body$
language plpgsql
;
