-- dmap_object_gen_tag : type : table name : nmcoinci
set search_path = labconf,oracle,dmap_extension,public;
create table "nmcoinci"  (
inc_keyemp numeric(10) not null,
inc_keycon varchar(3) not null,
inc_keypro numeric(5) not null,
inc_keyper varchar(7) not null,
inc_keydep varchar(16),
inc_keypue varchar(16),
inc_fecmov timestamp(0) not null,
inc_cantid decimal(16, 6),
inc_import decimal(12, 2),
inc_diauno decimal(12, 2),
inc_diados decimal(12, 2),
inc_diatre decimal(12, 2),
inc_diacua decimal(12, 2),
inc_diacin decimal(12, 2),
inc_diasei decimal(12, 2),
inc_diasie decimal(12, 2),
inc_keyinc decimal(16, 6),
inc_numfol numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : nmcoinci
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcoinci alter column inc_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmcoinci
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcoinci alter column inc_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : nmcoinci
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcoinci alter column inc_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : nmcoinci
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcoinci alter column inc_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : nmcoinci
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcoinci alter column inc_fecmov set not null;
