create or replace procedure labconf."sp_nmlstmo2"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar, wn_key_pro numeric, wn_key_per varchar, wn_tip_rep numeric, ws_nom_rp1 varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_key_cia varchar(5) := '..';
-- variables para las restricciones de despliegue.
wn_dsp_001 numeric(5) := sp_glgetdsp1('nmwkmovt', 'mov_cantid', ws_key_men);
wn_dsp_002 numeric(5) := sp_glgetdsp1('nmwkmovt', 'mov_import', ws_key_men);
-- variables para el corte de procesos.
wn_ant_emp numeric(10) := -0000;
ws_ant_con varchar(3)    := '______';
-- variables para el reporte de avance.
wn_tot_reg numeric(10) := -1;
wn_num_reg numeric(10) := 0;
wn_pct_reg decimal(10,2);
wn_pct_act numeric(10) := 1;
wn_can_ti2 glwkcrys.cry_dec003%type := null;
wn_can_tid glwkcrys.cry_dec001%type;
wn_imp_or2 glwkcrys.cry_dec004%type := null;
wn_imp_ort glwkcrys.cry_dec002%type;
ws_des_co2 glwkcrys.cry_chr004%type := null;
ws_des_con glwkcrys.cry_chr003%type;
ws_des_cor glwkcrys.cry_chr001%type := 'CORPORATIVO NO REGISTRADO ...';
ws_des_lis glwkcrys.cry_chr005%type := sp_glgetrep(ws_nom_rp1, 'No existe nombre del reporte...', 40);
ws_dia_act glwkcrys.cry_dat001%type := sp_glgetfec;
ws_etq_001 glwkcrys.cry_chr008%type := sp_glgetdsl('nmwkmovt', 'mov_keyemp', '........', 20);
ws_etq_002 glwkcrys.cry_chr009%type := sp_glgetdsl('nmcoempl', 'emp_nomemp', '........', 20);
ws_etq_003 glwkcrys.cry_chr006%type := sp_glgetdsl('nmwkmovt', 'mov_keycon', '........', null);
ws_etq_004 glwkcrys.cry_chr007%type := sp_glgetdsl('nmloconc', 'con_descon', '........', null);
ws_etq_005 glwkcrys.cry_chr010%type := sp_glgetdsl('nmwkmovt', 'mov_cantid', '........', 20);
ws_etq_006 glwkcrys.cry_chr011%type := sp_glgetdsl('nmwkmovt', 'mov_import', '........', 20);
ws_hor_act glwkcrys.cry_chr024%type := sp_glgethor;
ws_key_co2 glwkcrys.cry_chr025%type := null;
ws_key_con glwkcrys.cry_chr017%type;
ws_nom_emp glwkcrys.cry_chr002%type;
wn_con_reg numeric(10) := 0;
wn_lim_ite numeric(10) := 100;
c_descor record;
c_descia record;
c_mov record;
c_keyemp record;
c_keycon record;
begin
-- inserta registro de resultados.
insert into labconf.glcoresu(res_idepro, res_idepcc, res_keyusu, res_fecini,
res_horini, res_horreg, res_totreg, res_status)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, sp_glgetfec,
ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
-- borra la tabla de trabajo del crystal report.
delete from labconf.glwkcrys
where cry_nomrep = ws_nom_rep and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu;
-- extrae el nombre de la compania corporativa.
for c_descor in (select pro_keycia
from labconf.nmloproc
where pro_keypro = wn_key_pro) loop
ws_key_cia := c_descor.pro_keycia;
end loop;
for c_descia in (select oracle.substr(cia_descia,1,60) cia_descia
from labconf.nmlocias
where cia_keycia = ws_key_cia) loop
ws_des_cor := c_descia.cia_descia;
end loop;
-- inicializa variables de trabajo para realizar cortes y monitoreo.
wn_pct_reg := wn_tot_reg / 10.0;
/* commit; */
-- cursor principal.
for c_mov in (select mov_keyemp, mov_keycon, mov_cantid, mov_import, mov_codimp
from labconf.nmwkmovt
where mov_keypro = wn_key_pro and
mov_keyper = wn_key_per and
mov_keycon in (select ran_keycon
from labconf.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keycon::text, '') is not null)
order by  mov_keyemp, mov_keycon) loop
ws_key_con := c_mov.mov_keycon;
wn_can_tid := c_mov.mov_cantid;
wn_imp_ort := c_mov.mov_import;
-- actualiza el registro de monitoreo.
wn_num_reg := wn_num_reg + 1;
if wn_num_reg >= (wn_pct_reg * wn_pct_act) then
update labconf.glcoresu
set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = sp_glgetfec and
res_horreg = ws_hor_reg;
wn_con_reg := wn_con_reg + 1;
wn_pct_act := wn_pct_act + 1;
end if;
-- obtenemos el nombre del empleado.
if nullif(c_mov.mov_keyemp::text, '') is null then
ws_nom_emp := 'Empleado No existe...';
else
if wn_ant_emp <> c_mov.mov_keyemp then
ws_nom_emp := 'Empleado No existe...';
for c_keyemp in (select emp_nomemp
from labconf.nmcoempl
where emp_keyemp = c_mov.mov_keyemp) loop
ws_nom_emp := c_keyemp.emp_nomemp;
end loop;
wn_ant_emp := c_mov.mov_keyemp;
end if;
end if;
-- obtenemos el nombre del concepto.
if nullif(ws_key_con::text, '') is null then
ws_des_con := 'Concepto No existe...';
else
if ws_ant_con <> ws_key_con then
ws_des_con := 'Concepto No existe...';
for c_keycon in (select con_descon
from labconf.nmloconc
where con_keycon = ws_key_con) loop
ws_des_con := c_keycon.con_descon;
end loop;
ws_ant_con := oracle.substr(ws_key_con, 1, 3);
end if;
end if;
-- deduccion.
if c_mov.mov_codimp = '02' then
wn_imp_ort := wn_imp_ort * -1;
end if;
-- concepto auxiliar.
if (c_mov.mov_codimp = '03' or  c_mov.mov_codimp = '04') and wn_tip_rep = 1 then
ws_key_co2 := ws_key_con;
ws_des_co2 := ws_des_con;
wn_can_ti2 := wn_can_tid;
wn_imp_or2 := wn_imp_ort;
ws_key_con := null;
ws_des_con := null;
wn_imp_ort := null;
wn_can_tid := null;
end if;
-- aplica restricciones de despliegue de campos.
if wn_dsp_001 = 1 then
wn_can_tid := null;
end if;
if wn_dsp_002 = 1 then
wn_imp_ort := null;
end if;
-- inserta en la tabla de trabajo del crystal report.
insert into labconf.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr017, cry_chr003,
cry_dec006, cry_chr002, cry_dec001, cry_dec002, cry_chr006, cry_chr007,
cry_chr008, cry_chr009, cry_chr010, cry_chr011, cry_dat001, cry_chr024,
cry_chr025, cry_chr004, cry_dec003, cry_dec004, cry_chr005)
values (ws_nom_rep,       ws_ide_pcc, wn_key_usu, ws_des_cor, ws_key_con, ws_des_con,
c_mov.mov_keyemp, ws_nom_emp, wn_can_tid, wn_imp_ort, ws_etq_003, ws_etq_004,
ws_etq_001,       ws_etq_002, ws_etq_005, ws_etq_006, ws_dia_act, ws_hor_act,
ws_key_co2,       ws_des_co2, wn_can_ti2, wn_imp_or2, ws_des_lis);
wn_con_reg := wn_con_reg + 1;
/* commit; */
ws_key_co2 := null;
ws_des_co2 := null;
wn_can_ti2 := null;
wn_imp_or2 := null;
end loop;
--   actualiza la tabla de monitoreo la finalizacion del proceso.
update labconf.glcoresu
set res_numreg = wn_num_reg,
res_fecfin = sp_glgetfec,
res_horfin = sp_glgethor,
res_status = 'T'
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = sp_glgetfec and
res_horreg = ws_hor_reg;
/* commit; */
exception
when others then
call labconf.sp_glgenerr (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_hor_reg, sqlstate, 0,
oracle.substr(sqlerrm, 1, 60));
end;
$body$
language plpgsql
;
