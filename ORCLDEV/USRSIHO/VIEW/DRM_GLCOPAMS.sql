-- dmap_object_gen_tag : type : view name : drm_glcopams
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "drm_glcopams"  ("pam_keypar", "pam_cvesec", "pam_nompar") as select pam_keypar, pam_cvesec, pam_nompar  from glcopams;/* dmap converted statement end */
-- estimed cost of view [ drm_glcopams ]: 1.00;
