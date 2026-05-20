-- dmap_object_gen_tag : type : table name : sclofact
set search_path = labprod,oracle,dmap_extension,public;
create table "sclofact"  (
fac_keysoc varchar(10),
fac_keyfac varchar(6),
fac_valor numeric(5)
) ;
