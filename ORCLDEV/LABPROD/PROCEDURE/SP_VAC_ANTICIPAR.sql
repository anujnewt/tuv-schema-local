create or replace procedure labprod."sp_vac_anticipar"  ( keyemp numeric, fecsol timestamp(0), fecact timestamp(0), numani inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
diasal decimal(10,2);
numdia decimal(10,2);
fecing timestamp(0);
fecini timestamp(0);
feccad timestamp(0);
meses_fecact decimal(10,2);
meses_fecsol decimal(10,2);
cuenta_periodos integer;
keypro integer;
keyloc varchar(16);
begin
--valida si el empleado puede anticipar vacaciones en la fecha de la solicitud.
--si no hay d?as disponibles en el periodo de la solicitud, valida si est? a 3 meses de su siguiente periodo vacacional
--si no est? dentro dentro de los 3 meses anteriores a su siguiente periodo vacacional, entonces regresa 0 en numani
begin
--busca si existen periodos con dias de saldo disponibles para la solicitud
select count(*) into strict cuenta_periodos
from labprod.molodiad
where dia_keyemp = keyemp
and dia_feccad >= fecact
and dia_fecini <= fecsol
and dia_diasal > 0;
exception
when no_data_found then
cuenta_periodos := 0;
end;
if cuenta_periodos > 0 then
numani := 0;  --hay periodos con saldo vigentes. no se puede anticipar vacaciones
else
--busca la fecha de inicio del siguiente periodo vacacional
begin
select emp_fecaux, emp_keypro, emp_keyloc
into strict fecing, keypro, keyloc
from labprod.nmcoempl
where emp_keyemp = keyemp;
exception
when no_data_found then
numani := 0;
return;
end;
fecini := fn_vac_feciniper(keyemp,fecact,fecing);
meses_fecact := months_between(fecact,fecini);
meses_fecsol := months_between(fecsol,fecini);/* dmap converted statement start */
perform dbms_output.put_line( concat('FECINI = ', fecini)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('MESES_FECACT = ', meses_fecact)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('MESES_FECSOL = ', meses_fecsol)) ;/* dmap converted statement end */
if meses_fecact >= -3 and meses_fecsol >= -3 then
perform dbms_output.put_line('INSERTAR PERIODO');
call labprod.sp_vac_insertarperiodoant (keyemp,fecini,fecing,keypro,keyloc,numani);
else
perform dbms_output.put_line('Todav?a no puede insertar el periodo');
numani := 0;  --todav?a no puede insertar el periodo
end if;
end if;end;
$body$
language plpgsql
;
