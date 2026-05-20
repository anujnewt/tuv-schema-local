-- dmap_object_gen_tag : type : table name : plloconc
set search_path = labconf,oracle,dmap_extension,public;
create table "plloconc"  (
con_keycon varchar(10),
con_keyrub varchar(5),
con_descon varchar(40),
con_natcon varchar(1),
con_tipcon numeric(5),
con_manper numeric(5)
) ;
