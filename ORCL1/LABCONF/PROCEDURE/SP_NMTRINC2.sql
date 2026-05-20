create or replace procedure labconf."sp_nmtrinc2"  ( wn_key_pro numeric, ws_per_fue varchar, wn_per_cer numeric, ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_per_des varchar, wn_rev_ers numeric, wn_key_inc numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- variables para obtener los datos de la tabla de movimientos o hismov
wn_cve_emp numeric(10);
ws_cve_con char(3);
wn_cve_pro numeric(5);
wn_cve_nom numeric(5);
ws_cve_dep char(16);
ws_cve_pue char(16);
wn_can_tid decimal(16,2);
wn_imp_ort decimal(16,2);
ws_fec_mov timestamp(0);
ws_cve_per char(7);
-- variables para obtener los conceptos en glwkcrys
ws_con_fue char(3);
ws_con_des char(3);
-- variables auxiliares
wn_cer_o   numeric(5)  := 0;
wn_reg_ins numeric(10) := 0;
wn_con_reg numeric(3)  := 0;
wn_lim_ite numeric(3)  := 100;
wn_inc_loc decimal(16,6);
wn_con_inc  decimal(16,6);
wn_num_sec numeric(5) := 0;
c_hismov record;
c_movtos record;
begin
wn_inc_loc := 0.0;
wn_con_inc := wn_key_inc;
-- si el periodo esta cerrado utiliza nmlohism
if wn_per_cer = 1 then
for c_hismov in ( select his_keyemp, his_keycon, his_keypro, his_keydep, his_keypue,
his_cantid, his_import, his_fecmov, his_keyper,his_keynom
from nmlohism
where his_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keyemp::text, '') is not null)
and his_keypro = wn_key_pro and his_keyper = ws_per_fue ) loop
wn_cve_emp := c_hismov.his_keyemp;
ws_cve_con := c_hismov.his_keycon;
wn_cve_pro := c_hismov.his_keypro;
ws_cve_dep := c_hismov.his_keydep;
ws_cve_pue := c_hismov.his_keypue;
wn_can_tid := c_hismov.his_cantid;
wn_imp_ort := c_hismov.his_import;
ws_fec_mov := c_hismov.his_fecmov;
ws_cve_per := c_hismov.his_keyper;
wn_cve_nom := c_hismov.his_keynom;
-- si la bandera indica reversion se multiplica la cantidad
-- y el importe por -1
if wn_rev_ers = 1 then
wn_can_tid := wn_can_tid * -1;
wn_imp_ort := wn_imp_ort * -1;
end if;
wn_num_sec := wn_num_sec + 1;
call sp_nmkeyinc (wn_key_inc,ws_cve_con,wn_cve_pro,wn_cve_nom,ws_per_des,wn_cve_emp,wn_num_sec,wn_inc_loc);
-- inserta en la tabla de incidencias
insert into nmcoinci(inc_keyemp, inc_keycon, inc_keypro, inc_keyper, inc_keydep, inc_keypue,
inc_fecmov, inc_cantid, inc_import, inc_diauno, inc_diados, inc_diatre,
inc_diacua, inc_diacin, inc_diasei, inc_diasie, inc_keyinc, inc_numfol)
values (wn_cve_emp, ws_cve_con, wn_cve_pro, ws_per_des, ws_cve_dep, ws_cve_pue,
ws_fec_mov, wn_can_tid, wn_imp_ort, wn_cer_o,   wn_cer_o,   wn_cer_o,
wn_cer_o,   wn_cer_o,   wn_cer_o,   wn_cer_o,   wn_inc_loc,   wn_cer_o );
wn_reg_ins := wn_reg_ins + 1;
wn_con_reg := wn_con_reg + 1;
if wn_con_reg >= wn_lim_ite then
/* commit; */
wn_con_reg := 0;
end if;
end loop;
end if;
-- si el periodo esta abierto se utiliza la tabla de movtos (nmwkmovt)
if wn_per_cer = 0 then
for c_movtos in ( select mov_keyemp, mov_keycon, mov_keypro, mov_keydep, mov_keypue,
mov_cantid, mov_import, mov_fecmov, mov_keyper,mov_keynom
from nmwkmovt
where mov_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keyemp::text, '') is not null)
and mov_keypro = wn_key_pro and mov_keyper = ws_per_fue ) loop
wn_cve_emp := c_movtos.mov_keyemp;
ws_cve_con := c_movtos.mov_keycon;
wn_cve_pro := c_movtos.mov_keypro;
ws_cve_dep := c_movtos.mov_keydep;
ws_cve_pue := c_movtos.mov_keypue;
wn_can_tid := c_movtos.mov_cantid;
wn_imp_ort := c_movtos.mov_import;
ws_fec_mov := c_movtos.mov_fecmov;
ws_cve_per := c_movtos.mov_keyper;
wn_cve_nom := c_movtos.mov_keynom;
-- si la bandera indica reversion se multiplica la cantidad
-- y el importe por -1
if wn_rev_ers = 1 then
wn_can_tid := wn_can_tid * -1;
wn_imp_ort := wn_imp_ort * -1;
end if;
wn_num_sec := wn_num_sec + 1;
call sp_nmkeyinc (wn_key_inc,ws_cve_con,wn_cve_pro,wn_cve_nom,ws_per_des,wn_cve_emp,wn_num_sec,wn_inc_loc);
-- inserta en la tabla de incidencias
insert into nmcoinci(inc_keyemp, inc_keycon, inc_keypro, inc_keyper, inc_keydep, inc_keypue,
inc_fecmov, inc_cantid, inc_import, inc_diauno, inc_diados, inc_diatre,
inc_diacua, inc_diacin, inc_diasei, inc_diasie, inc_keyinc, inc_numfol)
values (wn_cve_emp, ws_cve_con, wn_cve_pro, ws_per_des, ws_cve_dep, ws_cve_pue,
ws_fec_mov, wn_can_tid, wn_imp_ort, wn_cer_o,   wn_cer_o,   wn_cer_o,
wn_cer_o,   wn_cer_o,   wn_cer_o,   wn_cer_o,   wn_inc_loc,   wn_cer_o );
wn_reg_ins := wn_reg_ins + 1;
wn_con_reg := wn_con_reg + 1;
if wn_con_reg >= wn_lim_ite then
/* commit; */
wn_con_reg := 0;
end if;
end loop;
end if;
-- se inserta en glwkcrys el no. de registros insertados en incidencias
insert into glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_dec006)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, 1, wn_reg_ins);
/* commit; */
exception
when others then
call sp_glgenerr (wn_key_usu, ws_ide_pcc, 0, sp_glgethor,
sqlstate, 0, oracle.substr(sqlerrm, 1, 60));end;
$body$
language plpgsql
;
