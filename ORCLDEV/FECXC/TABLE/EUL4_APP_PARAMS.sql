-- dmap_object_gen_tag : type : table name : eul4_app_params
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_app_params"  (
app_id numeric(10) not null,
app_type varchar(10) not null,
app_name_mn numeric(10) not null,
app_description_mn numeric(10) not null,
sp_default_value varchar(240),
sp_value varchar(240),
app_element_state numeric(10) not null,
app_created_by varchar(64) not null,
app_created_date timestamp(0) not null,
app_updated_by varchar(64),
app_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_app_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_app_params add constraint eul4_app_uk_1 unique (app_name_mn);
-- dmap_object_gen_tag : type : alter table name : eul4_app_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_app_params add constraint eul4_app_pk primary key (app_id);
-- dmap_object_gen_tag : type : alter table name : eul4_app_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_app_params add constraint eul4_app_check_1 check (    app_type in ( 'PRI' , 'SP' ));
-- dmap_object_gen_tag : type : alter table name : eul4_app_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_app_params alter column app_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_app_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_app_params alter column app_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_app_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_app_params alter column app_name_mn set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_app_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_app_params alter column app_description_mn set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_app_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_app_params alter column app_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_app_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_app_params alter column app_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_app_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_app_params alter column app_created_date set not null;
