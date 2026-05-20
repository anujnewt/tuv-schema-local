create or replace procedure labprod.tvcdesaf_local_afiliar (recurp labprod.nmcoempl.emp_recurp%type , cantid numeric, tipact numeric, keycon labprod.nmloconc.con_keycon%type, resultado inout numeric) as $body$
declare
-- pgv moved types start
--dmap moved type current package tvcdesaf_local;
--dmap moved type current package tvcdesaf_local;
v_afiliacion TVCDESAF_LOCAL_afiliacion;
--dmap moved type current package tvcdesaf_local;
--dmap moved type current package tvcdesaf_local;
v_periodo   TVCDESAF_LOCAL_periodo;
--dmap moved type current package tvcdesaf_local;
--dmap moved type current package tvcdesaf_local;
current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado TVCDESAF_LOCAL_empleado;
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
peract_temp varchar;
porcen_temp numeric;
cuofij_temp numeric;
totafi_temp numeric;
capdes_temp numeric;
fecini_temp timestamp(0);
keypre_temp numeric;
impdes_temp numeric;
total_temp numeric;
perini_temp varchar;
impdes_validado_temp numeric;
prueba_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVCDESAF_LOCAL');
--dmap conversion comment: gtt declaration added
call tvcdesaf_local_validacion(recurp, keycon, dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'V_VAR', 'NUMBER', 'N')::numeric, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado, v_periodo); --existencia de TVCDESAF_LOCAL_empleado, TVCDESAF_LOCAL_periodo y concepto
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'V_VAR', 'NUMBER', 'N')::numeric > 0 then
resultado := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'V_VAR', 'NUMBER', 'N')::numeric; return;
end if;
--compara rango de fechas de calendario
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(v_periodo.period)::text, 'N');/* dmap converted statement start */
if (trunc(clock_timestamp()) > v_periodo.fecini and trunc(clock_timestamp()) < v_periodo.fecfin) then
if (oracle.substr(v_periodo.period, 5, 3))::numeric  = floor(365/v_periodo.diaper) then
peract_temp := concat( to_char((oracle.substr(v_periodo.period, 1, 4))::numeric +1), '001') ;/* dmap converted statement end */
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(peract_temp)::text, 'N');
else
peract_temp := to_char((v_periodo.period)::numeric  + 1);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(peract_temp)::text, 'N');
end if;
end if;
--pasar??an por accidente algo distinto de 1 o 2?
if tipact = 1 then
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PORCEN', 'NUMBER',(0)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CUOFIJ', 'NUMBER',(cantid)::text, 'N');
elsif tipact = 2 then
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PORCEN', 'NUMBER',(cantid)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CUOFIJ', 'NUMBER',(0)::text, 'N');
else
resultado := 12; return;
end if;
--busca la afiliaci??n
v_afiliacion := tvcdesaf_local_existe_afiliacion(current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro);
--busca el concepto
select count(*) into strict totafi_temp from labprod.glcopams
where pam_keypar = 'SAFO' and pam_cvesec = keycon;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAFI', 'number',(totafi_temp)::text, 'N');
cuofij_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CUOFIJ', 'NUMBER', 'N')::numeric;
porcen_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PORCEN', 'NUMBER', 'N')::numeric;
peract_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR', 'N')::varchar;
if nullif(v_afiliacion.keycon::text, '') is null then
--inserta afiliaci??n
begin
insert into labprod.nmlodfij(current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, peract_temp, '2999999', current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keydep, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypue, clock_timestamp(), porcen_temp, cuofij_temp, clock_timestamp(), null)
values (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, peract_temp, '2999999', current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keydep, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypue, clock_timestamp(), porcen_temp, cuofij_temp, clock_timestamp(), null);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(peract_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PORCEN', 'NUMBER',(porcen_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CUOFIJ', 'NUMBER',(cuofij_temp)::text, 'N');
exception
when others then resultado := 15; return;
end;
else
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAFI', 'number', 'N')::numeric = 0 then
--actualiza sumando o manda error?       --se suma y se valida que...?
begin
update labprod.nmlodfij set dfi_cantid = current_setting('tvcdesaf_local.porcen')::numeric + dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PORCEN', 'NUMBER', 'N')::numeric, dfi_import = current_setting('tvcdesaf_local.cuofij')::numeric + dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CUOFIJ', 'NUMBER', 'N')::numeric, dfi_ca2aux = clock_timestamp()
where dfi_keyemp = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp
and dfi_keycon = keycon
and dfi_keypro = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro;
exception
when others then resultado := 16; return;
end;
else
--existe en la alfanum??rica
resultado := 12; return;
end if;
end if;
capdes_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric;
--calcula nueva capacidad de descuento
call labprod.sp_capdes_local (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, capdes_temp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER',(capdes_temp)::text, 'N');
--termina
resultado :=0;end;
$body$
language plpgsql
;
