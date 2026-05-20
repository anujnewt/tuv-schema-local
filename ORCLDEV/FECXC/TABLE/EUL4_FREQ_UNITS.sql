-- dmap_object_gen_tag : type : table name : eul4_freq_units
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_freq_units"  (
rfu_id numeric(10) not null,
rfu_name_mn numeric(10) not null,
rfu_sql_expression varchar(240) not null,
rfu_sequence numeric(22),
rfu_element_state numeric(10) not null,
rfu_created_by varchar(64) not null,
rfu_created_date timestamp(0) not null,
rfu_updated_by varchar(64),
rfu_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_freq_units
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_freq_units add constraint eul4_rfu_uk_1 unique (rfu_name_mn);
-- dmap_object_gen_tag : type : alter table name : eul4_freq_units
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_freq_units add constraint eul4_rfu_pk primary key (rfu_id);
-- dmap_object_gen_tag : type : alter table name : eul4_freq_units
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_freq_units alter column rfu_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_freq_units
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_freq_units alter column rfu_name_mn set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_freq_units
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_freq_units alter column rfu_sql_expression set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_freq_units
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_freq_units alter column rfu_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_freq_units
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_freq_units alter column rfu_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_freq_units
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_freq_units alter column rfu_created_date set not null;
