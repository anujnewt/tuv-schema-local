-- dmap_object_gen_tag : type : table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_fun_arguments"  (
fa_id numeric(10) not null,
fa_name_s varchar(100),
fa_name_mn numeric(10),
fa_developer_key varchar(100) not null,
fa_description_s varchar(240),
fa_description_mn numeric(10),
fa_data_type numeric(2) not null,
fa_optional numeric(1) not null,
fa_position numeric(22) not null,
fa_fun_id numeric(10) not null,
fa_user_prop2 varchar(100),
fa_user_prop1 varchar(100),
fa_element_state numeric(10) not null,
fa_created_by varchar(64) not null,
fa_created_date timestamp(0) not null,
fa_updated_by varchar(64),
fa_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments add constraint eul4_fa_uk_3 unique (fa_name_mn,fa_name_s,fa_fun_id);
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments add constraint eul4_fa_uk_1 unique (fa_developer_key,fa_fun_id);
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments add constraint eul4_fa_pk primary key (fa_id);
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments add constraint eul4_fa_uk_2 unique (fa_position,fa_fun_id);
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments add constraint eul4_fa_check_1 check (    fa_name_s is not null or fa_name_mn is not null);
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments add constraint eul4_fa_check_2 check (    fa_data_type in (0,1,2,3,4,5,6,7,8,9,10,11,12,13));
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments add constraint eul4_fa_check_3 check (    fa_optional in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments alter column fa_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments alter column fa_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments alter column fa_data_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments alter column fa_optional set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments alter column fa_position set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments alter column fa_fun_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments alter column fa_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments alter column fa_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments alter column fa_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_arguments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_arguments add constraint eul4_fa_fun_fk foreign key (fa_fun_id) references eul4_functions(fun_id) on delete no action not deferrable initially immediate;
