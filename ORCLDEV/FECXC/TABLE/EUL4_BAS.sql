-- dmap_object_gen_tag : type : table name : eul4_bas
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_bas"  (
ba_id numeric(10) not null,
ba_name varchar(100) not null,
ba_developer_key varchar(100) not null,
ba_description varchar(240),
ba_ext_name varchar(64),
ba_user_prop1 varchar(100),
ba_user_prop2 varchar(100),
ba_element_state numeric(10) not null,
ba_created_by varchar(64) not null,
ba_created_date timestamp(0) not null,
ba_updated_by varchar(64),
ba_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_bas
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bas add constraint eul4_ba_uk_1 unique (ba_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_bas
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bas add constraint eul4_ba_pk primary key (ba_id);
-- dmap_object_gen_tag : type : alter table name : eul4_bas
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bas add constraint eul4_ba_uk_2 unique (ba_name);
-- dmap_object_gen_tag : type : alter table name : eul4_bas
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bas alter column ba_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bas
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bas alter column ba_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bas
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bas alter column ba_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bas
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bas alter column ba_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bas
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bas alter column ba_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bas
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bas alter column ba_created_date set not null;
