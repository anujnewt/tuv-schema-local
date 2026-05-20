-- dmap_object_gen_tag : type : table name : rpcospro
set search_path = labconf,oracle,dmap_extension,public;
create table "rpcospro"  (
spr_keyspr varchar(16),
spr_desspr varchar(60),
spr_parent varchar(200),
spr_keyrpt varchar(12),
spr_keytab varchar(18),
spr_iderep varchar(18),
spr_idepcc varchar(18),
spr_ideusu varchar(18),
spr_keyrep varchar(16),
spr_keyfor varchar(16)
) ;
