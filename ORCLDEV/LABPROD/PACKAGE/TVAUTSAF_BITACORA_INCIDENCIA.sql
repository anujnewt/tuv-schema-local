create or replace procedure labprod.tvautsaf_bitacora_incidencia (inc tvautsaf_tipo_incidencia, resultado numeric, periodo varchar, proceso numeric, tipo numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
total_temp integer;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVAUTSAF');
--dmap conversion comment: gtt declaration added
return;end;
$body$
language plpgsql
;
