-- dmap_object_gen_tag : type : table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_summary_objs"  (
sumo_id numeric(10) not null,
sumo_type varchar(10) not null,
sumo_internal numeric(1) not null,
sumo_item_deleted numeric(1) not null,
sumo_item_modified numeric(1) not null,
sumo_join_state numeric(1) not null,
sumo_validity numeric(1) not null,
sumo_ext_object varchar(64),
sumo_ext_owner varchar(64),
sumo_ext_db_link varchar(64),
sumo_asmp_id numeric(10),
sumo_active numeric(1) not null,
sbo_srs_id numeric(10),
sbo_max_item_comb numeric(22),
sdo_sbo_id numeric(10),
sdo_num_joins numeric(22),
sdo_num_usgs numeric(22),
sdo_num_axis_items numeric(22),
sdo_num_rows numeric(22),
sdo_bitmap_pos numeric(22),
sdo_object_sql1 varchar(250),
sdo_object_sql2 varchar(250),
sdo_object_sql3 varchar(250),
sdo_last_refresh timestamp(0),
sdo_table_name varchar(64),
sdo_table_owner varchar(64),
sdo_database_link varchar(64),
msdo_svr_err_code numeric(22),
msdo_svr_err_text varchar(240),
msdo_refresh_reqd numeric(1),
ems_commit_size numeric(22),
ems_state numeric(2),
sumo_element_state numeric(10) not null,
sumo_created_by varchar(64) not null,
sumo_created_date timestamp(0) not null,
sumo_updated_by varchar(64),
sumo_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_pk primary key (sumo_id);
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_uk_1 unique (sbo_srs_id,sdo_bitmap_pos);
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_check_1 check (    sumo_type = 'SBO' or sdo_bitmap_pos is not null);
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_check_10 check (    sumo_active in (1,0));
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_check_2 check (    sumo_type in ( 'SBO','NMV','EMS','SMS' ));
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_check_3 check (    sumo_internal in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_check_4 check (    sumo_item_deleted in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_check_5 check (    sumo_item_modified in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_check_6 check (    sumo_join_state in ( 1 , 2 , 3 ));
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_check_7 check (    sumo_validity in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_check_8 check (    ems_state in (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18));
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_check_9 check (    msdo_refresh_reqd in (1,0));
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs alter column sumo_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs alter column sumo_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs alter column sumo_internal set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs alter column sumo_item_deleted set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs alter column sumo_item_modified set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs alter column sumo_join_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs alter column sumo_validity set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs alter column sumo_active set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs alter column sumo_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs alter column sumo_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs alter column sumo_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sbo_srs_fk foreign key (sbo_srs_id) references eul4_sum_rfsh_sets(srs_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sdo_sbo_fk foreign key (sdo_sbo_id) references eul4_summary_objs(sumo_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_summary_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_summary_objs add constraint eul4_sumo_asmp_fk foreign key (sumo_asmp_id) references eul4_asm_policies(asmp_id) on delete no action not deferrable initially immediate;
