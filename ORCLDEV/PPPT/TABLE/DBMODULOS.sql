-- dmap_object_gen_tag : type : table name : dbmodulos
set search_path = pppt,oracle,dmap_extension,public;
create table "dbmodulos"  (
idmodulo numeric(38) not null,
modulo varchar(50),
tipomodulo numeric(38),
activo numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : dbmodulos
set search_path = pppt,oracle,dmap_extension,public;
alter table dbmodulos alter column idmodulo set not null;
