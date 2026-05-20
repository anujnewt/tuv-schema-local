create or replace procedure labprod.tvcdesaf_local_inserta (recurp labprod.nmcoempl.emp_recurp%type , monsol numeric, mondes numeric, tipact numeric, cveref labprod.nmlopres.pre_refere%type, unipre numeric, unides numeric, unisal numeric, keycon labprod.nmloconc.con_keycon%type, resultado inout numeric) as $body$
declare
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
--pasar??an por accidente algo distinto de 7?
if tipact <> 7 then
resultado := 12; return;
end if;
--valida que no exista
if tvcdesaf_local_existe_prestamo(cveref, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, tipact) > 0 then
resultado := 9; return;
capdes_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric;
else
--calcula capacidad de descuento
call labprod.sp_capdes_local (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, capdes_temp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER',(capdes_temp)::text, 'N');
if floor(30/v_periodo.diaper)*(mondes+unides) > dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric then
resultado := 11; return;
else
--campos a insertar
begin
select per_fecini into strict fecini_temp from labprod.nmloperi
where per_keyper = dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR', 'N')::varchar
and per_keypro = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'FECINI', 'DATE',(fecini_temp)::text, 'N');
exception
when others then
resultado := 18; return;
end;
--se le est?? mandando al insert el fecini?
select nextval('labprod.nmlopres_seq') into strict keypre_temp;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER',(keypre_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER',((dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER', 'N')::numeric * 0.000001) + (to_char(clock_timestamp(), 'YYMMDD'))::numeric )::text, 'N');
peract_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR', 'N')::varchar;
keypre_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER', 'N')::numeric;
begin
insert into labprod.nmlopres(current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, keypre_temp, cveref, clock_timestamp(), 'N', unipre, monsol + unipre, 0, 0, unides, mondes + unides, 0, peract_temp, v_periodo.fecini, null, null, null, 0, 0, unipre, monsol + unipre, 0, 0, 0, 0, 1, clock_timestamp(), null, null, null, null, null, 1, mondes + unides, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, 1, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, null, null)
values (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, keypre_temp, cveref, clock_timestamp(), 'N', unipre, monsol + unipre, 0, 0, unides, mondes + unides, 0, peract_temp, v_periodo.fecini, null, null, null, 0, 0, unipre, monsol + unipre, 0, 0, 0, 0, 1, clock_timestamp(), null, null, null, null, null, 1, mondes + unides, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, 1, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, null, null);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER',(keypre_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(peract_temp)::text, 'N');
exception
when others then
resultado := 15; return;
end;
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
