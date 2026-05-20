-- dmap_object_gen_tag : type : table name : dbpermisos
set search_path = pppt,oracle,dmap_extension,public;
create table "dbpermisos"  (
idusuario numeric(38) not null,
idmodulo numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : dbpermisos
set search_path = pppt,oracle,dmap_extension,public;
alter table dbpermisos alter column idusuario set not null;
-- dmap_object_gen_tag : type : alter table name : dbpermisos
set search_path = pppt,oracle,dmap_extension,public;
alter table dbpermisos alter column idmodulo set not null;
