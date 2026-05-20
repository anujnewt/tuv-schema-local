-- dmap_object_gen_tag : type : table name : catseccion
set search_path = pppt,oracle,dmap_extension,public;
create table "catseccion"  (
idseccion numeric(38) not null default 0,
seccion varchar(100) not null,
idempresa numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : catseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table catseccion alter column idseccion set not null;
-- dmap_object_gen_tag : type : alter table name : catseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table catseccion alter column seccion set not null;
-- dmap_object_gen_tag : type : alter table name : catseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table catseccion alter column idempresa set not null;
