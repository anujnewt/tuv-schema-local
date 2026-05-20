create or replace procedure labprod."sp_eliminaprestamo_local"  (ws_rec_urp varchar, ws_cve_ref varchar, ws_key_con varchar, wn_res_pue inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_tot_reg numeric;
wn_key_emp numeric;
ws_key_dep varchar(16);
ws_key_pue varchar(16);
wn_key_pro numeric;
wn_sta_tus numeric;
wn_dia_per numeric;
ws_cve_cal varchar(3);
ws_per_act varchar(7);
wd_fec_ini timestamp(0);
wd_fec_fin timestamp(0);
--igneos.i
wn_cap_des numeric;
pr_sta_tus numeric;
q_empleado record;
begin
--inicializar
wn_key_emp :=0;
--1. buscar datos del empleado
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
--2. buscar pr?stamo
--se asume que los pr?stamos son ?nicos [ref+emp+con] con ca2aux =1
begin
select pre_status into strict pr_sta_tus from labprod.nmlopres
where pre_refere = ws_cve_ref
and pre_keyemp = wn_key_emp
and pre_keycon = ws_key_con
and pre_ca2aux = 1;
--and pre_status = 1;
exception
when no_data_found then
wn_res_pue := 3;
return;
end;
--3.
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
--4. buscar calendario para periodo abierto
---------------------------------------------
--error en calendarios
select count(*) into strict wn_tot_reg from labprod.glcopams
where pam_keypar = ws_cve_cal
and pam_nompar = (select min(per_keyper) from labprod.nmloperi
where per_keypro = wn_key_pro
and per_keynom in ( 1, 26 )
and nullif(per_fecact::text, '') is null);
--5. error en calendario
if wn_tot_reg = 0 then
wn_res_pue := 5;
return;
end if;
--error en calendarios
---------------------------------------------
select pam_nompar, pam_folini, pam_folfin into strict ws_per_act, wd_fec_ini ,wd_fec_fin  from labprod.glcopams
where pam_keypar = ws_cve_cal
and pam_nompar = (select min(per_keyper) from nmloperi
where per_keypro = wn_key_pro
and per_keynom in ( 1, 26 )
and nullif(per_fecact::text, '') is null);
if (trunc(clock_timestamp()) > wd_fec_ini and trunc(clock_timestamp()) < wd_fec_fin) and pr_sta_tus = 2 then
wn_res_pue := 4;
return;
end if;
--eliminar
delete from labprod.nmlopres
where pre_refere = ws_cve_ref
and pre_keyemp = wn_key_emp
and pre_keycon = ws_key_con
and pre_ca2aux = 1;
--and pre_status = 1;
-- mandar llamar a sp_capdes despu?s de insertar
--igneos.i
call labprod.sp_capdes_local (wn_key_emp, wn_cap_des);
wn_res_pue :=0;end;
$body$
language plpgsql
;
