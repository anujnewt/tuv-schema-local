create or replace procedure labprod.tvautsaf_local_sp_incidencia_ca ( wn_key_emp numeric, ws_cve_ref varchar, wn_tot_sol numeric, wn_imp_des numeric, gn_fec_ini varchar, wn_imp_sal numeric, wn_uni_pre numeric, wn_uni_des numeric, wn_uni_sal numeric, ws_key_con varchar, ws_per_saf varchar, wn_res_pue inout numeric) as $body$
declare
-- pgv moved types start
--dmap moved type current package tvautsaf_local;
--dmap moved type current package tvautsaf_local;
current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia TVAUTSAF_LOCAL_tipo_incidencia;
-- pgv moved types end
ws_key_dep varchar(16);
ws_key_pue varchar(16);
wn_key_pro numeric;
wn_key_cia numeric;
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
gn_key_emp numeric;
--dmap conversion comment: global temp variables moved as local temp variables
total_temp integer;
banco_temp varchar;
bandera_temp integer;
nombre__temp varchar;
--dmap conversion comment: declaration boundary ends
q_empleado record;
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVAUTSAF_LOCAL');
--dmap conversion comment: gtt declaration added
--0. inicializar variables
current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia.wn_key_emp := wn_key_emp; current_setting('tvautsaf_local.incidencia')::tipo_incidencia.ws_cve_ref := ws_cve_ref; current_setting('tvautsaf_local.incidencia')::tipo_incidencia.wn_tot_sol := wn_tot_sol; current_setting('tvautsaf_local.incidencia')::tipo_incidencia.wn_imp_des := wn_imp_des;
current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia.gn_fec_ini := gn_fec_ini; current_setting('tvautsaf_local.incidencia')::tipo_incidencia.wn_imp_sal := wn_imp_sal; current_setting('tvautsaf_local.incidencia')::tipo_incidencia.wn_uni_pre := wn_uni_pre; current_setting('tvautsaf_local.incidencia')::tipo_incidencia.wn_uni_des := wn_uni_des;
current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia.wn_uni_sal := wn_uni_sal; current_setting('tvautsaf_local.incidencia')::tipo_incidencia.ws_key_con := ws_key_con; current_setting('tvautsaf_local.incidencia')::tipo_incidencia.ws_per_saf := ws_per_saf;
wn_res_pue:=0;
-------------------------------------------
--1. buscar empleado
gn_key_emp :=0;
for q_empleado in (select emp_keyemp,emp_keydep,emp_keypue,emp_keypro,emp_status
from labprod.nmcoempl
where emp_keyemp = wn_key_emp
order by  emp_status) loop
gn_key_emp := q_empleado.emp_keyemp;
ws_key_dep := q_empleado.emp_keydep;
ws_key_pue := q_empleado.emp_keypue;
wn_key_pro := q_empleado.emp_keypro;
wn_sta_tus := q_empleado.emp_status;
exit;
end loop;
--no existe el empleado
if gn_key_emp = 0 then
wn_res_pue := 1;
call tvautsaf_local_bitacora_incidencia(current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia, wn_res_pue, null, null, 0);
return;
end if;
--2. buscar el calendario del proceso
--notar que s?lo se considera 7, 10, 15
select pro_diaper, pro_keycia into strict wn_dia_per, wn_key_cia
from labprod.nmloproc where pro_keypro = wn_key_pro;
if wn_dia_per = 7 then ws_cve_cal := 'CPS';
elsif wn_dia_per = 10 then ws_cve_cal := 'CPD';
elsif wn_dia_per = 15 then ws_cve_cal := 'CPQ';
end if;
begin
--3. buscar el periodo actual
select pam_nompar, pam_folini, pam_folfin into strict ws_per_act, wd_fec_ini ,wd_fec_fin  from labprod.glcopams
where pam_keypar = ws_cve_cal
and pam_nompar = (select min(per_keyper) from labprod.nmloperi
where per_keypro = wn_key_pro
and per_keynom in ( 1, 26 )
and nullif(per_fecact::text, '') is null);
exception
when others then
wn_res_pue := 4;
call tvautsaf_local_bitacora_incidencia(current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia, wn_res_pue, null, wn_key_pro, 0);
return;
end;/* dmap converted statement start */
--asignar el siguiente si la n?mina se est? calculando
if (trunc(clock_timestamp()) > wd_fec_ini and trunc(clock_timestamp()) < wd_fec_fin) then
if (oracle.substr(ws_per_act, 5, 3))::numeric  = floor(365/wn_dia_per) then
ws_per_act := concat( to_char((oracle.substr(ws_per_act, 1, 4))::numeric +1), '001') ;/* dmap converted statement end */
else
ws_per_act := to_char((ws_per_act)::numeric  + 1);
end if;
end if;
--si el empleado est? dado de baja, termina la ejecuci?n
if wn_sta_tus = 2 then
wn_res_pue := 2;
call tvautsaf_local_bitacora_incidencia(current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia, wn_res_pue, ws_per_act, wn_key_pro, 0);
return;
end if;
--valida que exista registro en calendarios
select count(*) into strict wn_tot_reg from labprod.glcopams
where pam_keypar = ws_cve_cal
and pam_nompar = (select min(per_keyper) from labprod.nmloperi
where per_keypro = wn_key_pro
and per_keynom in ( 1, 26 )
and nullif(per_fecact::text, '') is null);
--. error en calendario
if wn_tot_reg = 0 then
wn_res_pue := 4;
call tvautsaf_local_bitacora_incidencia(current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia, wn_res_pue, ws_per_act, wn_key_pro, 0);
return;
end if;
--4. buscar concepto
select count(*) into strict wn_tot_reg from labprod.nmloconc
where con_keycon = ws_key_con;
if wn_tot_reg = 0 then
wn_res_pue := 3;
call tvautsaf_local_bitacora_incidencia(current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia, wn_res_pue, ws_per_act, wn_key_pro, 0);
return;
end if;
--validaci?n de periodo enviado contra periodo de aplicaci?n
if ws_per_saf <> ws_per_act then
wn_res_pue := 19;
call tvautsaf_local_bitacora_incidencia(current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia, wn_res_pue, ws_per_act, wn_key_pro, 0);
return;
end if;
--6. buscar el pr?stamo
select count(*) into strict wn_tot_reg from labprod.nmlopres
where pre_refere = ws_cve_ref
and pre_keyemp = wn_key_emp
and pre_status = 2
and pre_impsal > 0
and pre_keycon = ws_key_con;
if wn_tot_reg > 0 then
update labprod.nmlopres set pre_impdes = wn_imp_des, pre_impsal = wn_imp_sal,
pre_unipre = wn_uni_pre, pre_unides = wn_uni_des, pre_unisal = wn_uni_sal
where pre_refere = ws_cve_ref
and pre_keyemp = wn_key_emp
and pre_keycon = ws_key_con;
call tvautsaf_local_bitacora_incidencia(current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia, wn_res_pue, ws_per_act, wn_key_pro, 1);
else
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
'N', wn_uni_pre, wn_tot_sol, 0, 0,
wn_uni_des, wn_imp_des, 0, ws_per_act, wd_fec_per,
null, null, null, 0, 0,
--gd_uni_sal, wn_tot_sol, 0, 0, 0,
wn_uni_sal, wn_imp_sal, 0, 0, 0,
0, 2, clock_timestamp(), null, null,
null, null, null, 1, wn_imp_des + wn_uni_des,
wn_key_pro, 1, wn_key_pro, null, null);
call tvautsaf_local_bitacora_incidencia(current_setting('tvautsaf_local.incidencia')::TVAUTSAF_LOCAL_tipo_incidencia, wn_res_pue, ws_per_act, wn_key_pro, 2);
end if;
call labprod.sp_capdes (wn_key_emp, wn_cap_des);
wn_res_pue := 0;end;
$body$
language plpgsql
;
