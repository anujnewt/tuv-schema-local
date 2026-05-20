-- dmap_object_gen_tag : type : table name : datapaso
set search_path = labprod,oracle,dmap_extension,public;
create table "datapaso"  (
dat_keyemp numeric(38) not null,
dat_keypar varchar(2) not null,
dat_valpar varchar(30) not null
) ;
-- dmap_object_gen_tag : type : alter table name : datapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table datapaso alter column dat_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : datapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table datapaso alter column dat_keypar set not null;
-- dmap_object_gen_tag : type : alter table name : datapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table datapaso alter column dat_valpar set not null;
