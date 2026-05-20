-- dmap_object_gen_tag : type : table name : eul4_fun_ctgs
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_fun_ctgs"  (
fc_id numeric(10) not null,
fc_name_s varchar(100),
fc_name_mn numeric(10),
fc_developer_key varchar(100) not null,
fc_description_s varchar(240),
fc_description_mn numeric(10),
fc_user_prop2 varchar(100),
fc_user_prop1 varchar(100),
fc_element_state numeric(10) not null,
fc_created_by varchar(64) not null,
fc_created_date timestamp(0) not null,
fc_updated_by varchar(64),
fc_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_ctgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_ctgs add constraint eul4_fc_pk primary key (fc_id);
-- dmap_object_gen_tag : type : alter table name : eul4_fun_ctgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_ctgs add constraint eul4_fc_uk_2 unique (fc_name_mn,fc_name_s);
-- dmap_object_gen_tag : type : alter table name : eul4_fun_ctgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_ctgs add constraint eul4_fc_uk_1 unique (fc_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_fun_ctgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_ctgs add constraint eul4_fc_check_1 check (    fc_name_s is not null or fc_name_mn is not null);
-- dmap_object_gen_tag : type : alter table name : eul4_fun_ctgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_ctgs alter column fc_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_ctgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_ctgs alter column fc_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_ctgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_ctgs alter column fc_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_ctgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_ctgs alter column fc_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_ctgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_ctgs alter column fc_created_date set not null;
