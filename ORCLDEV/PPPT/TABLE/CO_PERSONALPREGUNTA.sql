-- dmap_object_gen_tag : type : table name : co_personalpregunta
set search_path = pppt,oracle,dmap_extension,public;
create table "co_personalpregunta"  (
idpersonal numeric(38) not null,
idcaracteristica numeric(38) not null,
idpregunta numeric(38) not null,
anio numeric(38) not null,
valor numeric(38),
valor2 numeric(38),
status numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : co_personalpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table co_personalpregunta alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : co_personalpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table co_personalpregunta alter column idcaracteristica set not null;
-- dmap_object_gen_tag : type : alter table name : co_personalpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table co_personalpregunta alter column idpregunta set not null;
-- dmap_object_gen_tag : type : alter table name : co_personalpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table co_personalpregunta alter column anio set not null;
