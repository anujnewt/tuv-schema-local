-- dmap_object_gen_tag : type : table name : fuarchivo
set search_path = labprod,oracle,dmap_extension,public;
create table "fuarchivo"  (
idarchivo numeric(38),
nombrearchivo varchar(100),
fechacarga timestamp(0),
total_registros numeric(38)
) ;
