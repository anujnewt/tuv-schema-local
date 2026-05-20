-- dmap_object_gen_tag : type : index name : nmhism06
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmhism06 on nmlohism (his_keypro, his_keyper, his_keycon, his_keyemp);
