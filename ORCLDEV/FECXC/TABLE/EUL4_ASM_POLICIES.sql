-- dmap_object_gen_tag : type : table name : eul4_asm_policies
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_asm_policies"  (
asmp_id numeric(10) not null,
asmp_name varchar(100) not null,
asmp_developer_key varchar(100) not null,
asmp_description varchar(240),
asmp_user_prop1 varchar(100),
asmp_user_prop2 varchar(100),
asmp_element_state numeric(10) not null,
asmp_created_by varchar(64) not null,
asmp_created_date timestamp(0) not null,
asmp_updated_by varchar(64),
asmp_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_asm_policies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asm_policies add constraint eul4_asmp_uk_2 unique (asmp_name);
-- dmap_object_gen_tag : type : alter table name : eul4_asm_policies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asm_policies add constraint eul4_asmp_pk primary key (asmp_id);
-- dmap_object_gen_tag : type : alter table name : eul4_asm_policies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asm_policies add constraint eul4_asmp_uk_1 unique (asmp_developer_key);
-- dmap_object_gen_tag : type : alter table name : eul4_asm_policies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asm_policies alter column asmp_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asm_policies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asm_policies alter column asmp_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asm_policies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asm_policies alter column asmp_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asm_policies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asm_policies alter column asmp_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asm_policies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asm_policies alter column asmp_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_asm_policies
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_asm_policies alter column asmp_created_date set not null;
