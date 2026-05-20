create or replace procedure xx_bloqueobajas.pkg_notificaciones_actualiza_notificacion (p_idnotificacion numeric, p_estatus numeric, p_mensaje varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update xx_bloqueobajas.notificaciones
set estatus = case when p_estatus = 2 and intentos < 3 then 0 else p_estatus end,
mensaje = p_mensaje,
intentos = intentos + 1
where idnotificacion = p_idnotificacion;end;
$body$
language plpgsql
;
