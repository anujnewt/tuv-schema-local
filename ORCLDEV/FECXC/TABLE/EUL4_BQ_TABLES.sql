-- dmap_object_gen_tag : type : table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_bq_tables"  (
bqt_id numeric(10) not null,
bqt_bq_id numeric(10) not null,
bqt_brr_id numeric(10) not null,
bqt_table_name varchar(64) not null,
bqt_element_state numeric(10) not null,
bqt_created_by varchar(64) not null,
bqt_created_date timestamp(0) not null,
bqt_updated_by varchar(64),
bqt_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables add constraint eul4_bqt_uk_1 unique (bqt_table_name);
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables add constraint eul4_bqt_uk_2 unique (bqt_bq_id,bqt_brr_id);
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables add constraint eul4_bqt_pk primary key (bqt_id);
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables alter column bqt_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables alter column bqt_bq_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables alter column bqt_brr_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables alter column bqt_table_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables alter column bqt_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables alter column bqt_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables alter column bqt_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables add constraint eul4_bqt_bq_fk foreign key (bqt_bq_id) references eul4_batch_queries(bq_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_tables
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_tables add constraint eul4_bqt_brr_fk foreign key (bqt_brr_id) references eul4_br_runs(brr_id) on delete no action not deferrable initially immediate;
