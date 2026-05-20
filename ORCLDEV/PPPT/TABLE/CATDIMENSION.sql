-- dmap_object_gen_tag : type : table name : catdimension
set search_path = pppt,oracle,dmap_extension,public;
create table "catdimension"  (
iddimension numeric(38) not null default 0,
dimension varchar(100),
iddimensiontipo numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : catdimension
set search_path = pppt,oracle,dmap_extension,public;
alter table catdimension alter column iddimension set not null;
