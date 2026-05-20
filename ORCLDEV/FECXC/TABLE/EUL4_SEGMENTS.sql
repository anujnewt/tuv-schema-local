-- dmap_object_gen_tag : type : table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_segments"  (
seg_id numeric(10) not null,
seg_seg_type numeric(1) not null,
seg_sequence numeric(22) not null,
seg_obj_id numeric(10),
seg_sumo_id numeric(10),
seg_cuo_id numeric(10),
seg_bq_id numeric(10),
seg_exp_id numeric(10),
seg_sms_id numeric(10),
seg_el_id numeric(10),
seg_chunk1 varchar(250),
seg_chunk2 varchar(250),
seg_chunk3 varchar(250),
seg_chunk4 varchar(250),
seg_element_state numeric(10) not null,
seg_created_by varchar(64) not null,
seg_created_date timestamp(0) not null,
seg_updated_by varchar(64),
seg_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments add constraint eul4_seg_uk_1 unique (seg_sumo_id,seg_seg_type,seg_sequence,seg_obj_id,seg_cuo_id,seg_bq_id,seg_exp_id,seg_sms_id,seg_el_id);
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments add constraint eul4_seg_pk primary key (seg_id);
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments add constraint eul4_seg_check_1 check (    (seg_obj_id is null or seg_seg_type in (1,2))    and (seg_sumo_id is null or seg_seg_type = 3)    and (seg_bq_id is null or seg_seg_type = 4)    and (seg_cuo_id is null or seg_seg_type = 5)    and (seg_exp_id is null or seg_seg_type = 6)    and (seg_sms_id is null or seg_seg_type = 7)    and (seg_el_id is null or seg_seg_type > 7));
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments add constraint eul4_seg_check_2 check (    seg_obj_id is not null    or seg_sumo_id is not null    or seg_bq_id is not null    or seg_cuo_id is not null    or seg_exp_id is not null    or seg_sms_id is not null    or seg_el_id is not null);
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments alter column seg_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments alter column seg_seg_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments alter column seg_sequence set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments alter column seg_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments alter column seg_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments alter column seg_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments add constraint eul4_seg_bq_fk foreign key (seg_bq_id) references eul4_batch_queries(bq_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments add constraint eul4_seg_cuo_fk foreign key (seg_cuo_id) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments add constraint eul4_seg_exp_fk foreign key (seg_exp_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments add constraint eul4_seg_obj_fk foreign key (seg_obj_id) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments add constraint eul4_seg_sdo_fk foreign key (seg_sumo_id) references eul4_summary_objs(sumo_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_segments
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_segments add constraint eul4_seg_sms_fk foreign key (seg_sms_id) references eul4_summary_objs(sumo_id) on delete no action not deferrable initially immediate;
