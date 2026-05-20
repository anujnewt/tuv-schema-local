-- dmap_object_gen_tag : type : table name : personalcontadorx
set search_path = pppt,oracle,dmap_extension,public;
create table "personalcontadorx"  (
id numeric(38),
contador numeric(38),
incremento numeric(38),
crc varchar(25),
fecha timestamp(0)
) ;
