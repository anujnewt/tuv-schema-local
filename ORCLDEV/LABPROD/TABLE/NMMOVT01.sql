-- dmap_object_gen_tag : type : index name : nmmovt01
set search_path = labprod,oracle,dmap_extension,public;
create index nmmovt01 on nmwkmovt (mov_keypro, mov_keyper, mov_keycon, mov_keyemp);
