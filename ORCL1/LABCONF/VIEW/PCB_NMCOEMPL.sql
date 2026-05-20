-- dmap_object_gen_tag : type : view name : pcb_nmcoempl
set search_path = labconf,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pcb_nmcoempl"  ("emp_keyemp", "emp_nomemp", "emp_keypro", "emp_keypue", "emp_keydep", "emp_status", "emp_fecbaj") as select emp_keyemp, emp_nomemp, emp_keypro, emp_keypue, emp_keydep, emp_status, emp_fecbaj  from labconf.nmcoempl where emp_keypro in (139,550) and emp_status=1;/* dmap converted statement end */
-- estimed cost of view [ pcb_nmcoempl ]: 1.00;
