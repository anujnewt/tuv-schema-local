-- dmap_object_gen_tag : type : table name : entidades
set search_path = fecxc,oracle,dmap_extension,public;
create table "entidades"  (
entidad varchar(30) not null,
descripcion varchar(40) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : entidades
set search_path = fecxc,oracle,dmap_extension,public;
alter table entidades add primary key (entidad);
-- dmap_object_gen_tag : type : alter table name : entidades
set search_path = fecxc,oracle,dmap_extension,public;
alter table entidades alter column entidad set not null;
-- dmap_object_gen_tag : type : alter table name : entidades
set search_path = fecxc,oracle,dmap_extension,public;
alter table entidades alter column descripcion set not null;
