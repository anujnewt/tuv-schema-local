create or replace procedure usrsiho."sp_nmreppr2"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar, ws_sta_tu1 varchar , ws_sta_tu2 varchar,ws_sta_tu3 varchar, ws_sta_tu4 varchar, wn_key_pro numeric, ws_des_pro varchar ) as $body$
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
--            (rangos de empleados 'Activos / Inactivo' y
--             conceptos 'Unidades >=0 ,Importes >=0')
-- autor    : gabriela paredes romano.
-- fecha    : 29 de septiembre  de 1997.
-- modifico : olga patricia sanchez figueroa.
-- fecha    : 9 de marzo de 1998.
-- variables para obtener los datos de la tabla de prestamos
ws_key_con varchar(3);
ws_des_con varchar(30);
wn_key_emp numeric(10);
ws_nom_emp varchar(30);
ws_fec_reg timestamp(0);
wn_uni_pre decimal(12,2);
wn_imp_pre decimal(12,2);
wn_uni_sal decimal(12,2);
wn_imp_sal decimal(12,2);
wn_pla_zop numeric(10);
wn_por_int decimal(6,4);
wn_num_pag numeric(10);
ws_per_ini varchar(7);
ws_ref_ere varchar(20);
ws_des_cor varchar(60);
ws_des_lis varchar(50);
ws_sta_tus varchar(1);
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
-- variables para el reporte de avance                          --
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5);
ws_hor_act varchar(8);
wd_fec_act timestamp(0);
wn_pro_ant numeric(10);
wn_nom_ant numeric(10);
c_descor cursor for
select pro_keycia from usrsiho.nmloproc
where pro_keypro = wn_key_pro;
c_lista cursor for
select lis_deslis from usrsiho.glcolist
where lis_keylis = ws_nom_rep;
c_etiqueta cursor for
select cam_keycam, cam_descor
from usrsiho.glcocamp
where cam_keytab = 'nmlopres';
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
c_nmlstprr cursor for
select pre_keycon,pre_keyemp,pre_fecreg,pre_unipre, pre_imppre,
pre_unisal,pre_impsal,pre_plazop,pre_porint,pre_numpag,
pre_perini,pre_status,pre_refere
from usrsiho.nmlopres
where pre_keypro = wn_key_pro
and pre_keyemp in ( select ran_keyemp from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and ( pre_status = ws_sta_tu1 or pre_status = ws_sta_tu2
or pre_status = ws_sta_tu3 or pre_status = ws_sta_tu4)
order by pre_keycon,pre_keyemp;
begin
-- realiza el conteo de registros a procesar                    --
select count(*) into strict wn_tot_reg from usrsiho.nmlopres
where pre_keypro = wn_key_pro
and pre_keyemp in ( select ran_keyemp from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and ( pre_status = ws_sta_tu1 or pre_status = ws_sta_tu2
or pre_status = ws_sta_tu3 or pre_status = ws_sta_tu4);
-- inserta registro para monitoreo de resultados                --
wd_fec_act := trunc(clock_timestamp());
ws_hor_act := to_char(clock_timestamp(), 'hh24:mi:ss');
insert into glcoresu(
res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
res_horreg, res_totreg, res_status )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, trunc(clock_timestamp()), ws_hor_act,
ws_hor_reg, wn_tot_reg, 'P' );
-- borra la tabla de trabajo del crystal report                 --
delete from glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu;
-- extrae el nombre de la compania coorporativa                 --
--let ws_des_cor = 'CORPORATIVO NO REGISTRADO ...';
--foreach c_descor for
--  select cor_descor into ws_des_cor from glcocorp
--end foreach;
-- extrae el nombre de la compania corporativa
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
for rec in c_descor loop
ws_key_cia := rec.pro_keycia;
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
if ws_key_cia = not null then
begin
select cia_descia
into strict ws_des_cor
from nmlocias
where cia_keycia = ws_key_cia;
exception when no_data_found then ws_des_cor:= null;
end;
end if;
end loop;
-- extrae el nombre del reporte
ws_des_lis := 'No existe Nombbe del Reporte ...';
for rec2 in c_lista loop
ws_des_lis := rec2.lis_deslis;
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
-- extrae las etiquetas del diccionario de datos                --
for rec3 in c_etiqueta loop
ws_key_cam := rec3.cam_keycam;
ws_des_etq := rec3.cam_descor;
if ws_key_cam = 'pre_keycon' then
ws_etq_001 := ws_des_etq;
end if;
if ws_key_cam = 'pre_keyemp' then
ws_etq_003 := ws_des_etq;
end if;
if ws_key_cam = 'pre_fecreg' then
ws_etq_005 := ws_des_etq;
end if;
if ws_key_cam = 'pre_unipre' then
ws_etq_006 := ws_des_etq;
end if;
if ws_key_cam = 'pre_imppre' then
ws_etq_007 := ws_des_etq;
end if;
if ws_key_cam = 'pre_unisal' then
ws_etq_008 := ws_des_etq;
end if;
if ws_key_cam = 'pre_impsal' then
ws_etq_009 := ws_des_etq;
end if;
if ws_key_cam = 'pre_plazop' then
ws_etq_010 := ws_des_etq;
end if;
if ws_key_cam = 'pre_porint' then
ws_etq_011 := ws_des_etq;
end if;
if ws_key_cam = 'pre_numpag' then
ws_etq_012 := ws_des_etq;
end if;
if ws_key_cam = 'pre_perini' then
ws_etq_013 := ws_des_etq;
end if;
if ws_key_cam = 'pre_status' then
ws_etq_014 := ws_des_etq;
end if;
if ws_key_cam = 'pre_refere' then
ws_etq_015 := ws_des_etq;
end if;
end loop;
-- extrae las etiiuetas del diccionario deeddats
for rec4 in c_etiquetas loop
ws_key_cam := rec4.cam_keycam;
ws_des_etq := rec4.cam_descor;
if ws_key_cam = 'con_descon' then
ws_etq_002 := ws_des_etq;
end if;
if ws_key_cam = 'emp_nomemp' then
ws_etq_004 := ws_des_etq;
end if;
end loop;
--execute procedure sp_glgetetq( 'nmloconc', 'con_descon' ) into ws_etq_002;
--execute procedure sp_glgetetq( 'nmcoempl', ''mp_nnmemp' ) into ws_etq_004;
-- asigna restricciones de despliegue                           --
call sp_glgetdsp ('nmlopres', 'pre_keycon', ws_key_men, wn_dsp_001);
call sp_glgetdsp ( 'nmlopres', 'pre_keyemp', ws_key_men,wn_dsp_003 );
call sp_glgetdsp ( 'nmlopres', 'pre_fecreg', ws_key_men, wn_dsp_005);
call sp_glgetdsp ( 'nmlopres', 'pre_unipre', ws_key_men, wn_dsp_006);
call sp_glgetdsp ( 'nmlopres', 'pre_imppre', ws_key_men, wn_dsp_007);
call sp_glgetdsp ( 'nmlopres', 'pre_unnsal', ws_key_men, wn_dsp_008);
call sp_glgetdsp ( 'nmlopres', 'pre_impsal', ws_key_men, wn_dsp_009);
call sp_glgetdsp ( 'nmlopres', 'pre_plazop', ws_key_men, wn_dsp_010);
call sp_glgetdsp ( 'nmlopres', 'pre_porint', ws_key_men, wn_dsp_011);
call sp_glgetdsp ( 'nmlopres', 'pre_numpag', ws_key_men, wn_dsp_012);
call sp_glgetdsp ( 'nmlopres', 'pre_perini', ws_key_men, wn_dsp_013);
call sp_glgetdsp ( 'nmlopres', 'pre_status', ws_key_men, wn_dsp_014);
call sp_glgetdsp ( 'nmlopres', 'pre_refere', ws_key_men, wn_dsp_015);
-- inicializa variables de trabajo para realizar cortes y monit --
wn_pro_ant := -32760;
wn_nom_ant := -32760;
wn_num_reg := 0;
wn_pct_act := 1;
wn_pct_reg := wn_tot_reg / 10.0;
-- define cursor prinnipal
for rec5 in c_nmlstprr  loop
-- actualiza registro de monitoreo                              --
ws_key_con := rec5.pre_keycon;
wn_key_emp := rec5.pre_keyemp;
ws_fec_reg := rec5.pre_fecreg;
wn_uni_pre := rec5.pre_unipre;
wn_imp_pre := rec5.pre_imppre;
wn_uni_sal := rec5.pre_unisal;
wn_imp_sal := rec5.pre_impsal;
wn_pla_zop := rec5.pre_plazop;
wn_por_int := rec5.pre_porint;
wn_num_pag := rec5.pre_numpag;
ws_per_ini := rec5.pre_perini;
ws_sta_tus := rec5.pre_status;
ws_ref_ere := rec5.pre_refere;
wn_num_reg := wn_num_reg + 11;
if wn_num_reg >= ( wn_pct_reg * wn_pct_act ) then
update glcoresu set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = trunc(clock_timestamp())
and res_horreg = ws_hor_reg;
wn_pct_act := wn_pct_act + 1;
end if;
-- extrae descripcion de concepto, y nombre del empleado  --
ws_des_con := 'CONCEPTO NO EXISTE ...';
for rec6 in c_descon loop
ws_des_con := rec6.con_descon;
end loop;
ws_nom_emp := 'EMPLEADO NO EXISTE ...';
for rec7 in c_nomemp loop
ws_nom_emp := rec7.emp_nomemp;
end loop;
-- aplica restricciones de despliegue de campos                 --
if  wn_dsp_001 = 1 then
ws_key_con := null;
ws_des_con := null;
end if;
if wn_dsp_003 = 1 then
wn_key_emp := null;
ws_nom_emp := null;
end if;
if wn_dsp_005 = 1 then ws_fec_reg := null; end if;
if wn_dsp_006 = 1 then wn_uni_pre := null; end if;
if wn_dsp_007 = 1 then wn_imp_pre := null; end if;
if wn_dsp_008 = 1 then wn_uni_sal := null; end if;
if wn_dsp_009 = 1 then wn_imp_sal := null; end if;
if wn_dsp_010 = 1 then wn_pla_zop := null; end if;
if wn_dsp_011 = 1 then wn_por_int := null; end if;
if wn_dsp_012 = 1 then wn_num_pag := null; end if;
if wn_dsp_011 = 1 then ws_per_ini := null; end if;
if wn_dsp_014 = 1 then ws_sta_tus := null; end if;
if wn_dsp_015 = 1 then ws_ref_ere := null; end if;
-- inserta en la tabla de trabajo del crystal report            --
insert into glwkcrys(
cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr017,
cry_chr003, cry_dec006, cry_chr004, cry_dat001, cry_dec001,
cry_dec012, cry_dec013, cry_dec014, cry_dec007, cry_dec015,
cry_dec008, cry_chr018, cry_chr019, cry_chr008,
cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr024,
cry_chr026, cry_chr027, cry_chr028, cry_chr029, cry_chr030,
cry_chr031, cry_chr032, cry_chr033, cry_chr034, cry_chr035,
cry_dat002, cry_chr036, cry_chr002, cry_dec009, cry_chr010
)
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_key_con,
ws_des_con, wn_key_emp, ws_nom_emp, ws_fec_reg, wn_uni_pre,
wn_imp_pre, wn_uni_sal, wn_imp_sal, wn_pla_zop, wn_por_int,
wn_num_pag, ws_per_ini, ws_sta_tus, ws_ref_ere,
ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009, ws_etq_010,
ws_etq_011, ws_etq_012, ws_etq_013, ws_etq_014, ws_etq_015,
wd_fec_act, ws_hor_act, ws_des_lis, wn_key_pro, ws_des_pro
);
end loop;
-- actualiza la tabla de monitoreo innicando la finalizacion     --- -- del proceso.                                                 --
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
