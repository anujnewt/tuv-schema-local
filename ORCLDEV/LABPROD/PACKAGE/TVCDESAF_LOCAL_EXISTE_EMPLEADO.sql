create or replace  function  labprod.tvcdesaf_local_existe_empleado ( recurp labprod.nmcoempl.emp_recurp%type ) returns TVCDESAF_LOCAL_empleado as $body$
declare
-- pgv moved types start
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
q_empleado record;
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVCDESAF_LOCAL');
--dmap conversion comment: gtt declaration added
for q_empleado in (select emp_keyemp,emp_keydep,emp_keypue,emp_keypro,emp_status from labprod.nmcoempl where emp_recurp = recurp  order by  emp_status)
loop
current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp := q_empleado.emp_keyemp;
current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keydep := q_empleado.emp_keydep;
current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypue := q_empleado.emp_keypue;
current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro := q_empleado.emp_keypro;
current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.status := q_empleado.emp_status;
exit;
end loop;
return current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado;end;
$body$
language plpgsql
;
