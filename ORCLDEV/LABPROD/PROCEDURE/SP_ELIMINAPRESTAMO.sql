create or replace procedure labprod."sp_eliminaprestamo"  (ws_rec_urp varchar, ws_cve_ref varchar, ws_key_con varchar, wn_res_pue inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
total numeric;
base varchar(10);
begin
--busca el empleado en tvnomdes
base := labprod.fn_basedatos_curp(ws_rec_urp);
if base = 'TVNOMINA' then
call labprod.sp_eliminaprestamo_local (ws_rec_urp, ws_cve_ref, ws_key_con, wn_res_pue);
/*
apsi 231017
else
sp_eliminaprestamo_local__rtelecom (ws_rec_urp, ws_cve_ref, ws_key_con, wn_res_pue);
*/
end if;end;
$body$
language plpgsql
;
