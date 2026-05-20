-- dmap_object_gen_tag : type : table name : co_status
set search_path = pppt,oracle,dmap_extension,public;
create table "co_status"  (
idstatus numeric(38) not null,
status varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : co_status
set search_path = pppt,oracle,dmap_extension,public;
alter table co_status alter column idstatus set not null;
