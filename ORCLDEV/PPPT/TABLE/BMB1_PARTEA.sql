-- dmap_object_gen_tag : type : table name : bmb1_partea
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_partea"  (
idpregunta numeric(38) not null,
pregunta varchar(255),
opcion1 varchar(50),
opcion2 varchar(50),
opcion3 varchar(50),
opcion4 varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_partea
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_partea alter column idpregunta set not null;
