create or replace procedure labprod."sp_nmlstben"  ( ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar, vs_tip_ben varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_key_emp glwkcrys.cry_dec006%type;
ws_nom_emp glwkcrys.cry_chr002%type;
ws_key_dep glwkcrys.cry_chr010%type;
ws_des_dep glwkcrys.cry_chr004%type;
wn_key_ben glwkcrys.cry_dec007%type;
ws_tip_ben glwkcrys.cry_chr042%type;
ws_des_ben glwkcrys.cry_chr006%type;
wn_com_fam glwkcrys.cry_dec008%type;
ws_nom_ben glwkcrys.cry_chr003%type;
ws_rfc_ben glwkcrys.cry_chr008%type;
wd_fec_nac glwkcrys.cry_dat001%type;
ws_cve_sex glwkcrys.cry_chr040%type;
ws_tip_par glwkcrys.cry_chr041%type;
wn_por_par glwkcrys.cry_dec001%type;
wd_fec_ven glwkcrys.cry_dat002%type;
ws_key_ban glwkcrys.cry_chr043%type;
ws_cta_ban glwkcrys.cry_chr009%type;
ws_key_cen glwkcrys.cry_chr011%type;
ws_des_cen glwkcrys.cry_chr005%type;
ws_for_pag glwkcrys.cry_chr044%type;
ws_ca1_aux glwkcrys.cry_chr012%type;
ws_ca2_aux glwkcrys.cry_chr013%type;
ws_key_con glwkcrys.cry_chr016%type;
ws_per_ini glwkcrys.cry_chr014%type;
ws_per_fin glwkcrys.cry_chr015%type;
-- variables para la carga de las descripciones de las etiquetas
ws_key_cam varchar(20);
ws_des_etq varchar(8);
ws_etq_001 glwkcrys.cry_chr021%type := sp_glgetdsc('nmlobene','ben_keyemp','........',null);
ws_etq_002 glwkcrys.cry_chr018%type := sp_glgetdsc('nmlobene','ben_keyben','........',null);
ws_etq_003 glwkcrys.cry_chr019%type := sp_glgetdsc('nmlobene','ben_comfam','........',null);
ws_etq_004 glwkcrys.cry_chr020%type := sp_glgetdsc('nmlobene','ben_rfcben','........',null);
ws_etq_005 varchar(8)  := sp_glgetdsc('nmlobene','ben_nomben','........',null);
ws_etq_006 glwkcrys.cry_chr022%type := sp_glgetdsc('nmlobene','ben_fecnac','........',null);
ws_etq_007 glwkcrys.cry_chr023%type := sp_glgetdsc('nmlobene','ben_cvesex','........',null);
ws_etq_008 glwkcrys.cry_chr024%type := sp_glgetdsc('nmlobene','ben_tippar','........',null);
ws_etq_009 glwkcrys.cry_chr025%type := sp_glgetdsc('nmlobene','ben_nomben','........',null);
ws_etq_010 glwkcrys.cry_chr026%type := sp_glgetdsc('nmlobene','ben_keyban','........',null);
ws_etq_011 glwkcrys.cry_chr027%type := sp_glgetdsc('nmlobene','ben_ctaban','........',null);
ws_etq_012 glwkcrys.cry_chr028%type := sp_glgetdsc('nmlobene','ben_keydep','........',null);
ws_etq_013 glwkcrys.cry_chr029%type := sp_glgetdsc('nmlobene','ben_keycen','........',null);
ws_etq_014 glwkcrys.cry_chr030%type := sp_glgetdsc('nmlobene','ben_ca1aux','........',null);
ws_etq_015 glwkcrys.cry_chr031%type := sp_glgetdsc('nmlobene','ben_ca2aux','........',null);
ws_etq_016 glwkcrys.cry_chr032%type := sp_glgetdsc('nmlobebe','beb_tipben','........',null);
ws_etq_017 glwkcrys.cry_chr033%type := sp_glgetdsc('nmlobebe','beb_porpar','........',null);
ws_etq_018 glwkcrys.cry_chr034%type := sp_glgetdsc('nmlobebe','beb_fecven','........',null);
ws_etq_019 glwkcrys.cry_chr035%type := sp_glgetdsc('nmlobebe','beb_forpag','........',null);
ws_etq_020 glwkcrys.cry_chr036%type := sp_glgetdsc('nmlobebe','beb_keycon','........',null);
ws_etq_021 glwkcrys.cry_chr037%type := sp_glgetdsc('nmlobebe','beb_perini','........',null);
ws_etq_022 glwkcrys.cry_chr038%type := sp_glgetdsc('nmlobebe','beb_perfin','........',null);
ws_etq_023 glwkcrys.cry_chr039%type := 'NOMBRE';
ws_etq_024 glwkcrys.cry_chr017%type := sp_glgetdsc('nmcocenc','cen_descen','........',null);
ws_etq_025 glwkcrys.cry_chr039%type := sp_glgetdsc('nmcodeps','dep_desdep','........',null);
ws_des_cor glwkcrys.cry_chr001%type;
ws_des_lis glwkcrys.cry_chr007%type := sp_glgetrep(ws_nom_rep,'No existe nombre del Reporte',40);
-- variables para las restricciones de despliegue
ws_dsp_cam varchar(1);
wn_dsp_001 numeric(5) := 0;
wn_dsp_002 numeric(5) := 0;
wn_dsp_003 numeric(5) := 0;
wn_dsp_004 numeric(5) := 0;
wn_dsp_005 numeric(5) := 0;
wn_dsp_006 numeric(5) := 0;
wn_dsp_007 numeric(5) := 0;
wn_dsp_008 numeric(5) := 0;
wn_dsp_009 numeric(5) := 0;
wn_dsp_010 numeric(5) := 0;
wn_dsp_011 numeric(5) := 0;
wn_dsp_012 numeric(5) := 0;
wn_dsp_013 numeric(5) := 0;
wn_dsp_014 numeric(5) := 0;
wn_dsp_015 numeric(5) := 0;
wn_dsp_016 numeric(5) := 0;
wn_dsp_017 numeric(5) := 0;
wn_dsp_018 numeric(5) := 0;
wn_dsp_019 numeric(5) := 0;
wn_dsp_020 numeric(5) := 0;
wn_dsp_021 numeric(5) := 0;
-- variables para el reporte de avance
wn_tot_reg numeric(10);
wn_num_reg numeric(10)   := 0;
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5)    := 1;
ws_hor_act glwkcrys.cry_chr045%type;
ws_fec_act glwkcrys.cry_dat004%type;
-- variables para realizar cortes
wn_emp_ant glwkcrys.cry_dec006%type := -999999999;
ws_dep_ant glwkcrys.cry_chr010%type := '################';
ws_cen_ant glwkcrys.cry_chr011%type := '################';
ws_ben_ant glwkcrys.cry_chr042%type := '##';
wn_con_tad numeric(5);
wn_con_reg numeric(3) := 0;
wn_lim_ite numeric(3) := 100;
c_desplieg record;
c_nmlstben record;
c_nomemp record;
c_desdep record;
c_descen record;
c_beneficios record;
c_desben record;
begin
call sp_glfechor (ws_fec_act,ws_hor_act);
-- realiza el conteo de registros a procesar
select count(*) into strict wn_tot_reg from nmlobene
where ben_keyemp in ( select ran_keyemp from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keyemp::text, '') is not null )
and ben_keyben in ( select ran_keynom from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keynom::text, '') is not null )
and ben_comfam in ( select ran_keypro from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keypro::text, '') is not null );
-- inserta registro para monitoreo de resultados                --
insert into glcoresu(
res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
res_horreg, res_totreg, res_status )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_fec_act, ws_hor_act,
ws_hor_reg, wn_tot_reg, 'P');
-- borra la tabla de trabajo del crystal report                 --
delete from glwkcrys
where cry_nomrep = ws_nom_rep and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu;
-- nombre del corporativo
ws_des_cor:='CORPORATIVO NO REGISTRADO';
select cor_razsoc
into strict ws_des_cor from glcocorp;
-- extrae las restricciones de despliegue                       --
for c_desplieg in ( select rec_keycam, rec_despli from glcoreca
where rec_keytab = 'nmlobene' and
rec_keymen = ws_key_men ) loop
ws_key_cam := c_desplieg.rec_keycam;
ws_dsp_cam := c_desplieg.rec_despli;
if ( ws_key_cam = 'ben_keyemp') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_keyemp',ws_key_men, wn_dsp_001);
end if;
if ( ws_key_cam = 'ben_keyben') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_keyben',ws_key_men,wn_dsp_002);
end if;
if ( ws_key_cam = 'ben_comfam') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_comfam',ws_key_men,wn_dsp_003);
end if;
if ( ws_key_cam = 'ben_rfcben') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_rfcben',ws_key_men,wn_dsp_004);
end if;
if ( ws_key_cam = 'ben_nomben') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_nomben',ws_key_men,wn_dsp_005);
end if;
if ( ws_key_cam = 'ben_fecnac') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_fecnac',ws_key_men,wn_dsp_006);
end if;
if ( ws_key_cam = 'ben_cvesex') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_cvesex',ws_key_men,wn_dsp_007);
end if;
if ( ws_key_cam = 'ben_tippar') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_tippar',ws_key_men,wn_dsp_008);
end if;
if ( ws_key_cam = 'ben_keyban') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_keyban',ws_key_men,wn_dsp_009);
end if;
if ( ws_key_cam = 'ben_ctaban') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_ctaban',ws_key_men,wn_dsp_010);
end if;
if ( ws_key_cam = 'ben_keydep') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_keydep',ws_key_men,wn_dsp_011);
end if;
if ( ws_key_cam = 'ben_keycen') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_keycen',ws_key_men,wn_dsp_012);
end if;
if ( ws_key_cam = 'ben_ca1aux') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_ca1aux',ws_key_men,wn_dsp_013);
end if;
if ( ws_key_cam = 'ben_ca2aux') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobene','ben_ca2aux',ws_key_men,wn_dsp_014);
end if;
end loop;
for c_desplieg in ( select rec_keycam, rec_despli from glcoreca
where rec_keytab = 'nmlobebe'
and rec_keymen = ws_key_men ) loop
ws_key_cam := c_desplieg.rec_keycam;
ws_dsp_cam := c_desplieg.rec_despli;
if ( ws_key_cam = 'beb_tipben') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobebe','beb_tipben',ws_key_men,wn_dsp_015);
end if;
if ( ws_key_cam = 'beb_porpar') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobebe','beb_porpar',ws_key_men,wn_dsp_016);
end if;
if ( ws_key_cam = 'beb_fecven') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobebe','beb_fecven',ws_key_men,wn_dsp_017);
end if;
if ( ws_key_cam = 'beb_forpag') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobebe','beb_forpag',ws_key_men,wn_dsp_018);
end if;
if ( ws_key_cam = 'beb_keycon') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobebe','beb_keycon',ws_key_men,wn_dsp_019);
end if;
if ( ws_key_cam = 'beb_perini') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobebe','beb_perini',ws_key_men,wn_dsp_020);
end if;
if ( ws_key_cam = 'beb_perfin') and ( ws_dsp_cam = 'N') then
call sp_glnewdsp ('nmlobebe','beb_perfin',ws_key_men,wn_dsp_021);
end if;
end loop;
-- inicializa variables de trabajo para realizar cortes y monit --
wn_pct_reg := wn_tot_reg / 10.0;
-- cursor principal                                       --
/* commit; */
for c_nmlstben in ( select ben_keyemp, ben_keyben, ben_comfam, ben_rfcben, ben_nomben,
ben_fecnac, ben_cvesex, ben_tippar, ben_keyban, ben_ctaban,
ben_keydep, ben_keycen, ben_ca1aux, ben_ca2aux from nmlobene
where ben_keyemp in ( select ran_keyemp from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keyemp::text, '') is not null )
and ben_keyben in ( select ran_keynom from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keynom::text, '') is not null )
and ben_comfam in ( select ran_keypro from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keypro::text, '') is not null )) loop
-- actualiza registro de monitoreo
wn_key_emp := c_nmlstben.ben_keyemp;
wn_key_ben := c_nmlstben.ben_keyben;
wn_com_fam := c_nmlstben.ben_comfam;
ws_rfc_ben := c_nmlstben.ben_rfcben;/* dmap converted statement start */
ws_nom_ben := rtrim(c_nmlstben.ben_nomben::text);/* dmap converted statement end */
wd_fec_nac := c_nmlstben.ben_fecnac;
ws_cve_sex := c_nmlstben.ben_cvesex;
ws_tip_par := c_nmlstben.ben_tippar;
ws_key_ban := c_nmlstben.ben_keyban;
ws_cta_ban := c_nmlstben.ben_ctaban;
ws_key_dep := c_nmlstben.ben_keydep;
ws_key_cen := c_nmlstben.ben_keycen;
ws_ca1_aux := c_nmlstben.ben_ca1aux;
ws_ca2_aux := c_nmlstben.ben_ca2aux;
wn_num_reg := wn_num_reg + 1;
wn_con_reg := wn_con_reg + 1;
if wn_num_reg >= ( wn_pct_reg * wn_pct_act ) then
update glcoresu set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep and
res_idepcc = ws_ide_pcc and
res_keyusu = wn_key_usu and
res_fecini = ws_fec_act and
res_horreg = ws_hor_reg;
wn_pct_act := wn_pct_act + 1;
wn_con_reg := wn_con_reg + 1;
end if;
-- extrae descripciones del departamento, centro de costo y  --
-- nombre del empleado.                                      --
if nullif(wn_key_emp::text, '') is null then
ws_nom_emp := 'EMPLEADO NO EXISTE ...';
else
if wn_key_emp <> wn_emp_ant then
ws_nom_emp := 'EMPLEADO NO EXISTE ...';
for c_nomemp in ( select emp_nomemp from nmcoempl
where emp_keyemp = wn_key_emp ) loop
ws_nom_emp := c_nomemp.emp_nomemp;
end loop;
wn_emp_ant := wn_key_emp;
end if;
end if;
if nullif(ws_key_dep::text, '') is null then
ws_des_dep := 'DEPARTAMENTO NO EXISTE ...';
else
if ws_key_dep <> ws_dep_ant then
ws_des_dep := 'DEPARTAMENTO NO EXISTE ...';
for c_desdep in (select dep_desdep from nmcodeps
where dep_keydep = ws_key_dep ) loop
ws_des_dep := c_desdep.dep_desdep;
end loop;
ws_dep_ant := ws_key_dep;
end if;
end if;
if nullif(ws_key_cen::text, '') is null then
ws_des_cen := 'CENTRO NO EXISTE ...';
else
if ws_key_cen <> ws_cen_ant then
ws_des_cen := 'CENTRO NO EXISTE ...';
for c_descen in ( select cen_descen from nmlocenc
where cen_keycen = ws_key_cen ) loop
ws_des_cen := c_descen.cen_descen;
end loop;
ws_cen_ant := ws_key_cen;
end if;
end if;
-- cursor para extraer el detalle de los beneficios            --
wn_con_tad := 0;
for c_beneficios in ( select beb_tipben, beb_fecven, beb_porpar, beb_forpag, beb_keycon,
beb_perini, beb_perfin
from nmlobebe
where beb_keyemp = wn_key_emp and
beb_keyben = wn_key_ben and
beb_comfam = wn_com_fam and
beb_keyemp in ( select ran_keyemp from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keyemp::text, '') is not null )
and beb_keyben in ( select ran_keynom from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keynom::text, '') is not null )
and beb_comfam in ( select ran_keypro from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keypro::text, '') is not null ) ) loop
-- extrae la descripcion del tipo de beneficio                  --
ws_tip_ben := c_beneficios.beb_tipben;
wd_fec_ven := c_beneficios.beb_fecven;
wn_por_par := c_beneficios.beb_porpar;
ws_for_pag := c_beneficios.beb_forpag;
ws_key_con := c_beneficios.beb_keycon;
ws_per_ini := c_beneficios.beb_perini;
ws_per_fin := c_beneficios.beb_perfin;
if nullif(ws_tip_ben::text, '') is null then
ws_des_ben := 'BENEFICIO NO EXISTE ...';
else
if ws_tip_ben <> ws_ben_ant then
ws_des_ben := 'BENEFICIO NO EXISTE ...';
for c_desben in ( select pam_nompar from glcopams
where pam_keypar = vs_tip_ben and
pam_cvesec = ws_tip_ben ) loop
ws_des_ben := c_desben.pam_nompar;
end loop;
ws_ben_ant := ws_tip_ben;
end if;
end if;
-- aplica restricciones de despliegue de campos                 --
if wn_dsp_001 = 1 then
wn_key_emp := null;
ws_nom_emp := null;
end if;
if wn_dsp_002 = 1 then
wn_key_ben := null;
end if;
if wn_dsp_003 = 1 then
wn_com_fam := null;
end if;
if wn_dsp_004 = 1 then
ws_rfc_ben := null;
end if;
if wn_dsp_005 = 1 then
ws_nom_ben := null;
end if;
if wn_dsp_006 = 1 then
wd_fec_nac := null;
end if;
if wn_dsp_007 = 1 then
ws_cve_sex := null;
end if;
if wn_dsp_008 = 1 then
ws_tip_par := null;
end if;
if wn_dsp_009 = 1 then
ws_key_ban := null;
end if;
if wn_dsp_010 = 1 then
ws_cta_ban := null;
end if;
if wn_dsp_011 = 1 then
ws_key_dep := null;
ws_des_dep := null;
end if;
if wn_dsp_012 = 1 then
ws_key_cen := null;
ws_des_cen := null;
end if;
if wn_dsp_013 = 1 then
ws_ca1_aux := null;
end if;
if wn_dsp_014 = 1 then
ws_ca2_aux := null;
end if;
if wn_dsp_015 = 1 then
ws_tip_ben := null;
ws_des_ben := null;
end if;
if wn_dsp_016 = 1 then
wn_por_par := null;
end if;
if wn_dsp_017 = 1 then
wd_fec_ven := null;
end if;
if wn_dsp_018 = 1 then
ws_for_pag := null;
end if;
if wn_dsp_019 = 1 then
ws_key_con := null;
end if;
if wn_dsp_020 = 1 then
ws_per_ini := null;
end if;
if wn_dsp_021 = 1 then
ws_per_fin := null;
end if;
-- inserta en la tabla de trabajo del crystal report            --
insert into glwkcrys(
cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006,
cry_dec007, cry_dec008, cry_chr008, cry_chr003, cry_dat001,
cry_chr040, cry_chr041, cry_chr042, cry_dec001, cry_dat002,
cry_chr043, cry_chr009, cry_chr010, cry_chr011, cry_chr044,
cry_chr012, cry_chr013, cry_chr002, cry_chr004,
cry_chr005, cry_chr017, cry_chr018, cry_chr019, cry_chr020,
cry_chr021, cry_chr022, cry_chr023, cry_chr024, cry_chr025,
cry_chr026, cry_chr027, cry_chr028, cry_chr029, cry_chr030,
cry_chr031, cry_chr032, cry_chr033, cry_chr034, cry_chr035,
cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr045,
cry_dat004, cry_chr006, cry_chr007,
cry_chr016, cry_chr014, cry_chr015)
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_emp,
wn_key_ben, wn_com_fam, ws_rfc_ben, ws_nom_ben, wd_fec_nac,
ws_cve_sex, ws_tip_par, ws_tip_ben, wn_por_par, wd_fec_ven,
ws_key_ban, ws_cta_ban, ws_key_dep, ws_key_cen, ws_for_pag,
ws_ca1_aux, ws_ca2_aux, ws_nom_emp, ws_des_dep,
ws_des_cen, ws_etq_024, ws_etq_002, ws_etq_003, ws_etq_004,
ws_etq_001, ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009,
ws_etq_010, ws_etq_011, ws_etq_012, ws_etq_013, ws_etq_014,
ws_etq_015, ws_etq_016, ws_etq_017, ws_etq_018, ws_etq_019,
ws_etq_020, ws_etq_021, ws_etq_022, ws_etq_025, ws_hor_act,
ws_fec_act, ws_des_ben, ws_des_lis,
ws_key_con, ws_per_ini, ws_per_fin);
wn_con_tad := wn_con_tad + 1;
wn_con_reg := wn_con_reg + 1;
end loop;
if wn_con_tad = 0 then
-- aplica restricciones de despliegue de campos                 --
if wn_dsp_001 = 1 then
wn_key_emp := null;
ws_nom_emp := null;
end if;
if wn_dsp_002 = 1 then
wn_key_ben := null;
end if;
if wn_dsp_003 = 1 then
wn_com_fam := null;
end if;
if wn_dsp_004 = 1 then
ws_rfc_ben := null;
end if;
if wn_dsp_005 = 1 then
ws_nom_ben := null;
end if;
if wn_dsp_006 = 1 then
wd_fec_nac := null;
end if;
if wn_dsp_007 = 1 then
ws_cve_sex := null;
end if;
if wn_dsp_008 = 1 then
ws_tip_par := null;
end if;
if wn_dsp_009 = 1 then
ws_key_ban := null;
end if;
if wn_dsp_010 = 1 then
ws_cta_ban := null;
end if;
if wn_dsp_011 = 1 then
ws_key_dep := null;
ws_des_dep := null;
end if;
if wn_dsp_012 = 1 then
ws_key_cen := null;
ws_des_cen := null;
end if;
if wn_dsp_013 = 1 then
ws_ca1_aux := null;
end if;
if wn_dsp_014 = 1 then
ws_ca2_aux := null;
end if;
-- inserta en la tabla de trabajo del crystal report            --
insert into glwkcrys(
cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006,
cry_dec007, cry_dec008, cry_chr008, cry_chr003, cry_dat001,
cry_chr040, cry_chr041, cry_chr043, cry_chr009, cry_chr010,
cry_chr011, cry_chr012, cry_chr013, cry_chr002, cry_chr004,
cry_chr005, cry_chr017, cry_chr018, cry_chr019, cry_chr020,
cry_chr021, cry_chr022, cry_chr023, cry_chr024, cry_chr025,
cry_chr026, cry_chr027, cry_chr028, cry_chr029, cry_chr030,
cry_chr031, cry_chr032, cry_chr033, cry_chr034, cry_chr035,
cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr045,
cry_dat004, cry_chr007 )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_emp,
wn_key_ben, wn_com_fam, ws_rfc_ben, ws_nom_ben, wd_fec_nac,
ws_cve_sex, ws_tip_par, ws_key_ban, ws_cta_ban, ws_key_dep,
ws_key_cen, ws_ca1_aux, ws_ca2_aux, ws_nom_emp, ws_des_dep,
ws_des_cen, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004,
ws_etq_001, ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009,
ws_etq_010, ws_etq_011, ws_etq_012, ws_etq_013, ws_etq_014,
ws_etq_015, ws_etq_016, ws_etq_017, ws_etq_018, ws_etq_019,
ws_etq_020, ws_etq_021, ws_etq_022, ws_etq_023, ws_hor_act,
ws_fec_act, ws_des_lis );
wn_con_reg := wn_con_reg + 1;
end if;
if wn_con_reg >= wn_lim_ite then
/* commit; */
wn_con_reg := 0;
end if;
end loop;
-- actualiza la tabla de monitoreo indicando la finalizacion    --
-- del proceso.                                                 --
call sp_glfechor (ws_fec_act,ws_hor_act);
update glcoresu set res_numreg = wn_num_reg,
res_fecfin = ws_fec_act,
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep and
res_idepcc = ws_ide_pcc and
res_keyusu = wn_key_usu and
res_fecini = ws_fec_act and
res_horreg = ws_hor_reg;
/* commit; */
end;
$body$
language plpgsql
;
