-- dmap_object_gen_tag : type : table name : tvloincl
set search_path = labprod,oracle,dmap_extension,public;
create table "tvloincl"  (
inc_keyinc numeric(38),
inc_keyemp numeric(38) not null,
inc_keypro numeric(38) not null,
inc_keyper varchar(7) not null,
inc_keysem varchar(6) not null,
inc_keycon varchar(3) not null,
inc_cantid decimal(12, 2) not null,
inc_import decimal(12, 2) not null,
inc_keyusu numeric(38) not null,
inc_fecmod timestamp(0) not null,
inc_hormod varchar(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : tvloincl
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloincl alter column inc_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : tvloincl
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloincl alter column inc_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : tvloincl
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloincl alter column inc_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : tvloincl
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloincl alter column inc_keysem set not null;
-- dmap_object_gen_tag : type : alter table name : tvloincl
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloincl alter column inc_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : tvloincl
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloincl alter column inc_cantid set not null;
-- dmap_object_gen_tag : type : alter table name : tvloincl
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloincl alter column inc_import set not null;
-- dmap_object_gen_tag : type : alter table name : tvloincl
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloincl alter column inc_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : tvloincl
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloincl alter column inc_fecmod set not null;
-- dmap_object_gen_tag : type : alter table name : tvloincl
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloincl alter column inc_hormod set not null;
