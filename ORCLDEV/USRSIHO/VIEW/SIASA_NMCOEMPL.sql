-- dmap_object_gen_tag : type : view name : siasa_nmcoempl
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_nmcoempl"  ("emp_keyemp", "emp_nomemp", "emp_nomcor", "emp_keypro", "emp_fecmod") as select emp_keyemp, emp_nomemp, emp_nomcor, emp_keypro, emp_fecmod  from nmcoempl;/* dmap converted statement end */
-- estimed cost of view [ siasa_nmcoempl ]: 1.00;
