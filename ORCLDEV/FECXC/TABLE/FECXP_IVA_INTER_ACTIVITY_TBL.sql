-- dmap_object_gen_tag : type : table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_iva_inter_activity_tbl"  (
cla_fe_id varchar(25) not null,
cla_fe_des varchar(50) not null,
cia varchar(25) not null,
neg varchar(25) not null,
cta varchar(25) not null,
scta varchar(25) not null,
cc varchar(25) not null,
icia varchar(25) not null,
top varchar(25) not null,
last_update_date timestamp(0) not null default statement_timestamp(),
last_updated_by varchar(25) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_iva_inter_activity_tbl alter column cla_fe_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_iva_inter_activity_tbl alter column cla_fe_des set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_iva_inter_activity_tbl alter column cia set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_iva_inter_activity_tbl alter column neg set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_iva_inter_activity_tbl alter column cta set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_iva_inter_activity_tbl alter column scta set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_iva_inter_activity_tbl alter column cc set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_iva_inter_activity_tbl alter column icia set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_iva_inter_activity_tbl alter column top set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_iva_inter_activity_tbl alter column last_update_date set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_iva_inter_activity_tbl
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_iva_inter_activity_tbl alter column last_updated_by set not null;
