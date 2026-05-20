create or replace procedure labprod.tvcdesaf_local_inserta_prestamo (recurp labprod.nmcoempl.emp_recurp%type, totsol numeric, impdes numeric, totint numeric, intdes numeric, unisal numeric, cvecli varchar, cveref labprod.nmlopres.pre_refere%type, keycon labprod.nmloconc.con_keycon%type, resultado inout numeric) as $body$
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
--incapacitados
begin
select count(*) into strict total_temp from labprod.nmlopres
where pre_keyemp = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp
and pre_status = '2'
and pre_keycon in ('307','308','309')
and trunc(clock_timestamp()) >= pre_fecini
and trunc(clock_timestamp()) <= pre_fe1aux;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAL', 'NUMBER',(total_temp)::text, 'N');
exception
when others then
resultado := 18; return;
end;
--6. incapacitado
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAL', 'NUMBER', 'N')::numeric > 0 then
resultado := 14;
return;
end if;
-------------------------------------------
--solicitud concepto 89a
begin
select count(*) into strict total_temp from labprod.glcopams
where pam_keypar = 'SAFF' and pam_folini = keycon;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAL', 'NUMBER',(total_temp)::text, 'N');
exception
when others then
resultado := 18; return;
end;
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAL', 'NUMBER', 'N')::numeric > 0 then
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES_VALIDADO', 'number',(0)::text, 'N');
else
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES_VALIDADO', 'number',(dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES', 'NUMBER', 'N')::numeric)::text, 'N');
end if;
--valida que no exista
if tvcdesaf_local_existe_prestamo(cveref, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, 1) > 0 then
resultado := 9; return;
capdes_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric;
else
--calcula capacidad de descuento
call labprod.sp_capdes (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, capdes_temp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER',(capdes_temp)::text, 'N');
if floor(30/v_periodo.diaper)*(dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES', 'NUMBER', 'N')::numeric+intdes) > dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric then
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
select nextval('labprod.nmlopres_seq') into strict keypre_temp;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER',(keypre_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER',((dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER', 'N')::numeric * 0.000001) + (to_char(clock_timestamp(), 'YYMMDD'))::numeric )::text, 'N');
fecini_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'FECINI', 'DATE', 'N')::timestamp without time zone;
peract_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR', 'N')::varchar;
impdes_validado_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES_VALIDADO', 'number', 'N')::numeric;
keypre_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER', 'N')::numeric;
begin
insert into labprod.nmlopres(current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, keypre_temp, cveref, clock_timestamp(), 'N', totint, totsol, 0, 0, intdes, impdes_validado_temp, 0, peract_temp, fecini_temp, null, null, null, 0, 0, unisal, totsol, 0, 0, 0, 0, 1, clock_timestamp(), null, null, null, null, null, 1, current_setting('tvcdesaf_local.impdes')::numeric + intdes, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, 1, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, null, null)
values (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, keypre_temp, cveref, clock_timestamp(), 'N', totint, totsol, 0, 0, intdes, impdes_validado_temp, 0, peract_temp, fecini_temp, null, null, null, 0, 0, unisal, totsol, 0, 0, 0, 0, 1, clock_timestamp(), null, null, null, null, null, 1, dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES', 'NUMBER', 'N')::numeric + intdes, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, 1, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, null, null);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER',(keypre_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES_VALIDADO', 'number',(impdes_validado_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(peract_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'FECINI', 'DATE',(fecini_temp)::text, 'N');
exception
when others then
resultado := 15; return;
end;
end if;
end if;
capdes_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric;
------------------------------------------
------------------------------------------
--calcula nueva capacidad de descuento
call labprod.sp_capdes_local (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, capdes_temp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER',(capdes_temp)::text, 'N');
--termina
resultado :=0;end;
$body$
language plpgsql
;
