-- dmap_object_gen_tag : type : index name : tvincl02
set search_path = labprod,oracle,dmap_extension,public;
create index tvincl02 on tvloincl (inc_keyemp, inc_keyper, inc_keysem, inc_keycon);
