-- dmap_object_gen_tag : type : table name : xxmor_cat_buyunit_mkt_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_cat_buyunit_mkt_tab"  (
id_seg_neg numeric(38) not null,
id_fza_ventas numeric(38) not null,
buyuntid varchar(15) not null,
mkt_director varchar(50),
mkt_gerente varchar(50),
mkt_coordinador varchar(50),
mkt_ejecutivo varchar(50),
mkt_mail_director varchar(50),
mkt_mail_gerente varchar(50),
mkt_mail_coordinador varchar(50),
mkt_mail_ejecutivo varchar(50),
created_by varchar(20) not null,
created_date timestamp(0) not null default statement_timestamp(),
updated_by varchar(20),
updated_date timestamp(0),
id_buyunit_mkt numeric(15) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_buyunit_mkt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_buyunit_mkt_tab add constraint xxmor_cat_buyunit_mkt_pk primary key (id_seg_neg,id_fza_ventas,id_buyunit_mkt);
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_buyunit_mkt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_buyunit_mkt_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_buyunit_mkt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_buyunit_mkt_tab alter column id_fza_ventas set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_buyunit_mkt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_buyunit_mkt_tab alter column buyuntid set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_buyunit_mkt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_buyunit_mkt_tab alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_buyunit_mkt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_buyunit_mkt_tab alter column created_date set not null;
