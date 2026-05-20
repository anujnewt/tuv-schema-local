-- dmap_object_gen_tag : type : table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_asmp_logs"  (
apl_id numeric(10) not null,
apl_timestamp timestamp(0) not null,
apl_event_type numeric(2) not null,
apl_asmp_id numeric(10) not null,
apl_sumo_id numeric(10),
apl_element_state numeric(10) not null,
apl_created_by varchar(64) not null,
apl_created_date timestamp(0) not null,
apl_updated_by varchar(64),
apl_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_logs add constraint eul4_apl_pk primary key (apl_id);
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_logs add constraint eul4_apl_check_1 check (    apl_event_type in (0,1,2));
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_logs alter column apl_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_logs alter column apl_timestamp set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_logs alter column apl_event_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_logs alter column apl_asmp_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_logs alter column apl_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_logs alter column apl_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_logs alter column apl_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_logs add constraint eul4_apl_asmp_fk foreign key (apl_asmp_id) references eul4_asm_policies(asmp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_logs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_logs add constraint eul4_apl_sumo_fk foreign key (apl_sumo_id) references eul4_summary_objs(sumo_id) on delete no action not deferrable initially immediate;
