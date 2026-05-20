-- dmap_object_gen_tag : type : table name : personalho
set search_path = pppt,oracle,dmap_extension,public;
create table "personalho"  (
idpersonal numeric(38) not null,
idpregunta numeric(38) not null,
respuesta numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : personalho
set search_path = pppt,oracle,dmap_extension,public;
alter table personalho alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalho
set search_path = pppt,oracle,dmap_extension,public;
alter table personalho alter column idpregunta set not null;
