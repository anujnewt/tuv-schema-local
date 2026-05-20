-- dmap_object_gen_tag : type : table name : eul4_gateways
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_gateways"  (
gw_id numeric(10) not null,
gw_type varchar(10) not null,
gw_gateway_name varchar(100) not null,
gw_product_name varchar(100) not null,
gw_description varchar(240),
egw_version varchar(30),
egw_database_link varchar(64),
egw_schema varchar(64),
egw_sql_paradigm varchar(10),
gw_element_state numeric(10) not null,
gw_created_by varchar(64) not null,
gw_created_date timestamp(0) not null,
gw_updated_by varchar(64),
gw_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_gateways
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_gateways add constraint eul4_gw_pk primary key (gw_id);
-- dmap_object_gen_tag : type : alter table name : eul4_gateways
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_gateways add constraint eul4_gw_check_1 check (    gw_type in ('EGW', 'BGW'));
-- dmap_object_gen_tag : type : alter table name : eul4_gateways
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_gateways add constraint eul4_gw_check_2 check (    egw_sql_paradigm in ('TABLE','OBJECT'));
-- dmap_object_gen_tag : type : alter table name : eul4_gateways
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_gateways alter column gw_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_gateways
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_gateways alter column gw_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_gateways
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_gateways alter column gw_gateway_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_gateways
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_gateways alter column gw_product_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_gateways
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_gateways alter column gw_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_gateways
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_gateways alter column gw_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_gateways
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_gateways alter column gw_created_date set not null;
