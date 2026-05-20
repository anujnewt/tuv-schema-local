create or replace procedure usrsiho."sp_nmrepamo"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar, wn_key_pro numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- sipros, s.a. de c.v.
--
-- sistema  : rh-2000 c/s
-- modulo   : administracion de remuneraciones (nm)
--
-- programa : sp_nmreppre
--            reporte de prestamos
--
-- autor    : gabriela paredes romano.
-- fecha    : 29 de septiembre  de 1997.
--
-- variables para obtener los datos de la tabla de prestamos
wn_key_emp numeric(10);
ws_nom_emp varchar(50);
ws_key_con varchar(3);
ws_des_con varchar(50);
ws_ref_ere varchar(20);
wn_uni_pre decimal(12,2);
wn_imp_pre decimal(12,2);
ws_fec_ini timestamp(0);
wn_uni_sal decimal(12,2);
wn_imp_sal decimal(12,2);
ws_fec_pag timestamp(0);
wn_uni_pag decimal(12,2);
wn_imp_pag decimal(12,2);
wn_int_pag decimal(12,2);
wn_por_int decimal(6,4);
ws_key_per varchar(7);
wn_imp_des decimal(12,2);
wn_uni_des decimal(12,2);
wn_num_pag numeric(10);
wn_pla_zop numeric(10);
ws_sta_tus varchar(8);
wn_uni_amo decimal(12,2);
wn_imp_amo decimal(12,2);
wn_uni_ini decimal(12,2);
wn_imp_ini decimal(12,2);
wn_uni_tem decimal(12,2);
wn_imp_tem decimal(12,2);
ws_des_cor varchar(60);
ws_des_lis varchar(50);
ws_key_cia varchar(2);
-- variables para la carga de las descripciones de las etiquetas--
ws_key_cam varchar(20);
ws_des_etq varchar(8);
ws_etq_001 varchar(8);
ws_etq_002 varchar(8);
ws_etq_003 varchar(8);
ws_etq_004 varchar(8);
ws_etq_005 varchar(8);
ws_etq_006 varchar(8);
ws_etq_007 varchar(8);
ws_etq_008 varchar(8);
ws_etq_009 varchar(8);
ws_etq_010 varchar(8);
ws_etq_011 varchar(8);
ws_etq_012 varchar(8);
ws_etq_013 varchar(8);
ws_etq_014 varchar(8);
ws_etq_015 varchar(8);
ws_etq_016 varchar(8);
ws_etq_017 varchar(8);
ws_etq_018 varchar(8);
ws_etq_019 varchar(8);
ws_etq_020 varchar(8);
ws_etq_021 varchar(8);
ws_etq_022 varchar(8);
ws_etq_023 varchar(8);
-- variables para las restricciones de despliegue               --
wn_dsp_001 numeric(5);
wn_dsp_003 numeric(5);
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
wn_dsp_019 numeric(5);
wn_dsp_020 numeric(5);
wn_dsp_021 numeric(5);
wn_dsp_022 numeric(5);
wn_dsp_023 numeric(5);
-- variables para el reporte de avance                          --
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5);
ws_hor_act varchar(8);
wd_fec_act timestamp(0);
wn_pro_ant numeric(10);
wn_nom_ant numeric(10);
c_lista cursor for
select lis_deslis from usrsiho.glcolist
where lis_keylis = ws_nom_rep;
c_etiqueta cursor for
select cam_keycam, cam_descor
from usrsiho.glcocamp
where cam_keytab = 'nmlopres' or cam_keytab = 'nmloamor';
c_etiquetas cursor for
select cam_keycam, cam_descor
from usrsiho.glcocamp
where cam_keytab = 'nmloconc'
or cam_keytab='nmcoempl';
c_descon cursor for
select con_descon from usrsiho.nmloconc
where con_keycon = ws_key_con;
c_nomemp cursor for
select emp_nomemp from usrsiho.nmcoempl
where emp_keyemp = wn_key_emp;
c_nmlstpre cursor for
select pre_keyemp, pre_keycon, pre_refere, pre_unipre, pre_imppre,
pre_fecini, pre_unisal, pre_impsal, amo_fecpag, amo_unipag,
amo_imppag, amo_intpag, amo_porint, amo_keyper, amo_numpag,
pre_plazop, pre_status, pre_unides, pre_impdes, pre_uniamo,
pre_impamo, pre_keypro
from usrsiho.nmlopres, usrsiho.nmloamor
where pre_keycon in ( select ran_keycon from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keycon::text, '') is not null )
and pre_keyemp in ( select ran_keyemp from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and pre_keyemp = amo_keyemp
and pre_keycon = amo_keycon
--and pre_refere = amo_refere
and pre_keypro = wn_key_pro
order by pre_keyemp,amo_numpag;
begin
-- realiza el conteo de registros a procesar                    --
perform dbms_output.put_line('inicio..');
begin
select count(*)
into strict wn_tot_reg
from usrsiho.nmlopres,usrsiho.nmloamor
where pre_keycon in ( select ran_keycon from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keycon::text, '') is not null )
and pre_keyemp in ( select ran_keyemp from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and pre_keyemp = amo_keyemp
and pre_keycon = amo_keycon
and pre_refere = amo_refere
and pre_keypro = wn_key_pro;
exception when no_data_found then wn_tot_reg := 0;
end;
-- inserta registro para monitoreo de resultados                --
wd_fec_act := trunc(clock_timestamp());
ws_hor_act := to_char(clock_timestamp(), 'hh24:mi:ss');
insert into usrsiho.glcoresu(
res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
res_horreg, res_totreg, res_status )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, trunc(clock_timestamp()), ws_hor_act,
ws_hor_reg, wn_tot_reg, 'P' );
-- borra la tabla de trabajo del crystal report                 --
delete from usrsiho.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu;
-- extrae el nombre del reporte
ws_des_lis := 'No existe Nombre del Reporte ...';
for rec in c_lista loop
ws_des_lis := rec.lis_deslis;
end loop;
-- asigna valores por omision a las etiquetas del diccionario de datos --
ws_etq_001 := '........';
ws_etq_002 := '........';
ws_etq_003 := '........';
ws_etq_004 := '........';
ws_etq_005 := '........';
ws_etq_006 := '........';
ws_etq_007 := '........';
ws_etq_008 := '........';
ws_etq_009 := '........';
ws_etq_010 := '........';
ws_etq_011 := '........';
ws_etq_012 := '........';
ws_etq_013 := '........';
ws_etq_014 := '........';
ws_etq_015 := '........';
ws_etq_016 := '........';
ws_etq_017 := '........';
ws_etq_018 := '........';
ws_etq_019 := '........';
ws_etq_020 := '........';
ws_etq_021 := '........';
ws_etq_022 := '........';
ws_etq_023 := '........';
-- extrae las etiquetas del diccionario de datos                --
for rec2 in c_etiqueta loop
ws_key_cam := rec2.cam_keycam;
ws_des_etq := rec2.cam_descor;
if ws_key_cam = 'pre_keyemp' then
ws_etq_001 := ws_des_etq;
end if;
if ws_key_cam = 'pre_keycon' then
ws_etq_003 := ws_des_etq;
end if;
if ws_key_cam = 'pre_refere' then
ws_etq_005 := ws_des_etq;
end if;
if ws_key_cam = 'pre_unipre' then
ws_etq_006 := ws_des_etq;
end if;
if ws_key_cam = 'pre_imppre' then
ws_etq_007 := ws_des_etq;
end if;
if ws_key_cam = 'pre_fecini' then
ws_etq_008 := ws_des_etq;
end if;
if ws_key_cam = 'pre_unisal' then
ws_etq_009 := ws_des_etq;
end if;
if ws_key_cam = 'pre_impsal' then
ws_etq_010 := ws_des_etq;
end if;
if ws_key_cam = 'amo_fecpag' then
ws_etq_011 := ws_des_etq;
end if;
if ws_key_cam = 'amo_unipag' then
ws_etq_012 := ws_des_etq;
end if;
if ws_key_cam = 'amo_imppag' then
ws_etq_013 := ws_des_etq;
end if;
if ws_key_cam = 'amo_intpag' then
ws_etq_014 := ws_des_etq;
end if;
if ws_key_cam = 'amo_porint' then
ws_etq_015 := ws_des_etq;
end if;
if ws_key_cam = 'amo_keyper' then
ws_etq_016 := ws_des_etq;
end if;
if ws_key_cam = 'amo_numpag' then
ws_etq_017 := ws_des_etq;
end if;
if ws_key_cam = 'pre_plazop' then
ws_etq_018 := ws_des_etq;
end if;
if ws_key_cam = 'pre_status' then
ws_etq_019 := ws_des_etq;
end if;
if ws_key_cam = 'pre_unides' then
ws_etq_020 := ws_des_etq;
end if;
if ws_key_cam = 'pre_impdes' then
ws_etq_021 := ws_des_etq;
end if;
if ws_key_cam = 'pre_uniamo' then
ws_etq_022 := ws_des_etq;
end if;
if ws_key_cam = 'pre_impamo' then
ws_etq_023 := ws_des_etq;
end if;
end loop;
-- extrae las etiquetas del diccionario de datos
for rec3 in c_etiquetas loop
ws_key_cam := rec3.cam_keycam;
ws_des_etq := rec3.cam_descor;
if ws_key_cam = 'con_descon' then
ws_etq_004 := ws_des_etq;
end if;
if ws_key_cam = 'emp_nomemp' then
ws_etq_002 := ws_des_etq;
end if;
end loop;
-- asigna restriccionee dee ddpliegue                           --
--sp_glgetdsp ('nmlopres', 'pre_keycon', ws_key_men, wn_dsp_001);
perform dbms_output.put_line('ejecuta otro stored..');
call sp_glgetdsp ( 'nmlopres', 'pre_keyemp', ws_key_men,wn_dsp_001 );
call sp_glgetdsp ( 'nmlopres', 'pre_keycon', ws_key_men ,wn_dsp_003);
call sp_glgetdsp ( 'nmlopres', 'pre_refere', ws_key_men, wn_dsp_005);
call sp_glgetdsp ( 'nmlopres', 'pre_unipre', ws_key_men , wn_dsp_006);
call sp_glgetdsp ( 'nmlopres', 'pre_imppre', ws_key_men , wn_dsp_007);
call sp_glgetdsp ( 'nmlopres', 'pre_fecini', ws_key_men, wn_dsp_008);
call sp_glgetdsp ( 'nmlopres', 'pre_unisal', ws_key_men, wn_dsp_009);
call sp_glgetdsp ( 'nmlopres', 'pre_impsal', ws_key_men, wn_dsp_010);
call sp_glgetdsp ( 'nmloamor', 'amo_fecpag', ws_key_men, wn_dsp_011);
call sp_glgetdsp ( 'nmloamor', 'amo_unipag', ws_key_men, wn_dsp_012);
call sp_glgetdsp ( 'nmloamor', 'amo_imppag', ws_key_men, wn_dsp_013);
call sp_glgetdsp ( 'nmloamor', 'amo_intpag', ws_key_men, wn_dsp_014);
call sp_glgetdsp ( 'nmloamor', 'amo_porint', ws_key_men, wn_dsp_015);
call sp_glgetdsp ( 'nmloamor', 'amo_keyper', ws_key_men, wn_dsp_016);
call sp_glgetdsp ( 'nmloamor', 'amo_numpag', ws_key_men, wn_dsp_017);
call sp_glgetdsp ( 'nmlopres', 'pre_plazop', ws_key_men, wn_dsp_018);
call sp_glgetdsp ( 'nmlopres', 'pre_status', ws_key_men, wn_dsp_019);
call sp_glgetdsp ( 'nmlopres', 'pre_unides', ws_key_men, wn_dsp_020);
call sp_glgetdsp ( 'nmlopres', 'pre_impdes', ws_key_men, wn_dsp_021);
call sp_glgetdsp ( 'nmlopres', 'pre_uniamo', ws_key_men, wn_dsp_022);
call sp_glgetdsp ( 'nmlopres', 'pre_impamo', ws_key_men, wn_dsp_023);
-- inicializa variables de trabajo para reallzar cortes y monit ---
wn_pro_ant := -32760;
wn_nom_ant := -32760;
wn_num_reg := 0;
wn_pct_act := 1;
wn_pct_reg := wn_tot_reg / 10.0;
wn_uni_ini := 0;
wn_imp_ini := 0;
-- define cursor principal
for rec4 in c_nmlstpre loop
-- extraer el nombre de la empresa
perform dbms_output.put_line('dentro ciclo..');
wn_key_emp := rec4.pre_keyemp;
ws_key_con := rec4.pre_keycon;
ws_ref_ere := rec4.pre_refere;
wn_uni_pre := rec4.pre_unipre;
wn_imp_pre := rec4.pre_imppre;
ws_fec_ini := rec4.pre_fecini;
wn_uni_sal := rec4.pre_unisal;
wn_imp_sal := rec4.pre_impsal;
ws_fec_pag := rec4.amo_fecpag;
wn_uni_pag := rec4.amo_unipag;
wn_imp_pag := rec4.amo_imppag;
wn_int_pag := rec4.amo_intpag;
wn_por_int := rec4.amo_porint;
ws_key_per := rec4.amo_keyper;
wn_num_pag := rec4.amo_numpag;
wn_pla_zop := rec4.pre_plazop;
ws_sta_tus := rec4.pre_status;
wn_uni_des := rec4.pre_unides;
wn_imp_des := rec4.pre_impdes;
wn_uni_amo := rec4.pre_uniamo;
wn_imp_amo := rec4.pre_impamo;
--wn_key_pro := rec4.pre_keypro;
ws_key_cia:= null;
begin
select pro_keycia
into strict ws_key_cia
from nmloproc
where pro_keypro = wn_key_pro;
exception when no_data_found then ws_key_cia:= null;
end;
ws_des_cor := 'EMPRESA NO EXISTE ...';
begin
select cia_descia
into strict ws_des_cor
from nmlocias
where cia_keycia = ws_key_cia;
exception when no_data_found then ws_des_cor:= null;
end;
-- actualiza registro de monitoreo                              --
wn_num_reg := wn_num_reg + 1;
if wn_num_reg >= ( wn_pct_reg * wn_pct_act ) then
update glcoresu set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = trunc(clock_timestamp())
and res_horreg = ws_hor_reg;
wn_pct_act := wn_pct_act + 1;
end if;
-- extrae descripcionnde concepto, y nombre del empleado  --
ws_des_con := 'CONCEPTO NO EXISTE ...';
for rec5 in c_descon loop
ws_des_con := rec5.con_descon;
end loop;
ws_nom_emp := 'EMPLEADO NO EXISTE ...';
for rec6 in c_nomemp loop
ws_nom_emp := rec6.emp_nomemp;
end loop;
-- aplica restricciones de despliegue de campos                 --
if wn_dsp_001 = 1 then
wn_key_emp := null;
ws_nom_emp := null;
end if;
if wn_dsp_003 = 1 then
ws_key_con := null;
ws_des_con := null;
end if;
if ws_sta_tus = '1' then
ws_sta_tus := 'Proc. Ad.';
end if;
if ws_sta_tus = '2' then
ws_sta_tus := 'Vigente';
end if;
if ws_sta_tus = '3' then
ws_sta_tus := 'Redimido';
end if;
if ws_sta_tus = '4' then
ws_sta_tus := 'Suspend';
end if;
if wn_dsp_005 = 1 then ws_ref_ere := null; end if;
if wn_dsp_006 = 1 then wn_uni_pre := null; end if;
if wn_dsp_007 = 1 then wn_imp_pre := null; end if;
if wn_dsp_008 = 1 then ws_fec_ini := null; end if;
if wn_dsp_009 = 1 then wn_uni_sal := null; end if;
if wn_dsp_010 = 1 then wn_imp_sal := null; end if;
if wn_dsp_011 = 1 then ws_fec_pag := null; end if;
if wn_dsp_012 = 1 then wn_uni_pag := null; end if;
if wn_dsp_013 = 1 then wn_imp_pag := null; end if;
if wn_dsp_014 = 1 then wn_int_pag := null; end if;
if wn_dsp_015 = 1 then wn_por_int := null; end if;
if wn_dsp_016 = 1 then ws_key_per := null; end if;
if wn_dsp_017 = 1 then wn_num_pag := null; end if;
if wn_dsp_018 = 1 then wn_pla_zop := null; end if;
if wn_dsp_019 = 1 then ws_sta_tus := null; end if;
if wn_dsp_020 = 1 then wn_uni_des := null; end if;
if wn_dsp_021 = 1 then wn_imp_des := null; end if;
if wn_dsp_022 = 1 then wn_uni_amo := null; end if;
if wn_dsp_023 = 1 then wn_imp_amo := null; end if;
-- inserta en la tabla de trabajo del crystal report            --
if wn_num_pag = 1 then
wn_uni_ini := wn_uni_pre;
wn_imp_ini := wn_imp_pre;
else
wn_uni_ini := wn_uni_ini - wn_uni_tem;
wn_imp_ini := wn_imp_ini - wn_imp_tem;
end if;
insert into glwkcrys(
cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006,
cry_chr003, cry_chr017, cry_chr004, cry_chr008, cry_dec011,
cry_dec012, cry_dat001, cry_dec013, cry_dec014, cry_dat002,
cry_dec015, cry_dec016, cry_dec017, cry_dec018, cry_chr018,
cry_dec007, cry_dec008, cry_chr037, cry_dec019, cry_dec020,
cry_dec021, cry_dec022, cry_dec023, cry_dec024,
cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr024,
cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_chr029,
cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
cry_chr035, cry_chr038, cry_chr039, cry_chr040, cry_chr041,
cry_chr042, cry_chr043, cry_chr044,
cry_dat003, cry_chr036, cry_chr002 )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_emp,
ws_nom_emp, ws_key_con, ws_des_con, ws_ref_ere, wn_uni_pre,
wn_imp_pre, ws_fec_ini, wn_uni_sal, wn_imp_sal, ws_fec_pag,
wn_uni_pag, wn_imp_pag, wn_int_pag, wn_por_int, ws_key_per,
wn_num_pag, wn_pla_zop, ws_sta_tus, wn_uni_des, wn_imp_des,
wn_uni_amo, wn_imp_amo, wn_uni_ini, wn_imp_ini,
ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009, ws_etq_010,
ws_etq_011, ws_etq_012, ws_etq_013, ws_etq_014, ws_etq_015,
ws_etq_016, ws_etq_017, ws_etq_018, ws_etq_019, ws_etq_020,
ws_etq_021, ws_etq_022, ws_etq_023,
wd_fec_act, ws_hor_act, ws_des_lis
);
wn_uni_tem := wn_uni_pag;
wn_imp_tem := wn_imp_pag;
end loop;
-- actualiza la tabbaa deemnitoreo indicandoola finalizacion    --
-- del proceso.                                                 --
ws_hor_act := to_char(clock_timestamp(), 'hh24:mi:ss');
update glcoresu set res_numreg = wn_num_reg,
res_fecfin = trunc(clock_timestamp()),
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep
and res_idepcc =  ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = trunc(clock_timestamp())
and res_horreg = ws_hor_reg;
end;
$body$
language plpgsql
;
