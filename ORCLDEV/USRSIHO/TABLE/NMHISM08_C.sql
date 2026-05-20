-- dmap_object_gen_tag : type : index name : nmhism08_c
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmhism08_c on nmlohism_cons (his_keycon, his_keydep, his_keypue, his_codimp, his_keyemp);
