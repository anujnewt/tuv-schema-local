-- dmap_object_gen_tag : type : table name : resortografia
set search_path = pppt,oracle,dmap_extension,public;
create table "resortografia"  (
idpersona numeric(38) not null,
aciertos numeric(38),
respuestas varchar(80),
status numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : resortografia
set search_path = pppt,oracle,dmap_extension,public;
alter table resortografia alter column idpersona set not null;
