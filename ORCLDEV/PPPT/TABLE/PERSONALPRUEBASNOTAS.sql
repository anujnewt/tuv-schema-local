-- dmap_object_gen_tag : type : table name : personalpruebasnotas
set search_path = pppt,oracle,dmap_extension,public;
create table "personalpruebasnotas"  (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
notas varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : personalpruebasnotas
set search_path = pppt,oracle,dmap_extension,public;
alter table personalpruebasnotas alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalpruebasnotas
set search_path = pppt,oracle,dmap_extension,public;
alter table personalpruebasnotas alter column idprueba set not null;
