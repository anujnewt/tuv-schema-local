-- dmap_object_gen_tag : type : index name : nmhism06_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmhism06_tmp on nmlohism_tmp (his_keypro, his_keyper, his_keycon, his_keyemp);
