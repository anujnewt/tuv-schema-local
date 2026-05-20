-- dmap_object_gen_tag : type : table name : eul4_batch_params
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_batch_params"  (
bp_id numeric(10) not null,
bp_name varchar(100) not null,
bp_value1 varchar(250) not null,
bp_value2 varchar(250),
bp_value3 varchar(250),
bp_value4 varchar(250),
bp_value5 varchar(250),
bp_value6 varchar(250),
bp_bs_id numeric(10) not null,
bp_element_state numeric(10) not null,
bp_created_by varchar(64) not null,
bp_created_date timestamp(0) not null,
bp_updated_by varchar(64),
bp_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_params add constraint eul4_bp_pk primary key (bp_id);
-- dmap_object_gen_tag : type : alter table name : eul4_batch_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_params add constraint eul4_bp_uk_1 unique (bp_bs_id,bp_name);
-- dmap_object_gen_tag : type : alter table name : eul4_batch_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_params alter column bp_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_params alter column bp_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_params alter column bp_value1 set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_params alter column bp_bs_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_params alter column bp_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_params alter column bp_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_params alter column bp_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_params add constraint eul4_bp_bs_fk foreign key (bp_bs_id) references eul4_batch_sheets(bs_id) on delete no action not deferrable initially immediate;
