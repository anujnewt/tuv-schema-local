-- dmap_object_gen_tag : type : table name : sino
set search_path = pppt,oracle,dmap_extension,public;
create table "sino"  (
idsino numeric(38) not null,
sino varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : sino
set search_path = pppt,oracle,dmap_extension,public;
alter table sino alter column idsino set not null;
