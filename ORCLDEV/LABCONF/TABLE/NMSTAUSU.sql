-- dmap_object_gen_tag : type : table name : nmstausu
set search_path = labconf,oracle,dmap_extension,public;
create table "nmstausu"  (
sta_keyusu numeric(38),
sta_keyubi varchar(1),
sta_status varchar(1),
sta_verusu varchar(300),
sta_activo varchar(5),
sta_keysem varchar(53),
sta_keysemq varchar(53)
) ;
