-- dmap_object_gen_tag : type : table name : plloperi
set search_path = labprod,oracle,dmap_extension,public;
create table "plloperi"  (
per_keyper numeric(10),
per_keymin varchar(5),
per_keytip numeric(5),
per_nivelp numeric(5),
per_desper varchar(60),
per_fecini timestamp(0),
per_fecfin timestamp(0),
per_ppadre numeric(10),
per_agrega varchar(2),
per_ordper numeric(5),
per_status numeric(5)
) ;
