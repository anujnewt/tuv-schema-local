-- dmap_object_gen_tag : type : table name : tvdiaobl
set search_path = labconf,oracle,dmap_extension,public;
create table "tvdiaobl"  (
dob_fecha timestamp(0) not null,
dob_descri varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : tvdiaobl
set search_path = labconf,oracle,dmap_extension,public;
alter table tvdiaobl alter column dob_fecha set not null;
