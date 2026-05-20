-- dmap_object_gen_tag : type : index name : nmhism07
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmhism07 on nmlohism (his_keyemp, his_keycon, his_keyper);
