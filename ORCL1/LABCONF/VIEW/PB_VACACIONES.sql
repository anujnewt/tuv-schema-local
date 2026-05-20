-- dmap_object_gen_tag : type : view name : pb_vacaciones
set search_path = labconf,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pb_vacaciones"  ("fecha_captura", "keyemp", "nombre", "fecha_inicio", "fecha_final", "dias_vacaciones") as select vac_fecmod fecha_captura,
vac_keyemp keyemp,
emp_nomemp nombre,
vac_fecini fecha_inicio,
vac_fecfin fecha_final,
vac_diavac dias_vacaciones
from labconf.tvpbvacc
inner join labconf.nmcoempl on vac_keyemp = emp_keyemp
where     vac_diavac >= 30
and vac_fecmod >= statement_timestamp() - interval '2 days'
and vac_fecmod <= statement_timestamp() + interval '1 days';/* dmap converted statement end */
-- estimed cost of view [ pb_vacaciones ]: 1.00;
