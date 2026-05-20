-- dmap_object_gen_tag : type : table name : consulta
set search_path = pppt,oracle,dmap_extension,public;
create table "consulta"  (
idconsulta numeric(38) not null default 0,
consulta varchar(255) not null,
sql varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : consulta
set search_path = pppt,oracle,dmap_extension,public;
alter table consulta alter column idconsulta set not null;
-- dmap_object_gen_tag : type : alter table name : consulta
set search_path = pppt,oracle,dmap_extension,public;
alter table consulta alter column consulta set not null;
