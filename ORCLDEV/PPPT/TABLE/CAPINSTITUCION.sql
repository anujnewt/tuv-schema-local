-- dmap_object_gen_tag : type : table name : capinstitucion
set search_path = pppt,oracle,dmap_extension,public;
create table "capinstitucion"  (
idinstitucion numeric(38) not null default 0,
institucion varchar(100) not null,
idempresa numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : capinstitucion
set search_path = pppt,oracle,dmap_extension,public;
alter table capinstitucion alter column idinstitucion set not null;
-- dmap_object_gen_tag : type : alter table name : capinstitucion
set search_path = pppt,oracle,dmap_extension,public;
alter table capinstitucion alter column institucion set not null;
-- dmap_object_gen_tag : type : alter table name : capinstitucion
set search_path = pppt,oracle,dmap_extension,public;
alter table capinstitucion alter column idempresa set not null;
