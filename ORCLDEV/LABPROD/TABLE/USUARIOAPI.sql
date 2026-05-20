-- dmap_object_gen_tag : type : table name : usuarioapi
set search_path = labprod,oracle,dmap_extension,public;
create table "usuarioapi"  (
id numeric not null,
usuario varchar(30) not null,
"password" varchar(60) not null,
nombre varchar(60) not null,
estatus varchar(1) not null,
rol varchar(30) not null
) ;
-- dmap_object_gen_tag : type : alter table name : usuarioapi
set search_path = labprod,oracle,dmap_extension,public;
alter table usuarioapi alter column id set not null;
-- dmap_object_gen_tag : type : alter table name : usuarioapi
set search_path = labprod,oracle,dmap_extension,public;
alter table usuarioapi alter column usuario set not null;
-- dmap_object_gen_tag : type : alter table name : usuarioapi
set search_path = labprod,oracle,dmap_extension,public;
alter table usuarioapi alter column password set not null;
-- dmap_object_gen_tag : type : alter table name : usuarioapi
set search_path = labprod,oracle,dmap_extension,public;
alter table usuarioapi alter column nombre set not null;
-- dmap_object_gen_tag : type : alter table name : usuarioapi
set search_path = labprod,oracle,dmap_extension,public;
alter table usuarioapi alter column estatus set not null;
-- dmap_object_gen_tag : type : alter table name : usuarioapi
set search_path = labprod,oracle,dmap_extension,public;
alter table usuarioapi alter column rol set not null;
