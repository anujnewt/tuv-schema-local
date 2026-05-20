create or replace procedure xx_bloqueobajas.pkg_notificaciones_get_notificaciones_sysadmin (p_tipo numeric,p_fecha timestamp(0), p_result inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open p_result for
select
noti.idnotificacion,
sol.idsolicitud,  --folio de la solicitud
usu.keyemp numero_solicitante, --numero de empleado del solicitante
usu.nombreusuario nombre_solicitante, --nombre del solicitante
coalesce(usu.correo, 'SIN CORREO') correo_solicitante,  --correo del solicitante
emp.keycia,   --clave de la compa?ia en labora
emp.compania, --descripcion de la compa?ia en labora
emp.keypro,   --clave del proceso
emp.proceso,  --descripcion del proceso
sol.fechabaja,  --fecha de baja
sol.fechacaptura,  --fecha de captura
emp.nombre,  --nombre del empleado al que se le bloquearan los accesos
sol.keyemp,  --numero del empleado al que se le bloquearan los accesos
coalesce(emp.keyjefe,0) keyjefe, --numero del jefe del empleado al que se le bloquearan los accesos
coalesce(jefe.nombre,'SIN JEFE AUTORIZADOR') nombre_jefe, --nombre del jefe del empleado al que se le bloquearan los accesos
emp.puesto,  --puesto del empleado al se le bloquearan los accesos
emp.ubicacion, --ubicacion del empleado al se le bloquearan los accesos
mot.descripcion motivo_baja  ----motivo de baja
from xx_bloqueobajas.solicitudes sol
inner join xx_bloqueobajas.notificaciones noti on sol.idsolicitud = noti.idsolicitud
inner join xx_bloqueobajas.usuarioempleado usu on usu.usuario = sol.usuario
inner join xx_bloqueobajas.empleados_completo emp on emp.keyemp = sol.keyemp
inner join xx_bloqueobajas.motivosbaja mot on mot.motivobaja = sol.motivobaja
left join xx_bloqueobajas.empleados jefe on jefe.keyemp = emp.keyjefe
where noti.estatus = 0
and noti.intentos < 3
and noti.tiponotificacion = p_tipo
and sol.estatus = 2
and sol.fechabaja < p_fecha;
exception
when no_data_found then
open p_result for select
-1 idnotificacion,
-1 idsolicitud,  --folio de la solicitud
0 numero_solicitante, --numero de empleado del solicitante
null nombre_solicitante, --nombre del solicitante
null correo_solicitante,  --correo del solicitante
null keycia,   --clave de la compa?ia en labora
null compania, --descripcion de la compa?ia en labora
0 keypro,   --clave del proceso
null proceso,  --descripcion del proceso
'01/01/2021' fechabaja,  --fecha de baja
'01/01/2021' fechacaptura,  --fecha de captura
null nombre,  --nombre del empleado al que se le bloquearan los accesos
0 keyemp,  --numero del empleado al que se le bloquearan los accesos
0 keyjefe, --numero de empleado del jefe del empleado al que se le bloquearan los accesos
null nombre_jefe, --nombre del jefe del empleado al que se le bloquearan los accesos
null puesto,  --puesto del empleado al se le bloquearan los accesos
null ubicacion, --ubicacion del empleado al se le bloquearan los accesos
null motivo_baja  ----motivo de baja
;end;
$body$
language plpgsql
;
