-- dmap_object_gen_tag : type : table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
create table "tvpmocaj"  (
oca_tipnom varchar(1) not null,
oca_keycia varchar(4) not null,
oca_keypro numeric(38) not null,
oca_keyper varchar(7) not null,
oca_keyemp numeric(38) not null,
oca_keypre numeric(38) not null,
oca_imppre decimal(16, 2) not null,
oca_impdes decimal(16, 2) not null,
oca_impsal decimal(16, 2) not null,
oca_unipre decimal(16, 2) not null,
oca_unides decimal(16, 2) not null,
oca_unisal decimal(16, 2) not null,
oca_fecini timestamp(0) not null,
oca_keyusu numeric(38) not null,
oca_idepcc varchar(15) not null,
oca_fecmod timestamp(0) not null,
oca_keycon varchar(3) not null
) ;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_tipnom set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_keypre set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_imppre set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_impdes set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_impsal set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_unipre set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_unides set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_unisal set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_fecini set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_idepcc set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_fecmod set not null;
-- dmap_object_gen_tag : type : alter table name : tvpmocaj
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpmocaj alter column oca_keycon set not null;
