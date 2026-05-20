-- dmap_object_gen_tag : type : view name : siasa_nmlohism
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_nmlohism"  ("his_keyemp", "his_keycon", "his_keypro", "his_keydep", "his_keypue", "his_import", "his_fecmov", "his_keyper", "his_keynom", "his_ca1aux", "his_ca2aux") as select his_keyemp, his_keycon, his_keypro, his_keydep, his_keypue, his_import, his_fecmov, his_keyper, his_keynom, his_ca1aux, his_ca2aux  from nmlohism;/* dmap converted statement end */
-- estimed cost of view [ siasa_nmlohism ]: 1.00;
