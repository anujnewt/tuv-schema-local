-- dmap_object_gen_tag : type : table name : ttccompetencia
set search_path = pppt,oracle,dmap_extension,public;
create table "ttccompetencia"  (
idcompetencia numeric(38) not null,
competencia varchar(150) not null,
definicion varchar(4000) not null,
secuencia numeric(38) not null,
idprueba numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : ttccompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table ttccompetencia alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : ttccompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table ttccompetencia alter column competencia set not null;
-- dmap_object_gen_tag : type : alter table name : ttccompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table ttccompetencia alter column definicion set not null;
-- dmap_object_gen_tag : type : alter table name : ttccompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table ttccompetencia alter column secuencia set not null;
-- dmap_object_gen_tag : type : alter table name : ttccompetencia
set search_path = pppt,oracle,dmap_extension,public;
alter table ttccompetencia alter column idprueba set not null;
