-- dmap_object_gen_tag : type : table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_hierarchies"  (
hi_id numeric(10) not null,
hi_type varchar(10) not null,
hi_name varchar(100) not null,
hi_developer_key varchar(100) not null,
hi_description varchar(240),
hi_sys_generated numeric(1) not null,
hi_ext_hierarchy varchar(64),
dbh_default numeric(1),
ibh_dbh_id numeric(10),
hi_user_prop2 varchar(100),
hi_user_prop1 varchar(100),
hi_element_state numeric(10) not null,
hi_created_by varchar(64) not null,
hi_created_date timestamp(0) not null,
hi_updated_by varchar(64),
hi_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies add constraint eul4_hi_pk primary key (hi_id);
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies add constraint eul4_hi_uk_2 unique (hi_name);
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies add constraint eul4_hi_uk_1 unique (hi_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies add constraint eul4_hi_check_1 check (    hi_type in ( 'DBH' , 'IBH' ));
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies add constraint eul4_hi_check_2 check (    hi_sys_generated in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies add constraint eul4_hi_check_3 check (    dbh_default in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies alter column hi_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies alter column hi_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies alter column hi_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies alter column hi_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies alter column hi_sys_generated set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies alter column hi_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies alter column hi_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies alter column hi_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hierarchies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hierarchies add constraint eul4_ibh_dbh_fk foreign key (ibh_dbh_id) references eul4_hierarchies(hi_id) on delete no action not deferrable initially immediate;
