create or replace procedure xx_bloqueobajas.bloqueoaccesos_registro (p_usuario varchar, p_empleado numeric, p_social varchar, p_correo varchar, p_ip varchar, p_mombrepc varchar, p_rol inout varchar, p_resp inout numeric, p_mensaje inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
regims varchar(13);
empleado numeric;
rolusuario varchar(20);
v_code numeric;
v_errm varchar(64);
cuentausuario numeric;
cuentaempleado numeric;
nombre varchar(100);
correo varchar(100);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
p_resp := 1;
p_rol := null;/* dmap converted statement start */
p_mensaje :=  concat('El usuario ', p_usuario , ' se cre???? con ????xito.') ;/* dmap converted statement end */
select keyemp, regims,nombre
into strict empleado, regims,nombre
from xx_bloqueobajas.empleados_completo
where keyemp = p_empleado
and regims = p_social;
if (bloqueoaccesos_validaesjefe(p_empleado) > 0) then
select count(usuario)
into strict cuentausuario
from xx_bloqueobajas.usuarioempleado
where usuario = upper(p_usuario);
select count(keyemp)
into strict cuentaempleado
from xx_bloqueobajas.usuarioempleado
where keyemp = p_empleado;/* dmap converted statement start */
if nullif(p_correo::text, '') is null then
correo := concat( lower(p_usuario), '__televisa.com.mx') ;/* dmap converted statement end */
else
correo := p_correo;
end if;
if (cuentausuario = 0 and cuentaempleado = 0 ) then
--inserta usuario
rolusuario := bloqueoaccesos_tipousuario(p_empleado);
p_rol := rolusuario;
insert into xx_bloqueobajas.usuarioempleado( usuario,keyemp,fechaingreso,dirip,nombrepc,correo,rol,nombreusuario)
values (upper(p_usuario),
p_empleado,clock_timestamp() ,
p_ip,
p_mombrepc,
correo,
rolusuario,
nombre);
else
-- usuario ya existe
p_resp := 0;
p_mensaje := 'El usuario ya esta registrado.';
end if;
else
p_resp := 0;/* dmap converted statement start */
p_mensaje :=  concat('El usuario ', p_usuario , ' no es jefe. Es necesario que te comuniques con tu Jefe Inmediato para realizar el bloqueo de acceso por medio de la opci????n Fuera de Estructura. Adicionalmente comun????cate con Compensaciones para actualizar la estructura a tu cargo') ;/* dmap converted statement end */
end if;
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
