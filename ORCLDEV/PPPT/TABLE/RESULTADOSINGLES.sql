-- dmap_object_gen_tag : type : table name : resultadosingles
set search_path = pppt,oracle,dmap_extension,public;
create table "resultadosingles"  (
idpersonal numeric(38) not null,
aciertos numeric(38),
status numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : resultadosingles
set search_path = pppt,oracle,dmap_extension,public;
alter table resultadosingles alter column idpersonal set not null;
