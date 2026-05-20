-- dmap_object_gen_tag : type : table name : weaccaut
set search_path = labprod,oracle,dmap_extension,public;
create table "weaccaut"  (
wea_idusua numeric(38) not null,
wea_keyemp numeric(38) not null,
wea_keypro numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : weaccaut
set search_path = labprod,oracle,dmap_extension,public;
alter table weaccaut add primary key (wea_idusua);
-- dmap_object_gen_tag : type : alter table name : weaccaut
set search_path = labprod,oracle,dmap_extension,public;
alter table weaccaut alter column wea_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : weaccaut
set search_path = labprod,oracle,dmap_extension,public;
alter table weaccaut alter column wea_keypro set not null;
