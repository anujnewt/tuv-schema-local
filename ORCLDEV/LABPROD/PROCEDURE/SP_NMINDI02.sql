create or replace procedure labprod."sp_nmindi02"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- claves, fecha inicial y final del periodo, corporacion, nombre del empleado.
wn_pro_ant numeric(10) := -32760;
ws_per_ant varchar(7)    := '______________';
ws_dep_ant varchar(16)   := '________________________________';
wn_emp_ant numeric(10) := -999999999;
ws_con_ant varchar(8)    := '________________';
ws_key_cia varchar(5);
wn_pri_mer numeric(10) := 0;
-- variables para la carga de las descripciones de las etiquetas.
ws_key_cam varchar(20);
ws_des_etq varchar(8);
-- variables para las restricciones de despliegue.
ws_dsp_cam varchar(1);
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_dsp_003 numeric(5);
wn_dsp_004 numeric(5);
wn_dsp_005 numeric(5);
wn_dsp_006 numeric(5);
wn_dsp_007 numeric(5);
wn_dsp_008 numeric(5);
wn_dsp_009 numeric(5);
wn_dsp_010 numeric(5);
wn_dsp_011 numeric(5);
wn_dsp_012 numeric(5);
wn_dsp_013 numeric(5);
wn_dsp_014 numeric(5);
-- variables para el reporte de avance.
wn_tot_reg numeric(10);
wn_num_reg numeric(10) := 0;
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5)  := 1;
ws_des_cor glwkcrys.cry_chr001%type;
wn_key_emp glwkcrys.cry_dec006%type;
ws_key_con glwkcrys.cry_chr017%type;
wn_dia_uno glwkcrys.cry_dec001%type;
wn_dia_dos glwkcrys.cry_dec002%type;
wd_fec_mov glwkcrys.cry_dat001%type;
ws_key_dep glwkcrys.cry_chr008%type;
ws_key_pue glwkcrys.cry_chr009%type;
wn_key_pro glwkcrys.cry_dec007%type;
ws_key_per glwkcrys.cry_chr018%type;
ws_des_con glwkcrys.cry_chr003%type;
ws_nom_emp glwkcrys.cry_chr002%type;
ws_des_pro glwkcrys.cry_chr010%type;
wd_fec_ini glwkcrys.cry_dat002%type;
wd_fec_fin glwkcrys.cry_dat003%type;
wd_fec_act glwkcrys.cry_dat004%type;
ws_hor_act glwkcrys.cry_chr019%type;
wn_dia_tre glwkcrys.cry_dec003%type;
wn_dia_cua glwkcrys.cry_dec004%type;
wn_dia_cin glwkcrys.cry_dec005%type;
wn_dia_sei glwkcrys.cry_dec011%type;
wn_dia_sie glwkcrys.cry_dec012%type;
ws_etq_001 glwkcrys.cry_chr020%type := sp_glgetdsc('nmcoinci', 'inc_keyemp', '........', null);
ws_etq_002 glwkcrys.cry_chr021%type := sp_glgetdsc('nmcoinci', 'inc_keycon', '........', null);
ws_etq_003 glwkcrys.cry_chr022%type := sp_glgetdsc('nmcoinci', 'inc_diauno', '........', null);
ws_etq_004 glwkcrys.cry_chr023%type := sp_glgetdsc('nmcoinci', 'inc_diados', '........', null);
ws_etq_005 glwkcrys.cry_chr024%type := sp_glgetdsc('nmcoinci', 'inc_fecmov', '........', null);
ws_etq_006 glwkcrys.cry_chr025%type := sp_glgetdsc('nmcoinci', 'inc_keydep', '........', null);
ws_etq_007 glwkcrys.cry_chr026%type := sp_glgetdsc('nmcoinci', 'inc_keypue', '........', null);
ws_etq_008 glwkcrys.cry_chr027%type := sp_glgetdsc('nmcoinci', 'inc_keypro', '........', null);
ws_etq_009 glwkcrys.cry_chr028%type := sp_glgetdsc('nmcoinci', 'inc_keyper', '........', null);
ws_etq_010 glwkcrys.cry_chr029%type := sp_glgetdsc('nmcoempl', 'emp_nomemp', 'Nombre',   null);
ws_etq_011 glwkcrys.cry_chr030%type := sp_glgetdsc('nmloconc', 'con_descon', 'Descripcion', null);
ws_etq_012 glwkcrys.cry_chr031%type := sp_glgetdsc('nmcoinci', 'inc_diatre', '........', null);
ws_etq_013 glwkcrys.cry_chr032%type := sp_glgetdsc('nmcoinci', 'inc_diacua', '........', null);
ws_etq_014 glwkcrys.cry_chr033%type := sp_glgetdsc('nmcoinci', 'inc_diacin', '........', null);
ws_etq_015 glwkcrys.cry_chr034%type := sp_glgetdsc('nmcoinci', 'inc_diasei', '........', null);
ws_etq_016 glwkcrys.cry_chr035%type := sp_glgetdsc('nmcoinci', 'inc_diasie', '........', null);
ws_des_dep glwkcrys.cry_chr004%type;
wn_tot_dia glwkcrys.cry_dec013%type;
ws_des_lis glwkcrys.cry_chr005%type := sp_glgetrep(ws_nom_rep, 'No existe nombre del Reporte', 40);
wn_con_reg numeric(3) := 0;
wn_lim_ite numeric(3) := 100;
c_nmindi02 record;
c_descor record;
c_descia record;
c_descon record;
c_desemp record;
c_desdep record;
c_despro record;
c_desfec record;
begin
call sp_glgetdsp ('nmcoinci', 'inc_keypro', ws_key_men, wn_dsp_001);
call sp_glgetdsp ('nmcoinci', 'inc_keyper', ws_key_men, wn_dsp_002);
call sp_glgetdsp ('nmcoinci', 'inc_keyemp', ws_key_men, wn_dsp_003);
call sp_glgetdsp ('nmcoinci', 'inc_keycon', ws_key_men, wn_dsp_004);
call sp_glgetdsp ('nmcoinci', 'inc_diauno', ws_key_men, wn_dsp_005);
call sp_glgetdsp ('nmcoinci', 'inc_diados', ws_key_men, wn_dsp_006);
call sp_glgetdsp ('nmcoinci', 'inc_fecmov', ws_key_men, wn_dsp_007);
call sp_glgetdsp ('nmcoinci', 'inc_keydep', ws_key_men, wn_dsp_008);
call sp_glgetdsp ('nmcoinci', 'inc_keypue', ws_key_men, wn_dsp_009);
call sp_glgetdsp ('nmcoinci', 'inc_diatre', ws_key_men, wn_dsp_010);
call sp_glgetdsp ('nmcoinci', 'inc_diacua', ws_key_men, wn_dsp_011);
call sp_glgetdsp ('nmcoinci', 'inc_diacin', ws_key_men, wn_dsp_012);
call sp_glgetdsp ('nmcoinci', 'inc_diasei', ws_key_men, wn_dsp_013);
call sp_glgetdsp ('nmcoinci', 'inc_diasie', ws_key_men, wn_dsp_014);
call sp_glfechor (wd_fec_act,ws_hor_act);
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
select cor_razsoc into strict ws_des_cor
from labprod.glcocorp;
-- realiza el conteo de registros a procesar.
select coalesce(count(*), 0)
into strict wn_tot_reg
from labprod.nmcoinci
where inc_keypro in (select ran_keypro
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keypro::text, '') is not null) and
inc_keyper in (select ran_keyper
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keyper::text, '') is not null) and
inc_keycon in (select ran_keycon
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keycon::text, '') is not null) and
inc_keyemp in (select ran_keyemp
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keyemp::text, '') is not null) and
inc_keydep in (select ran_keydep
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keydep::text, '') is not null);
wn_pct_reg := wn_tot_reg / 10.0;
insert into labprod.glcoresu(res_idepro, res_idepcc, res_keyusu, res_fecini,
res_horini, res_horreg, res_totreg, res_status)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, wd_fec_act,
ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
-- borra la tabla de trabajo del crystal report.
delete from labprod.glwkcrys
where cry_nomrep = ws_nom_rep and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu;
/* commit; */
-- cursor principal.
for c_nmindi02 in (select inc_keyemp, inc_keycon, inc_diauno, inc_diados, inc_fecmov,
inc_keydep, inc_keypue, inc_keypro, inc_keyper, inc_diatre,
inc_diacua, inc_diacin, inc_diasei, inc_diasie
from labprod.nmcoinci
where inc_keypro in (select ran_keypro
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keypro::text, '') is not null) and
inc_keyper in (select ran_keyper
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keyper::text, '') is not null) and
inc_keycon in (select ran_keycon
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keycon::text, '') is not null) and
inc_keyemp in (select ran_keyemp
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keyemp::text, '') is not null) and
inc_keydep in (select ran_keydep
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keydep::text, '') is not null)
order by  inc_keypro, inc_keyper, inc_keydep,
inc_keyemp, inc_keycon) loop
wn_key_emp := c_nmindi02.inc_keyemp;
ws_key_con := c_nmindi02.inc_keycon;
wn_dia_uno := c_nmindi02.inc_diauno;
wn_dia_dos := c_nmindi02.inc_diados;
wd_fec_mov := c_nmindi02.inc_fecmov;
ws_key_dep := c_nmindi02.inc_keydep;
ws_key_pue := c_nmindi02.inc_keypue;
wn_key_pro := c_nmindi02.inc_keypro;
ws_key_per := c_nmindi02.inc_keyper;
wn_dia_tre := c_nmindi02.inc_diatre;
wn_dia_cua := c_nmindi02.inc_diacua;
wn_dia_cin := c_nmindi02.inc_diacin;
wn_dia_sei := c_nmindi02.inc_diasei;
wn_dia_sie := c_nmindi02.inc_diasie;
if wn_pri_mer = 0 then
-- extrae el nombre de la compania corporativa
ws_key_cia := '..';
for c_descor in (select pro_keycia
from labprod.nmloproc
where pro_keypro = wn_key_pro) loop
ws_key_cia := c_descor.pro_keycia;
end loop;
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
for c_descia in (select cia_descia
from labprod.nmlocias
where cia_keycia = ws_key_cia) loop
ws_des_cor := c_descia.cia_descia;
end loop;
wn_pri_mer := wn_pri_mer +1;
end if;
-- actualiza registro de monitoreo.
wn_num_reg := wn_num_reg + 1;
if wn_num_reg >= (wn_pct_reg * wn_pct_act) then
update labprod.glcoresu
set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = wd_fec_act and
res_horreg = ws_hor_reg;
wn_pct_act := wn_pct_act + 1;
wn_con_reg := wn_con_reg + 1;
end if;
-- suma incidencias.
wn_tot_dia := 0;
if nullif(wn_dia_uno::text, '') is not null then
wn_tot_dia := wn_tot_dia + wn_dia_uno;
end if;
if nullif(wn_dia_dos::text, '') is not null then
wn_tot_dia := wn_tot_dia + wn_dia_dos;
end if;
if nullif(wn_dia_tre::text, '') is not null then
wn_tot_dia := wn_tot_dia + wn_dia_tre;
end if;
if nullif(wn_dia_cua::text, '') is not null then
wn_tot_dia := wn_tot_dia + wn_dia_cua;
end if;
if nullif(wn_dia_cin::text, '') is not null then
wn_tot_dia := wn_tot_dia + wn_dia_cin;
end if;
if nullif(wn_dia_sei::text, '') is not null then
wn_tot_dia := wn_tot_dia + wn_dia_sei;
end if;
if nullif(wn_dia_sie::text, '') is not null then
wn_tot_dia := wn_tot_dia + wn_dia_sie;
end if;
-- descrip. de concepto, proceso, nombre del empl., fecha inicial y final del periodo.
if nullif(ws_key_con::text, '') is null then
ws_des_con := 'CONCEPTO NO EXISTE ...';
else
if ws_key_con <> ws_con_ant then
ws_des_con := 'CONCEPTO NO EXISTE ...';
for c_descon in (select con_descon
from labprod.nmloconc
where con_keycon = ws_key_con) loop
ws_des_con := c_descon.con_descon;
end loop;
ws_con_ant := ws_key_con;
end if;
end if;
if nullif(wn_key_emp::text, '') is null then
ws_nom_emp := 'EMPLEADO NO EXISTE ...';
else
if wn_key_emp <> wn_emp_ant then
ws_nom_emp := 'EMPLEADO NO EXISTE ...';
for c_desemp in (select emp_nomemp
from labprod.nmcoempl
where emp_keyemp = wn_key_emp) loop
ws_nom_emp := c_desemp.emp_nomemp;
end loop;
wn_emp_ant := wn_key_emp;
end if;
end if;
if nullif(ws_key_dep::text, '') is null then
ws_des_dep := 'DEPTO. NO EXISTE...';
else
if ws_key_dep <> ws_dep_ant then
ws_des_dep := 'DEPTO. NO EXISTE...';
for c_desdep in (select dep_desdep
from labprod.nmcodeps
where dep_keydep = ws_key_dep) loop
ws_des_dep := c_desdep.dep_desdep;
end loop;
ws_dep_ant := oracle.substr(ws_key_dep, 1, 16);
end if;
end if;
if nullif(wn_key_pro::text, '') is null then
ws_des_pro := 'PROCESO NO EXISTE...';
else
if wn_key_pro <> wn_pro_ant then
ws_des_pro := 'PROCESO NO EXISTE...';
for c_despro in (select pro_despro
from labprod.nmloproc
where pro_keypro = wn_key_pro) loop
ws_des_pro := c_despro.pro_despro;
end loop;
wn_pro_ant := wn_key_pro;
end if;
end if;
if nullif(ws_key_per::text, '') is null then
wd_fec_ini := null;
wd_fec_fin := null;
else
if ws_key_per <> ws_per_ant then
wd_fec_ini := null;
wd_fec_fin := null;
for c_desfec in (select per_fecini, per_fecfin
from labprod.nmloperi
where per_keyper = ws_key_per and
per_keypro = wn_key_pro) loop
wd_fec_ini := c_desfec.per_fecini;
wd_fec_fin := c_desfec.per_fecfin;
end loop;
ws_per_ant := oracle.substr(ws_key_per, 1, 7);
end if;
end if;
-- aplica restricciones de despliegue de campos.
if wn_dsp_001 = 1 then
wn_key_pro := null;
ws_des_pro := null;
end if;
if wn_dsp_002 = 1 then
ws_key_per := null;
wd_fec_ini := null;
wd_fec_fin := null;
end if;
if wn_dsp_003 = 1 then
wn_key_emp := null;
ws_nom_emp := null;
end if;
if wn_dsp_004 = 1 then
ws_key_con := null;
ws_des_con := null;
end if;
if wn_dsp_005 = 1 then
wn_dia_uno := null;
end if;
if wn_dsp_006 = 1 then
wn_dia_dos := null;
end if;
if wn_dsp_007 = 1 then
wd_fec_mov := null;
end if;
if wn_dsp_008 = 1 then
ws_key_dep := null;
ws_des_dep := null;
end if;
if wn_dsp_009 = 1 then
ws_key_pue := null;
end if;
if wn_dsp_010 = 1 then
wn_dia_tre := null;
end if;
if wn_dsp_011 = 1 then
wn_dia_cua := null;
end if;
if wn_dsp_012 = 1 then
wn_dia_cin := null;
end if;
if wn_dsp_013 = 1 then
wn_dia_sei := null;
end if;
if wn_dsp_014 = 1 then
wn_dia_sie := null;
end if;
-- inserta en la tabla de trabajo del crystal report.
insert into labprod.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006, cry_chr017,
cry_dec001, cry_dec002, cry_dat001, cry_chr008, cry_chr009, cry_dec007,
cry_chr018, cry_chr003, cry_chr002, cry_chr010, cry_dat002, cry_dat003,
cry_dat004, cry_chr019, cry_dec003, cry_dec004, cry_dec005, cry_dec011,
cry_dec012, cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr024,
cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_chr029, cry_chr030,
cry_chr031, cry_chr032, cry_chr033, cry_chr034, cry_chr035, cry_chr004,
cry_dec013, cry_chr005)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_emp, ws_key_con,
wn_dia_uno, wn_dia_dos, wd_fec_mov, ws_key_dep, ws_key_pue, wn_key_pro,
ws_key_per, ws_des_con, ws_nom_emp, ws_des_pro, wd_fec_ini, wd_fec_fin,
wd_fec_act, ws_hor_act, wn_dia_tre, wn_dia_cua, wn_dia_cin, wn_dia_sei,
wn_dia_sie, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009, ws_etq_010, ws_etq_011,
ws_etq_012, ws_etq_013, ws_etq_014, ws_etq_015, ws_etq_016, ws_des_dep,
wn_tot_dia, ws_des_lis);
wn_con_reg := wn_con_reg + 1;
if wn_con_reg = wn_lim_ite then
/* commit; */
wn_con_reg := 0;
end if;
end loop;
-- actualiza la tabla de monitoreo indicando la finalizacion del proceso.
call sp_glfechor (wd_fec_act,ws_hor_act);
update labprod.glcoresu
set res_numreg = wn_num_reg,
res_fecfin = wd_fec_act,
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = wd_fec_act and
res_horreg = ws_hor_reg;
/* commit; */
exception
when others then
call sp_glgenerr (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_hor_reg, sqlstate, 0,
oracle.substr(sqlerrm, 1, 60));
end;
$body$
language plpgsql
;
