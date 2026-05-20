-- dmap_object_gen_tag : type : table name : bitacoraacceso
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
create table "bitacoraacceso"  (
usuario varchar(256),
fecha timestamp(0),
accion varchar(10),
mensaje varchar(256)
) ;
