-- dmap_object_gen_tag : type : index name : nmperi01
set search_path = labprod,oracle,dmap_extension,public;
create index nmperi01 on nmloperi (per_keypro, per_keyper);
