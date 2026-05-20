-- dmap_object_gen_tag : type : table name : resoffice
set search_path = pppt,oracle,dmap_extension,public;
create table "resoffice"  (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
fecha timestamp(0) not null,
calificaciones varchar(100) not null,
tiempos varchar(100) not null,
status numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : resoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table resoffice alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : resoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table resoffice alter column idprueba set not null;
-- dmap_object_gen_tag : type : alter table name : resoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table resoffice alter column fecha set not null;
-- dmap_object_gen_tag : type : alter table name : resoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table resoffice alter column calificaciones set not null;
-- dmap_object_gen_tag : type : alter table name : resoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table resoffice alter column tiempos set not null;
-- dmap_object_gen_tag : type : alter table name : resoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table resoffice alter column status set not null;
