-- dmap_object_gen_tag : type : view name : glcopams_siho
set search_path = usrsiasa,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "glcopams_siho"  ("pam_keypar", "pam_cvesec", "pam_nompar", "pam_folini", "pam_folfin") as select pam_keypar, pam_cvesec, pam_nompar, pam_folini, pam_folfin  from glcopams where pam_keypar  in ('H1' ,'H3' ,'H5' ,'H6' ,'PT' ,'PM');/* dmap converted statement end */
-- estimed cost of view [ glcopams_siho ]: 1.00;
