-- dmap_object_gen_tag : type : table name : dias_festivos
set search_path = labprod,oracle,dmap_extension,public;
create table "dias_festivos"  (
id numeric(38),
fecha timestamp(0),
detalle varchar(40)
) ;
