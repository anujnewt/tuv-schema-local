-- dmap_object_gen_tag : type : table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_functions"  (
fun_id numeric(10) not null,
fun_name varchar(100) not null,
fun_developer_key varchar(100) not null,
fun_description_s varchar(240),
fun_description_mn numeric(10),
fun_function_type numeric(2) not null,
fun_hidden numeric(1) not null,
fun_data_type numeric(2) not null,
fun_available numeric(1) not null,
fun_maximum_args numeric(22),
fun_minimum_args numeric(22) not null,
fun_built_in numeric(1) not null,
fun_ext_name varchar(64) not null,
fun_ext_package varchar(64),
fun_ext_owner varchar(64),
fun_ext_db_link varchar(64),
fun_user_prop2 varchar(100),
fun_user_prop1 varchar(100),
fun_element_state numeric(10) not null,
fun_created_by varchar(64) not null,
fun_created_date timestamp(0) not null,
fun_updated_by varchar(64),
fun_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions add constraint eul4_fun_uk_2 unique (fun_name);
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions add constraint eul4_fun_pk primary key (fun_id);
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions add constraint eul4_fun_uk_1 unique (fun_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions add constraint eul4_fun_check_1 check (    coalesce(fun_maximum_args,fun_minimum_args) >= fun_minimum_args);
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions add constraint eul4_fun_check_2 check (    fun_function_type in (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14));
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions add constraint eul4_fun_check_3 check (    fun_hidden in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions add constraint eul4_fun_check_4 check (    fun_data_type in (0,1,2,3,4,5,6,7,8,9,10,11,12,13));
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions add constraint eul4_fun_check_5 check (    fun_available in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions add constraint eul4_fun_check_6 check (    fun_built_in in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_function_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_hidden set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_data_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_available set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_minimum_args set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_built_in set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_ext_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_functions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_functions alter column fun_created_date set not null;
