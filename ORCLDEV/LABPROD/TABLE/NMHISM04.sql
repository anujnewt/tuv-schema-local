-- dmap_object_gen_tag : type : index name : nmhism04
set search_path = labprod,oracle,dmap_extension,public;
create index nmhism04 on nmlohism (his_keypro, his_keyper, his_keyemp, his_keycon, his_codacu);
