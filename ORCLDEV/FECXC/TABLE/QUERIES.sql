-- dmap_object_gen_tag : type : table name : queries
set search_path = fecxc,oracle,dmap_extension,public;
create table "queries"  (
entidad varchar(30) not null,
nombre varchar(50) not null,
usuario varchar(30) not null,
condicion varchar(255) not null,
ordenamiento varchar(255) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table queries add primary key (entidad,nombre,usuario);
-- dmap_object_gen_tag : type : alter table name : queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table queries alter column entidad set not null;
-- dmap_object_gen_tag : type : alter table name : queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table queries alter column nombre set not null;
-- dmap_object_gen_tag : type : alter table name : queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table queries alter column usuario set not null;
-- dmap_object_gen_tag : type : alter table name : queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table queries alter column condicion set not null;
-- dmap_object_gen_tag : type : alter table name : queries
set search_path = fecxc,oracle,dmap_extension,public;
alter table queries alter column ordenamiento set not null;
