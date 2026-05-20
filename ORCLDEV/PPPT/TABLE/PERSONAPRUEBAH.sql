-- dmap_object_gen_tag : type : table name : personapruebah
set search_path = pppt,oracle,dmap_extension,public;
create table "personapruebah"  (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
fecha timestamp(0) not null,
resultados varchar(255)
) ;
-- dmap_object_gen_tag : type : alter table name : personapruebah
set search_path = pppt,oracle,dmap_extension,public;
alter table personapruebah alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personapruebah
set search_path = pppt,oracle,dmap_extension,public;
alter table personapruebah alter column idprueba set not null;
-- dmap_object_gen_tag : type : alter table name : personapruebah
set search_path = pppt,oracle,dmap_extension,public;
alter table personapruebah alter column fecha set not null;
