-- dmap_object_gen_tag : type : table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_sum_rfsh_sets"  (
srs_id numeric(10) not null,
srs_name varchar(100) not null,
srs_developer_key varchar(100) not null,
srs_description varchar(240),
srs_state numeric(2) not null,
srs_online numeric(1) not null,
srs_auto_refresh numeric(1) not null,
srs_last_refresh timestamp(0),
srs_next_refresh timestamp(0),
srs_job_id numeric(22),
srs_eu_id numeric(10) not null,
srs_num_freq_units numeric(22),
srs_rfu_id numeric(10),
srs_refresh_count numeric(22),
srs_user_prop2 varchar(100),
srs_user_prop1 varchar(100),
srs_element_state numeric(10) not null,
srs_created_by varchar(64) not null,
srs_created_date timestamp(0) not null,
srs_updated_by varchar(64),
srs_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets add constraint eul4_srs_uk_1 unique (srs_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets add constraint eul4_srs_uk_2 unique (srs_name);
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets add constraint eul4_srs_pk primary key (srs_id);
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets add constraint eul4_srs_check_1 check (    srs_state in (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18));
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets add constraint eul4_srs_check_2 check (    srs_online in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets add constraint eul4_srs_check_3 check (    srs_auto_refresh in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets alter column srs_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets alter column srs_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets alter column srs_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets alter column srs_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets alter column srs_online set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets alter column srs_auto_refresh set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets alter column srs_eu_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets alter column srs_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets alter column srs_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets alter column srs_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets add constraint eul4_srs_eu_fk foreign key (srs_eu_id) references eul4_eul_users(eu_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_rfsh_sets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_rfsh_sets add constraint eul4_srs_rfu_fk foreign key (srs_rfu_id) references eul4_freq_units(rfu_id) on delete no action not deferrable initially immediate;
