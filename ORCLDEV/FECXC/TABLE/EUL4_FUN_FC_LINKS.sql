-- dmap_object_gen_tag : type : table name : eul4_fun_fc_links
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_fun_fc_links"  (
ffl_id numeric(10) not null,
ffl_fun_id numeric(10) not null,
ffl_fc_id numeric(10) not null,
ffl_element_state numeric(10) not null,
ffl_created_by varchar(64) not null,
ffl_created_date timestamp(0) not null,
ffl_updated_by varchar(64),
ffl_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_fc_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_fc_links add constraint eul4_ffl_uk_1 unique (ffl_fun_id,ffl_fc_id);
-- dmap_object_gen_tag : type : alter table name : eul4_fun_fc_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_fc_links add constraint eul4_ffl_pk primary key (ffl_id);
-- dmap_object_gen_tag : type : alter table name : eul4_fun_fc_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_fc_links alter column ffl_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_fc_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_fc_links alter column ffl_fun_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_fc_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_fc_links alter column ffl_fc_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_fc_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_fc_links alter column ffl_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_fc_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_fc_links alter column ffl_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_fc_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_fc_links alter column ffl_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_fc_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_fc_links add constraint eul4_ffl_fc_fk foreign key (ffl_fc_id) references eul4_fun_ctgs(fc_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_fun_fc_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_fun_fc_links add constraint eul4_ffl_fun_fk foreign key (ffl_fun_id) references eul4_functions(fun_id) on delete no action not deferrable initially immediate;
