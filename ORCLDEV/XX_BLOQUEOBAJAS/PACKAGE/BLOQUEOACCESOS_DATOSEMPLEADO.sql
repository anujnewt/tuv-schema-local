create or replace procedure xx_bloqueobajas.bloqueoaccesos_datosempleado (p_empleado numeric, p_result inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open p_result for
select  concat(keydep, ' ' , departamento)  as departamento,
concat(keypue, ' ' , puesto)  as puesto
from xx_bloqueobajas.empleados_completo
where keyemp = p_empleado;/* dmap converted statement end */end;
$body$
language plpgsql
;
