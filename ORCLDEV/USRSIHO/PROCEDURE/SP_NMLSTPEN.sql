create or replace procedure usrsiho."sp_nmlstpen"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar, ws_tab_sub varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- sipros, s.a. de c.v.
--
-- sistema  : rh-2000 c/s
-- modulo   : administracion de remuneraciones (nm)
--
-- programa : sp_nmlstpen
--            reporte de pensiones alimenticias.
--
-- autor    : joaquin perez m.
-- fecha    : 15 de agosto de 1997.
--
-- variables para la carga de la tabla de beneficiarios y prestamos --
wn_key_emp numeric(10);
ws_nom_emp varchar(60);
ws_key_dep varchar(16);
ws_des_dep varchar(40);
wn_key_ben numeric(5);
ws_tip_ben varchar(2);
wn_com_fam numeric(5);
ws_des_ben varchar(40);
ws_nom_ben varchar(60);
ws_rfc_ben varchar(13);
wd_fec_nac timestamp(0);
wn_por_par decimal(6,2);
ws_cve_sex varchar(1);
ws_tip_par varchar(2);
ws_key_ban varchar(7);
ws_cta_ban varchar(18);
ws_dep_ben varchar(16);
ws_key_cen varchar(16);
ws_des_cen varchar(40);
ws_for_pag varchar(2);
ws_ca1_aux varchar(10);
ws_ca2_aux varchar(10);
ws_key_con varchar(3);
ws_reg_inf varchar(14);
wd_fec_exp timestamp(0);
ws_tip_pen varchar(2);       --integer;   wn_pla_zop
wn_uni_pre decimal(12,2);
wn_imp_pre decimal(12,2);
wn_uni_des decimal(12,2);
wn_imp_des decimal(12,2);
ws_per_ini varchar(7);
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
ws_des_cor varchar(60);
-- variables para las etiquetas de la tabla de prestamos       --
ws_etq_con varchar(8);
ws_etq_ofi varchar(8);
ws_etq_exp varchar(8);
ws_etq_pen varchar(8);
ws_etq_po1 varchar(8);
ws_etq_im1 varchar(8);
ws_etq_po2 varchar(8);
ws_etq_im2 varchar(8);
ws_etq_per varchar(8);
-- variables para las restricciones de despliegue               --
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
wn_dsp_015 numeric(5);
wn_dsp_016 numeric(5);
wn_dsp_017 numeric(5);
wn_dsp_018 numeric(5);
wn_dsp_019 numeric(5);
wn_dsp_020 numeric(5);
wn_dsp_021 numeric(5);
wn_dsp_022 numeric(5);
wn_dsp_023 numeric(5);
wn_dsp_024 numeric(5);
wn_dsp_025 numeric(5);
wn_dsp_026 numeric(5);
wn_dsp_027 numeric(5);
-- variables para el reporte de avance                          --
--define wn_tot_reg integer;
wn_num_reg numeric(10);
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5);
ws_hor_act varchar(8);
ws_fec_act timestamp(0);
-- variables para realizar cortes                               --
wn_emp_ant numeric(10);
ws_dep_ant varchar(16);
ws_cen_ant varchar(16);
ws_ben_ant varchar(2);
c_descor cursor for
select cor_descor from usrsiho.glcocorp;
c_etiqueta cursor for
select cam_keycam, cam_descor
from usrsiho.glcocamp
where cam_keytab = 'nmlobene';
c_etiqueta2 cursor for
select cam_keycam, cam_descor
from usrsiho.glcocamp
where cam_keytab = 'nmlobebe';
c_nomemp cursor for
select cam_descor from usrsiho.glcocamp
where cam_keytab = 'nmcoempl'
and cam_keycam = 'emp_nomemp';
c_descen cursor for
select cam_descor from usrsiho.glcocamp
where cam_keytab = 'nmlocenc'
and cam_keycam = 'cen_descen';
c_desdep cursor for
select cam_descor from usrsiho.glcocamp
where cam_keytab = 'nmcodeps'
and cam_keycam = 'dep_desdep';
c_desplieg cursor for
select rec_keycam, rec_despli from usrsiho.glcoreca
where rec_keytab = 'nmlobene'
and rec_keymen = ws_key_men;
c_desplieg2 cursor for
select rec_keycam, rec_despli from usrsiho.glcoreca
where rec_keytab = 'nmlopres'
and rec_keymen = ws_key_men;
c_nomemp2 cursor for
select emp_nomemp from usrsiho.nmcoempl
where emp_keyemp = wn_key_emp;
c_desdep2 cursor for
select dep_desdep from usrsiho.nmcodeps
where dep_keydep = ws_key_dep;
c_descen2 cursor for
select cen_descen from usrsiho.nmlocenc
where cen_keycen = ws_key_cen;
c_desben cursor for
select pam_nompar from usrsiho.glcopams
where pam_keypar = ws_tab_sub
and pam_cvesec = ws_tip_ben;
c_nmlstben cursor for
select ben_keyemp, ben_keyben, ben_comfam, ben_rfcben, ben_nomben,
ben_fecnac, ben_cvesex, ben_tippar, beb_tipben, beb_porpar,
ben_keyban, ben_ctaban, ben_keydep, ben_keycen,
beb_forpag,             ben_ca1aux, ben_ca2aux,
pre_keycon, pre_refere, pre_tippre, pre_unipre, pre_imppre,
pre_unides, pre_impdes, pre_perini, pre_fecreg
from usrsiho.nmlopres, usrsiho.nmlobene, usrsiho.nmlobebe
where pre_keyemp = ben_keyemp
and pre_keyemp = beb_keyemp
and pre_ca4aux = ben_keyben
and pre_ca4aux = beb_keyben
and ben_keyben = beb_keyben
and ben_comfam = beb_comfam
and ben_comfam = 1
and ben_keyemp in ( select ran_keyemp from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and ben_keyben in ( select ran_keynom from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keynom::text, '') is not null )
order by ben_keyemp, ben_keyben, ben_keydep, ben_keycen, beb_tipben;
begin
-- asignacion por omision de las etiquetas de la tabla de prestamos --
ws_etq_con := 'Concepto';
ws_etq_ofi := 'Oficio';
ws_etq_exp := 'Fec.Exp.';
ws_etq_pen := 'T.Pen.';
ws_etq_po1 := '1er %';
ws_etq_im1 := 'Importe';
ws_etq_po2 := '2do%';
ws_etq_im2 := '2do Imp.';
ws_etq_per := 'Per.Ini.';
-- realiza el conteo de registros a procesar                    --
--select count(*) into wn_tot_reg from nmlopres, nmlobenf
--  where pre_keyemp = ben_keyemp
--  and pre_refere = ben_keyben
--    and ben_keyemp in
--    ( select ran_keyemp from glwkrang
--        where ran_nomrep = ws_nom_rep
--          and ran_idepcc = ws_ide_pcc
--          and ran_keyusu = wn_key_usu
--          and ran_keyemp is not null )
--    and ben_keyben in
--    ( select ran_keynom from glwkrang
--        where ran_nomrep = ws_nom_rep
--          and ran_idepcc = ws_ide_pcc
--          and ran_keyusu = wn_key_usu
--          and ran_keynom is not null )
--    and ben_tipben in
--    ( select ran_keycon from glwkrang
--        where ran_nomrep = ws_nom_rep
--          and ran_idepcc = ws_ide_pcc
--          and ran_keyusu = wn_key_usu
--          and ran_keycon is not null );
-- inserta registro para monitoreo de resultados                --
ws_hor_act := to_char(clock_timestamp(), 'hh24:mi:ss');
ws_fec_act := trunc(clock_timestamp());
insert into usrsiho.glcoresu(
res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
res_horreg, res_totreg, res_status )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, trunc(clock_timestamp()), ws_hor_act,
ws_hor_reg, -1, 'P' );
-- borra la tabla de trabajo del crystal report                 --
delete from usrsiho.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu;
-- extrae el nombre de la compania corporativa                 --
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
for rec in c_descor loop
ws_des_cor := rec.cor_descor;
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
if ws_key_cam = 'ben_keyemp' then
ws_etq_001 := ws_des_etq;
end if;
if ws_key_cam = 'ben_keyben' then
ws_etq_002 := ws_des_etq;
end if;
if ws_key_cam = 'ben_comfam' then
ws_etq_003 := ws_des_etq;
end if;
if ws_key_cam = 'ben_rfcben' then
ws_etq_004 := ws_des_etq;
end if;
if ws_key_cam = 'ben_nomben' then
ws_etq_005 := ws_des_etq;
end if;
if ws_key_cam = 'ben_fecnac' then
ws_etq_006 := ws_des_etq;
end if;
if ws_key_cam = 'ben_cvesex' then
ws_etq_007 := ws_des_etq;
end if;
if ws_key_cam = 'ben_tippar' then
ws_etq_008 := ws_des_etq;
end if;
-- if ws_key_cam = 'ben_tipben' then
--   let ws_etq_009 = ws_des_etq;
-- end if;
if ws_key_cam = 'ben_nomben' then
ws_etq_010 := ws_des_etq;
end if;
-- if ws_key_cam = 'ben_porpar' then
--   let ws_etq_011 = ws_des_etq;
-- end if;
-- if ws_key_cam = 'ben_fecven' then
--   let ws_etq_012 = ws_des_etq;
-- end if;
if ws_key_cam = 'ben_keyban' then
ws_etq_013 := ws_des_etq;
end if;
if ws_key_cam = 'ben_ctaban' then
ws_etq_014 := ws_des_etq;
end if;
if ws_key_cam = 'ben_keydep' then
ws_etq_015 := ws_des_etq;
end if;
if ws_key_cam = 'ben_keycen' then
ws_etq_016 := ws_des_etq;
end if;
--if ws_key_cam = 'ben_forpag' then
--  let ws_etq_017 = ws_des_etq;
--end if;
--if ws_key_cam = 'ben_fecact' then
--  let ws_etq_018 = ws_des_etq;
--end if;
if ws_key_cam = 'ben_ca1aux' then
ws_etq_019 := ws_des_etq;
end if;
if ws_key_cam = 'ben_ca2aux' then
ws_etq_020 := ws_des_etq;
end if;
end loop;
for rec3 in c_etiqueta2 loop
ws_key_cam := rec3.cam_keycam;
ws_des_etq := rec3.cam_descor;
if ws_key_cam = 'beb_tipben' then
ws_etq_009 := ws_des_etq;
end if;
if ws_key_cam = 'beb_porpar' then
ws_etq_011 := ws_des_etq;
end if;
if ws_key_cam = 'beb_forpag' then
ws_etq_017 := ws_des_etq;
end if;
end loop;
ws_etq_021 := 'NOMBRE';
for rec4 in c_nomemp loop
ws_etq_021 := rec4.cam_descor;
end loop;
ws_etq_022 := 'DESCRIP.';
for rec5 in c_descen loop
ws_etq_022 := rec5.cam_descor;
end loop;
ws_etq_023 := 'DESCRIP.';
for rec6 in c_desdep loop
ws_etq_023 := rec6.cam_descor;
end loop;
-- asigna por omision que todos los campos se pueden desplegar  --
wn_dsp_001 := 0;
wn_dsp_002 := 0;
wn_dsp_003 := 0;
wn_dsp_004 := 0;
wn_dsp_005 := 0;
wn_dsp_006 := 0;
wn_dsp_007 := 0;
wn_dsp_008 := 0;
wn_dsp_009 := 0;
wn_dsp_010 := 0;
wn_dsp_011 := 0;
wn_dsp_012 := 0;
wn_dsp_013 := 0;
wn_dsp_014 := 0;
wn_dsp_015 := 0;
wn_dsp_016 := 0;
wn_dsp_017 := 0;
wn_dsp_018 := 0;
wn_dsp_019 := 0;
wn_dsp_020 := 0;
wn_dsp_021 := 0;
wn_dsp_022 := 0;
wn_dsp_023 := 0;
wn_dsp_024 := 0;
wn_dsp_025 := 0;
wn_dsp_026 := 0;
wn_dsp_027 := 0;
-- extrae las restricciones de despliegue de la tabla de beneficiarios --
for rec7 in c_desplieg loop
ws_key_cam := rec7.rec_keycam;
ws_dsp_cam := rec7.rec_despli;
if ( ws_key_cam = 'ben_keyemp' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_001 := 1;
end if;
if ( ws_key_cam = 'ben_keyben' ) and (ws_dsp_cam = 'N' ) then
wn_dsp_002 := 1;
end if;
if ( ws_key_cam = 'ben_comfam' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_003 := 1;
end if;
if ( ws_key_cam = 'ben_rfcben' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_004 := 1;
end if;
if ( ws_key_cam = 'ben_nomben' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_005 := 1;
end if;
if ( ws_key_cam = 'ben_fecnac' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_006 := 1;
end if;
if ( ws_key_cam = 'ben_cvesex' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_007 := 1;
end if;
if ( ws_key_cam = 'ben_tippar' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_008 := 1;
end if;
if ( ws_key_cam = 'ben_tipben' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_009 := 1;
end if;
if ( ws_key_cam = 'ben_porpar' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_010 := 1;
end if;
if ( ws_key_cam = 'ben_fecven' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_011 := 1;
end if;
if ( ws_key_cam = 'ben_keyban' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_012 := 1;
end if;
if ( ws_key_cam = 'ben_ctaban' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_013 := 1;
end if;
if ( ws_key_cam = 'ben_keydep' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_014 := 1;
end if;
if ( ws_key_cam = 'ben_keycen' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_015 := 1;
end if;
if ( ws_key_cam = 'ben_forpag' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_016 := 1;
end if;
if ( ws_key_cam = 'ben_fecact' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_017 := 1;
end if;
if ( ws_key_cam = 'ben_ca1aux' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_018 := 1;
end if;
if ( ws_key_cam = 'ben_ca2aux' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_019 := 1;
end if;
end loop;
-- extrae las restricciones de  espliegue de la tabla de prestamos --
for rec8 in c_desplieg2 loop
ws_key_cam := rec8.rec_keycam;
ws_dsp_cam := rec8.rec_despli;
if ( ws_key_cam = 'pre_keycon' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_020 := 1;
end if;
if ( ws_key_cam = 'pre_ca1aux' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_021 := 1;
end if;
if ( ws_key_cam = 'pre_fecini' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_022 := 1;
end if;
if ( ws_key_cam = 'pre_plazop' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_023 := 1;
end if;
if ( ws_key_cam = 'pre_porint' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_024 := 1;
end if;
if ( ws_key_cam = 'pre_impdes' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_025 := 1;
end if;
if ( ws_key_cam = 'pre_imppre' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_026 := 1;
end if;
if ( ws_key_cam = 'pre_perini' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_027 := 1;
end if;
end loop;
-- inicializa variables de trabajo para realizar cortes y monit --
wn_emp_ant := -999999999;
ws_dep_ant := '################';
ws_cen_ant := '################';
ws_ben_ant := '##';
wn_num_reg := 0;
wn_pct_act := 1;
--let wn_pct_reg = wn_tot_reg / 10.0;
-- define cursor principal                                      --
for rec9 in c_nmlstben loop
-- actualiza registro de monitoreo                              --
--let wn_num_reg = wn_num_reg + 1;
--if wn_num_reg >= ( wn_pct_reg * wn_pct_act ) then
--  update glcoresu set res_numreg = wn_num_reg
--    where res_idepro = ws_nom_rep
--      and res_idepcc = ws_ide_pcc
--      and res_keyusu = wn_key_usu
--      and res_fecini = today
--      and res_horreg = ws_hor_reg;
--a  let wn_pct_act = wn_pct_act + 1;
--end if;
-- extrae descripciones del departamento, centro de costo y  --
-- nombre del empleado.                                      --
wn_key_emp := rec9.ben_keyemp;
wn_key_ben := rec9.ben_keyben;
wn_com_fam := rec9.ben_comfam;
ws_rfc_ben := rec9.ben_rfcben;
ws_nom_ben := rec9.ben_nomben;
wd_fec_nac := rec9.ben_fecnac;
ws_cve_sex := rec9.ben_cvesex;
ws_tip_par := rec9.ben_tippar;
ws_tip_ben := rec9.beb_tipben;
wn_por_par := rec9.beb_porpar;
ws_key_ban := rec9.ben_keyban;
ws_cta_ban := rec9.ben_ctaban;
ws_key_dep := rec9.ben_keydep;
ws_key_cen := rec9.ben_keycen;
ws_for_pag := rec9.beb_forpag;
ws_ca1_aux := rec9.ben_ca1aux;
ws_ca2_aux := rec9.ben_ca2aux;
ws_key_con := rec9.pre_keycon;
ws_reg_inf := rec9.pre_refere;
ws_tip_pen := rec9.pre_tippre;
wn_uni_pre := rec9.pre_unipre;
wn_imp_pre := rec9.pre_imppre;
wn_uni_des := rec9.pre_unides;
wn_imp_des := rec9.pre_impdes;
ws_per_ini := rec9.pre_perini;
wd_fec_exp := rec9.pre_fecreg;
if nullif(wn_key_emp::text, '') is null then
ws_nom_emp := 'EMPLEADO NO EXISTE ...';
else
if wn_key_emp <> wn_emp_ant then
ws_nom_emp := 'EMPLEADO NO EXISTE ...';
for rec10 in c_nomemp2 loop
ws_nom_emp := rec10.emp_nomemp;
end loop;
wn_emp_ant := wn_key_emp;
end if;
end if;
if nullif(ws_key_dep::text, '') is null then
ws_des_dep := 'DEPARTAMENTO NO EXISTE ...';
else
if ws_key_dep <> ws_dep_ant then
ws_des_dep := 'DEPARTAMENTO NO EXISTE ...';
for rec11 in c_desdep2 loop
ws_des_dep := rec11.dep_desdep;
end loop;
ws_dep_ant := ws_key_dep;
end if;
end if;
if nullif(ws_key_cen::text, '') is null then
ws_des_cen := 'CENTRO NO EXISTE ...';
else
if ws_key_cen <> ws_cen_ant then
ws_des_cen := 'CENTRO NO EXISTE ...';
for rec12 in c_descen2 loop
ws_des_cen := rec12.cen_descen;
end loop;
ws_cen_ant := ws_key_cen;
end if;
end if;
-- extrae la descripcion del tipo de beneficio                  --
if nullif(ws_tip_ben::text, '') is null then
ws_des_ben := 'BENEFICIO NO EXISTE ...';
else
if ws_tip_ben <> ws_ben_ant then
ws_des_ben := 'BENEFICIO NO EXISTE ...';
for rec13 in c_desben loop
ws_des_ben := rec13.pam_nompar;
end loop;
ws_ben_ant := ws_tip_ben;
end if;
end if;
-- aplica restricciones de despliegue de campos                 --
if wn_dsp_001 = 1 then
wn_key_emp := null;
ws_nom_emp := null;
end if;
if wn_dsp_002 = 1 then wn_key_ben := null; end if;
if wn_dsp_003 = 1 then wn_com_fam := null; end if;
if wn_dsp_004 = 1 then ws_rfc_ben := null; end if;
if wn_dsp_005 = 1 then ws_nom_ben := null; end if;
if wn_dsp_006 = 1 then wd_fec_nac := null; end if;
if wn_dsp_007 = 1 then ws_cve_sex := null; end if;
if wn_dsp_008 = 1 then ws_tip_par := null; end if;
if wn_dsp_009 = 1 then
ws_tip_ben := null;
ws_des_ben := null;
end if;
if wn_dsp_010 = 1 then wn_por_par := null; end if;
--if wn_dsp_011 = 1 then let wd_fec_ven = null; end if;
if wn_dsp_012 = 1 then ws_key_ban := null; end if;
if wn_dsp_013 = 1 then ws_cta_ban := null; end if;
if wn_dsp_014 = 1 then
ws_key_dep := null;
ws_des_dep := null;
end if;
if wn_dsp_015 = 1 then
ws_key_cen := null;
ws_des_cen := null;
end if;
if wn_dsp_016 = 1 then ws_for_pag := null; end if;
--   if wn_dsp_017 = 1 then let wd_fec_act = null; end if;
if wn_dsp_018 = 1 then ws_ca1_aux := null; end if;
if wn_dsp_019 = 1 then ws_ca2_aux := null; end if;
if wn_dsp_020 = 1 then ws_key_con := null; end if;
if wn_dsp_021 = 1 then ws_reg_inf := null; end if;
--   if wn_dsp_022 = 1 then let wd_fec_exp = null; end if;
--   if wn_dsp_023 = 1 then let wn_pla_zop = null; end if;
--   if wn_dsp_024 = 1 then let wn_por_int = null; end if;
--   if wn_dsp_025 = 1 then let wn_imp_des = null; end if;
--   if wn_dsp_026 = 1 then let wn_imp_pre = null; end if;
if wn_dsp_027 = 1 then ws_per_ini := null; end if;
-- inserta en la tabla de trabajo del crystal report            --
insert into usrsiho.glwkcrys(
cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006,
cry_dec007, cry_dec008, cry_chr008, cry_chr003, cry_dat001,
cry_chr040, cry_chr041, cry_chr042, cry_dec011,
cry_chr043, cry_chr009, cry_chr010, cry_chr011, cry_chr044,
cry_chr012, cry_chr013, cry_chr002, cry_chr004,
cry_chr005, cry_chr017, cry_chr018, cry_chr019, cry_chr020,
cry_chr021, cry_chr022, cry_chr023, cry_chr024, cry_chr025,
cry_chr026, cry_chr027,             cry_chr029, cry_chr030,
cry_chr031, cry_chr032,                         cry_chr035,
cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr045,
cry_dat004, cry_chr006,
cry_chr015, cry_chr007, cry_dat005, cry_chr033, cry_dec012,
cry_dec013, cry_dec014, cry_chr014, cry_dec015 )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_emp,
wn_key_ben, wn_com_fam, ws_rfc_ben, oracle.substr(ws_nom_ben,1,40), wd_fec_nac,
ws_cve_sex, ws_tip_par, ws_tip_ben, wn_por_par,
ws_key_ban, ws_cta_ban, ws_key_dep, ws_key_cen, ws_for_pag,
ws_ca1_aux, ws_ca2_aux, ws_nom_emp, ws_des_dep,
ws_des_cen, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004,
ws_etq_005, ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009,
ws_etq_010, ws_etq_011,             ws_etq_013, ws_etq_014,
ws_etq_015, ws_etq_016,                         ws_etq_019,
ws_etq_020, ws_etq_021, ws_etq_022, ws_etq_023, ws_hor_act,
ws_fec_act, ws_des_ben,
ws_key_con, ws_reg_inf, wd_fec_exp, ws_tip_pen, wn_uni_pre,
wn_imp_pre, wn_uni_des, ws_per_ini, wn_imp_des );
end loop;
-- actualiza la tabla de monitoreo indicando la finalizacion    --
-- del proceso.                                                 --
ws_hor_act := to_char(clock_timestamp(), 'hh24:mi:ss');
update usrsiho.glcoresu set res_numreg = wn_num_reg,
res_fecfin = trunc(clock_timestamp()),
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = trunc(clock_timestamp())
and res_horreg = ws_hor_reg;
end;
$body$
language plpgsql
;
