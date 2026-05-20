-- dmap_object_gen_tag : type : table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_key_cons"  (
key_id numeric(10) not null,
key_type varchar(10) not null,
key_name varchar(100) not null,
key_developer_key varchar(100) not null,
key_description varchar(240),
key_ext_key varchar(64),
key_obj_id numeric(10) not null,
uk_primary numeric(1),
fk_key_id_remote numeric(10),
fk_obj_id_remote numeric(10),
fk_one_to_one numeric(1),
fk_mstr_no_detail numeric(1),
fk_dtl_no_master numeric(1),
fk_mandatory numeric(1),
key_user_prop2 varchar(100),
key_user_prop1 varchar(100),
key_element_state numeric(10) not null,
key_created_by varchar(64) not null,
key_created_date timestamp(0) not null,
key_updated_by varchar(64),
key_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_uk_1 unique (key_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_pk primary key (key_id);
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_uk_2 unique (key_name);
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_check_1 check (    key_type in ( 'UK' , 'FK' ));
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_check_2 check (    key_type != 'FK'    or    key_obj_id != fk_obj_id_remote);
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_check_3 check (    key_type != 'FK'    or    fk_mandatory = 0    or    fk_dtl_no_master = 0);
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_check_4 check (    fk_mandatory in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_check_5 check (    fk_one_to_one in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_check_6 check (    fk_mstr_no_detail in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_check_7 check (    fk_dtl_no_master in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_check_8 check (    uk_primary in (0,1));
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons alter column key_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons alter column key_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons alter column key_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons alter column key_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons alter column key_obj_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons alter column key_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons alter column key_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons alter column key_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_fk_obj_fk foreign key (fk_obj_id_remote) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_fk_uk_fk foreign key (fk_key_id_remote) references eul4_key_cons(key_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_key_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_key_cons add constraint eul4_key_obj_fk foreign key (key_obj_id) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
