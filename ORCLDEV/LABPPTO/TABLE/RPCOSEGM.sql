-- dmap_object_gen_tag : type : table name : rpcosegm
set search_path = labppto,oracle,dmap_extension,public;
create table "rpcosegm"  (
seg_keyrep varchar(16),
seg_keymen varchar(4),
seg_repfor varchar(3),
seg_permen numeric(5)
) ;
