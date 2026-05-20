-- dmap_object_gen_tag : type : view name : erp_nmcoempl
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "erp_nmcoempl"  ("emp_keyemp", "emp_nomemp", "emp_regrfc", "emp_recurp", "emp_domemp", "emp_munemp", "emp_cidemp", "emp_codemp", "emp_colemp", "emp_pobemp", "emp_keypro", "emp_status", "emp_refcon", "emp_fecing", "emp_pering", "emp_fecmod") as select emp_keyemp, emp_nomemp, emp_regrfc, emp_recurp, emp_domemp, emp_munemp, emp_cidemp, emp_codemp, emp_colemp, emp_pobemp, emp_keypro, emp_status, emp_refcon, emp_fecing, emp_pering, emp_fecmod
from usrsiho.nmcoempl;/* dmap converted statement end */
-- estimed cost of view [ erp_nmcoempl ]: 1.00;
