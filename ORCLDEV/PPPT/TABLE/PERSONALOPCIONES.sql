-- dmap_object_gen_tag : type : table name : personalopciones
set search_path = pppt,oracle,dmap_extension,public;
create table "personalopciones"  (
idpersonal numeric(38) not null,
idopcion numeric(38) not null,
fecha timestamp(0) not null,
valor numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : personalopciones
set search_path = pppt,oracle,dmap_extension,public;
alter table personalopciones alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalopciones
set search_path = pppt,oracle,dmap_extension,public;
alter table personalopciones alter column idopcion set not null;
-- dmap_object_gen_tag : type : alter table name : personalopciones
set search_path = pppt,oracle,dmap_extension,public;
alter table personalopciones alter column fecha set not null;
