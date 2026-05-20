create or replace procedure xx_bloqueobajas.bloqueoaccesos_empleadofueraestrucrtura (p_nombre varchar, p_paterno varchar, p_materno varchar, p_empleado numeric, p_result inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if nullif(p_empleado::text, '') is not null then
open p_result for select keyemp,nombre,  concat(keydep, ' ' , departamento)  as departamento,
concat(keypue, ' ' , puesto)  as puesto
from xx_bloqueobajas.empleados_completo
where  keyemp = p_empleado;/* dmap converted statement end *//* dmap converted statement start */
else
if nullif(p_nombre::text, '') is not null and  nullif(p_paterno::text, '') is not null and nullif(p_materno::text, '') is null then
open p_result for select keyemp,nombre,  concat(keydep, ' ' , departamento)  as departamento,
concat(keypue, ' ' , puesto)  as puesto
from xx_bloqueobajas.empleados_completo
where  nombres = upper(p_nombre) and paterno = upper(p_paterno);/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(p_nombre::text, '') is not null and  nullif(p_paterno::text, '') is not null and nullif(p_materno::text, '') is not null then
open p_result for select keyemp,nombre,  concat(keydep, ' ' , departamento)  as departamento,
concat(keypue, ' ' , puesto)  as puesto
from xx_bloqueobajas.empleados_completo
where  nombres = upper(p_nombre) and paterno = upper(p_paterno) and materno = upper(p_materno);/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(p_nombre::text, '') is not null and  nullif(p_paterno::text, '') is null and nullif(p_materno::text, '') is not null then
open p_result for select keyemp,nombre,  concat(keydep, ' ' , departamento)  as departamento,
concat(keypue, ' ' , puesto)  as puesto
from xx_bloqueobajas.empleados_completo
where  nombres = upper(p_nombre) and materno = upper(p_materno);/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(p_nombre::text, '') is null and  nullif(p_paterno::text, '') is not null and nullif(p_materno::text, '') is not null then
open p_result for select keyemp,nombre,  concat(keydep, ' ' , departamento)  as departamento,
concat(keypue, ' ' , puesto)  as puesto
from xx_bloqueobajas.empleados_completo
where  paterno = upper(p_paterno) and materno = upper(p_materno);/* dmap converted statement end */
end if;
end if;end;
$body$
language plpgsql
;
