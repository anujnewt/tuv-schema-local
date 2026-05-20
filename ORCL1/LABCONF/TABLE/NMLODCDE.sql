-- dmap_object_gen_tag : type : table name : nmlodcde
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlodcde"  (
dcd_keyemp numeric(38) not null,
dcd_keycia varchar(5) not null,
dcd_keyper varchar(7) not null,
dcd_keyrub varchar(3) not null,
dcd_import numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmlodcde
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlodcde alter column dcd_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcde
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlodcde alter column dcd_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcde
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlodcde alter column dcd_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcde
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlodcde alter column dcd_keyrub set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodcde
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlodcde alter column dcd_import set not null;
