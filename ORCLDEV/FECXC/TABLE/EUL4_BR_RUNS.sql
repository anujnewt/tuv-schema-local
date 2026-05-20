-- dmap_object_gen_tag : type : table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_br_runs"  (
brr_id numeric(10) not null,
brr_br_id numeric(10) not null,
brr_run_number numeric(22) not null,
brr_state numeric(2) not null,
brr_run_date timestamp(0),
brr_svr_err_code numeric,
brr_svr_err_text varchar(240),
brr_act_elap_time numeric,
brr_element_state numeric(10) not null,
brr_created_by varchar(64) not null,
brr_created_date timestamp(0) not null,
brr_updated_by varchar(64),
brr_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_br_runs add constraint eul4_brr_uk_1 unique (brr_br_id,brr_run_number);
-- dmap_object_gen_tag : type : alter table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_br_runs add constraint eul4_brr_pk primary key (brr_id);
-- dmap_object_gen_tag : type : alter table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_br_runs add constraint eul4_brr_check_1 check (    brr_state in (0, 1, 2, 3, 4, 5, 6, 7, 8, 9));
-- dmap_object_gen_tag : type : alter table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_br_runs alter column brr_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_br_runs alter column brr_br_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_br_runs alter column brr_run_number set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_br_runs alter column brr_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_br_runs alter column brr_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_br_runs alter column brr_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_br_runs alter column brr_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_br_runs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_br_runs add constraint eul4_brr_br_fk foreign key (brr_br_id) references eul4_batch_reports(br_id) on delete no action not deferrable initially immediate;
