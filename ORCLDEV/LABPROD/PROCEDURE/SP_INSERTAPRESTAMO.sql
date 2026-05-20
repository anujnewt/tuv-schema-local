create or replace procedure labprod."sp_insertaprestamo"  (ws_rec_urp varchar, wn_tot_sol numeric, wn_imp_des numeric, wn_tot_int numeric, wn_int_des numeric, ws_cve_cli varchar, ws_cve_ref varchar, ws_key_con varchar, wn_res_pue inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
total numeric;
base varchar(10);
begin
--busca el empleado en tvnomdes
base := labprod.fn_basedatos_curp(ws_rec_urp);
if base = 'TVNOMINA' then
call labprod.sp_insertaprestamo_local (ws_rec_urp, wn_tot_sol, wn_imp_des, wn_tot_int, wn_int_des, ws_cve_cli, ws_cve_ref, ws_key_con, wn_res_pue);
/*
apsi 231017
else
sp_insertaprestamo_local__rtelecom (ws_rec_urp, wn_tot_sol, wn_imp_des, wn_tot_int, wn_int_des, ws_cve_cli, ws_cve_ref, ws_key_con, wn_res_pue);
*/
end if;end;
$body$
language plpgsql
;
