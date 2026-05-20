-- dmap_object_gen_tag : type : table name : eolodest
set search_path = labconf,oracle,dmap_extension,public;
create table "eolodest"  (
des_keyest varchar(5) not null,
des_desest varchar(40),
des_tipest varchar(1) not null
) ;
-- dmap_object_gen_tag : type : alter table name : eolodest
set search_path = labconf,oracle,dmap_extension,public;
alter table eolodest alter column des_keyest set not null;
-- dmap_object_gen_tag : type : alter table name : eolodest
set search_path = labconf,oracle,dmap_extension,public;
alter table eolodest alter column des_tipest set not null;
