-- dmap_object_gen_tag : type : table name : glcomage
set search_path = labconf,oracle,dmap_extension,public;
create table "glcomage"  (
ima_keyemp numeric(10),
ima_keygen varchar(16),
ima_tipima varchar(3),
ima_imagen bytea,
ima_longit numeric(10),
ima_format varchar(5)
) ;
