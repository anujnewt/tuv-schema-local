-- dmap_object_gen_tag : type : table name : eul4_qpp_stats
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_qpp_stats"  (
qs_id numeric(10) not null,
qs_cost numeric,
qs_act_cpu_time numeric,
qs_act_elap_time numeric not null,
qs_est_elap_time numeric not null,
qs_object_use_key varchar(240) not null,
qs_summary_fit numeric(2),
qs_state numeric(1),
qs_num_rows numeric(10),
qs_doc_owner varchar(64),
qs_doc_name varchar(100),
qs_doc_details varchar(240),
qs_sdo_id numeric(10),
qs_dbmp0 bytea,
qs_dbmp1 bytea,
qs_dbmp2 bytea,
qs_dbmp3 bytea,
qs_dbmp4 bytea,
qs_dbmp5 bytea,
qs_dbmp6 bytea,
qs_dbmp7 bytea,
qs_mbmp0 bytea,
qs_mbmp1 bytea,
qs_mbmp2 bytea,
qs_mbmp3 bytea,
qs_mbmp4 bytea,
qs_mbmp5 bytea,
qs_mbmp6 bytea,
qs_mbmp7 bytea,
qs_jbmp0 bytea,
qs_jbmp1 bytea,
qs_jbmp2 bytea,
qs_jbmp3 bytea,
qs_jbmp4 bytea,
qs_jbmp5 bytea,
qs_jbmp6 bytea,
qs_jbmp7 bytea,
qs_fbmp0 bytea,
qs_fbmp1 bytea,
qs_fbmp2 bytea,
qs_fbmp3 bytea,
qs_fbmp4 bytea,
qs_fbmp5 bytea,
qs_fbmp6 bytea,
qs_fbmp7 bytea,
qs_created_by varchar(64) not null,
qs_created_date timestamp(0) not null
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_qpp_stats
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_qpp_stats add constraint eul4_qs_pk primary key (qs_id);
-- dmap_object_gen_tag : type : alter table name : eul4_qpp_stats
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_qpp_stats add constraint eul4_qs_check_1 check (    coalesce(qs_cost, 0) >= 0 and    coalesce(qs_act_cpu_time, 0) >= 0 and    qs_act_elap_time >= 0 and    qs_est_elap_time >= 0);
-- dmap_object_gen_tag : type : alter table name : eul4_qpp_stats
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_qpp_stats add constraint eul4_qs_check_2 check (    qs_summary_fit in ( 0 , 1 , 2 , 3 , 4 , 5 , 6 ));
-- dmap_object_gen_tag : type : alter table name : eul4_qpp_stats
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_qpp_stats add constraint eul4_qs_check_3 check (    qs_state in (0,1,2));
-- dmap_object_gen_tag : type : alter table name : eul4_qpp_stats
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_qpp_stats alter column qs_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_qpp_stats
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_qpp_stats alter column qs_act_elap_time set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_qpp_stats
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_qpp_stats alter column qs_est_elap_time set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_qpp_stats
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_qpp_stats alter column qs_object_use_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_qpp_stats
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_qpp_stats alter column qs_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_qpp_stats
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_qpp_stats alter column qs_created_date set not null;
