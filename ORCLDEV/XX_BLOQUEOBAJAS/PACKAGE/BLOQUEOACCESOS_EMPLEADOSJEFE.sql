create or replace procedure xx_bloqueobajas.bloqueoaccesos_empleadosjefe (p_usuario varchar, p_result inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
p_keyjefe numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select keyemp
into strict p_keyjefe
from xx_bloqueobajas.usuarioempleado
where usuario = upper(p_usuario);
open p_result for
select keyemp,nombre
from xx_bloqueobajas.empleados_completo
where keyjefe = p_keyjefe
order by  nombre;
exception
when no_data_found then
open p_result for
select ' ' as keyemp,' ' as nombre,' ' as departamento,
' ' as puesto
;end;
$body$
language plpgsql
;
