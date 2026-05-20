-- dmap_object_gen_tag : type : table name : nmlodata
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlodata"  (
dat_keyemp numeric(10) not null,
dat_keypar varchar(4) not null,
dat_valpar varchar(36)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlodata
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlodata alter column dat_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodata
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlodata alter column dat_keypar set not null;
