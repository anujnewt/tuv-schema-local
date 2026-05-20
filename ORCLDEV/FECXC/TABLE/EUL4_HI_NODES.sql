-- dmap_object_gen_tag : type : table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_hi_nodes"  (
hn_id numeric(10) not null,
hn_name varchar(100) not null,
hn_developer_key varchar(100) not null,
hn_description varchar(240),
hn_hi_id numeric(10) not null,
hn_ext_node varchar(64),
hn_user_prop2 varchar(100),
hn_user_prop1 varchar(100),
hn_element_state numeric(10) not null,
hn_created_by varchar(64) not null,
hn_created_date timestamp(0) not null,
hn_updated_by varchar(64),
hn_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_nodes add constraint eul4_hn_uk_1 unique (hn_hi_id,hn_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_nodes add constraint eul4_hn_uk_2 unique (hn_hi_id,hn_name);
-- dmap_object_gen_tag : type : alter table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_nodes add constraint eul4_hn_pk primary key (hn_id);
-- dmap_object_gen_tag : type : alter table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_nodes alter column hn_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_nodes alter column hn_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_nodes alter column hn_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_nodes alter column hn_hi_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_nodes alter column hn_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_nodes alter column hn_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_nodes alter column hn_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_nodes add constraint eul4_hn_ibh_fk foreign key (hn_hi_id) references eul4_hierarchies(hi_id) on delete no action not deferrable initially immediate;
