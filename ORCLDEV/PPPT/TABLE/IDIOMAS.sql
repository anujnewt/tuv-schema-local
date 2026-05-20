-- dmap_object_gen_tag : type : table name : idiomas
set search_path = pppt,oracle,dmap_extension,public;
create table "idiomas"  (
idpersonal numeric(38) not null,
idioma varchar(50) not null,
dominio numeric,
cursos varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : idiomas
set search_path = pppt,oracle,dmap_extension,public;
alter table idiomas alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : idiomas
set search_path = pppt,oracle,dmap_extension,public;
alter table idiomas alter column idioma set not null;
