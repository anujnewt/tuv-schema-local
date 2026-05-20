create or replace procedure labprod.tvautsaf_local_bitacora_incidencia (inc tvautsaf_local_tipo_incidencia, resultado numeric, periodo varchar, proceso numeric, tipo numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
total_temp integer;
banco_temp varchar;
bandera_temp integer;
nombre__temp varchar;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVAUTSAF_LOCAL');
--dmap conversion comment: gtt declaration added
select count(*) into strict total_temp from labprod.tvincsaf
where inc_cveref = inc.ws_cve_ref
and inc_keyemp = inc.wn_key_emp
and inc_persaf = inc.ws_per_saf
and inc_perlab = periodo
and inc_keycon = inc.ws_key_con;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVAUTSAF_LOCAL', 'TOTAL', 'integer',(total_temp)::text, 'N');
begin
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVAUTSAF_LOCAL', 'TOTAL', 'integer', 'N')::integer = 0 then
insert into labprod.tvincsaf values (inc.wn_key_emp, inc.ws_cve_ref, inc.wn_tot_sol, inc.wn_imp_des, inc.gn_fec_ini,
inc.wn_imp_sal, inc.wn_uni_pre, inc.wn_uni_des, inc.wn_uni_sal, inc.ws_key_con,
inc.ws_per_saf, resultado, periodo, proceso, tipo, clock_timestamp());
else
update labprod.tvincsaf set
inc_totsol = inc.wn_tot_sol, inc_impdes = inc.wn_imp_des, inc_impsal = inc.wn_imp_sal,
inc_unipre = inc.wn_uni_pre, inc_unides = inc.wn_uni_des, inc_unisal = inc.wn_uni_sal
where inc_cveref = inc.ws_cve_ref
and inc_keyemp = inc.wn_key_emp
and inc_perlab = periodo
and inc_keycon = inc.ws_key_con;
end if;
exception
when others then
null; return;
end;end;
$body$
language plpgsql
;
