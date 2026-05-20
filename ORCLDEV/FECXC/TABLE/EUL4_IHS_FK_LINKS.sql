-- dmap_object_gen_tag : type : table name : eul4_ihs_fk_links
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_ihs_fk_links"  (
ifl_id numeric(10) not null,
ifl_ihs_id numeric(10) not null,
ifl_key_id numeric(10) not null,
ifl_element_state numeric(10) not null,
ifl_created_by varchar(64) not null,
ifl_created_date timestamp(0) not null,
ifl_updated_by varchar(64),
ifl_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_ihs_fk_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ihs_fk_links add constraint eul4_ifl_pk primary key (ifl_id);
-- dmap_object_gen_tag : type : alter table name : eul4_ihs_fk_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ihs_fk_links add constraint eul4_ifl_uk_1 unique (ifl_key_id,ifl_ihs_id);
-- dmap_object_gen_tag : type : alter table name : eul4_ihs_fk_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ihs_fk_links alter column ifl_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ihs_fk_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ihs_fk_links alter column ifl_ihs_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ihs_fk_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ihs_fk_links alter column ifl_key_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ihs_fk_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ihs_fk_links alter column ifl_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ihs_fk_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ihs_fk_links alter column ifl_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ihs_fk_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ihs_fk_links alter column ifl_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ihs_fk_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ihs_fk_links add constraint eul4_ifl_fk_fk foreign key (ifl_key_id) references eul4_key_cons(key_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_ihs_fk_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ihs_fk_links add constraint eul4_ifl_ihs_fk foreign key (ifl_ihs_id) references eul4_hi_segments(hs_id) on delete no action not deferrable initially immediate;
