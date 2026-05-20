-- dmap_object_gen_tag : type : view name : sim_nmcoempl
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "sim_nmcoempl"  ("emp_nomcor", "emp_keyemp") as select emp_nomcor, emp_keyemp  from nmcoempl;/* dmap converted statement end */
-- estimed cost of view [ sim_nmcoempl ]: 1.00;
