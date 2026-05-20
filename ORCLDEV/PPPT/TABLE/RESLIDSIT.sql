-- dmap_object_gen_tag : type : table name : reslidsit
set search_path = pppt,oracle,dmap_extension,public;
create table "reslidsit"  (
idpersonal numeric(38) not null,
respuestas varchar(17),
resultados varchar(20),
status numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : reslidsit
set search_path = pppt,oracle,dmap_extension,public;
alter table reslidsit alter column idpersonal set not null;
