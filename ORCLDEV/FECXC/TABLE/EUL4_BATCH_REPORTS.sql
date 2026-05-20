-- dmap_object_gen_tag : type : table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_batch_reports"  (
br_id numeric(10) not null,
br_name varchar(100) not null,
br_workbook_name varchar(240) not null,
br_description varchar(240),
br_next_run_date timestamp(0),
br_job_id numeric(22),
br_expiry numeric(22),
br_completion_date timestamp(0),
br_num_freq_units numeric(22),
br_eu_id numeric(10) not null,
br_rfu_id numeric(10) not null,
br_auto_refresh numeric(1) not null,
br_report_schema varchar(64) not null,
br_element_state numeric(10) not null,
br_created_by varchar(64) not null,
br_created_date timestamp(0) not null,
br_updated_by varchar(64),
br_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports add constraint eul4_br_pk primary key (br_id);
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports add constraint eul4_br_uk_2 unique (br_job_id);
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports add constraint eul4_br_uk_1 unique (br_name);
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports add constraint eul4_br_check_1 check (    br_auto_refresh in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports alter column br_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports alter column br_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports alter column br_workbook_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports alter column br_eu_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports alter column br_rfu_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports alter column br_auto_refresh set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports alter column br_report_schema set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports alter column br_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports alter column br_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports alter column br_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports add constraint eul4_br_eu_fk foreign key (br_eu_id) references eul4_eul_users(eu_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_reports
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_reports add constraint eul4_br_rfu_fk foreign key (br_rfu_id) references eul4_freq_units(rfu_id) on delete no action not deferrable initially immediate;
