-- dmap_object_gen_tag : type : table name : rpcoenrp
set search_path = labconf,oracle,dmap_extension,public;
create table "rpcoenrp"  (
enr_keyrep varchar(16),
enr_orihoj varchar(1),
enr_linpag numeric(38),
enr_linepa numeric(38),
enr_letenc numeric(38),
enr_encab1 varchar(50),
enr_encab2 varchar(50),
enr_encab3 varchar(50),
enr_encab4 varchar(50),
enr_letdet numeric(38),
enr_espcol numeric(38),
enr_delimi varchar(1),
enr_letpie numeric(38),
enr_piepa1 varchar(30),
enr_piepa2 varchar(30),
enr_swipie varchar(5)
) ;
