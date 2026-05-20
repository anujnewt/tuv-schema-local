create or replace procedure labprod.tvautsaf_local_sp_datosgenerales_fa (recurp labprod.nmcoempl.emp_recurp%type, keyemp labprod.nmcoempl.emp_keyemp%type, nomemp labprod.nmcoempl.emp_nomemp%type, keypro labprod.nmcoempl.emp_keypro%type, cveban labprod.nmcoempl.emp_cveban%type, fecaux labprod.nmcoempl.emp_fecaux%type, domemp labprod.nmcoempl.emp_domemp%type, colemp labprod.nmcoempl.emp_colemp%type, munemp labprod.nmcoempl.emp_munemp%type, entemp labprod.nmcoempl.emp_entemp%type, codemp labprod.nmcoempl.emp_codemp%type, telemp labprod.nmcoempl.emp_telemp%type, cidemp labprod.nmcoempl.emp_cidemp%type, salmes labprod.nmcoempl.emp_salmes%type, keyloc labprod.nmcoempl.emp_keyloc%type, forpag labprod.nmcoempl.emp_forpag%type, ca2aux labprod.nmcoempl.emp_ca2aux%type, status labprod.nmcoempl.emp_status%type, ca4aux labprod.nmcoempl.emp_ca4aux%type) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_res_pue labprod.datosgenerales.gen_valida%type;
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
--dmap conversion comment: global temp variables moved as local temp variables
total_temp integer;
banco_temp varchar;
bandera_temp integer;
nombre__temp varchar;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVAUTSAF_LOCAL');
--dmap conversion comment: gtt declaration added
wn_res_pue:=' ';
wd_fec_mov:= clock_timestamp();/* dmap converted statement start */
if ca4aux <> 'F' then
wn_res_pue :=  concat(wn_res_pue, '8') ;/* dmap converted statement end */
--  return;
end if;/* dmap converted statement start */
if status <> 1 then
wn_res_pue :=  concat(wn_res_pue, '0') ;/* dmap converted statement end */
--  return;
end if;
--1. buscar clientes
select pam_cvesec, coalesce(pam_folini,'T') into strict ws_cve_cte, ws_tpo_con
from labprod.glcopams
where pam_keypar = 'SAFN'
and pam_folfin = 'F';/* dmap converted statement start */
--2. validar tipo de contrato
if ws_tpo_con <> 'T' then
if position(ca2aux in ws_tpo_con) = 0 then
wn_res_pue :=  concat(wn_res_pue, '2') ;/* dmap converted statement end */
--  return;
end if;
end if;
--3. validar procesos
select count(*) into strict wn_tot_reg from labprod.glcopams
where pam_keypar = 'SAF'
and pam_folfin = 'tviaefah'
and pam_folini = keypro;/* dmap converted statement start */
if wn_tot_reg > 0 then
wn_res_pue :=  concat(wn_res_pue, '3') ;/* dmap converted statement end */
--return;
end if;
--4.	validar empleados con m?s de una clave en saf
begin
select pam_nompar into strict gl_rec_urp from labprod.glcopams
where pam_keypar = 'CEFI'
and pam_folini = keyemp;
exception
when no_data_found then gl_rec_urp := ' ';
end;
if gl_rec_urp <> ' ' then
ws_rec_urp := gl_rec_urp;
else
ws_rec_urp := recurp;
end if;
--5.	validar registros en la tabla aux_acum3
select count(*) into strict wn_tot_reg
from labprod.aux_acum3
where keycon = 'tviaesnt'
and keyemp = keyemp;/* dmap converted statement start */
if wn_tot_reg <> 0 then
wn_res_pue :=  concat(wn_res_pue, '5') ;/* dmap converted statement end */
end if;
-- validaciones en la inserci?n
-- buscar el calendario del proceso (notar que s?lo se considera 7, 10, 15)
select pro_diaper into strict wn_dia_per from labprod.nmloproc
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
from labprod.nmloctas
where cta_keyemp = keyemp
and cta_keypro = keypro;/* dmap converted statement start */
exception
when no_data_found then wn_res_pue :=  concat(wn_res_pue, '9') ;/* dmap converted statement end */
end;
if keypro = 6 then
wn_sal_mes := 15000;
else
wn_sal_mes := salmes;
end if;
ws_cve_ban := cveban;
if forpag = 1 or forpag = 4 then
ws_cve_ban := '000';
ws_cta_ban := '000000000000000000';
end if;
nombre := trim(both labprod.sp_delimitador(nomemp,'/',3));
paterno := trim(both coalesce(labprod.sp_delimitador(nomemp,'/',1), ' '));
materno := trim(both coalesce(labprod.sp_delimitador(nomemp,'/',2), ' '));/* dmap converted statement start */
if tvautsaf_local_antiguedadvalida(fecaux) = 0 then
wn_res_pue :=  concat(wn_res_pue, '9') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
insert into labprod.datosgenerales_errsaf values (keyemp, 'UPDATE', clock_timestamp(),
concat(wn_res_pue, ' prueba fondo ahorro 2711_respue' , wn_res_pue)) ;/* dmap converted statement end */
if wn_res_pue = ' ' then
call tvautsaf_local_sp_datosgenerales_fa_aut(ws_cve_cte, to_char(keyemp), recurp, nombre, paterno, materno, coalesce(domemp, ' '), coalesce(colemp, ' '),
coalesce(cidemp, ' '), tvautsaf_local_nombremunicipio(munemp), coalesce(entemp, ' '), coalesce(codemp, ' '), coalesce(telemp, ' '), ws_cve_ban, ws_cta_ban, sp_tovarchar2(wn_sal_mes), fecaux,
ws_cve_cal, coalesce(forpag, ' '), coalesce(ca2aux, ' '), keypro, keyloc, status, wd_fec_mov);
end if;end;
$body$
language plpgsql
;
