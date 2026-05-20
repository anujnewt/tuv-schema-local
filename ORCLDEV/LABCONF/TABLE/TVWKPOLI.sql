-- dmap_object_gen_tag : type : table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
create table "tvwkpoli"  (
pol_keyemp numeric(10) not null,
pol_keypro numeric(5) not null,
pol_keycon varchar(3) not null,
pol_codacu numeric(10) not null,
pol_descta varchar(30),
pol_cia varchar(3),
pol_neg varchar(2) not null,
pol_cta varchar(3) not null,
pol_scta varchar(6) not null,
pol_cc varchar(8) not null,
pol_icia varchar(3) not null,
pol_top varchar(1) not null,
pol_ietu varchar(4) not null,
pol_impcar decimal(16, 2) not null,
pol_impabo decimal(16, 2) not null,
pol_keycia varchar(2) not null,
pol_keypol varchar(10) not null,
pol_cveban varchar(7),
pol_forpag varchar(2),
pol_keyben numeric(5),
pol_comfam numeric(5),
pol_tipo numeric(1) not null,
pol_fecmov timestamp(0) default null
) ;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_codacu set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_neg set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_cta set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_scta set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_cc set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_icia set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_top set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_ietu set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_impcar set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_impabo set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_keypol set not null;
-- dmap_object_gen_tag : type : alter table name : tvwkpoli
set search_path = labconf,oracle,dmap_extension,public;
alter table tvwkpoli alter column pol_tipo set not null;
