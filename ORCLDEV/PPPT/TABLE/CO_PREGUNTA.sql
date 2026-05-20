-- dmap_object_gen_tag : type : table name : co_pregunta
set search_path = pppt,oracle,dmap_extension,public;
create table "co_pregunta"  (
idcaracteristica numeric(38) not null,
idpregunta numeric(38) not null,
pregunta varchar(255),
negativo varchar(255),
accion varchar(255)
) ;
-- dmap_object_gen_tag : type : alter table name : co_pregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table co_pregunta alter column idcaracteristica set not null;
-- dmap_object_gen_tag : type : alter table name : co_pregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table co_pregunta alter column idpregunta set not null;
