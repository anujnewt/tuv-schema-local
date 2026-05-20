create or replace procedure xx_bloqueobajas.bloqueoaccesos_solicitudfueraestructura ( p_empleado numeric, p_fechabaja timestamp(0), p_motivobaja varchar, p_usuario varchar, p_ip varchar, p_nombrepc varchar, p_resp inout numeric, p_mensaje inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
call bloqueoaccesos_solicitud( p_empleado,
p_fechabaja,
p_motivobaja,
'0',
p_usuario,
p_ip,
p_nombrepc,
p_resp,
p_mensaje);end;
$body$
language plpgsql
;
