-- dmap_object_gen_tag : type : table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_obj_join_usgs"  (
oju_id numeric(10) not null,
oju_obj_id numeric(10),
oju_join_modified numeric(1) not null,
oju_key_id numeric(10) not null,
oju_sumo_id numeric(10),
oju_element_state numeric(10) not null,
oju_created_by varchar(64) not null,
oju_created_date timestamp(0) not null,
oju_updated_by varchar(64),
oju_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs add constraint eul4_oju_pk primary key (oju_id);
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs add constraint eul4_oju_uk_1 unique (oju_obj_id,oju_key_id,oju_sumo_id);
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs add constraint eul4_oju_check_1 check (    (oju_obj_id is null and oju_sumo_id is not null)    or (oju_obj_id is not null and oju_sumo_id is null));
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs add constraint eul4_oju_check_2 check (    oju_join_modified in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs alter column oju_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs alter column oju_join_modified set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs alter column oju_key_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs alter column oju_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs alter column oju_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs alter column oju_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs add constraint eul4_oju_cobj_fk foreign key (oju_obj_id) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs add constraint eul4_oju_fk_fk foreign key (oju_key_id) references eul4_key_cons(key_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_join_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_join_usgs add constraint eul4_oju_sumo_fk foreign key (oju_sumo_id) references eul4_summary_objs(sumo_id) on delete no action not deferrable initially immediate;
