-- dmap_object_gen_tag : type : view name : sgv_nmcoempl
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "sgv_nmcoempl"  ("emp_keyemp", "emp_nomemp", "emp_keypro") as select emp_keyemp, emp_nomemp, emp_keypro  from nmcoempl;/* dmap converted statement end */
-- estimed cost of view [ sgv_nmcoempl ]: 1.00;
