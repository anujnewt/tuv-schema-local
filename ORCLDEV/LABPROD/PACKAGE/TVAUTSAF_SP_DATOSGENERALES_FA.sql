create or replace procedure labprod.tvautsaf_sp_datosgenerales_fa (recurp labprod.nmcoempl.emp_recurp%type, keyemp labprod.nmcoempl.emp_keyemp%type, nomemp labprod.nmcoempl.emp_nomemp%type, keypro labprod.nmcoempl.emp_keypro%type, cveban labprod.nmcoempl.emp_cveban%type, fecaux labprod.nmcoempl.emp_fecaux%type, domemp labprod.nmcoempl.emp_domemp%type, colemp labprod.nmcoempl.emp_colemp%type, munemp labprod.nmcoempl.emp_munemp%type, entemp labprod.nmcoempl.emp_entemp%type, codemp labprod.nmcoempl.emp_codemp%type, telemp labprod.nmcoempl.emp_telemp%type, cidemp labprod.nmcoempl.emp_cidemp%type, salmes labprod.nmcoempl.emp_salmes%type, keyloc labprod.nmcoempl.emp_keyloc%type, forpag labprod.nmcoempl.emp_forpag%type, ca2aux labprod.nmcoempl.emp_ca2aux%type, status labprod.nmcoempl.emp_status%type, ca4aux labprod.nmcoempl.emp_ca4aux%type) as $body$
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
