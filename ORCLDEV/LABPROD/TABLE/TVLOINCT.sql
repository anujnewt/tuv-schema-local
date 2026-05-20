-- dmap_object_gen_tag : type : table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
create table "tvloinct"  (
inc_keyinc numeric(38) not null,
inc_keypro numeric(8) not null,
inc_keyper varchar(7) not null,
inc_keyemp numeric(10) not null,
inc_keycen varchar(8) not null,
inc_keycon varchar(3) not null,
inc_import decimal(18, 2) not null,
inc_seccio varchar(6) not null,
inc_porcen decimal(18, 6) not null,
inc_impsec decimal(18, 2) not null,
inc_fijo numeric(4) not null,
inc_keyusu numeric(10) not null,
inc_fecmod timestamp(0) not null,
inc_hormod varchar(8) not null,
inc_status varchar(1),
inc_keypue varchar(16),
inc_cveinc decimal(16, 6),
inc_cvesec decimal(16, 6)
) ;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct add constraint tvloinct_pk primary key (inc_keyinc);
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_keyinc set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_keycen set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_import set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_seccio set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_porcen set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_impsec set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_fijo set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_fecmod set not null;
-- dmap_object_gen_tag : type : alter table name : tvloinct
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloinct alter column inc_hormod set not null;
