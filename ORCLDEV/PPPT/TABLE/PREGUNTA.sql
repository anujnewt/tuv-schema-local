-- dmap_object_gen_tag : type : table name : pregunta
set search_path = pppt,oracle,dmap_extension,public;
create table "pregunta"  (
idpregunta numeric(38),
pregunta varchar(255),
orden numeric(38),
iddimension numeric(38)
) ;
