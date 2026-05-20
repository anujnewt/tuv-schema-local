-- dmap_object_gen_tag : type : view name : catactores
set search_path = usrsai,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "catactores"  ("cda_keyemp", "cda_nomemp", "cda_nomart", "cda_keypro", "cda_origen", "cda_sindicato", "cda_calsin", "cda_docfis", "cda_regrfc") as select x0.emp_keyemp , x0.emp_nomemp , x0.emp_nomcor , x0.emp_keypro
, x1.ale_origen , x2.pam_nompar , x1.ale_calsin , x0.emp_ca2aux
, x0.emp_regrfc  from usrsiho.nmcoempl x0 ,
usrsiho.holoalem x1 ,usrsiho.glcopams x2 where
(((((x0.emp_keyemp = x1.ale_keyemp )
and (x1.ale_keytco =cast(x2.pam_cvesec as integer)) ) and (x2.pam_keypar = 'H3' ) ) and (x0.emp_keypro = 138 ) ) and (x0.emp_status = 1 ) );/* dmap converted statement end */
-- estimed cost of view [ catactores ]: 1.00;
