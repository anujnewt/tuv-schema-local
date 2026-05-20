-- dmap_object_gen_tag : type : index name : nmhism01
set search_path = labprod,oracle,dmap_extension,public;
create index nmhism01 on nmlohism (his_keypro, his_keyper);
