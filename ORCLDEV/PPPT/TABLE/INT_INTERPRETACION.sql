-- dmap_object_gen_tag : type : table name : int_interpretacion
set search_path = pppt,oracle,dmap_extension,public;
create table "int_interpretacion"  (
idcompetencia numeric(38) not null,
idprueba numeric(38) not null,
resultado varchar(10) not null,
interpretacion varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : int_interpretacion
set search_path = pppt,oracle,dmap_extension,public;
alter table int_interpretacion alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : int_interpretacion
set search_path = pppt,oracle,dmap_extension,public;
alter table int_interpretacion alter column idprueba set not null;
-- dmap_object_gen_tag : type : alter table name : int_interpretacion
set search_path = pppt,oracle,dmap_extension,public;
alter table int_interpretacion alter column resultado set not null;
