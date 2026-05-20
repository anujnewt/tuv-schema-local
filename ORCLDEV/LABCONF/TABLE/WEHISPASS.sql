-- dmap_object_gen_tag : type : table name : wehispass
set search_path = labconf,oracle,dmap_extension,public;
create table "wehispass"  (
weh_id numeric(38) not null,
weh_keyemp varchar(50) not null,
weh_clavea varchar(50) not null,
weh_fecalt timestamp(0) not null
) ;
-- dmap_object_gen_tag : type : alter table name : wehispass
set search_path = labconf,oracle,dmap_extension,public;
alter table wehispass add primary key (weh_id);
-- dmap_object_gen_tag : type : alter table name : wehispass
set search_path = labconf,oracle,dmap_extension,public;
alter table wehispass alter column weh_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : wehispass
set search_path = labconf,oracle,dmap_extension,public;
alter table wehispass alter column weh_clavea set not null;
-- dmap_object_gen_tag : type : alter table name : wehispass
set search_path = labconf,oracle,dmap_extension,public;
alter table wehispass alter column weh_fecalt set not null;
