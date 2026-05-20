-- dmap_object_gen_tag : type : index name : nmmovt02
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmmovt02 on nmwkmovt (mov_keyemp, mov_keydep);
