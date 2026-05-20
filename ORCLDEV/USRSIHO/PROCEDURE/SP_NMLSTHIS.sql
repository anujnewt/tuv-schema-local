create or replace procedure usrsiho."sp_nmlsthis"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar,ws_lis_per varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- sipros, s. a. de c. v.
--
-- sistema  : rh-2000  c/s
-- modulo   : administracion de remuneraciones (nm)
--
-- programa : sp_nmlsthis
--            reporte de programas de cifras de control
--                             historico de movimientos
-- autor    : pedro perez gutierrez
-- fecha    : 18 de abril de 1997
--
-- variables para la carga de la tablas movimientos
wn_his_emp numeric(10);
ws_his_con varchar(3);
wn_his_nom numeric(5);
ws_his_per varchar(7);
wn_his_pro numeric(5);
ws_cod_imp varchar(2);
ws_his_cia varchar(4);
-- variable para la carga de las especificaciones de las claves
ws_des_pro varchar(20);
ws_des_nom varchar(40);
ws_des_con varchar(40);
ws_des_cor varchar(60);
ws_des_cia varchar(60);
wd_fec_ini timestamp(0);
wd_fec_fin timestamp(0);
ws_lis_pro varchar(40);
ws_lis_nom varchar(40);
ws_des_lis varchar(50);
ws_key_cia varchar(4);
wn_numemi  varchar(05);
wd_fecpag  timestamp(0);
-- variable para la carga de las descripciones de las etiquetas
ws_key_cam varchar(10);
ws_des_etq varchar(40);
ws_etq_001 varchar(10);
ws_etq_002 varchar(10);
ws_etq_003 varchar(10);
ws_etq_004 varchar(20);
ws_etq_005 varchar(10);
ws_etq_006 varchar(10);
ws_etq_007 varchar(10);
wn_pri_mer numeric(10);
-- variables para las restricciones de despliegue
ws_dsp_cam varchar(20);
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_dsp_003 numeric(5);
wn_dsp_004 numeric(5);
wn_dsp_005 numeric(5);
wn_dsp_006 numeric(5);
--  variables para los cortes de procesos, periodos y conceptos --
wn_ant_pro numeric(5);
ws_ant_per varchar(7);
ws_ant_con varchar(3);
wn_ant_nom numeric(5);
ws_ant_cod varchar(2);
-- variables para el reporte de avance
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
ws_hor_act varchar(8);
ws_dia_act timestamp(0);
wn_con_tar numeric(10);
wn_tot_emp numeric(10);
wn_tot_can decimal(18,2);
wn_tot_imp decimal(18,2);
wn_tot_tra numeric(10);
c_lista cursor for
select lis_deslis from usrsiho.glcolist
where lis_keylis = ws_nom_rep;
c_etiqueta cursor for
select cam_keycam, cam_descor
from usrsiho.glcocamp
where cam_keytab = 'nmlohism';
c_etiqueta1 cursor for
select cam_keycam, cam_descam
from usrsiho.glcocamp
where cam_keytab = 'nmlohism';
c_des_nom cursor for
select cam_keycam, cam_descor
from usrsiho.glcocamp
where cam_keytab = 'nmlonomi';
c_desplieg cursor for
select rec_keycam, rec_despli
from usrsiho.glcoreca
where rec_keytab = 'nmlohism'
and rec_keymen = ws_key_men;
c_descor cursor for
select pro_keycia from usrsiho.nmloproc
where pro_keypro = wn_his_pro;
c_for_pro cursor for
select pro_despro, pro_keycia
from usrsiho.nmloproc
where pro_keypro = wn_his_pro;
c_des_cia cursor for
select cia_descia
from usrsiho.nmlocias
where cia_keycia = ws_his_cia;
c_lis_pro cursor for
select ran_keycen
from usrsiho.glwkrang
where ran_keypro = wn_his_pro
and ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu;
c_pro_tot cursor for
select count(unique his_keyemp) totemp
from usrsiho.nmlohism
where his_keypro = wn_his_pro
and his_keyper = ws_his_per;
c_for_con cursor for
select con_descon
from usrsiho.nmloconc
where con_keycon = ws_his_con;
c_for_per cursor for
select per_fecini, per_fecfin, per_keynom, per_nu4aux, per_fecpag   ----cig
from usrsiho.nmloperi
where per_keyper = ws_his_per
and per_keypro = wn_his_pro;
c_per_tot cursor for
select count(unique his_keyemp) totemp
from usrsiho.nmlohism
where his_keypro = wn_his_pro
and his_keyper = ws_his_per;
c_for_nom cursor for
select nom_destip
from usrsiho.nmlonomi
where nom_keynom = wn_his_nom;
c_lis_nom cursor for
select ran_keycat
from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu;
c_nmlsthis cursor for
select his_keycon, sum(his_cantid) suma_can,sum(his_import) suma_imp, his_keypro, his_keyper,
his_codimp, count(*) total
from usrsiho.nmlohism
where his_keypro in ( select ran_keypro from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
and his_keyper in ( select ran_keyper from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyper::text, '') is not null )
group by his_keypro, his_keyper, his_codimp, his_keycon
order by his_keypro, his_keyper, his_codimp, his_keycon;
begin
-- realiza el conteo de registros a procesar
begin
select count(*) into strict wn_tot_reg from usrsiho.nmloperi
where per_keypro in ( select ran_keypro from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
and per_keyper in ( select ran_keyper from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyper::text, '') is not null );
exception when no_data_found then wn_tot_reg := 0;
end;
-- inserta registro de resultados
ws_hor_act := to_char(clock_timestamp(), 'HH24:MI:SS');
ws_dia_act := trunc(clock_timestamp());
insert into usrsiho.glcoresu(
res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
res_horreg, res_totreg, res_status )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, trunc(clock_timestamp()), ws_hor_act,
ws_hor_reg, wn_tot_reg, 'P' );
-- borra la tabla de trabajo del crystal report
delete from usrsiho.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu;
-- extrae el nombre de la compania corporativa
--let ws_des_cor = 'CORPORATIVO NO REGISTRADO ...';
--foreach c_descor for
--  select cor_descor into ws_des_cor from glcocorp
--end foreach;
-- extrae el nombre del reporte
begin
select  lis_deslis into strict ws_des_lis from usrsiho.glcolist
where lis_keylis = ws_nom_rep;
exception
when no_data_found then
ws_des_lis := 'No existe Nombre del Reporte ...';
end;
-- asigna valores por omision a las etiquetas del diccionario de datos --
ws_etq_001 := '........'; ws_etq_002 := '........';
ws_etq_003 := '........'; ws_etq_004 := '........';
ws_etq_005 := '........'; ws_etq_006 := '........';
ws_etq_007 := '........';
-- extrae las etiquetas del diccionario de datos
for rec2 in c_etiqueta loop
ws_key_cam := rec2.cam_keycam;
ws_des_etq := rec2.cam_descor;
if ws_key_cam = 'his_keypro' then
ws_etq_001 := ws_des_etq;
end if;
if ws_key_cam = 'his_keyper' then
ws_etq_002 := ws_des_etq;
end if;
if ws_key_cam = 'his_keycon' then
ws_etq_003 := ws_des_etq;
end if;
end loop;
for rec3 in c_etiqueta1 loop
ws_key_cam := rec3.cam_keycam;
ws_des_etq := rec3.cam_descam;
if ws_key_cam = 'his_cantid' then
ws_etq_004 := ws_des_etq;
end if;
if ws_key_cam = 'his_import' then
ws_etq_005 := ws_des_etq;
end if;
end loop;
for rec4 in c_des_nom loop
ws_key_cam := rec4.cam_keycam;
ws_des_etq := rec4.cam_descor;
if ws_key_cam = 'nom_keynom' then
ws_etq_006 := ws_des_etq;
end if;
if ws_key_cam = 'nom_destip' then
ws_etq_007 := ws_des_etq;
end if;
end loop;
-- asigna  por omicion que todos los campos se pueden desplegar
wn_dsp_001 := 0; wn_dsp_002 := 0;
wn_dsp_003 := 0; wn_dsp_004 := 0;
wn_dsp_005 := 0; wn_dsp_006 := 0;
-- extrae las restricciones de despliegue --
for rec5 in c_desplieg loop
ws_key_cam := rec5.rec_keycam;
ws_dsp_cam := rec5.rec_despli;
if (ws_key_cam = 'ms_his_pro') and ( ws_dsp_cam ='N' ) then
wn_dsp_001 := 1;
end if;
if (ws_key_cam = 'ws_his_per') and ( ws_dsp_cam ='N' ) then
wn_dsp_002 := 1;
end if;
if (ws_key_cam = 'ws_his_con') and ( ws_dsp_cam ='N' ) then
wn_dsp_003 := 1;
end if;
if (ws_key_cam = 'wn_tot_can') and ( ws_dsp_cam ='N' ) then
wn_dsp_004 := 1;
end if;
if (ws_key_cam = 'wn_tot_imp') and ( ws_dsp_cam ='N' ) then
wn_dsp_005 := 1;
end if;
end loop;
ws_ant_con := '______';
wn_ant_nom := -9999;
ws_ant_per := '______'; -- variable que contiene el periodo anterior
wn_ant_pro := -9999; -- variable que contiene el proceso anterior
ws_ant_cod := '____';
ws_his_cia := '..';
wn_num_reg := 0;
wn_con_tar := 0;
wn_tot_can := 0;
wn_tot_imp := 0;
wn_pri_mer := 0;
wn_his_emp := -999999;
-- para contar cuanto empleados se vana  procesar en total
begin
select count(unique his_keyemp)
into strict wn_his_emp
from usrsiho.nmlohism
where his_keypro in ( select ran_keypro from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
and his_keyper in ( select ran_keyper from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyper::text, '') is not null );
exception when no_data_found then wn_his_emp := 0;
end;
-- define cursor principal -------------------------------------------------
for rec6 in c_nmlsthis loop
ws_his_con := rec6.his_keycon;
wn_tot_can := rec6.suma_can;
wn_tot_imp := rec6.suma_imp;
wn_his_pro := rec6.his_keypro;
ws_his_per := rec6.his_keyper;
ws_cod_imp := rec6.his_codimp;
wn_con_tar := rec6.total;
if wn_pri_mer = 0 then
-- extrae el nombre de la compania corporativa
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
for rec7 in c_descor loop
ws_key_cia := rec7.pro_keycia;
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
if length(ws_key_cia) > 0 then
begin
select cia_descia
into strict ws_des_cor
from nmlocias
where cia_keycia = ws_key_cia;
exception when no_data_found then ws_des_cor:= null;
end;
end if;
end loop;
wn_pri_mer:= wn_pri_mer+1;
end if;
-- actualiza el registro de monitoreo
if wn_ant_pro <> wn_his_pro and ws_ant_per <> ws_his_per then
wn_num_reg := wn_num_reg + 1;
update glcoresu set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = trunc(clock_timestamp())
and res_horreg = ws_hor_reg;
end if;
-- extraemos la descripcion del proceso
if nullif(wn_ant_pro::text, '') is null then
ws_des_cia := 'Compania No existe...';
ws_his_cia := '..';
ws_des_pro := 'No Existe Proceso...';
else
if wn_ant_pro <> wn_his_pro then
ws_des_pro := 'No Existe Proceso...';
ws_his_cia := '..';
for rec8 in c_for_pro loop
ws_des_pro := rec8.pro_despro;
ws_his_cia := rec8.pro_keycia;
end loop;
ws_des_cia := 'Compania No existe...';
for rec9 in c_des_cia loop
ws_des_cia := rec9.cia_descia;
end loop;
for rec10 in c_lis_pro loop
ws_lis_pro := rec10.ran_keycen;
end loop;
for rec11 in c_pro_tot loop
wn_tot_emp := rec11.totemp;
end loop;
wn_ant_pro := wn_his_pro;
end if;
end if;
-- extraemos la descripcion del concepto
if nullif(ws_ant_con::text, '') is null then
ws_des_con := 'No Existe Concepto...';
else
if ws_ant_con <> ws_his_con then
ws_des_con := 'No Existe Concepto...';
for rec12 in c_for_con loop
ws_des_con := rec12.con_descon;
end loop;
ws_ant_con := ws_his_con;
end if;
end if;
-- guardamos el codigo de impresion
if ws_ant_cod <> ws_cod_imp then
ws_ant_cod := ws_cod_imp;
end if;
-- obtenemos fecha inicio y fecha final del periodo
if nullif(ws_ant_per::text, '') is null then
wd_fec_ini:= trunc(clock_timestamp());
wd_fec_fin:= trunc(clock_timestamp());
else
if ws_ant_per <> ws_his_per then
wd_fec_ini:= trunc(clock_timestamp());
wd_fec_fin:= trunc(clock_timestamp());
for rec13 in c_for_per loop
wd_fec_ini := rec13.per_fecini;
wd_fec_fin := rec13.per_fecfin;
wn_his_nom := rec13.per_keynom;
wn_numemi := rec13.per_nu4aux;
wd_fecpag := rec13.per_fecpag;
end loop;
for rec14 in c_per_tot loop
wn_tot_emp := rec14.totemp;
end loop;
ws_ant_per := ws_his_per;
end if;
end if;
-- extraemos la descripcion de la nomina
--let ws_des_nom = 'No Existe Nomina...';
if nullif(wn_ant_nom::text, '') is null then
ws_des_nom := 'No Existe Nomina...';
else
if wn_ant_nom <> wn_his_nom then
ws_des_nom := 'No Existe Nomina...';
for rec15 in c_for_nom loop
ws_des_nom := rec15.nom_destip;
end loop;
for rec16 in c_lis_nom loop
ws_lis_nom := rec16.ran_keycat;
end loop;
wn_ant_nom := wn_his_nom;
end if;
end if;
-- aplica restricciones de despliegue de campos ---
if wn_dsp_001 = 1 then
wn_his_pro := null;
end if;
if wn_dsp_002 = 1 then
ws_his_per := null;
end if;
if wn_dsp_003 = 1 then
ws_his_con := null;
end if;
if wn_dsp_004 = 1 then
wn_tot_can := null;
end if;
if wn_dsp_005 = 1 then
wn_tot_imp := null;
end if;
-- inserta en la tabla de trabajo del crystal report
insert into usrsiho.glwkcrys(
cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr008,
cry_chr004, cry_chr017, cry_chr018, cry_chr019, cry_chr009,
cry_chr010, cry_chr022, cry_chr024, cry_chr025, cry_chr005,
cry_dec001, cry_dec002, cry_dec006, cry_chr026, cry_dec008,
cry_dec009, cry_dat001, cry_dat002, cry_dat003, cry_chr027,
cry_chr002, cry_chr028, cry_chr011, cry_dec010, cry_chr006,
cry_chr007, cry_chr003, cry_chr012, cry_dec007, cry_dat004,
cry_chr044)
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_des_pro,
ws_des_nom, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004,
ws_etq_005, ws_etq_006, ws_hor_act, ws_ant_con, ws_des_con,
wn_tot_can, wn_tot_imp, wn_his_pro, ws_his_per, wn_his_nom,
wn_con_tar, wd_fec_ini, wd_fec_fin, ws_dia_act, ws_ant_cod,
ws_des_cia, ws_his_cia, ws_etq_007, wn_tot_emp, ws_lis_pro,
ws_lis_per, ws_des_lis, ws_lis_nom, wn_his_emp, wd_fecpag,
wn_numemi);
-- fin del foreach principal
end loop;
-- actualiza la tabla de monitoreo la finalizacion del proceso
ws_hor_act := to_char(clock_timestamp(), 'HH24:MI:SS');
update usrsiho.glcoresu set res_numreg = wn_num_reg,
res_fecfin = trunc(clock_timestamp()),
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = trunc(clock_timestamp())
and res_horreg = ws_hor_reg;
-- fin del store procedure
end;
$body$
language plpgsql
;
