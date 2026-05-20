create or replace procedure labconf."sp_nmlstdic"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- variable para la carga de las descripciones de las claves.
ws_des_aux varchar(40);
ws_tab_ant glwkcrys.cry_chr002%type := '______';
wn_row_ide numeric(10);
-- variable para la carga de las descripciones de las etiquetas.
ws_des_etq varchar(10);
-- variables para las restricciones de despliegue.
ws_dsp_cam varchar(20);
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_dsp_003 numeric(5);
wn_dsp_004 numeric(5);
wn_dsp_005 numeric(5);
wn_dsp_006 numeric(5);
wn_dsp_007 numeric(5);
-- variables para el reporte de avance.
wn_tot_reg numeric(10);
wn_num_reg numeric(10)  := 0;
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5)   := 1;
ws_hor_act varchar(8);
ws_des_cor glwkcrys.cry_chr001%type;
ws_key_tab glwkcrys.cry_chr004%type;
ws_des_tab glwkcrys.cry_chr003%type;
ws_key_cam glwkcrys.cry_chr005%type;
ws_des_cam glwkcrys.cry_chr006%type;
ws_dau_cam glwkcrys.cry_chr007%type;
ws_dco_cam glwkcrys.cry_chr008%type;
ws_etq_001 glwkcrys.cry_chr029%type := sp_glgetdsc('glcotabl', 'tab_keytab', '....', null);
ws_etq_002 glwkcrys.cry_chr010%type := sp_glgetdsl('glcocamp', 'cam_keytab', '....', 20);
ws_etq_003 glwkcrys.cry_chr011%type := sp_glgetdsl('glcocamp', 'cam_keycam', '....', 20);
ws_etq_004 glwkcrys.cry_chr012%type := sp_glgetdsl('glcocamp', 'cam_descam', '....', 16);
ws_etq_005 glwkcrys.cry_chr013%type := sp_glgetdsl('glcocamp', 'cam_desaux', '....', 16);
ws_etq_006 glwkcrys.cry_chr014%type := sp_glgetdsl('glcocamp', 'cam_descor', '....', 16);
ws_etq_007 glwkcrys.cry_chr030%type := sp_glgetdsc('glcotabl', 'tab_destab', '....', null);
wd_dia_act glwkcrys.cry_dat001%type;
ws_des_lis glwkcrys.cry_chr002%type := sp_glgetrep(ws_nom_rep, 'No Existe Nombre del Reporte', 40);
wn_con_reg numeric(3) := 0;
wn_lim_ite numeric(3) := 100;
c_nmlstdic record;
c_tab record;
begin
call sp_glfechor (wd_dia_act,ws_hor_act);
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
select cor_razsoc into strict ws_des_cor	from glcocorp;
call sp_glnewdsp ('glcotabl', 'tab_keytab', ws_key_men, wn_dsp_001);
call sp_glnewdsp ('glcotabl', 'tab_destab', ws_key_men, wn_dsp_002);
call sp_glnewdsp ('glcocamp', 'cam_keytab', ws_key_men, wn_dsp_003);
call sp_glnewdsp ('glcocamp', 'cam_keycam', ws_key_men, wn_dsp_004);
call sp_glnewdsp ('glcocamp', 'cam_descam', ws_key_men, wn_dsp_005);
call sp_glnewdsp ('glcocamp', 'cam_desaux', ws_key_men, wn_dsp_006);
call sp_glnewdsp ('glcocamp', 'cam_descor', ws_key_men, wn_dsp_007);
-- realiza el conteo de registros a procesar.
select coalesce(count(*), 0)
into strict wn_tot_reg
from glcocamp
where cam_keytab in (select ran_keydep
from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keydep::text, '') is not null);
-- inserta registro de resultados.
insert into glcoresu(res_idepro, res_idepcc, res_keyusu, res_fecini,
res_horini, res_horreg, res_totreg, res_status)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, wd_dia_act,
ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
-- borra la tabla de trabajo del crystal report.
delete from glwkcrys
where cry_nomrep = ws_nom_rep and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu;
-- inicializa variables de trabajo para realizar cortes y monitoreo.
wn_pct_reg := wn_tot_reg / 10.0;
/* commit; */
-- cursor principal.
for c_nmlstdic in (select cam_keytab, cam_keycam, cam_descam, cam_desaux, cam_descor
from glcocamp
where cam_keytab in (select ran_keydep
from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keydep::text, '') is not null)
order by  cam_keytab, cam_keycam) loop
ws_key_cam := c_nmlstdic.cam_keycam;
ws_des_cam := c_nmlstdic.cam_descam;
ws_dau_cam := c_nmlstdic.cam_desaux;
ws_dco_cam := c_nmlstdic.cam_descor;
-- actualiza el registro de monitoreo.
wn_num_reg := wn_num_reg + 1;
wn_con_reg := wn_con_reg + 1;
if wn_num_reg >= (wn_pct_reg * wn_pct_act) then
update glcoresu
set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = wd_dia_act and
res_horreg = ws_hor_reg;
wn_pct_act := wn_pct_act + 1;
wn_con_reg := wn_con_reg + 1;
end if;/* dmap converted statement start */
-- substr a?adido para el buen funcionamiento.
if ws_tab_ant <> c_nmlstdic.cam_keytab then
for c_tab in (select tab_keytab, tab_destab
from  glcotabl
where tab_keytab = rtrim(c_nmlstdic.cam_keytab::text)) loop
ws_key_tab := c_tab.tab_keytab;/* dmap converted statement end */
ws_des_tab := oracle.substr(c_tab.tab_destab, 1, 40);
end loop;
ws_tab_ant := ws_key_tab;
end if;
-- aplica restricciones de despliegue de campos.
if wn_dsp_001 = 1 then
ws_key_tab := null;
end if;
if wn_dsp_002 = 1 then
ws_des_tab := null;
end if;
if wn_dsp_003 = 1 then
ws_key_tab := null;
end if;
if wn_dsp_004 = 1 then
ws_key_cam := null;
end if;
if wn_dsp_005 = 1 then
ws_des_cam := null;
end if;
if wn_dsp_006 = 1 then
ws_dau_cam := null;
end if;
if wn_dsp_007 = 1 then
ws_dco_cam := null;
end if;
-- inserta en la tabla de trabajo del crystal report.
insert into glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr004,
cry_chr003, cry_chr005, cry_chr006, cry_chr007, cry_chr008,
cry_chr029, cry_chr010, cry_chr011, cry_chr012, cry_chr013,
cry_chr014, cry_chr030, cry_chr016, cry_dat001, cry_chr002)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_key_tab,
ws_des_tab, ws_key_cam, ws_des_cam, ws_dau_cam, ws_dco_cam,
ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
ws_etq_006, ws_etq_007, ws_hor_act, wd_dia_act, ws_des_lis);
if wn_con_reg >= wn_lim_ite then
/* commit; */
wn_con_reg := 0;
end if;
end loop;
call sp_glfechor (wd_dia_act,ws_hor_act);
-- actualiza la tabla de monitoreo la finalizacion del proceso
update glcoresu
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
