-- dmap_object_gen_tag : type : table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_objs"  (
obj_id numeric(10) not null,
obj_type varchar(10) not null,
obj_name varchar(100) not null,
obj_developer_key varchar(100) not null,
obj_description varchar(240),
obj_ba_id numeric(10),
obj_hidden numeric(1) not null,
obj_distinct_flag numeric(1) not null,
obj_ndeterministic numeric(1) not null,
obj_cbo_hint varchar(100),
obj_ext_object varchar(64),
obj_ext_owner varchar(64),
obj_ext_db_link varchar(64),
obj_object_sql1 varchar(250),
obj_object_sql2 varchar(250),
obj_object_sql3 varchar(250),
sobj_ext_table varchar(64),
obj_user_prop2 varchar(100),
obj_user_prop1 varchar(100),
obj_element_state numeric(10) not null,
obj_created_by varchar(64) not null,
obj_created_date timestamp(0) not null,
obj_updated_by varchar(64),
obj_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs add constraint eul4_obj_pk primary key (obj_id);
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs add constraint eul4_obj_uk_2 unique (obj_name);
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs add constraint eul4_obj_uk_1 unique (obj_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs add constraint eul4_obj_check_1 check (    obj_type in ( 'COBJ' , 'SOBJ', 'CUO' ));
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs add constraint eul4_obj_check_2 check (    obj_hidden in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs add constraint eul4_obj_check_3 check (    obj_distinct_flag in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs add constraint eul4_obj_check_4 check (    obj_ndeterministic in (0,1));
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs alter column obj_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs alter column obj_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs alter column obj_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs alter column obj_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs alter column obj_hidden set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs alter column obj_distinct_flag set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs alter column obj_ndeterministic set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs alter column obj_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs alter column obj_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs alter column obj_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_objs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_objs add constraint eul4_obj_ba_fk foreign key (obj_ba_id) references eul4_bas(ba_id) on delete no action not deferrable initially immediate;
