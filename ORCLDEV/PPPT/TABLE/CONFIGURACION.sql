-- dmap_object_gen_tag : type : table name : configuracion
set search_path = pppt,oracle,dmap_extension,public;
create table "configuracion"  (
idconfig numeric(38),
logo bytea,
icono bytea,
version varchar(50)
) ;
