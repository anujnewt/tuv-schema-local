-- dmap_object_gen_tag : type : table name : holoretr
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoretr"  (
ret_keyrph numeric(10),
ret_keyrpv numeric(10),
ret_status varchar(1),
ret_keyusu numeric(10),
ret_logusu varchar(15),
ret_idepcc varchar(15),
ret_fecmov timestamp(0),
ret_hormov varchar(8)
) ;
