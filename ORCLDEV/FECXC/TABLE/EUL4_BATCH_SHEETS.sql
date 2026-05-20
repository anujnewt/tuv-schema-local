-- dmap_object_gen_tag : type : table name : eul4_batch_sheets
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_batch_sheets"  (
bs_id numeric(10) not null,
bs_br_id numeric(10) not null,
bs_sheet_name varchar(240) not null,
bs_sheet_id varchar(240) not null,
bs_element_state numeric(10) not null,
bs_created_by varchar(64) not null,
bs_created_date timestamp(0) not null,
bs_updated_by varchar(64),
bs_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_sheets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_sheets add constraint eul4_bs_pk primary key (bs_id);
-- dmap_object_gen_tag : type : alter table name : eul4_batch_sheets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_sheets add constraint eul4_bs_uk_1 unique (bs_br_id,bs_sheet_id);
-- dmap_object_gen_tag : type : alter table name : eul4_batch_sheets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_sheets alter column bs_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_sheets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_sheets alter column bs_br_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_sheets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_sheets alter column bs_sheet_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_sheets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_sheets alter column bs_sheet_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_sheets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_sheets alter column bs_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_sheets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_sheets alter column bs_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_sheets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_sheets alter column bs_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_batch_sheets
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_batch_sheets add constraint eul4_bs_br_fk foreign key (bs_br_id) references eul4_batch_reports(br_id) on delete no action not deferrable initially immediate;
