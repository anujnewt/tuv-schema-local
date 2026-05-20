-- dmap_object_gen_tag : type : table name : conductanivel360
set search_path = pppt,oracle,dmap_extension,public;
create table "conductanivel360"  (
idconducta numeric(38) not null,
nivel numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : conductanivel360
set search_path = pppt,oracle,dmap_extension,public;
alter table conductanivel360 alter column idconducta set not null;
-- dmap_object_gen_tag : type : alter table name : conductanivel360
set search_path = pppt,oracle,dmap_extension,public;
alter table conductanivel360 alter column nivel set not null;
