create or replace procedure labprod."sp_nmlstcxp"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_lee_dfc varchar(1);
wn_pro_ant numeric(5) := -32760;
wn_nom_ant numeric(5) := -32760;
-- variables para las restricciones de despliegue.
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
wn_dsp_015 numeric(5);
wn_dsp_016 numeric(5);
wn_dsp_017 numeric(5);
wn_dsp_018 numeric(5);
wn_dsp_019 numeric(5);  --rdd
wn_dsp_020 numeric(5);  --rdd
-- variables para la carga de las descripciones de las claves.
ws_des_cor glwkcrys.cry_chr001%type;
ws_des_pro glwkcrys.cry_chr003%type;
ws_des_nom glwkcrys.cry_chr004%type;
ws_des_con glwkcrys.cry_chr005%type;
ws_key_con glwkcrys.cry_chr008%type;
ws_key_for glwkcrys.cry_chr009%type;
ws_for_val glwkcrys.cry_chr038%type; --rdd
ws_lee_inc glwkcrys.cry_chr010%type;
ws_lee_dfi glwkcrys.cry_chr011%type;
ws_lee_pre glwkcrys.cry_chr012%type;
ws_lee_acu glwkcrys.cry_chr013%type;
ws_lee_aus glwkcrys.cry_chr038%type; --rdd
ws_cod_acu glwkcrys.cry_chr014%type;
ws_cod_imp glwkcrys.cry_chr015%type;
ws_cod_val glwkcrys.cry_chr016%type;
wn_key_pro glwkcrys.cry_dec006%type;
wn_key_nom glwkcrys.cry_dec007%type;
wn_uni_ini glwkcrys.cry_dec003%type;
wn_uni_fin glwkcrys.cry_dec004%type;
wn_imp_ini glwkcrys.cry_dec005%type;
wn_imp_fin glwkcrys.cry_dec001%type;
wn_num_sec glwkcrys.cry_dec008%type;
wn_por_cen glwkcrys.cry_dec002%type;
ws_des_lis glwkcrys.cry_chr002%type := sp_glgetrep('nmrspcxp', 'No existe Nombre del Reporte...', null);
ws_etq_001 glwkcrys.cry_chr020%type := sp_glgetdsc('nmlocxpr', 'cxp_keypro', '........', null);
ws_etq_002 glwkcrys.cry_chr021%type := sp_glgetdsc('nmlocxpr', 'cxp_keynom', '........', null);
ws_etq_003 glwkcrys.cry_chr022%type := sp_glgetdsc('nmlocxpr', 'cxp_numsec', '........', null);
ws_etq_004 glwkcrys.cry_chr023%type := sp_glgetdsc('nmlocxpr', 'cxp_keycon', '........', null);
ws_etq_005 glwkcrys.cry_chr024%type := sp_glgetdsc('nmlocxpr', 'cxp_keyfor', '........', null);
ws_etq_006 glwkcrys.cry_chr025%type := sp_glgetdsc('nmlocxpr', 'cxp_leeinc', '........', null);
ws_etq_007 glwkcrys.cry_chr026%type := sp_glgetdsc('nmlocxpr', 'cxp_leedfi', '........', null);
ws_etq_008 glwkcrys.cry_chr027%type := sp_glgetdsc('nmlocxpr', 'cxp_leepre', '........', null);
ws_etq_009 glwkcrys.cry_chr028%type := sp_glgetdsc('nmlocxpr', 'cxp_leeacu', '........', null);
ws_etq_010 glwkcrys.cry_chr029%type := sp_glgetdsc('nmlocxpr', 'cxp_codacu', '........', null);
ws_etq_011 glwkcrys.cry_chr030%type := sp_glgetdsc('nmlocxpr', 'cxp_codimp', '........', null);
ws_etq_012 glwkcrys.cry_chr031%type := sp_glgetdsc('nmlocxpr', 'cxp_codval', '........', null);
ws_etq_013 glwkcrys.cry_chr032%type := sp_glgetdsc('nmlocxpr', 'cxp_uniini', '........', null);
ws_etq_014 glwkcrys.cry_chr033%type := sp_glgetdsc('nmlocxpr', 'cxp_unifin', '........', null);
ws_etq_015 glwkcrys.cry_chr034%type := sp_glgetdsc('nmlocxpr', 'cxp_impini', '........', null);
ws_etq_016 glwkcrys.cry_chr035%type := sp_glgetdsc('nmlocxpr', 'cxp_impfin', '........', null);
ws_etq_017 glwkcrys.cry_chr006%type := sp_glgetdsc('nmloconc', 'con_descon', '........', null);
ws_etq_018 glwkcrys.cry_chr037%type := sp_glgetdsc('nmlocxpr', 'cxp_porcen', '........', null);
ws_etq_019 glwkcrys.cry_chr019%type := sp_glgetdsc('nmlocxpr', 'cxp_leedfc', '........', null);
ws_etq_020 glwkcrys.cry_chr036%type := sp_glgetdsc('nmlocxpr', 'cxp_forval', '........', null); --rdd
ws_etq_021 glwkcrys.cry_chr036%type := sp_glgetdsc('nmlocxpr', 'cxp_leeaus', '........', null); --rdd
wd_fec_act glwkcrys.cry_dat001%type;
-- variables para el reporte de avance.
wn_tot_reg numeric(10);
wn_num_reg numeric(10)  := 0;
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5)   := 1;
ws_hor_act varchar(8);
wn_con_reg numeric(3) := 0;
wn_lim_ite numeric(3) := 100;
c_nmlstcxp record;
c_descon record;
c_despro record;
c_desnom record;
begin
call sp_glfechor (wd_fec_act,ws_hor_act);
call sp_glnewdsp ('nmlobene','ben_keyben',ws_key_men,wn_dsp_002);
call sp_glnewdsp ('nmlocxpr', 'cxp_keypro', ws_key_men,wn_dsp_001);
call sp_glnewdsp ('nmlocxpr', 'cxp_keynom', ws_key_men,wn_dsp_002);
call sp_glnewdsp ('nmlocxpr', 'cxp_numsec', ws_key_men,wn_dsp_003);
call sp_glnewdsp ('nmlocxpr', 'cxp_keycon', ws_key_men,wn_dsp_004);
call sp_glnewdsp ('nmlocxpr', 'cxp_keyfor', ws_key_men,wn_dsp_005);
call sp_glnewdsp ('nmlocxpr', 'cxp_leeinc', ws_key_men,wn_dsp_006);
call sp_glnewdsp ('nmlocxpr', 'cxp_leedfi', ws_key_men,wn_dsp_007);
call sp_glnewdsp ('nmlocxpr', 'cxp_leepre', ws_key_men,wn_dsp_008);
call sp_glnewdsp ('nmlocxpr', 'cxp_leeacu', ws_key_men,wn_dsp_009);
call sp_glnewdsp ('nmlocxpr', 'cxp_codacu', ws_key_men,wn_dsp_010);
call sp_glnewdsp ('nmlocxpr', 'cxp_codimp', ws_key_men,wn_dsp_011);
call sp_glnewdsp ('nmlocxpr', 'cxp_codval', ws_key_men,wn_dsp_012);
call sp_glnewdsp ('nmlocxpr', 'cxp_uniini', ws_key_men,wn_dsp_013);
call sp_glnewdsp ('nmlocxpr', 'cxp_unifin', ws_key_men,wn_dsp_014);
call sp_glnewdsp ('nmlocxpr', 'cxp_impini', ws_key_men,wn_dsp_015);
call sp_glnewdsp ('nmlocxpr', 'cxp_impfin', ws_key_men,wn_dsp_016);
call sp_glnewdsp ('nmlocxpr', 'cxp_porcen', ws_key_men,wn_dsp_017);
call sp_glnewdsp ('nmlocxpr', 'cxp_leedfc', ws_key_men,wn_dsp_018);
call sp_glnewdsp ('nmlocxpr', 'cxp_forval', ws_key_men,wn_dsp_019);
call sp_glnewdsp ('nmlocxpr', 'cxp_leeaus', ws_key_men,wn_dsp_020);
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
select cor_razsoc into strict ws_des_cor
from glcocorp;
-- realiza el conteo de registros a procesar.
select count(*)
into strict wn_tot_reg
from nmlocxpr
where cxp_keypro in (select ran_keypro
from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keypro::text, '') is not null) and
cxp_keynom in (select ran_keynom
from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keynom::text, '') is not null);
insert into glcoresu(res_idepro, res_idepcc, res_keyusu, res_fecini,
res_horini, res_horreg, res_totreg, res_status)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, wd_fec_act,
ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
-- borra la tabla de trabajo del crystal report.
delete from glwkcrys
where cry_nomrep = ws_nom_rep and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu;
/* commit; */
-- inicializa variables de trabajo para realizar cortes y monit.
wn_pct_reg := wn_tot_reg / 10.0;
-- define cursor principal.
for c_nmlstcxp in (select cxp_keypro, cxp_keynom, cxp_numsec, cxp_keycon, cxp_keyfor,
cxp_leeinc, cxp_leedfi, cxp_leepre, cxp_leeacu, cxp_codacu,
cxp_codimp, cxp_codval, cxp_uniini, cxp_unifin, cxp_impini,
cxp_impfin, cxp_porcen, cxp_leedfc, cxp_forval, cxp_leeaus -- rdd
from nmlocxpr
where cxp_keypro in (select ran_keypro
from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keypro::text, '') is not null) and
cxp_keynom in (select ran_keynom
from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keynom::text, '') is not null)
order by  cxp_keypro, cxp_keynom) loop
-- asignaci"n de valores.
wn_key_pro := c_nmlstcxp.cxp_keypro;
wn_key_nom := c_nmlstcxp.cxp_keynom;
wn_num_sec := c_nmlstcxp.cxp_numsec;
ws_key_con := c_nmlstcxp.cxp_keycon;
ws_key_for := c_nmlstcxp.cxp_keyfor;
ws_lee_inc := c_nmlstcxp.cxp_leeinc;
ws_lee_dfi := c_nmlstcxp.cxp_leedfi;
ws_lee_pre := c_nmlstcxp.cxp_leepre;
ws_lee_acu := c_nmlstcxp.cxp_leeacu;
ws_cod_acu := c_nmlstcxp.cxp_codacu;
ws_cod_imp := c_nmlstcxp.cxp_codimp;
ws_cod_val := c_nmlstcxp.cxp_codval;
wn_uni_ini := c_nmlstcxp.cxp_uniini;
wn_uni_fin := c_nmlstcxp.cxp_unifin;
wn_imp_ini := c_nmlstcxp.cxp_impini;
wn_imp_fin := c_nmlstcxp.cxp_impfin;
wn_por_cen := c_nmlstcxp.cxp_porcen;
ws_lee_dfc := c_nmlstcxp.cxp_leedfc;
ws_for_val := c_nmlstcxp.cxp_forval; --rdd
ws_lee_aus := c_nmlstcxp.cxp_leeaus; --rdd
/* dmap converted statement start */
if nullif(rtrim(ws_lee_aus::text)::text, '') is null or nullif(ws_lee_aus::text, '') is null then --rdd
ws_lee_aus := 'N';/* dmap converted statement end */
end if;
-- actualiza registro de monitoreo.
wn_num_reg := wn_num_reg + 1;
if wn_num_reg >= (wn_pct_reg * wn_pct_act) then
update glcoresu
set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = wd_fec_act and
res_horreg = ws_hor_reg;
wn_pct_act := wn_pct_act + 1;
wn_con_reg := wn_con_reg + 1;
end if;
-- extrae descripciones de concepto, proceso y tipo de nomina.
ws_des_con := 'CONCEPTO NO EXISTE ...';
for c_descon in (select con_descon
from nmloconc
where con_keycon = ws_key_con) loop
ws_des_con := c_descon.con_descon;
end loop;
if nullif(wn_key_pro::text, '') is null then
ws_des_pro := 'PROCESO NO EXISTE ...';
else
if wn_key_pro <> wn_pro_ant then
ws_des_pro := 'PROCESO NO EXISTE ...';
for c_despro in (select pro_despro
from nmloproc
where pro_keypro = wn_key_pro) loop
ws_des_pro := c_despro.pro_despro;
end loop;
wn_pro_ant := wn_key_pro;
end if;
end if;
if nullif(wn_key_nom::text, '') is null then
ws_des_nom := 'TIPO DE NOMINA NO EXISTE ..';
else
if wn_key_nom <> wn_nom_ant then
ws_des_nom := 'TIPO DE NOMINA NO EXISTE ...';
for c_desnom in (select nom_destip
from nmlonomi
where nom_keynom = wn_key_nom) loop
ws_des_nom := c_desnom.nom_destip;
end loop;
wn_nom_ant := wn_key_nom;
end if;
end if;
-- aplica restricciones de despliegue de campos.
if wn_dsp_001 = 1 then
wn_key_pro := null;
ws_des_pro := null;
end if;
if wn_dsp_002 = 1 then
wn_key_nom := null;
ws_des_nom := null;
end if;
if wn_dsp_004 = 1 then
ws_key_con := null;
ws_des_con := null;
end if;
if wn_dsp_003 = 1 then
wn_num_sec := null;
end if;
if wn_dsp_005 = 1 then
ws_key_for := null;
end if;
if wn_dsp_006 = 1 then
ws_lee_inc := null;
end if;
if wn_dsp_007 = 1 then
ws_lee_dfi := null;
end if;
if wn_dsp_008 = 1 then
ws_lee_pre := null;
end if;
if wn_dsp_009 = 1 then
ws_lee_acu := null;
end if;
if wn_dsp_010 = 1 then
ws_cod_acu := null;
end if;
if wn_dsp_011 = 1 then
ws_cod_imp := null;
end if;
if wn_dsp_012 = 1 then
ws_cod_val := null;
end if;
if wn_dsp_013 = 1 then
wn_uni_ini := null;
end if;
if wn_dsp_014 = 1 then
wn_uni_fin := null;
end if;
if wn_dsp_015 = 1 then
wn_imp_ini := null;
end if;
if wn_dsp_016 = 1 then
wn_imp_fin := null;
end if;
if wn_dsp_017 = 1 then
wn_por_cen := null;
end if;
if wn_dsp_018 = 1 then
ws_lee_dfc := null;
end if;
if wn_dsp_019 = 1 then --rdd
ws_for_val := null;
end if;
if wn_dsp_020 = 1 then --rdd
ws_lee_aus := null;
end if;
-- inserta en la tabla de trabajo del crystal report.
insert into glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr003, cry_chr004,
cry_chr005, cry_chr008, cry_chr009, cry_chr010, cry_chr011, cry_chr012,
cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_dec006, cry_dec007,
cry_dec003, cry_dec004, cry_dec005, cry_dec001, cry_dec008, cry_dec002,
cry_chr002, cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr024,
cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_chr029, cry_chr030,
cry_chr031, cry_chr032, cry_chr033, cry_chr034, cry_chr035, cry_chr006,
cry_dat001, cry_chr017, cry_chr037, cry_chr018, cry_chr019,
cry_chr036, cry_chr038, cry_chr039, cry_chr040) --rdd cry_chr36,cry_chr038
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_des_pro, ws_des_nom,
ws_des_con, ws_key_con, ws_key_for, ws_lee_inc, ws_lee_dfi, ws_lee_pre,
ws_lee_acu, ws_cod_acu, ws_cod_imp, ws_cod_val, wn_key_pro, wn_key_nom,
wn_uni_ini, wn_uni_fin, wn_imp_ini, wn_imp_fin, wn_num_sec, wn_por_cen,
ws_des_lis, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009, ws_etq_010, ws_etq_011,
ws_etq_012, ws_etq_013, ws_etq_014, ws_etq_015, ws_etq_016, ws_etq_017,
wd_fec_act, ws_hor_act, ws_etq_018, ws_lee_dfc, ws_etq_019,
ws_etq_020, ws_for_val, ws_etq_021, ws_lee_aus); --rdd ws_etq_020
wn_con_reg := wn_con_reg + 1;
if wn_con_reg = wn_lim_ite then
/* commit; */
wn_con_reg := 0;
end if;
end loop;
-- actualiza la tabla de monitoreo indicando la finalizacion del proceso.
call sp_glfechor (wd_fec_act,ws_hor_act);
update glcoresu
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
end;
$body$
language plpgsql
;
