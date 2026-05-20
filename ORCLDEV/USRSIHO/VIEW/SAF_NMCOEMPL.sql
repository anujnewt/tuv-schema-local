-- dmap_object_gen_tag : type : view name : saf_nmcoempl
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "saf_nmcoempl"  ("emp_regrfc", "emp_keyemp", "emp_nomemp", "emp_cveban", "emp_ctaban", "emp_fecing", "emp_domemp", "emp_colemp", "emp_entemp", "emp_codemp", "emp_telemp", "emp_cidemp", "emp_salmes", "emp_forpag", "emp_status", "emp_ca2aux") as select	emp_regrfc, emp_keyemp, emp_nomemp, emp_cveban, emp_ctaban, emp_fecing, emp_domemp, emp_colemp, emp_entemp, emp_codemp, emp_telemp, emp_cidemp, emp_salmes, emp_forpag, emp_status, emp_ca2aux  from nmcoempl;/* dmap converted statement end */
-- estimed cost of view [ saf_nmcoempl ]: 1.00;
