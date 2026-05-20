-- dmap_object_gen_tag : type : table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_sumo_exp_usgs"  (
seu_id numeric(10) not null,
seu_type varchar(10) not null,
seu_sumo_id numeric(10) not null,
seu_ext_column varchar(64),
seu_visible numeric(1) not null,
siu_exp_id numeric(10),
siu_item_modified numeric(1),
smiu_fun_id numeric(10),
sfu_fun_id numeric(10),
seu_element_state numeric(10) not null,
seu_created_by varchar(64) not null,
seu_created_date timestamp(0) not null,
seu_updated_by varchar(64),
seu_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs add constraint eul4_seu_pk primary key (seu_id);
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs add constraint eul4_seu_uk_1 unique (seu_type,seu_sumo_id,siu_exp_id,smiu_fun_id,sfu_fun_id);
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs add constraint eul4_seu_check_1 check (    seu_type in ( 'SAIU' , 'SMIU' , 'SFU' ));
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs add constraint eul4_seu_check_2 check (    siu_item_modified in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs add constraint eul4_seu_check_3 check (    seu_visible in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs alter column seu_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs alter column seu_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs alter column seu_sumo_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs alter column seu_visible set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs alter column seu_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs alter column seu_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs alter column seu_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs add constraint eul4_seu_sumo_fk foreign key (seu_sumo_id) references eul4_summary_objs(sumo_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs add constraint eul4_sfu_fun_fk foreign key (sfu_fun_id) references eul4_functions(fun_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs add constraint eul4_siu_it_fk foreign key (siu_exp_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_sumo_exp_usgs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sumo_exp_usgs add constraint eul4_smiu_fun_fk foreign key (smiu_fun_id) references eul4_functions(fun_id) on delete no action not deferrable initially immediate;
