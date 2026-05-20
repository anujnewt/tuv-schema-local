-- dmap_object_gen_tag : type : table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_obj_deps"  (
od_id numeric(10) not null,
od_obj_id_from numeric(10) not null,
od_obj_id_to numeric(10) not null,
od_element_state numeric(10) not null,
od_created_by varchar(64) not null,
od_created_date timestamp(0) not null,
od_updated_by varchar(64),
od_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_deps add constraint eul4_od_uk_1 unique (od_obj_id_from,od_obj_id_to);
-- dmap_object_gen_tag : type : alter table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_deps add constraint eul4_od_pk primary key (od_id);
-- dmap_object_gen_tag : type : alter table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_deps add constraint eul4_od_check_1 check (    od_obj_id_from != od_obj_id_to);
-- dmap_object_gen_tag : type : alter table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_deps alter column od_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_deps alter column od_obj_id_from set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_deps alter column od_obj_id_to set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_deps alter column od_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_deps alter column od_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_deps alter column od_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_deps add constraint eul4_od_cobj_fk foreign key (od_obj_id_from) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_obj_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_obj_deps add constraint eul4_od_obj_fk foreign key (od_obj_id_to) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
