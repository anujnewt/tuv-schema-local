-- dmap_object_gen_tag : type : table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_asmp_cons"  (
apc_id numeric(10) not null,
apc_type varchar(10) not null,
apc_cons_type numeric(2) not null,
apc_asmp_id numeric(10) not null,
aoc_obj_id numeric(10),
asoc_sumo_id numeric(10),
auc_eu_id numeric(10),
apc_element_state numeric(10) not null,
apc_created_by varchar(64) not null,
apc_created_date timestamp(0) not null,
apc_updated_by varchar(64),
apc_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons add constraint eul4_apc_pk primary key (apc_id);
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons add constraint eul4_apc_uk_1 unique (apc_asmp_id,asoc_sumo_id,auc_eu_id,aoc_obj_id);
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons add constraint eul4_apc_check_1 check (    apc_type in ('AOC','ASOC','AUC'));
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons add constraint eul4_apc_check_2 check (    apc_cons_type in (1,2));
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons alter column apc_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons alter column apc_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons alter column apc_cons_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons alter column apc_asmp_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons alter column apc_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons alter column apc_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons alter column apc_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons add constraint eul4_aoc_obj_fk foreign key (aoc_obj_id) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons add constraint eul4_apc_asmp_fk foreign key (apc_asmp_id) references eul4_asm_policies(asmp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons add constraint eul4_asoc_sumo_fk foreign key (asoc_sumo_id) references eul4_summary_objs(sumo_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_asmp_cons
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asmp_cons add constraint eul4_auc_eu_fk foreign key (auc_eu_id) references eul4_eul_users(eu_id) on delete no action not deferrable initially immediate;
