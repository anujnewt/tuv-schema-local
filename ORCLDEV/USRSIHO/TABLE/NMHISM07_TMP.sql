-- dmap_object_gen_tag : type : index name : nmhism07_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmhism07_tmp on nmlohism_tmp (his_keyemp, his_keycon, his_keyper);
