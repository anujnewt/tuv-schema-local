-- dmap_object_gen_tag : type : table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_sub_queries"  (
sq_id numeric(10) not null,
sq_name varchar(100) not null,
sq_developer_key varchar(100) not null,
sq_description varchar(240),
sq_obj_id numeric(10) not null,
sq_it_id numeric(10) not null,
sq_fil_id numeric(10) not null,
sq_user_prop2 varchar(100),
sq_user_prop1 varchar(100),
sq_element_state numeric(10) not null,
sq_created_by varchar(64) not null,
sq_created_date timestamp(0) not null,
sq_updated_by varchar(64),
sq_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries add constraint eul4_sq_uk_1 unique (sq_fil_id,sq_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries add constraint eul4_sq_pk primary key (sq_id);
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries add constraint eul4_sq_uk_2 unique (sq_fil_id,sq_name);
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries alter column sq_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries alter column sq_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries alter column sq_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries alter column sq_obj_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries alter column sq_it_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries alter column sq_fil_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries alter column sq_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries alter column sq_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries alter column sq_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries add constraint eul4_sq_fil_fk foreign key (sq_fil_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries add constraint eul4_sq_it_fk foreign key (sq_it_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_sub_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sub_queries add constraint eul4_sq_obj_fk foreign key (sq_obj_id) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
