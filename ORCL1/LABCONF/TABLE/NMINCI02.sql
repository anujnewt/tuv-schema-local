-- dmap_object_gen_tag : type : index name : nminci02
set search_path = labconf,oracle,dmap_extension,public;
create index nminci02 on nmcoinci (inc_keypro, inc_keyper, inc_keycon, inc_keyemp);
