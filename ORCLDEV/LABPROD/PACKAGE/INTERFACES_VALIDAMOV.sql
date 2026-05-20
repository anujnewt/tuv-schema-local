create or replace procedure labprod.interfaces_validamov ( id_transaccion varchar, estatus inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0) ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
keyemp numeric;
tipmov varchar(2);
submov varchar(6);
cuenta numeric;
existe numeric;
statusemp varchar(1);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
message := 'Pendiente de validar';
estatus := 'OK';
code := '1';
fecha := clock_timestamp();
select count(*)  into strict cuenta  from labprod.api_movimientosper where api_movimientosper.id_transaccion = validamov.id_transaccion and api_movimientosper.estatus = '4';/* dmap converted statement start */
perform dbms_output.put_line( concat('CUENTA', cuenta)) ;/* dmap converted statement end */
if cuenta != 0 then
select  emp_tipmov,emp_submov,emp_keyemp  into strict tipmov,submov ,keyemp
from labprod.api_movimientosper where api_movimientosper.id_transaccion = validamov.id_transaccion and api_movimientosper.estatus = '4';/* dmap converted statement start */
perform dbms_output.put_line( concat('KEYEMP', keyemp)) ;/* dmap converted statement end */
select count(*) into strict existe  from labprod.nmcoempl where nmcoempl.emp_keyemp = validamov.keyemp;/* dmap converted statement start */
perform dbms_output.put_line( concat('EXISTE', existe)) ;/* dmap converted statement end */
if existe = 0 then
-- si no existe el empleado
if tipmov !='1' and tipmov != '6'  then
message:= 'EL EMPLEADO NO EXISTE, DAR DE ALTA PRIMERO';
estatus := 'ERROR';
code := '5';
end if;
if tipmov = '6' and submov = '44'   then
message:= 'EL EMPLEADO NO EXISTE, DAR DE ALTA PRIMERO';
estatus := 'ERROR';
code := '5';
end if;
end if;
if existe > 0 then
select emp_status into strict statusemp from labprod.nmcoempl where nmcoempl.emp_keyemp = validamov.keyemp;
if tipmov = '1' then
message:= 'NO SE PUEDE DAR DE ALTA A UN EMPLEADO EXISTENTE';
estatus := 'ERROR';
code := '5';
end if;
if tipmov = '6' and statusemp  = '1' then
message:= 'NO SE PUEDE REINGRESAR A UN EMPLEADO ACTIVO';
estatus := 'ERROR';
code := '5';
end if;
if statusemp  = '2' and tipmov !='6' then
message:= 'NO SE PUEDE APLICAR MOVIMIENTO A UN EMPLEADO DADO DE BAJA, SOLO REINGRESO';
estatus := 'ERROR';
code := '5';
end if;
end if;
end if;end;
$body$
language plpgsql
;
