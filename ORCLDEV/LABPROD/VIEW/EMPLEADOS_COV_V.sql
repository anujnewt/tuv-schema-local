-- dmap_object_gen_tag : type : view name : empleados_cov_v
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "empleados_cov_v"  ("emp_keyemp", "emp_recurp", "emp_regims", "emp_status", "emp_ctaban", "cta_ctaban", "pam_nompar", "emp_nomemp") as select  t1.emp_keyemp  ,
t1.emp_recurp  ,
t1.emp_regims  ,
t1.emp_status  ,
t1.emp_ctaban  ,
t2.cta_ctaban  ,
t3.pam_nompar  ,
t1.emp_nomemp
from labprod.nmloctas t2, labprod.nmcoempl t1
left outer join labprod.glcopams t3 on (t1.emp_forpag = t3.pam_cvesec and 'FP' = t3.pam_keypar)
where t1.emp_keyemp = t2.cta_keyemp and t1.emp_keypro = t2.cta_keypro and t1.emp_status = 1 and t1.emp_keypro <> 6;/* dmap converted statement end */
-- estimed cost of view [ empleados_cov_v ]: 1.00;
