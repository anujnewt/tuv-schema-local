-- dmap_object_gen_tag : type : index name : pptohyp_02
set search_path = labppto,oracle,dmap_extension,public;
create index pptohyp_02 on pptohyperion (pto_keyver, pto_ciamadre);
