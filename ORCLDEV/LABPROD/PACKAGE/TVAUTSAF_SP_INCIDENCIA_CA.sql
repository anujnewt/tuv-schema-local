create or replace procedure labprod.tvautsaf_sp_incidencia_ca ( wn_key_emp numeric, ws_cve_ref varchar, wn_tot_sol numeric, wn_imp_des numeric, gn_fec_ini varchar, wn_imp_sal numeric, wn_uni_pre numeric, wn_uni_des numeric, wn_uni_sal numeric, ws_key_con varchar, ws_per_saf varchar, wn_res_pue inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
total_temp integer;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVAUTSAF');
--dmap conversion comment: gtt declaration added
--busca el empleado en tvnomdes
select count(*) into strict total_temp from glcopams where pam_keypar = 'SEPB' and pam_cvesec = (select emp_keypro from nmcoempl where emp_keyemp = wn_key_emp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVAUTSAF', 'TOTAL', 'integer',(total_temp)::text, 'N');
if (dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVAUTSAF', 'TOTAL', 'integer', 'N')::integer < 1) then
call tvautsaf_local_sp_incidencia_ca(wn_key_emp, ws_cve_ref, wn_tot_sol, wn_imp_des, gn_fec_ini, wn_imp_sal, wn_uni_pre, wn_uni_des, wn_uni_sal, ws_key_con, ws_per_saf, wn_res_pue);
/*
apsi 231017
else
call tvautsaf_local_sp_incidencia_ca()__rtelecom (wn_key_emp, ws_cve_ref, wn_tot_sol, wn_imp_des, gn_fec_ini, wn_imp_sal, wn_uni_pre, wn_uni_des, wn_uni_sal, ws_key_con, ws_per_saf, wn_res_pue);
*/
end if;end;
$body$
language plpgsql
;
