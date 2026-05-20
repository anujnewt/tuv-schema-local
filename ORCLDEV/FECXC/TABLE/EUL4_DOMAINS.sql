-- dmap_object_gen_tag : type : table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_domains"  (
dom_id numeric(10) not null,
dom_name varchar(100) not null,
dom_developer_key varchar(100) not null,
dom_description varchar(240),
dom_data_type numeric(2) not null,
dom_logical_item numeric(1) not null,
dom_sys_generated numeric(1) not null,
dom_cardinality numeric(22),
dom_last_exec_time numeric(22),
dom_cached numeric(1) not null,
dom_it_id_lov numeric(10),
dom_it_id_rank numeric(10),
dom_user_prop2 varchar(100),
dom_user_prop1 varchar(100),
dom_element_state numeric(10) not null,
dom_created_by varchar(64) not null,
dom_created_date timestamp(0) not null,
dom_updated_by varchar(64),
dom_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains add constraint eul4_dom_uk_2 unique (dom_name);
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains add constraint eul4_dom_pk primary key (dom_id);
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains add constraint eul4_dom_uk_1 unique (dom_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains add constraint eul4_dom_check_2 check (    dom_data_type in (0,1,2,3,4,5,6,7,8,9,10,11,12,13));
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains add constraint eul4_dom_check_3 check (    dom_logical_item in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains add constraint eul4_dom_check_4 check (    dom_sys_generated in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains add constraint eul4_dom_check_5 check (    dom_cached in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains alter column dom_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains alter column dom_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains alter column dom_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains alter column dom_data_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains alter column dom_logical_item set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains alter column dom_sys_generated set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains alter column dom_cached set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains alter column dom_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains alter column dom_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains alter column dom_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains add constraint eul4_dom_it_l_fk foreign key (dom_it_id_lov) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_domains
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_domains add constraint eul4_dom_it_r_fk foreign key (dom_it_id_rank) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
