-- dmap_object_gen_tag : type : index name : nminci04
set search_path = labconf,oracle,dmap_extension,public;
create index nminci04 on nmcoinci (inc_keypro, inc_keyper, inc_keyemp);
