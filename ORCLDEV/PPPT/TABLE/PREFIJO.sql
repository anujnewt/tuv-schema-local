-- dmap_object_gen_tag : type : table name : prefijo
set search_path = pppt,oracle,dmap_extension,public;
create table "prefijo"  (
idprefijo numeric(38) not null default 0,
prefijo varchar(15),
numeros numeric(38),
automatico numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : prefijo
set search_path = pppt,oracle,dmap_extension,public;
alter table prefijo alter column idprefijo set not null;
