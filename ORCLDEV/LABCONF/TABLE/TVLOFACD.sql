-- dmap_object_gen_tag : type : table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
create table "tvlofacd"  (
fde_keyfac varchar(30) not null,
fde_numlin numeric(38) not null,
fde_cia varchar(3) not null,
fde_neg varchar(2) not null,
fde_cta varchar(3) not null,
fde_scta varchar(6) not null,
fde_cc varchar(8) not null,
fde_icia varchar(3) not null,
fde_top varchar(1) not null,
fde_ietu varchar(4) not null,
fde_keycon varchar(3),
fde_impcar decimal(16, 2) not null,
fde_impabo decimal(16, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_keyfac set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_numlin set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_cia set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_neg set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_cta set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_scta set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_cc set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_icia set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_top set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_ietu set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_impcar set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofacd
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlofacd alter column fde_impabo set not null;
