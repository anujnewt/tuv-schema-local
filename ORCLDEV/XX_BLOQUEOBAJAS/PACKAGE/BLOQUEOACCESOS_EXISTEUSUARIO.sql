create or replace procedure xx_bloqueobajas.bloqueoaccesos_existeusuario (p_usuario varchar, p_valida inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
actividad xx_bloqueobajas.usuarioempleado.rol%type;
l_basedatos varchar(9);
correo varchar(255);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select rol
into strict actividad
from xx_bloqueobajas.usuarioempleado
where usuario = upper(p_usuario);
p_valida := 1;
select global_name into strict l_basedatos from global_name;/* dmap converted statement start */
if l_basedatos = 'TVNOMINA' or l_basedatos = 'TVNOMDES' then
correo:=  concat(p_usuario, '__televisa.com.mx') ;/* dmap converted statement end *//* dmap converted statement start */
else
correo:=  concat(p_usuario, '__izzi.mx') ;/* dmap converted statement end */
end if;
update xx_bloqueobajas.usuarioempleado set correo = lower(existeusuario.correo)
where usuario = upper(p_usuario) and nullif(correo::text, '') is null;
/* commit; */
exception
when no_data_found then
p_valida := 0;end;
$body$
language plpgsql
;
