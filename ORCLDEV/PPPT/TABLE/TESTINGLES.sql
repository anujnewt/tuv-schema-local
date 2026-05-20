-- dmap_object_gen_tag : type : table name : testingles
set search_path = pppt,oracle,dmap_extension,public;
create table "testingles"  (
idpregunta numeric(38) not null,
seccion numeric(38),
orden numeric(38),
idplanteamiento numeric(38),
pregunta varchar(255),
opcion1 varchar(255),
opcion2 varchar(255),
opcion3 varchar(255),
opcion4 varchar(255),
correcta numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : testingles
set search_path = pppt,oracle,dmap_extension,public;
alter table testingles alter column idpregunta set not null;
