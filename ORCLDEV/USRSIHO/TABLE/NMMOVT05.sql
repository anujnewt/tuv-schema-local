-- dmap_object_gen_tag : type : index name : nmmovt05
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmmovt05 on nmwkmovt (mov_keypro, mov_keyper, mov_keynom, mov_keyemp);
