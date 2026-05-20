create or replace procedure labprod."sp_insertaprestamo_local"  (ws_rec_urp varchar, wn_tot_sol numeric, wn_imp_des numeric, --wn_tot_int in number, wn_int_des in number, gd_uni_sal in number, ws_cve_cli in varchar, ws_cve_ref in varchar, ws_key_con in varchar,
wn_tot_int numeric, wn_int_des numeric, ws_cve_cli varchar, ws_cve_ref varchar, ws_key_con varchar, wn_res_pue inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--ws_rec_urp  curp del empleado
--wn_tot_sol  monto total solicitado
--wn_imp_des  monto a descontar
--wn_tot_int  total intereses
--wn_int_des  intereses a descontar por periodo
--ws_cve_cli  clave de cliente
--ws_cve_ref  clave de prestamo saf
--ws_key_con  clave del concepto
--gd_uni_sal  ... saldo
wn_key_emp numeric;
ws_key_dep varchar(16);
ws_key_pue varchar(16);
wn_key_pro numeric;
wn_sta_tus numeric;
wn_dia_per numeric;
--igneos.i
wn_tot_reg numeric;
ws_cve_cal varchar(3);
ws_per_act varchar(7);
wd_fec_ini timestamp(0);
wd_fec_fin timestamp(0);
wd_fec_per timestamp(0);
--igneos.i
wn_cap_des numeric;
wn_key_pre numeric;
--igneos.i
wn_imp_des_validado numeric;
q_empleado record;
begin
wn_res_pue:=0;
--1. buscar empleado
wn_key_emp :=0;
for q_empleado in (select emp_keyemp,emp_keydep,emp_keypue,emp_keypro,emp_status
from labprod.nmcoempl
where emp_recurp = ws_rec_urp
order by  emp_status) loop
wn_key_emp := q_empleado.emp_keyemp;
ws_key_dep := q_empleado.emp_keydep;
ws_key_pue := q_empleado.emp_keypue;
wn_key_pro := q_empleado.emp_keypro;
wn_sta_tus := q_empleado.emp_status;
exit;
end loop;
if wn_key_emp = 0 then
wn_res_pue := 1;
return;
end if;
if wn_sta_tus = 2 then
wn_res_pue := 2;
return;
end if;
--2. buscar el pr?stamo
select count(*) into strict wn_tot_reg from labprod.nmlopres
where pre_refere = ws_cve_ref
and pre_keyemp = wn_key_emp
and pre_ca2aux = 1
and pre_keycon = ws_key_con;
if wn_tot_reg > 0 then
wn_res_pue := 3;
return;
end if;
--3. buscar el calendario del proceso
--notar que s?lo se considera 7, 10, 15
select pro_diaper into strict wn_dia_per
from labprod.nmloproc
where pro_keypro = wn_key_pro;
if wn_dia_per = 7 then
ws_cve_cal := 'CPS';
elsif wn_dia_per = 10 then
ws_cve_cal := 'CPD';
elsif wn_dia_per = 15 then
ws_cve_cal := 'CPQ';
end if;
--4. buscar concepto
select count(*) into strict wn_tot_reg from labprod.nmloconc
where con_keycon = ws_key_con;
if wn_tot_reg = 0 then
wn_res_pue := 4;
return;
end if;
--5. buscar periodo de n?mina inicial de descuento
select min(per_keyper) into strict ws_per_act from labprod.nmloperi
where per_keypro = wn_key_pro
and per_keynom in ( 1, 26 )
and nullif(per_fecact::text, '') is null;
---------------------------------------------
--error en calendarios
select count(*) into strict wn_tot_reg from labprod.glcopams
where pam_keypar = ws_cve_cal
and pam_nompar = (select min(per_keyper) from nmloperi
where per_keypro = wn_key_pro
and per_keynom in ( 1, 26 )
and nullif(per_fecact::text, '') is null);
--5. error en calendario
if wn_tot_reg = 0 then
wn_res_pue := 5;
return;
end if;
---------------------------------------------
--error en calendarios
--incapacitados:
select count(*) into strict wn_tot_reg from labprod.nmlopres
where pre_keyemp = wn_key_emp
and pre_status = '2'
and pre_keycon in ('307','308','309')
and trunc(clock_timestamp()) >= pre_fecini
and trunc(clock_timestamp()) <= pre_fe1aux;
--6. incapacitado
if wn_tot_reg > 0 then
wn_res_pue := 6;
return;
end if;
-------------------------------------------
--solicitud concepto 89a
select count(*) into strict wn_tot_reg from labprod.glcopams
where pam_keypar = 'SAFF' and pam_folini = ws_key_con;
if wn_tot_reg > 0 then
wn_imp_des_validado := 0;
else
wn_imp_des_validado := wn_imp_des;
end if;
-------------------------------------------
select pam_nompar, pam_folini, pam_folfin into strict ws_per_act, wd_fec_ini ,wd_fec_fin  from labprod.glcopams
where pam_keypar = ws_cve_cal
and pam_nompar = (select min(per_keyper) from nmloperi
where per_keypro = wn_key_pro
and per_keynom in ( 1, 26 )
and nullif(per_fecact::text, '') is null);/* dmap converted statement start */
if (trunc(clock_timestamp()) > wd_fec_ini and trunc(clock_timestamp()) < wd_fec_fin) then
if (oracle.substr(ws_per_act, 5, 3))::numeric  = floor(365/wn_dia_per) then
ws_per_act := concat( to_char((oracle.substr(ws_per_act, 1, 4))::numeric +1), '001') ;/* dmap converted statement end */
else
ws_per_act := to_char((ws_per_act)::numeric  + 1);
end if;
end if;
--campos a insertar
select per_fecini into strict wd_fec_per from labprod.nmloperi
where per_keyper = ws_per_act
and per_keypro = wn_key_pro;
select nextval('labprod.nmlopres_seq') into strict wn_key_pre;
wn_key_pre := (wn_key_pre * 0.000001) + (to_char(clock_timestamp(), 'YYMMDD'))::numeric;
insert into labprod.nmlopres(pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
pre_ca4aux, pre_uniope, pre_keypro, pre_impnoa, pre_pernoa)
values (
wn_key_emp, ws_key_con, wn_key_pre , ws_cve_ref, clock_timestamp(),
'N', wn_tot_int, wn_tot_sol, 0, 0,
wn_int_des, wn_imp_des_validado, 0, ws_per_act, wd_fec_per,
null, null, null, 0, 0,
--gd_uni_sal, wn_tot_sol, 0, 0, 0,
0, wn_tot_sol, 0, 0, 0,
0, 1, clock_timestamp(), null, null,
null, null, null, 1, wn_imp_des + wn_int_des,
wn_key_pro, 1, wn_key_pro, null, null);
-- mandar llamar a sp_capdes despu?s de insertar
--igneos.i
call labprod.sp_capdes (wn_key_emp, wn_cap_des);
-----------------------------------------------
wn_res_pue := 0;end;
$body$
language plpgsql
;
