-- dmap_object_gen_tag : type : table name : pllohoja
set search_path = labconf,oracle,dmap_extension,public;
create table "pllohoja"  (
hoj_keyhoj varchar(5),
hoj_deshoj varchar(50),
hoj_sizcol numeric(5),
hoj_sizrow numeric(5)
) ;
