-- dmap_object_gen_tag : type : table name : encpcanr
set search_path = usrsiho,oracle,dmap_extension,public;
create table "encpcanr"  (
epc_numpco numeric(10),
epc_keydep varchar(16),
epc_fecpet timestamp(0),
epc_observ varchar(255),
epc_keyusu varchar(20),
epc_stspet numeric(10)
) ;
