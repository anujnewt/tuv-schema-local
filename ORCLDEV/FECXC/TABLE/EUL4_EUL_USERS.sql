-- dmap_object_gen_tag : type : table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_eul_users"  (
eu_id numeric(10) not null,
eu_username varchar(64) not null,
eu_security_model numeric(2) not null,
eu_use_pub_privs numeric(1) not null,
eu_query_time_lmt numeric(22),
eu_query_est_lmt numeric(22),
eu_row_fetch_lmt numeric(22),
eu_role_flag numeric(1) not null,
eu_batch_jobs_lmt numeric(22),
eu_batch_wnd_start timestamp(0),
eu_batch_wnd_end timestamp(0),
eu_batch_qtime_lmt numeric(22),
eu_batch_expiry numeric(22),
eu_batch_cmt_sz numeric(22),
eu_batch_rep_user varchar(64),
eu_element_state numeric(10) not null,
eu_created_by varchar(64) not null,
eu_created_date timestamp(0) not null,
eu_updated_by varchar(64),
eu_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users add constraint eul4_eu_pk primary key (eu_id);
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users add constraint eul4_eu_uk_2 unique (eu_username);
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users add constraint eul4_eu_check_1 check (    eu_use_pub_privs in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users add constraint eul4_eu_check_2 check (    eu_role_flag in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users add constraint eul4_eu_check_3 check (    eu_security_model in (0,1));
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users alter column eu_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users alter column eu_username set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users alter column eu_security_model set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users alter column eu_use_pub_privs set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users alter column eu_role_flag set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users alter column eu_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users alter column eu_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_eul_users
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_eul_users alter column eu_created_date set not null;
