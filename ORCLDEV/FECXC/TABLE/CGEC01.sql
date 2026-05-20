-- dmap_object_gen_tag : type : table name : cgec01
set search_path = fecxc,oracle,dmap_extension,public;
create table "cgec01"  (
cgecbat numeric(38) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cgec01
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgec01 alter column cgecbat set not null;
