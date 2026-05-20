-- dmap_object_gen_tag : type : table name : personalresultado
set search_path = pppt,oracle,dmap_extension,public;
create table "personalresultado"  (
idpersonal numeric(38) not null,
idresultado numeric(38) not null,
fecha timestamp(0) not null,
valor numeric
) ;
-- dmap_object_gen_tag : type : alter table name : personalresultado
set search_path = pppt,oracle,dmap_extension,public;
alter table personalresultado alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalresultado
set search_path = pppt,oracle,dmap_extension,public;
alter table personalresultado alter column idresultado set not null;
-- dmap_object_gen_tag : type : alter table name : personalresultado
set search_path = pppt,oracle,dmap_extension,public;
alter table personalresultado alter column fecha set not null;
