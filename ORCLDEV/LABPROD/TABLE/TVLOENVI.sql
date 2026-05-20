-- dmap_object_gen_tag : type : table name : tvloenvi
set search_path = labprod,oracle,dmap_extension,public;
create table "tvloenvi"  (
env_keypro numeric(38) not null,
env_keyper varchar(7) not null,
env_keyusu numeric(38) not null,
env_fecmod timestamp(0) not null,
env_hormod varchar(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : tvloenvi
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloenvi alter column env_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : tvloenvi
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloenvi alter column env_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : tvloenvi
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloenvi alter column env_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : tvloenvi
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloenvi alter column env_fecmod set not null;
-- dmap_object_gen_tag : type : alter table name : tvloenvi
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloenvi alter column env_hormod set not null;
