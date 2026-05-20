-- dmap_object_gen_tag : type : table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
create table "pplorep"  (
rep_keycia varchar(4) not null,
rep_keyver numeric(38) not null,
rep_keyemp numeric(38) not null,
rep_keycon numeric(38) not null,
rep_ene decimal(20, 2) not null,
rep_feb decimal(20, 2) not null,
rep_mar decimal(20, 2) not null,
rep_abr decimal(20, 2) not null,
rep_may decimal(20, 2) not null,
rep_jun decimal(20, 2) not null,
rep_jul decimal(20, 2) not null,
rep_ago decimal(20, 2) not null,
rep_sep decimal(20, 2) not null,
rep_oct decimal(20, 2) not null,
rep_nov decimal(20, 2) not null,
rep_dic decimal(20, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_keyver set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_ene set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_feb set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_mar set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_abr set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_may set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_jun set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_jul set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_ago set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_sep set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_oct set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_nov set not null;
-- dmap_object_gen_tag : type : alter table name : pplorep
set search_path = labppto,oracle,dmap_extension,public;
alter table pplorep alter column rep_dic set not null;
