-- dmap_object_gen_tag : type : view name : codeac_nmcoempl
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_nmcoempl"  ("emp_keypro", "emp_keyemp", "emp_nomemp", "emp_recurp", "emp_regrfc") as select emp_keypro, emp_keyemp, emp_nomemp, emp_recurp, emp_regrfc  from nmcoempl;/* dmap converted statement end */
-- estimed cost of view [ codeac_nmcoempl ]: 1.00;
