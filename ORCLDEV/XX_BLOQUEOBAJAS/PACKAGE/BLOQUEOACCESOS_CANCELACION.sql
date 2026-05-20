create or replace procedure xx_bloqueobajas.bloqueoaccesos_cancelacion (p_idsolicitud numeric, p_usuario varchar, p_ip varchar, p_nombrepc varchar, p_resp inout numeric, p_mensaje inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_code numeric;
v_errm varchar(64);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
p_resp := 1;
p_mensaje := 'Solicitud Rechazada.';
--update xx_bloqueobajas.solicitudes set estatus = 3
--where idsolicitud = p_idsolicitud;
update xx_bloqueobajas.solicitudes set estatus = 3,usuarioaccion = upper(p_usuario), fechaaccion = clock_timestamp(),
diripaccion = p_ip, nombrepcaccion = p_nombrepc
where idsolicitud = p_idsolicitud;
/* commit; */
exception
when no_data_found then
p_resp := 0;
p_mensaje := 'El usuario no existe.';
when others then
v_code := sqlstate;
v_errm := oracle.substr(sqlerrm, 1 , 64);
p_resp := 0;/* dmap converted statement start */
p_mensaje :=  concat(v_code, ' ' , v_errm) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
