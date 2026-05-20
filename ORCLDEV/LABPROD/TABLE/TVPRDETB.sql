-- dmap_object_gen_tag : type : table name : tvprdetb
set search_path = labprod,oracle,dmap_extension,public;
create table "tvprdetb"  (
det_keyusu numeric(38) not null,
det_fecmov timestamp(0) not null,
det_hormov varchar(8) not null,
det_keytab varchar(18),
det_keycam varchar(18) not null,
det_valant varchar(40) not null,
det_valact varchar(40) not null
) ;
-- dmap_object_gen_tag : type : alter table name : tvprdetb
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprdetb alter column det_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : tvprdetb
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprdetb alter column det_fecmov set not null;
-- dmap_object_gen_tag : type : alter table name : tvprdetb
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprdetb alter column det_hormov set not null;
-- dmap_object_gen_tag : type : alter table name : tvprdetb
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprdetb alter column det_keycam set not null;
-- dmap_object_gen_tag : type : alter table name : tvprdetb
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprdetb alter column det_valant set not null;
-- dmap_object_gen_tag : type : alter table name : tvprdetb
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprdetb alter column det_valact set not null;
