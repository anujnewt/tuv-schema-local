create or replace procedure xx_bloqueobajas.bloqueoaccesos_solicitudesintelectus ( p_result inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open p_result for
select sol.idsolicitud, sol.keyemp,emp.nombre,  concat(emp.keydep, ' ' , emp.departamento)  as departamento,
concat(emp.keypue, ' ' , emp.puesto)  as puesto,
concat(emp.keyloc, ' ' , emp.ubicacion)  as ubicacion,
concat(emp.keypro, ' ' , emp.proceso)  as proceso,
concat(usu.keyemp, ' ' , usu.nombreusuario)  as usuario
from xx_bloqueobajas.solicitudes sol
join xx_bloqueobajas.empleados_completo emp on emp.keyemp = sol.keyemp
join xx_bloqueobajas.usuarioempleado usu on usu.usuario = sol.usuario
where sol.estatus = 1;/* dmap converted statement end */end;
$body$
language plpgsql
;
