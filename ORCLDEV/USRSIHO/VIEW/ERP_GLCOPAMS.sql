-- dmap_object_gen_tag : type : view name : erp_glcopams
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "erp_glcopams"  ("pam_keypar", "pam_cvesec", "pam_nompar", "pam_folini", "pam_folfin") as select pam_keypar, pam_cvesec, pam_nompar, pam_folini, pam_folfin  from usrsiho.glcopams where pam_keypar in ('CIAO','H45');/* dmap converted statement end */
-- estimed cost of view [ erp_glcopams ]: 1.00;
