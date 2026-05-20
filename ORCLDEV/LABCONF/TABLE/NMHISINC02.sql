-- dmap_object_gen_tag : type : index name : nmhisinc02
set search_path = labconf,oracle,dmap_extension,public;
create index nmhisinc02 on nmhisinc (inc_keypro, inc_keyper, inc_keycon, inc_keyusu);
