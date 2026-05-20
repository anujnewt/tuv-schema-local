-- dmap_object_gen_tag : type : table name : eul4_versions
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_versions"  (
ver_name varchar(100),
ver_description varchar(240),
ver_release varchar(30) not null,
ver_min_code_ver varchar(30) not null,
ver_eul_timestamp varchar(30) not null,
ver_sa numeric(22)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_versions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_versions alter column ver_release set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_versions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_versions alter column ver_min_code_ver set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_versions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_versions alter column ver_eul_timestamp set not null;
