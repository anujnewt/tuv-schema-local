create or replace procedure labprod.tvautsaf_sp_amortizaciones (keyper labprod.nmloamor.amo_keyper%type, keypro labprod.nmloamor.amo_keypro%type) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
total_temp integer;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVAUTSAF');
--dmap conversion comment: gtt declaration added
call tvautsaf_local_sp_amortizaciones(keyper, keypro);end;
$body$
language plpgsql
;
