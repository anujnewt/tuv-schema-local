-- dmap_object_gen_tag : type : table name : comcias
set search_path = labppto,oracle,dmap_extension,public;
create table "comcias"  (
numcia varchar(4) not null,
nomcia varchar(60) not null
) ;
-- dmap_object_gen_tag : type : alter table name : comcias
set search_path = labppto,oracle,dmap_extension,public;
alter table comcias alter column numcia set not null;
-- dmap_object_gen_tag : type : alter table name : comcias
set search_path = labppto,oracle,dmap_extension,public;
alter table comcias alter column nomcia set not null;
