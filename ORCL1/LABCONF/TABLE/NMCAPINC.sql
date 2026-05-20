-- dmap_object_gen_tag : type : table name : nmcapinc
set search_path = labconf,oracle,dmap_extension,public;
create table "nmcapinc"  (
inc_keyusu numeric(38) not null,
inc_keyemp numeric(38) not null,
inc_keysem numeric(38) not null,
inc_keyjor numeric(38) not null,
inc_keycco varchar(16) not null,
inc_feccap timestamp(0) not null,
inc_ddesc1 varchar(2),
inc_ddesc2 varchar(2),
inc_keypro numeric(38),
inc_xytech numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : nmcapinc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcapinc alter column inc_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : nmcapinc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcapinc alter column inc_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmcapinc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcapinc alter column inc_keysem set not null;
-- dmap_object_gen_tag : type : alter table name : nmcapinc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcapinc alter column inc_keyjor set not null;
-- dmap_object_gen_tag : type : alter table name : nmcapinc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcapinc alter column inc_keycco set not null;
-- dmap_object_gen_tag : type : alter table name : nmcapinc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcapinc alter column inc_feccap set not null;
