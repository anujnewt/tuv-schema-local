-- dmap_object_gen_tag : type : table name : catcompetencias360
set search_path = pppt,oracle,dmap_extension,public;
create table "catcompetencias360"  (
idcompetencia numeric(38) not null default 0,
competencia varchar(255),
tipo numeric(38),
definicion varchar(4000),
idempresa numeric(38),
inactiva numeric(1) default 0
) ;
-- dmap_object_gen_tag : type : alter table name : catcompetencias360
set search_path = pppt,oracle,dmap_extension,public;
alter table catcompetencias360 alter column idcompetencia set not null;
