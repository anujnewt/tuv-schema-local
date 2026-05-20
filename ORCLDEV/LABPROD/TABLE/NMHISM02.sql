-- dmap_object_gen_tag : type : index name : nmhism02
set search_path = labprod,oracle,dmap_extension,public;
create index nmhism02 on nmlohism (his_keyemp, his_keycon);
