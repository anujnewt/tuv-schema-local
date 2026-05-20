create or replace procedure xx_bloqueobajas.bloqueoaccesos_solicitudkiosco ( p_empleado numeric, p_fechabaja timestamp(0), p_motivobaja varchar, p_tipo varchar, p_usuarioempleado numeric, p_ip varchar, p_nombrepc varchar, p_resp inout numeric, p_mensaje inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_code numeric;
v_errm varchar(200);
v_estatus numeric;
v_proceso numeric;
v_idsolicitud numeric;
v_usuario varchar(50);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
p_resp := 1;
p_mensaje := 'Tu solicitud ha sido enviada, espera la notificaci??n en tu correo. De no recibirla, por favor comun??cate al CAT.';
begin
select idsolicitud into strict v_idsolicitud
from xx_bloqueobajas.solicitudes
where keyemp = p_empleado
and fechabaja = p_fechabaja  limit 1;
exception
when no_data_found then
v_idsolicitud := 0;
end;
if v_idsolicitud <> 0 then
p_resp := 1;/* dmap converted statement start */
p_mensaje :=  concat('Tu solicitud ya hab??a sido generada con el folio ', v_idsolicitud) ;/* dmap converted statement end */
return;
end if;
begin
select usuario into strict v_usuario
from xx_bloqueobajas.usuarioempleado
where keyemp = p_usuarioempleado  limit 1;
exception
when no_data_found then
v_usuario := p_usuarioempleado;
end;
select keypro
into strict v_proceso
from xx_bloqueobajas.empleados_completo
where keyemp = p_empleado;
v_estatus := 2;
insert into xx_bloqueobajas.solicitudes(keyemp,fechabaja,motivobaja,tipo,estatus,usuario,
fechacaptura,dirip,nombrepc,usuarioaccion,fechaaccion,diripaccion,nombrepcaccion)
values (p_empleado,
p_fechabaja,
p_motivobaja,
p_tipo,
v_estatus,
upper(v_usuario),
clock_timestamp(),
p_ip,
p_nombrepc,
upper(v_usuario),
clock_timestamp(),
p_ip,
p_nombrepc)
returning idsolicitud into v_idsolicitud;
call bloqueoaccesos_insertar_notificaciones(v_idsolicitud,p_tipo,v_proceso);/* dmap converted statement start */
p_mensaje :=  concat('Tu solicitud hab??a sido generada con el folio ', v_idsolicitud, ', espera la notificaci??n en tu correo. De no recibirla, por favor comun??cate al CAT.') ;/* dmap converted statement end */
/* commit; */
exception
when no_data_found then
p_resp := 0;
p_mensaje := 'El usuario no existe.';
when others then
v_code := sqlstate;
v_errm := oracle.substr(sqlerrm, 1 , 200);
p_resp := 0;/* dmap converted statement start */
p_mensaje :=  concat(v_code, ' ' , v_errm) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
