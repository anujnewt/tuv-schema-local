-- dmap_object_gen_tag : type : table name : plloecol
set search_path = labprod,oracle,dmap_extension,public;
create table "plloecol"  (
ecl_keyori varchar(5),
ecl_keyext varchar(20),
ecl_keycol varchar(10),
ecl_tipdat varchar(2),
ecl_tipcol varchar(1)
) ;
