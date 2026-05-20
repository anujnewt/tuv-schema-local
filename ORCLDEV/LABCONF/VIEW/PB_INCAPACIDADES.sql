-- dmap_object_gen_tag : type : view name : pb_incapacidades
set search_path = labconf,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pb_incapacidades"  ("fecha_captura", "keyemp", "nombre", "tipo_incapacidad", "fecha_inicio", "fecha_final", "dias_incapacidad", "proceso", "desc_proceso") as select inc_fecmod fecha_captura,
inc_keyemp keyemp,
emp_nomemp nombre,
case
when inc_tipinc = 'IA' then 'RIESGO DE TRABAJO'
when inc_tipinc = 'IG' then 'ENFERMEDAD GENERAL'
when inc_tipinc = 'IM' then 'INCAPACIDAD MATERNIDAD'
end
tipo_incapacidad,
inc_fecini fecha_inicio,
inc_fecfin fecha_final,
inc_diainc dias_incapacidad,
emp_keypro proceso,
pro_despro desc_proceso
from labconf.tvpbincc
inner join labconf.nmcoempl on inc_keyemp = emp_keyemp
inner join labconf.nmloproc on pro_keypro = emp_keypro
where     inc_diainc >= 30
and inc_fecmod >= statement_timestamp() - interval '2 days'
and inc_fecmod <= statement_timestamp();/* dmap converted statement end */
-- estimed cost of view [ pb_incapacidades ]: 1.00;
