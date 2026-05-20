-- dmap_object_gen_tag : type : view name : drm_nmcoempl
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "drm_nmcoempl"  ("emp_keyemp", "emp_nomemp", "emp_nomcor", "emp_regrfc", "emp_fecing") as select emp_keyemp, emp_nomemp, emp_nomcor, emp_regrfc, emp_fecing  from nmcoempl;/* dmap converted statement end */
-- estimed cost of view [ drm_nmcoempl ]: 1.00;
