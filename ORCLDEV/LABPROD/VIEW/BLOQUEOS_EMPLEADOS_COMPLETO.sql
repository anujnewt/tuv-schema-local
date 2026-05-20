-- dmap_object_gen_tag : type : view name : bloqueos_empleados_completo
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "bloqueos_empleados_completo"  ("keyemp", "nombre", "keydep", "departamento", "keypue", "puesto", "keypro", "proceso", "keyloc", "ubicacion", "regims", "keyplz", "keyjefe", "keycia", "compania", "paterno", "materno", "nombres") as select emp_keyemp keyemp,
emp_nomemp::VARCHAR nombre,
emp_keydep keydep,
dep_desdep departamento,
emp_keypue keypue,
pue_despue puesto,
emp_keypro keypro,
pro_despro proceso,
emp_keyloc keyloc,
loc_desloc ubicacion,
emp_regims regims,
plz_keyplz keyplz,
plz_cverem keyjefe,
pro_keycia keycia,
cia_descia compania,
labprod.apellidopat(emp_nomemp::VARCHAR) paterno,
labprod.apellidomat(emp_nomemp::VARCHAR) materno,
labprod.nombreemp(emp_nomemp::VARCHAR)nombres
from nmcoempl
inner join labprod.nmcodeps on emp_keydep = dep_keydep
inner join labprod.nmcopues on emp_keypue = pue_keypue
inner join labprod.nmloproc on emp_keypro = pro_keypro
inner join labprod.nmlolocp on emp_keyloc = loc_keyloc
inner join labprod.nmlocias on pro_keycia = cia_keycia
left join labprod.eocoplza on emp_keyemp = plz_keyemp;/* dmap converted statement end */
-- estimed cost of view [ bloqueos_empleados_completo ]: 1.00;
