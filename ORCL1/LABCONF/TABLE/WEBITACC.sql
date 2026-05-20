-- dmap_object_gen_tag : type : table name : webitacc
set search_path = labconf,oracle,dmap_extension,public;
create table "webitacc"  (
wcc_idbacc numeric(38) not null,
wcc_keyemp numeric(38) not null,
wcc_pcempl varchar(20) not null,
wcc_detall varchar(100) not null,
wcc_fecalt timestamp(0) not null
) ;
-- dmap_object_gen_tag : type : alter table name : webitacc
set search_path = labconf,oracle,dmap_extension,public;
alter table webitacc add primary key (wcc_idbacc);
-- dmap_object_gen_tag : type : alter table name : webitacc
set search_path = labconf,oracle,dmap_extension,public;
alter table webitacc alter column wcc_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : webitacc
set search_path = labconf,oracle,dmap_extension,public;
alter table webitacc alter column wcc_pcempl set not null;
-- dmap_object_gen_tag : type : alter table name : webitacc
set search_path = labconf,oracle,dmap_extension,public;
alter table webitacc alter column wcc_detall set not null;
-- dmap_object_gen_tag : type : alter table name : webitacc
set search_path = labconf,oracle,dmap_extension,public;
alter table webitacc alter column wcc_fecalt set not null;
