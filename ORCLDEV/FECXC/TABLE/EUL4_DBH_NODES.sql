-- dmap_object_gen_tag : type : table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_dbh_nodes"  (
dhn_id numeric(10) not null,
dhn_name varchar(100) not null,
dhn_developer_key varchar(100) not null,
dhn_description varchar(240),
dhn_data_fmt_msk varchar(100) not null,
dhn_disp_fmt_msk varchar(100) not null,
dhn_hi_id numeric(10) not null,
dhn_user_prop2 varchar(100),
dhn_user_prop1 varchar(100),
dhn_element_state numeric(10) not null,
dhn_created_by varchar(64) not null,
dhn_created_date timestamp(0) not null,
dhn_updated_by varchar(64),
dhn_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes add constraint eul4_dhn_uk_2 unique (dhn_hi_id,dhn_name);
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes add constraint eul4_dhn_pk primary key (dhn_id);
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes add constraint eul4_dhn_uk_1 unique (dhn_hi_id,dhn_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes alter column dhn_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes alter column dhn_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes alter column dhn_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes alter column dhn_data_fmt_msk set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes alter column dhn_disp_fmt_msk set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes alter column dhn_hi_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes alter column dhn_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes alter column dhn_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes alter column dhn_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_dbh_nodes
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_dbh_nodes add constraint eul4_dhn_dbh_fk foreign key (dhn_hi_id) references eul4_hierarchies(hi_id) on delete no action not deferrable initially immediate;
