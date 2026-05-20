-- dmap_object_gen_tag : type : table name : catdimensiontipo
set search_path = pppt,oracle,dmap_extension,public;
create table "catdimensiontipo"  (
iddimensiontipo numeric(38) not null default 0,
dimensiontipo varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : catdimensiontipo
set search_path = pppt,oracle,dmap_extension,public;
alter table catdimensiontipo alter column iddimensiontipo set not null;
