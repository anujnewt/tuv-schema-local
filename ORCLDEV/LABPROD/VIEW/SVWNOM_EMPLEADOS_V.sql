-- dmap_object_gen_tag : type : view name : svwnom_empleados_v
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "svwnom_empleados_v"  ("no_empleado", "nombre", "ape_paterno", "ape_materno", "clave_costos", "desc_costos", "clave_localidad", "desc_localidad", "clave_proceso", "desc_proceso", "clave_compania", "desc_compania", "clave_puesto", "desc_puesto", "estatus") as select emp_keyemp no_empleado
, oracle.substr(emp_nomemp, instr(emp_nomemp, '/', 1, 2) +1, length(emp_nomemp) - instr(emp_nomemp, '/', 1, 2)) nombre
, oracle.substr(emp_nomemp, 0, instr(emp_nomemp, '/', 1, 1)-1) ape_paterno
, oracle.substr(emp_nomemp, instr(emp_nomemp, '/', 1, 1)+1, instr(emp_nomemp, '/', 1, 2) - instr(emp_nomemp, '/', 1, 1)-1) ape_materno
, cen_keycen clave_costos
, cen_descen desc_costos
, loc_keyloc clave_localidad
, loc_desloc desc_localidad
, pro_keypro clave_proceso
, pro_despro desc_proceso
, (select cia_keycia  from labprod.nmlocias where cia_keycia=pro_keycia) "clave_compania"
,(select cia_descia from labprod.nmlocias where cia_keycia=pro_keycia) "desc_compania"
,pue_keypue "clave_puesto"
,pue_despue "desc_puesto"
,case emp_status
when 1 then ' 1- ACTIVO'
when 2 then '2- INACTIVO'
else 'OTRO'
end "estatus"
from labprod.nmcoempl
,labprod.nmlocenc
,labprod.nmlolocp
,labprod.nmloproc
,labprod.nmcopues
where emp_keycen=cen_keycen
and emp_keypro =pro_keypro
and emp_keyloc = loc_keyloc
and emp_keypue=pue_keypue
order by  emp_keyemp  desc
;/* dmap converted statement end */
-- estimed cost of view [ svwnom_empleados_v ]: 1.00;
