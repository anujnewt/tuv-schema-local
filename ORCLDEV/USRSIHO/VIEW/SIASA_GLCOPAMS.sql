-- dmap_object_gen_tag : type : view name : siasa_glcopams
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_glcopams"  ("pam_keypar", "pam_cvesec", "pam_nompar", "pam_folini", "pam_folfin") as select pam_keypar, pam_cvesec, pam_nompar, pam_folini, pam_folfin  from glcopams;/* dmap converted statement end */
-- estimed cost of view [ siasa_glcopams ]: 1.00;
