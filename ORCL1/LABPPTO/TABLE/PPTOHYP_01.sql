-- dmap_object_gen_tag : type : index name : pptohyp_01
set search_path = labppto,oracle,dmap_extension,public;
create index pptohyp_01 on pptohyperion (pto_keyver);
