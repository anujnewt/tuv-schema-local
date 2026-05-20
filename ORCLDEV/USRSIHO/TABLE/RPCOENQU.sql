-- dmap_object_gen_tag : type : table name : rpcoenqu
set search_path = usrsiho,oracle,dmap_extension,public;
create table "rpcoenqu"  (
enq_keyrep varchar(16),
enq_idepcc varchar(15),
enq_keyusu numeric(38),
enq_fecela timestamp(0),
enq_fecact timestamp(0),
enq_titrep varchar(80),
enq_status varchar(1),
enq_desrep varchar(60),
enq_usuexp varchar(1)
) ;
