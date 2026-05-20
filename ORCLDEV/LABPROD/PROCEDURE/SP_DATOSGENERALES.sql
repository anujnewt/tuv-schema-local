create or replace procedure labprod."sp_datosgenerales"  (recurp nmcoempl.emp_recurp%type, keyemp nmcoempl.emp_keyemp%type, nomemp nmcoempl.emp_nomemp%type, keypro nmcoempl.emp_keypro%type, cveban nmcoempl.emp_cveban%type, fecaux nmcoempl.emp_fecaux%type, domemp nmcoempl.emp_domemp%type, colemp nmcoempl.emp_colemp%type, munemp nmcoempl.emp_munemp%type, entemp nmcoempl.emp_entemp%type, codemp nmcoempl.emp_codemp%type, telemp nmcoempl.emp_telemp%type, cidemp nmcoempl.emp_cidemp%type, salmes nmcoempl.emp_salmes%type, keyloc nmcoempl.emp_keyloc%type, forpag nmcoempl.emp_forpag%type, ca2aux nmcoempl.emp_ca2aux%type, status nmcoempl.emp_status%type) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_res_pue datosgenerales.gen_valida%type;
--igneos.i
wn_tot_reg numeric;
ws_cve_cte varchar(5);
gl_rec_urp varchar(20);
ws_rec_urp varchar(20);
wn_dia_per numeric;
ws_cve_cal varchar(1);
ws_cta_ban varchar(18);
ws_tpo_con varchar(50);
wn_sal_mes numeric;
ws_cve_ban varchar(18);
wd_fec_mov timestamp(0);
paterno varchar(50);
materno varchar(50);
nombre varchar(100);
claveban varchar(3);
existe numeric;
valido numeric;
begin
wn_res_pue:=' ';
wd_fec_mov:= clock_timestamp();
--wd_fec_mov:= to_char (sysdate, 'yyyymmdd');
--1. buscar clientes
select pam_cvesec, coalesce(pam_folini,'T') into strict ws_cve_cte, ws_tpo_con
from glcopams
where pam_keypar = 'SDGI'
and pam_folfin <> 'D';/* dmap converted statement start */
--2. validar tipo de contrato
--select count(*) into wn_tot_reg from nmcoempl
--where emp_keyemp = empleado
--and emp_ca2aux in (ws_tpo_con);
if wn_tot_reg = 0 then
wn_res_pue :=  concat(wn_res_pue, '2') ;/* dmap converted statement end */
--  return;
end if;
--3. validar procesos
select count(*) into strict wn_tot_reg from glcopams
where pam_keypar = 'IINT'
and pam_folfin = 'tviaesnt'
and pam_folini = keypro;/* dmap converted statement start */
if wn_tot_reg > 0 then
wn_res_pue :=  concat(wn_res_pue, '3') ;/* dmap converted statement end */
--return;
end if;
--4.	validar empleados con m?s de una clave en saf
begin
select pam_nompar into strict gl_rec_urp from glcopams
where pam_keypar = 'CEFI'
and pam_folini = keyemp;
exception
when no_data_found then
gl_rec_urp := ' ';
end;
if gl_rec_urp <> ' ' then
ws_rec_urp := gl_rec_urp;
else
ws_rec_urp := recurp;
end if;
--5.	validar registros en la tabla aux_acum3
select count(*) into strict wn_tot_reg
from aux_acum3
where keycon = 'tviaesnt'
and keyemp = keyemp;/* dmap converted statement start */
if wn_tot_reg <> 0 then
wn_res_pue :=  concat(wn_res_pue, '5') ;/* dmap converted statement end */
--  return;
end if;
-- validaciones en la inserci?n
-- buscar el calendario del proceso (notar que s?lo se considera 7, 10, 15)
select pro_diaper into strict wn_dia_per from nmloproc
where pro_keypro = keypro;
if wn_dia_per = 7 then ws_cve_cal := 'S';
elsif wn_dia_per = 10 then ws_cve_cal := 'D';
elsif wn_dia_per = 15 then ws_cve_cal := 'Q';/* dmap converted statement start */
else wn_res_pue :=  concat(wn_res_pue, '6') ;/* dmap converted statement end */
end if;
-- buscar la clave de banco y la cuenta bancaria
--validar la n?mina confidencial
begin
select cta_ctaban into strict ws_cta_ban
from nmloctas
where cta_keyemp = keyemp
and cta_keypro = keypro;/* dmap converted statement start */
exception
when no_data_found then
wn_res_pue :=  concat(wn_res_pue, '9') ;/* dmap converted statement end */
end;
if keypro = 6 then
wn_sal_mes := 15000;
else
wn_sal_mes := salmes;
end if;
if forpag = 1 or forpag = 4 then
ws_cve_ban := '000';
ws_cta_ban := '000000000000000000';
end if;
nombre := trim(both sp_delimitador(nomemp,'/',3));
paterno := trim(both coalesce(sp_delimitador(nomemp,'/',1), ' '));
materno := trim(both coalesce(sp_delimitador(nomemp,'/',2), ' '));
claveban := oracle.substr(cveban,1, 3);
-- aqui va el disparo para insertar o actualizar en saf
--(sesion, 	numcliente,	clave, numnomina, 	nombre, 	appaterno, 	apmaterno, 	domicilio, 	colonia,
--ciudad, 	munidele, 	idestado, 	codpostal, 	telefono, 	idbanco, 	clabe, 	salario, 	fechaingreso,
--idtipopago, 	metodopago, 	idtipocontratacion, 	idempresa, 	idubicacion, 	idestatus, 	exito, 	fechasol, 	fechaapl)
--insert into foempleadoslabora values
--(' ', ws_cve_cte, keyemp, ws_rec_urp, nombre, paterno, materno, domemp, colemp,
--cidemp, munemp, entemp, codemp, telemp, claveban, ws_cta_ban, salmes, fecaux,
--'Q', forpag, ca2aux, keypro, keyloc, status, 'E', wd_fec_mov, wd_fec_mov);
-- verificar si existe el registro
--5.	validar registros en la tabla aux_acum3
--where "numcliente" = ws_cve_cte
--and "numnomina" = keyemp
--and "clave" = recurp;
--existe := 0;
--sp_tovarchar2(salmes)
if wn_res_pue = ' ' then
call sp_datosgenerales_aut (ws_cve_cte, to_char(keyemp), recurp, nombre, paterno, materno, coalesce(domemp, ' '), coalesce(colemp, ' '),
coalesce(cidemp, ' '), coalesce(munemp, ' '), coalesce(entemp, ' '), coalesce(codemp, ' '), coalesce(telemp, ' '), claveban, ws_cta_ban, sp_tovarchar2(wn_sal_mes), fecaux,
ws_cve_cal, coalesce(forpag, ' '), coalesce(ca2aux, ' '), keypro, keyloc, status, wd_fec_mov);
end if;
--insert into foempleadoslabora values
--(' ', 1, 8888, '8888', 'nombre', 'paterno', 'materno', 'domemp', 'colemp',
--'cidemp', 'munemp', 'entemp', '99999', 'telemp', 'claveban', 'ws_cta_ban', 1, '01/01/2001',
--'Q', 'forpag', 'ca2aux', '8', 'keyloc', 1, 'N', '01/01/2013', '01/01/2013');
-- aqui va el disparo para insertar o actualizar en saf
insert into datosgenerales(gen_recurp, gen_keyemp, gen_nomemp, gen_apepat, gen_apemat,
gen_keypro, gen_perpag, gen_cveban, gen_ctaban, gen_fecant, gen_domemp, gen_colemp,
gen_munemp, gen_entemp, gen_codemp, gen_telemp, gen_cidemp, gen_salmes, gen_keyloc, gen_forpag, gen_tpocon, gen_status, gen_numcte, gen_valida) values (ws_rec_urp, keyemp, trim(both sp_delimitador(nomemp,'/',3)), trim(both coalesce(sp_delimitador(nomemp,'/',1), ' ')), trim(both coalesce(sp_delimitador(nomemp,'/',2), ' ')),
keypro, ws_cve_cal, oracle.substr(cveban,1, 3), ws_cta_ban, fecaux, domemp, colemp,
munemp, entemp, codemp, telemp, cidemp, wn_sal_mes, keyloc, forpag, ca2aux, status, ws_cve_cte, wn_res_pue);end;
$body$
language plpgsql
;
