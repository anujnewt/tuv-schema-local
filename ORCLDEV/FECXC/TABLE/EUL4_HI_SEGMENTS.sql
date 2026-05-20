-- dmap_object_gen_tag : type : table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_hi_segments"  (
hs_id numeric(10) not null,
hs_type varchar(10) not null,
dhs_hi_id numeric(10),
dhs_dhn_id_child numeric(10),
dhs_dhn_id_parent numeric(10),
ihs_hn_id_child numeric(10),
ihs_hn_id_parent numeric(10),
ihs_hi_id numeric(10),
hs_element_state numeric(10) not null,
hs_created_by varchar(64) not null,
hs_created_date timestamp(0) not null,
hs_updated_by varchar(64),
hs_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments add constraint eul4_hs_pk primary key (hs_id);
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments add constraint eul4_hs_uk_1 unique (ihs_hn_id_child,ihs_hn_id_parent,ihs_hi_id,dhs_hi_id,dhs_dhn_id_child,dhs_dhn_id_parent);
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments add constraint eul4_hs_check_1 check (    (hs_type != 'DHS' or dhs_dhn_id_child != dhs_dhn_id_parent)    and (hs_type != 'IHS' or ihs_hn_id_child != ihs_hn_id_parent));
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments add constraint eul4_hs_check_2 check (    hs_type in ( 'IHS' , 'DHS' ));
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments alter column hs_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments alter column hs_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments alter column hs_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments alter column hs_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments alter column hs_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments add constraint eul4_dhs_dbh_fk foreign key (dhs_hi_id) references eul4_hierarchies(hi_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments add constraint eul4_dhs_dhn_c_fk foreign key (dhs_dhn_id_parent) references eul4_dbh_nodes(dhn_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments add constraint eul4_dhs_dhn_p_fk foreign key (dhs_dhn_id_child) references eul4_dbh_nodes(dhn_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments add constraint eul4_ihs_hn_c_fk foreign key (ihs_hn_id_parent) references eul4_hi_nodes(hn_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments add constraint eul4_ihs_hn_p_fk foreign key (ihs_hn_id_child) references eul4_hi_nodes(hn_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_hi_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_hi_segments add constraint eul4_ihs_ibh_fk foreign key (ihs_hi_id) references eul4_hierarchies(hi_id) on delete no action not deferrable initially immediate;
