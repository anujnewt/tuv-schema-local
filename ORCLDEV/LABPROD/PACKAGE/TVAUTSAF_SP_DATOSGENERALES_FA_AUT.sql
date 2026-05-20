create or replace procedure labprod.dmap_tvautsaf_sp_datosgenerales_fa_aut (cliente varchar,keyemp varchar, recurp nmcoempl.emp_recurp%type, nombre varchar, paterno varchar, materno varchar, domicilio varchar, colonia varchar, ciudad varchar, municipio varchar, entidad varchar, codigopostal varchar, telefono varchar, clavebanco varchar, cuentabanco varchar, salariomensual varchar, fechaingreso timestamp(0), tipopago varchar, metodopago varchar, tipocontrato varchar, proceso varchar, localidad varchar, status varchar, fecha timestamp(0)) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- pragma autonomous_transaction;
existe_curp integer;
existe_empleado integer;
--dmap conversion comment: global temp variables moved as local temp variables
total_temp integer;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVAUTSAF');
--dmap conversion comment: gtt declaration added
return;end;
$body$
language plpgsql
;
