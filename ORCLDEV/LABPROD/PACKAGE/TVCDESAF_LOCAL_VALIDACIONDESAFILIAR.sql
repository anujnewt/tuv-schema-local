create or replace procedure labprod.tvcdesaf_local_validaciondesafiliar (recurp labprod.nmcoempl.emp_recurp%type, keycon labprod.nmloconc.con_keycon%type, resultado inout numeric, emp inout tvcdesaf_local_empleado, per inout tvcdesaf_local_periodo) as $body$
declare
-- pgv moved types start
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
--1, 2. buscar datos del empleado
emp := tvcdesaf_local_existe_empleado(recurp);
if nullif(emp.keyemp::text, '') is null then resultado := 1; return; end if;
--if emp.status = 2 then resultado := 2; return; end if;
--3. buscar concepto
if tvcdesaf_local_existe_concepto(keycon) = 0 then resultado := 8; return; end if;
--4. busca periodo, fechas de calendario
per :=  tvcdesaf_local_existe_periodo( emp );
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PRUEBA', 'NUMBER',(per.diaper)::text, 'N');
if (per.diaper <> 7 and per.diaper <> 10 and per.diaper <> 15)
then resultado := 13;
return;
end if;
if nullif(per.period::text, '') is null then resultado := 5;  return; end if;
resultado := 0;end;
$body$
language plpgsql
;
