-- dmap_object_gen_tag : type : view name : pb_vacaciones
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pb_vacaciones"  ("fecha_captura", "keyemp", "nombre", "fecha_inicio", "fecha_final", "dias_vacaciones") as select sol_fecmod as fecha_captura,
sol_keyemp as keyemp,
emp_nomemp as nombre,
sol_fecini as fecha_inicio,
sol_fecfin as fecha_final,
sol_numdia as "dias_vacaciones"
from labprod.molosoli
inner join labprod.nmcoempl
on     sol_keyemp = emp_keyemp
and sol_status = 2
and sol_numdia >= 20
and emp_keypro <> 6;/* dmap converted statement end */
-- estimed cost of view [ pb_vacaciones ]: 1.00;
