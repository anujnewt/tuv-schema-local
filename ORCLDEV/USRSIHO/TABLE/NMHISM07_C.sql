-- dmap_object_gen_tag : type : index name : nmhism07_c
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmhism07_c on nmlohism_cons (his_keyemp, his_keycon, his_keyper);
