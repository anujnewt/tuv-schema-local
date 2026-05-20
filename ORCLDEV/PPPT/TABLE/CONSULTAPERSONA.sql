-- dmap_object_gen_tag : type : table name : consultapersona
set search_path = pppt,oracle,dmap_extension,public;
create table "consultapersona"  (
idconsulta numeric(38) not null,
idpersonal numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : consultapersona
set search_path = pppt,oracle,dmap_extension,public;
alter table consultapersona alter column idconsulta set not null;
-- dmap_object_gen_tag : type : alter table name : consultapersona
set search_path = pppt,oracle,dmap_extension,public;
alter table consultapersona alter column idpersonal set not null;
