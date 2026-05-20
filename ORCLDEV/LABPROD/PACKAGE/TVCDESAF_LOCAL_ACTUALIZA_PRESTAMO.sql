create or replace procedure labprod.tvcdesaf_local_actualiza_prestamo ( recurp labprod.nmcoempl.emp_recurp%type , cveref labprod.nmlopres.pre_refere%type, keycon labprod.nmloconc.con_keycon%type, resultado inout numeric) as $body$
declare
ora2pg_rowcount int;
-- pgv moved types start
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
--consulta perini del pr??stamo
begin
select pre_perini into strict perini_temp from labprod.nmlopres
where pre_keyemp = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp
and pre_refere = cveref and pre_keycon = keycon;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERINI', 'VARCHAR',(perini_temp)::text, 'N');
exception
when others then
resultado := 18; return;
end;
--verifica si existe el pr??stamo
if tvcdesaf_local_existe_prestamo(cveref, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, 14) > 0 then
resultado := 9; return;
end if;/* dmap converted statement start */
--compara rango de fechas de calendario
if (trunc(clock_timestamp()) > v_periodo.fecini and trunc(clock_timestamp()) < v_periodo.fecfin) then
--resultado := 4; return; -- la n??mina se est?? calculando
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERINI', 'VARCHAR', 'N')::varchar <= v_periodo.period then
if (oracle.substr(v_periodo.period, 5, 3))::numeric  = floor(365/v_periodo.diaper) then
peract_temp := concat( to_char((oracle.substr(v_periodo.period, 1, 4))::numeric +1), '001') ;/* dmap converted statement end */
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(peract_temp)::text, 'N');
else
peract_temp := to_char((v_periodo.period)::numeric  + 1);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(peract_temp)::text, 'N');
end if;
begin
update labprod.nmlopres set pre_status = 2, pre_perini = dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR', 'N')::varchar
where pre_refere = cveref
and pre_keyemp = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp
and pre_keycon = keycon
and pre_ca2aux = 1
and pre_status = 1;
exception
when others then
resultado := 16; return;
end;
--si no se actualizaron registros, avisar
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount = 0 then
resultado := 3; return;
end if;
else
--actualiza registro de pr??stamo
begin
update labprod.nmlopres set pre_status = 2
where pre_refere = cveref
and pre_keyemp = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp
and pre_keycon = keycon
and pre_ca2aux = 1
and pre_status = 1;
exception
when others then
resultado := 16; return;
end;
--si no se actualizaron registros, avisar
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount = 0 then
resultado := 3; return;
end if;
end if;
else
--actualiza registro de pr??stamo
begin
update labprod.nmlopres set pre_status = 2
where pre_refere = cveref
and pre_keyemp = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp
and pre_keycon = keycon
and pre_ca2aux = 1
and pre_status = 1;
exception
when others then
resultado := 16; return;
end;
--si no se actualizaron registros, avisar
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount = 0 then
resultado := 3; return;
end if;
end if;
capdes_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric;
/*
--compara rango de fechas de calendario
if (trunc(sysdate) > v_periodo.fecini and trunc(sysdate) < v_periodo.fecfin) and perini <= v_periodo.period then
resultado := 4; return; -- la n??mina se est?? calculando
end if;
--verifica si existe el pr??stamo
if tvcdesaf_local_existe_prestamo(cveref, v_empleado.keyemp, keycon, 14) > 0 then
resultado := 9; return;
end if;
*/
--calcula nueva capacidad de descuento
call labprod.sp_capdes_local (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, capdes_temp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER',(capdes_temp)::text, 'N');
--termina
resultado :=0;end;
$body$
language plpgsql
;
