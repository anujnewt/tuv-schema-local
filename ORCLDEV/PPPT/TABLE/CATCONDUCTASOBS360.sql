-- dmap_object_gen_tag : type : table name : catconductasobs360
set search_path = pppt,oracle,dmap_extension,public;
create table "catconductasobs360"  (
idconducta numeric(38) not null default 0,
idcompetencia numeric(38),
peso numeric(38),
conducta varchar(255),
cursos varchar(4000),
niveles numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : catconductasobs360
set search_path = pppt,oracle,dmap_extension,public;
alter table catconductasobs360 alter column idconducta set not null;
