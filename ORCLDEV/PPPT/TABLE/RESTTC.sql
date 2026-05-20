-- dmap_object_gen_tag : type : table name : resttc
set search_path = pppt,oracle,dmap_extension,public;
create table "resttc"  (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
fecha timestamp(0) not null,
respuestas varchar(150) not null,
resultados varchar(150) not null,
status numeric(38) not null,
tiempos varchar(4000) not null
) ;
-- dmap_object_gen_tag : type : alter table name : resttc
set search_path = pppt,oracle,dmap_extension,public;
alter table resttc alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : resttc
set search_path = pppt,oracle,dmap_extension,public;
alter table resttc alter column idprueba set not null;
-- dmap_object_gen_tag : type : alter table name : resttc
set search_path = pppt,oracle,dmap_extension,public;
alter table resttc alter column fecha set not null;
-- dmap_object_gen_tag : type : alter table name : resttc
set search_path = pppt,oracle,dmap_extension,public;
alter table resttc alter column respuestas set not null;
-- dmap_object_gen_tag : type : alter table name : resttc
set search_path = pppt,oracle,dmap_extension,public;
alter table resttc alter column resultados set not null;
-- dmap_object_gen_tag : type : alter table name : resttc
set search_path = pppt,oracle,dmap_extension,public;
alter table resttc alter column status set not null;
-- dmap_object_gen_tag : type : alter table name : resttc
set search_path = pppt,oracle,dmap_extension,public;
alter table resttc alter column tiempos set not null;
