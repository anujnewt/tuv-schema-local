-- dmap_object_gen_tag : type : table name : eul4_ba_obj_links
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_ba_obj_links"  (
bol_id numeric(10) not null,
bol_ba_id numeric(10) not null,
bol_obj_id numeric(10) not null,
bol_sequence numeric(22),
bol_element_state numeric(10) not null,
bol_created_by varchar(64) not null,
bol_created_date timestamp(0) not null,
bol_updated_by varchar(64),
bol_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_ba_obj_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ba_obj_links add constraint eul4_bol_pk primary key (bol_id);
-- dmap_object_gen_tag : type : alter table name : eul4_ba_obj_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ba_obj_links add constraint eul4_bol_uk_1 unique (bol_ba_id,bol_obj_id);
-- dmap_object_gen_tag : type : alter table name : eul4_ba_obj_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ba_obj_links alter column bol_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ba_obj_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ba_obj_links alter column bol_ba_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ba_obj_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ba_obj_links alter column bol_obj_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ba_obj_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ba_obj_links alter column bol_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ba_obj_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ba_obj_links alter column bol_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ba_obj_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ba_obj_links alter column bol_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ba_obj_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ba_obj_links add constraint eul4_bol_ba_fk foreign key (bol_ba_id) references eul4_bas(ba_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_ba_obj_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ba_obj_links add constraint eul4_bol_obj_fk foreign key (bol_obj_id) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
