-- dmap_object_gen_tag : type : table name : eul4_batch_queries
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_batch_queries"  (
bq_id numeric(10) not null,
bq_bs_id numeric(10) not null,
bq_query_id varchar(240) not null,
bq_result_sql_1 varchar(250),
bq_result_sql_2 varchar(250),
bq_result_sql_3 varchar(250),
bq_result_sql_4 varchar(250),
bq_element_state numeric(10) not null,
bq_created_by varchar(64) not null,
bq_created_date timestamp(0) not null,
bq_updated_by varchar(64),
bq_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_queries add constraint eul4_bq_pk primary key (bq_id);
-- dmap_object_gen_tag : type : alter table name : eul4_batch_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_queries add constraint eul4_bq_uk_1 unique (bq_bs_id,bq_query_id);
-- dmap_object_gen_tag : type : alter table name : eul4_batch_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_queries alter column bq_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_queries alter column bq_bs_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_queries alter column bq_query_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_queries alter column bq_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_queries alter column bq_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_queries alter column bq_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_queries add constraint eul4_bq_bs_fk foreign key (bq_bs_id) references eul4_batch_sheets(bs_id) on delete no action not deferrable initially immediate;
