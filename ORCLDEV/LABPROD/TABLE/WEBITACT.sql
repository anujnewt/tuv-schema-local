-- dmap_object_gen_tag : type : table name : webitact
set search_path = labprod,oracle,dmap_extension,public;
create table "webitact"  (
wct_idbact numeric(38) not null,
wcc_keyemp numeric(38) not null,
wcc_pcempl varchar(20),
wcc_modulo varchar(50) not null,
wcc_datset varchar(50) not null,
wcc_detall varchar(100) not null,
wcc_fecalt timestamp(0) not null
) ;
-- dmap_object_gen_tag : type : alter table name : webitact
set search_path = labprod,oracle,dmap_extension,public;
alter table webitact add primary key (wct_idbact);
-- dmap_object_gen_tag : type : alter table name : webitact
set search_path = labprod,oracle,dmap_extension,public;
alter table webitact alter column wcc_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : webitact
set search_path = labprod,oracle,dmap_extension,public;
alter table webitact alter column wcc_modulo set not null;
-- dmap_object_gen_tag : type : alter table name : webitact
set search_path = labprod,oracle,dmap_extension,public;
alter table webitact alter column wcc_datset set not null;
-- dmap_object_gen_tag : type : alter table name : webitact
set search_path = labprod,oracle,dmap_extension,public;
alter table webitact alter column wcc_detall set not null;
-- dmap_object_gen_tag : type : alter table name : webitact
set search_path = labprod,oracle,dmap_extension,public;
alter table webitact alter column wcc_fecalt set not null;
