-- dmap_object_gen_tag : type : table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_access_privs"  (
ap_id numeric(10) not null,
ap_type varchar(10) not null,
ap_eu_id numeric(10) not null,
ap_priv_level numeric(2) not null,
gp_app_id numeric(10),
gba_ba_id numeric(10),
gd_doc_id numeric(10),
ap_element_state numeric(10) not null,
ap_created_by varchar(64) not null,
ap_created_date timestamp(0) not null,
ap_updated_by varchar(64),
ap_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs add constraint eul4_ap_uk_1 unique (gp_app_id,gba_ba_id,gd_doc_id,ap_eu_id);
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs add constraint eul4_ap_pk primary key (ap_id);
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs add constraint eul4_ap_check_1 check (    ap_type in ( 'GBA' , 'GP', 'GD' ));
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs add constraint eul4_ap_check_2 check (    ap_priv_level in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs alter column ap_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs alter column ap_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs alter column ap_eu_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs alter column ap_priv_level set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs alter column ap_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs alter column ap_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs alter column ap_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs add constraint eul4_ap_eu_fk foreign key (ap_eu_id) references eul4_eul_users(eu_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs add constraint eul4_gba_ba_fk foreign key (gba_ba_id) references eul4_bas(ba_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs add constraint eul4_gd_doc_fk foreign key (gd_doc_id) references eul4_documents(doc_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_access_privs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_access_privs add constraint eul4_gp_pri_fk foreign key (gp_app_id) references eul4_app_params(app_id) on delete no action not deferrable initially immediate;
