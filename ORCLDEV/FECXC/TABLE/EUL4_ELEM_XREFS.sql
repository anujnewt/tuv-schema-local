-- dmap_object_gen_tag : type : table name : eul4_elem_xrefs
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_elem_xrefs"  (
ex_id numeric(10) not null,
ex_type numeric(2) not null,
ex_ref1 varchar(100) not null,
ex_el_type varchar(10) not null,
ex_el_id numeric(10) not null,
ex_ref2 varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_elem_xrefs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_elem_xrefs add constraint eul4_ex_pk primary key (ex_id);
-- dmap_object_gen_tag : type : alter table name : eul4_elem_xrefs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_elem_xrefs alter column ex_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_elem_xrefs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_elem_xrefs alter column ex_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_elem_xrefs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_elem_xrefs alter column ex_ref1 set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_elem_xrefs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_elem_xrefs alter column ex_el_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_elem_xrefs
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_elem_xrefs alter column ex_el_id set not null;
