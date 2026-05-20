create or replace procedure labprod."sp_nmlsttan"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
----------------------------------------------------------------------------
-- igneos, s.a. de c.v.
--
-- sistema  : rh-2000    c/s
-- modulo   : administracion de remuneraciones (nm)
--
-- programa : sp_nmlsttan
--            reporte de tablas numericas
--
-- autor    : pedro perez gutierrez
-- fecha    : 28 de febrero de 1997
-- correcci??n oracle por: orlando olgu??n olvera.	11:11 am 16/07/1998
----------------------------------------------------------------------------
-- variables para la carga de la tablas numericas.
ws_tab_key varchar(3);
-- variable para la carga de las especificaciones de las claves.
ws_des_tan varchar(40);
ws_des_tab varchar(40);
ws_tab_ant varchar(3) := '______';
wn_row_ide numeric(10);
-- variable para la carga de las descripciones de las etiquetas.
ws_key_cam varchar(40);
ws_des_etq varchar(40);
-- variables para las restricciones de despliegue.
ws_dsp_cam varchar(20);
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
-- variables para el reporte de avance.
wn_tot_reg numeric(10);
wn_num_reg numeric(10) := 0;
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5)  := 1;
ws_des_cor glwkcrys.cry_chr001%type;
ws_des_lis glwkcrys.cry_chr002%type := labprod.sp_glgetrep(ws_nom_rep, 'No existe Nombre del Reporte ...', null);
ws_tan_de1 glwkcrys.cry_chr003%type;
ws_tan_de2 glwkcrys.cry_chr004%type;
ws_tan_de3 glwkcrys.cry_chr005%type;
wn_tab_sec glwkcrys.cry_dec001%type;
wn_tab_uno glwkcrys.cry_dec002%type;
wn_tab_dos glwkcrys.cry_dec003%type;
wn_tab_tre glwkcrys.cry_dec004%type;
wn_tab_cua glwkcrys.cry_dec005%type;
wd_dia_act glwkcrys.cry_dat001%type;
ws_tan_key glwkcrys.cry_chr017%type;
ws_etq_001 glwkcrys.cry_chr011%type := labprod.sp_glgetdsl('nmlotanu', 'tan_keytab', '....', 20);
ws_etq_002 glwkcrys.cry_chr012%type := labprod.sp_glgetdsl('nmlotanu', 'tan_de1tab', '....', 16);
ws_etq_003 glwkcrys.cry_chr013%type := labprod.sp_glgetdsl('nmlotanu', 'tan_de2tab', '....', 16);
ws_etq_004 glwkcrys.cry_chr014%type := labprod.sp_glgetdsl('nmlotanu', 'tan_de3tab', '....', 16);
ws_etq_005 glwkcrys.cry_chr015%type := labprod.sp_glgetdsl('nmlotabn', 'tab_keytab', '....', 16);
ws_etq_006 glwkcrys.cry_chr007%type := labprod.sp_glgetdsl('nmlotabn', 'tab_sectab', '....', null);
ws_etq_007 glwkcrys.cry_chr008%type := labprod.sp_glgetdsl('nmlotabn', 'tab_eleuno', '....', 20);
ws_etq_008 glwkcrys.cry_chr009%type := labprod.sp_glgetdsl('nmlotabn', 'tab_eledos', '....', 20);
ws_etq_009 glwkcrys.cry_chr010%type := labprod.sp_glgetdsl('nmlotabn', 'tab_eletre', '....', 20);
ws_etq_010 glwkcrys.cry_chr006%type := labprod.sp_glgetdsl('nmlotabn', 'tab_elecua', '....', null);
ws_hor_act glwkcrys.cry_chr021%type;
wn_con_reg numeric(3) := 0;
wn_lim_ite numeric(3) := 100;
c_nmlsttan record;
c_nmlotanu record;
begin
call labprod.sp_glfechor (wd_dia_act,ws_hor_act);
call labprod.sp_glnewdsp ('nmlotanu', 'tan_keytab', ws_key_men, wn_dsp_001);
call labprod.sp_glnewdsp ('nmlotanu', 'tan_de1tab', ws_key_men, wn_dsp_002);
call labprod.sp_glnewdsp ('nmlotanu', 'tan_de2tab', ws_key_men, wn_dsp_003);
call labprod.sp_glnewdsp ('nmlotanu', 'tan_de3tab', ws_key_men, wn_dsp_004);
call labprod.sp_glnewdsp ('nmlotabn', 'tab_keytab', ws_key_men, wn_dsp_005);
call labprod.sp_glnewdsp ('nmlotabn', 'tan_keytab', ws_key_men, wn_dsp_006);
call labprod.sp_glnewdsp ('nmlotabn', 'tan_de2tab', ws_key_men, wn_dsp_007);
call labprod.sp_glnewdsp ('nmlotabn', 'tan_de3tab', ws_key_men, wn_dsp_008);
call labprod.sp_glnewdsp ('nmlotabn', 'tan_de3tab', ws_key_men, wn_dsp_009);
call labprod.sp_glnewdsp ('nmlotabn', 'tan_de3tab', ws_key_men, wn_dsp_010);
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
select cor_razsoc
into strict ws_des_cor
from labprod.glcocorp;
-- realiza el conteo de registros a procesar.
select coalesce(count(*), 0)
into strict wn_tot_reg
from labprod.nmlotabn
where tab_keytab in (select ran_keydep
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keydep::text, '') is not null);
-- inicializa variables de trabajo para realizar cortes y monitoreo
wn_pct_reg := wn_tot_reg / 10.0;
-- inserta registro de resultados.
insert into labprod.glcoresu(res_idepro, res_idepcc, res_keyusu, res_fecini,
res_horini, res_horreg, res_totreg, res_status)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, wd_dia_act,
ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
-- borra la tabla de trabajo del crystal report.
delete from labprod.glwkcrys
where cry_nomrep = ws_nom_rep and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu;
/* commit; */
-- cursor principal.
for c_nmlsttan in (select tab_keytab, tab_sectab, tab_eleuno,
tab_eledos, tab_eletre, tab_elecua
from labprod.nmlotabn
where tab_keytab in (select ran_keydep
from labprod.glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keydep::text, '') is not null)
order by  tab_keytab, tab_sectab) loop
-- contador para realizar el commit
wn_con_reg := wn_con_reg + 1;
ws_tab_key := c_nmlsttan.tab_keytab;
wn_tab_sec := c_nmlsttan.tab_sectab;
wn_tab_uno := c_nmlsttan.tab_eleuno;
wn_tab_dos := c_nmlsttan.tab_eledos;
wn_tab_tre := c_nmlsttan.tab_eletre;
wn_tab_cua := c_nmlsttan.tab_elecua;
-- actualiza el registro de monitoreo.
wn_num_reg := wn_num_reg + 1;
if wn_num_reg >= (wn_pct_reg * wn_pct_act) then
update labprod.glcoresu
set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = wd_dia_act and
res_horreg = ws_hor_reg;
wn_pct_act := wn_pct_act + 1;
wn_con_reg := wn_con_reg + 1;
end if;
if ws_tab_ant <> ws_tab_key then
for c_nmlotanu in (select tan_keytab, tan_de1tab, tan_de2tab, tan_de3tab
from labprod.nmlotanu
where tan_keytab = ws_tab_key ) loop
ws_tan_key := c_nmlotanu.tan_keytab;
ws_tan_de1 := c_nmlotanu.tan_de1tab;
ws_tan_de2 := c_nmlotanu.tan_de2tab;
ws_tan_de3 := c_nmlotanu.tan_de3tab;
end loop;
ws_tab_ant := ws_tab_key;
end if;
-- aplica restricciones de despliegue de campos.
if wn_dsp_001 = 1 then
ws_tan_key := null;
end if;
if wn_dsp_002 = 1 then
ws_tan_de1 := null;
end if;
if wn_dsp_003 = 1 then
ws_tan_de2 := null;
end if;
if wn_dsp_004 = 1 then
ws_tan_de3 := null;
end if;
if wn_dsp_005 = 1 then
ws_tab_key := null;
end if;
if wn_dsp_006 = 1 then
wn_tab_sec := null;
end if;
if wn_dsp_007 = 1 then
wn_tab_uno := null;
end if;
if wn_dsp_008 = 1 then
wn_tab_dos := null;
end if;
if wn_dsp_009 = 1 then
wn_tab_tre := null;
end if;
if wn_dsp_010 = 1 then
wn_tab_cua := null;
end if;
-- inserta en la tabla de trabajo del crystal report.
insert into labprod.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr002, cry_chr003,
cry_chr004, cry_chr005, cry_dec001, cry_dec002, cry_dec003, cry_dec004,
cry_dec005, cry_dat001, cry_chr017, cry_chr011, cry_chr012, cry_chr013,
cry_chr014, cry_chr015, cry_chr007, cry_chr008, cry_chr009, cry_chr010,
cry_chr006, cry_chr021)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_des_lis, ws_tan_de1,
ws_tan_de2, ws_tan_de3, wn_tab_sec, wn_tab_uno, wn_tab_dos, wn_tab_tre,
wn_tab_cua, wd_dia_act, ws_tan_key, ws_etq_001, ws_etq_002, ws_etq_003,
ws_etq_004, ws_etq_005, ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009,
ws_etq_010, ws_hor_act);
if wn_con_reg >= wn_lim_ite then
/* commit; */
wn_con_reg := 0;
end if;
end loop;
-- actualiza la tabla de monitoreo la finalizacion del proceso
call labprod.sp_glfechor (wd_dia_act,ws_hor_act);
update labprod.glcoresu
set res_numreg = wn_num_reg,
res_fecfin = wd_dia_act,
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = wd_dia_act and
res_horreg = ws_hor_reg;
/* commit; */
end;
$body$
language plpgsql
;
