-- dmap_object_gen_tag : type : table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_bq_deps"  (
bqd_id numeric(10) not null,
bqd_type varchar(10) not null,
bqd_bq_id numeric(10) not null,
bfild_fil_id numeric(10),
bid_it_id numeric(10),
bfund_fun_id numeric(10),
bqd_element_state numeric(10) not null,
bqd_created_by varchar(64) not null,
bqd_created_date timestamp(0) not null,
bqd_updated_by varchar(64),
bqd_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps add constraint eul4_bqd_uk_1 unique (bqd_type,bqd_bq_id,bfild_fil_id,bid_it_id,bfund_fun_id);
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps add constraint eul4_bqd_pk primary key (bqd_id);
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps add constraint eul4_bqd_check_1 check (    bqd_type in ('BFUND', 'BFILD', 'BID'));
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps alter column bqd_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps alter column bqd_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps alter column bqd_bq_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps alter column bqd_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps alter column bqd_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps alter column bqd_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps add constraint eul4_bfild_fil_fk foreign key (bfild_fil_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps add constraint eul4_bfund_fun_fk foreign key (bfund_fun_id) references eul4_functions(fun_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps add constraint eul4_bid_it_fk foreign key (bid_it_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_bq_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_bq_deps add constraint eul4_bqd_bq_fk foreign key (bqd_bq_id) references eul4_batch_queries(bq_id) on delete no action not deferrable initially immediate;
