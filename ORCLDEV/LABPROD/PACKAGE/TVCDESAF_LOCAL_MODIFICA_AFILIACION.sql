create or replace procedure labprod.tvcdesaf_local_modifica_afiliacion ( recurp labprod.nmcoempl.emp_recurp%type , cantid numeric, tipact numeric, keycon labprod.nmloconc.con_keycon%type, resultado inout numeric) as $body$
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
--compara rango de fechas de calendario
if (trunc(clock_timestamp()) > v_periodo.fecini and trunc(clock_timestamp()) < v_periodo.fecfin) then
resultado := 4; return; -- la n??mina se est?? calculando
end if;
--pasar??an por accidente algo distinto de 11 o 12?
if tipact = 11 then
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PORCEN', 'NUMBER',(0)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CUOFIJ', 'NUMBER',(cantid)::text, 'N');
elsif tipact = 12 then
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PORCEN', 'NUMBER',(cantid)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CUOFIJ', 'NUMBER',(0)::text, 'N');
else
resultado := 12; return;
end if;
--modifica afiliaci??n
begin
update labprod.nmlodfij set dfi_cantid = dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PORCEN', 'NUMBER', 'N')::numeric, dfi_import = dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CUOFIJ', 'NUMBER', 'N')::numeric, dfi_fecmov = clock_timestamp()
where dfi_keyemp = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp
and dfi_keycon = keycon;
exception
when others then
resultado := 16; return;
end;
--preguntamos por el proceso? a veces lo hacen, a veces n -- podr??a haber m??s de un registro?
--si no se actualizaron registros, avisar
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount = 0 then
resultado := 6; return;
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
