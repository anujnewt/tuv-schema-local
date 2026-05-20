-- dmap_object_gen_tag : type : view name : empleados
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "empleados"  ("emp_keyemp", "emp_nomemp", "emp_keypro", "email") as select emp_keyemp, emp_nomemp, emp_keypro, email
from labprod.nmcoempl__rtelecom
left join labprod.wemail__rtelecom on emp_keyemp = keyemp
union all
select emp_keyemp, emp_nomemp, emp_keypro, email
from labprod.nmcoempl
left join labprod.wemail on emp_keyemp = keyemp;/* dmap converted statement end */
-- estimed cost of view [ empleados ]: 3.00;
