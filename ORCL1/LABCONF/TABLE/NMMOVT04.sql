-- dmap_object_gen_tag : type : index name : nmmovt04
set search_path = labconf,oracle,dmap_extension,public;
create index nmmovt04 on nmwkmovt (mov_keypro, mov_keyper);
