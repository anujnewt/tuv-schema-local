-- dmap_object_gen_tag : type : index name : nmhism03
set search_path = labconf,oracle,dmap_extension,public;
create index nmhism03 on nmlohism (his_keycon, his_keyemp, his_keyper);
