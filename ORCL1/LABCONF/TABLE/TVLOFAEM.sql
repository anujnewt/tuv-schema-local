-- dmap_object_gen_tag : type : table name : tvlofaem
set search_path = labconf,oracle,dmap_extension,public;
create table "tvlofaem"  (
fae_keyfac varchar(30) not null,
fae_keyemp numeric(38) not null,
fae_keypro numeric(5) not null,
fae_keyper varchar(7) not null
) ;
-- dmap_object_gen_tag : type : alter table name : tvlofaem
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofaem alter column fae_keyfac set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofaem
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofaem alter column fae_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofaem
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofaem alter column fae_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofaem
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofaem alter column fae_keyper set not null;
