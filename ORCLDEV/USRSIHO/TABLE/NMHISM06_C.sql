-- dmap_object_gen_tag : type : index name : nmhism06_c
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmhism06_c on nmlohism_cons (his_keypro, his_keyper, his_keycon, his_keyemp);
