create or replace procedure xx_bloqueobajas.pkg_notificaciones_actualiza_notificacion_sys (p_tipo numeric,p_fecha timestamp(0), p_estatus numeric, p_mensaje varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update xx_bloqueobajas.notificaciones
set estatus = case when p_estatus = 2 and intentos < 3 then 1 else p_estatus end,
mensaje = p_mensaje,
intentos = intentos + 1
where idnotificacion in (select idnotificacion
from xx_bloqueobajas.solicitudes sol
inner join xx_bloqueobajas.notificaciones noti on sol.idsolicitud = noti.idsolicitud
where noti.estatus = 0
and noti.intentos < 3
and noti.tiponotificacion = p_tipo
and sol.estatus = 2
and sol.fechabaja < p_fecha);end;
$body$
language plpgsql
;
