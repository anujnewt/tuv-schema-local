-- dmap_object_gen_tag : type : table name : rpcosegu
set search_path = labppto,oracle,dmap_extension,public;
create table "rpcosegu"  (
seg_keyrep varchar(16),
seg_keymen varchar(4),
seg_repfor varchar(3),
seg_keyusu numeric(10),
seg_perusu numeric(5)
) ;
