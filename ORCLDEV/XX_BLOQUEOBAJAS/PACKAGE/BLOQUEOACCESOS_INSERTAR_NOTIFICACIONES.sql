create or replace procedure xx_bloqueobajas.bloqueoaccesos_insertar_notificaciones (p_idsolicitud numeric, p_tiposolicitud numeric, p_proceso numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--insertar notificaciones de tipo
--1 normal (aplica para todas las solcitides. se hace env????o de notificaci????n cada vez que se inserta una solicitud).
insert into xx_bloqueobajas.notificaciones(idsolicitud, tiponotificacion,fechacreacion,estatus,intentos)
values (p_idsolicitud, 1, clock_timestamp(), 0, 0);
--insertar notificaciones de tipo
--2 compensaciones (aplica para las solicitudes con tipo de solicitude igual a 0 fuera de estructura. se hace env????o de notificiaci????n cada vez que se inserta una solicitud)
if p_tiposolicitud = 0 then
insert into xx_bloqueobajas.notificaciones(idsolicitud, tiponotificacion,fechacreacion,estatus,intentos)
values (p_idsolicitud, 2, clock_timestamp(), 0, 0);
end if;
--insertar notificaciones de tipo
--3 intelectus (aplica para las solicitudes de los procesos de intelectus. se hace env????o de notificaciones cada vez que se inserta una solicitud)
if bloqueoaccesos_validaintelectus(p_proceso) = 1 then
insert into xx_bloqueobajas.notificaciones(idsolicitud, tiponotificacion,fechacreacion,estatus,intentos)
values (p_idsolicitud, 3, clock_timestamp(), 0, 0);
end if;
--insertar notificaciones de tipo
--4 sysadmin (aplica para todas las solicitudes. se hace un solo env????o diario)
insert into xx_bloqueobajas.notificaciones(idsolicitud, tiponotificacion,fechacreacion,estatus,intentos)
values (p_idsolicitud, 4, clock_timestamp(), 0, 0);
--insertar notificaciones de tipo
--5 sysadmin telecom (aplica para todas las solicitudes. se hace un solo env????o diario)
insert into xx_bloqueobajas.notificaciones(idsolicitud, tiponotificacion,fechacreacion,estatus,intentos)
values (p_idsolicitud, 5, clock_timestamp(), 0, 0);end;
$body$
language plpgsql
;
