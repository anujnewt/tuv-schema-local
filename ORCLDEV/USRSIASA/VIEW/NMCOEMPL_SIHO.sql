-- dmap_object_gen_tag : type : view name : nmcoempl_siho
set search_path = usrsiasa,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "nmcoempl_siho"  ("emp_keyemp", "emp_nomemp", "emp_nomcor", "emp_keypro", "emp_fecmod") as select emp_keyemp, emp_nomemp, emp_nomcor, emp_keypro, emp_fecmod  from nmcoempl;/* dmap converted statement end */
-- estimed cost of view [ nmcoempl_siho ]: 1.00;
