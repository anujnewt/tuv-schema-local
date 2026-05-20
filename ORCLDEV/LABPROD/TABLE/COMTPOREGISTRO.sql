-- dmap_object_gen_tag : type : table name : comtporegistro
set search_path = labprod,oracle,dmap_extension,public;
create table "comtporegistro"  (
numtporeg numeric(38) not null default 0,
destporeg char(60) not null default ' '
) ;
-- dmap_object_gen_tag : type : alter table name : comtporegistro
set search_path = labprod,oracle,dmap_extension,public;
alter table comtporegistro alter column numtporeg set not null;
-- dmap_object_gen_tag : type : alter table name : comtporegistro
set search_path = labprod,oracle,dmap_extension,public;
alter table comtporegistro alter column destporeg set not null;
