-- dmap_object_gen_tag : type : table name : pruebastitulos
set search_path = pppt,oracle,dmap_extension,public;
create table "pruebastitulos"  (
idprueba numeric(38) not null,
valor varchar(50) not null,
titulo varchar(255)
) ;
-- dmap_object_gen_tag : type : alter table name : pruebastitulos
set search_path = pppt,oracle,dmap_extension,public;
alter table pruebastitulos alter column idprueba set not null;
-- dmap_object_gen_tag : type : alter table name : pruebastitulos
set search_path = pppt,oracle,dmap_extension,public;
alter table pruebastitulos alter column valor set not null;
