-- dmap_object_gen_tag : type : table name : bmb1_parteb1
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_parteb1"  (
idpregunta numeric(38) not null,
pregunta varchar(255),
opcion1 varchar(100),
opcion2 varchar(100),
opcion3 varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_parteb1
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_parteb1 alter column idpregunta set not null;
