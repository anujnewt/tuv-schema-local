-- dmap_object_gen_tag : type : index name : index1
set search_path = labprod,oracle,dmap_extension,public;
create index index1 on tvlocope (cop_keypro, cop_keyper);
