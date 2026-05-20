-- dmap_object_gen_tag : type : table name : feci_carga_tipocambio_batch
set search_path = feci,oracle,dmap_extension,public;
create table "feci_carga_tipocambio_batch"  (
fecha varchar(20),
de varchar(20),
a varchar(20),
tipo_cambio varchar(100),
factor varchar(100)
) ;
