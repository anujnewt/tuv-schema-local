-- dmap_object_gen_tag : type : table name : evalpregunta
set search_path = pppt,oracle,dmap_extension,public;
create table "evalpregunta"  (
idseccion numeric(38) not null,
idpregunta numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : evalpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpregunta alter column idseccion set not null;
-- dmap_object_gen_tag : type : alter table name : evalpregunta
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpregunta alter column idpregunta set not null;
