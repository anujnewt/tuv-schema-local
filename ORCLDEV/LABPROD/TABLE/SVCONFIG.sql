-- dmap_object_gen_tag : type : table name : svconfig
set search_path = labprod,oracle,dmap_extension,public;
create table "svconfig"  (
nom_param varchar(60) not null,
val_param numeric not null,
des_param varchar(60) not null
) ;
-- dmap_object_gen_tag : type : alter table name : svconfig
set search_path = labprod,oracle,dmap_extension,public;
alter table svconfig alter column nom_param set not null;
-- dmap_object_gen_tag : type : alter table name : svconfig
set search_path = labprod,oracle,dmap_extension,public;
alter table svconfig alter column val_param set not null;
-- dmap_object_gen_tag : type : alter table name : svconfig
set search_path = labprod,oracle,dmap_extension,public;
alter table svconfig alter column des_param set not null;
