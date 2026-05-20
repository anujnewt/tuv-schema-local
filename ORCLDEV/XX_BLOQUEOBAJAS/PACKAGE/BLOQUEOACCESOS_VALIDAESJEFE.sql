create or replace  function  xx_bloqueobajas.bloqueoaccesos_validaesjefe (p_empleado numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
valida numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select count(keyemp)
into strict valida
from xx_bloqueobajas.empleados_completo
where keyjefe = p_empleado;
return valida;end;
$body$
language plpgsql
stable;
