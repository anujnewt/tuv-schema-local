-- dmap_object_gen_tag : type : index name : jm_nmpas01
set search_path = labconf,oracle,dmap_extension,public;
create index jm_nmpas01 on nmpasinc (inc_keypro, inc_keyper, inc_keyusu);
