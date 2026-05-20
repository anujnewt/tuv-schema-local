-- dmap_object_gen_tag : type : table name : apirestriccionacceso
set search_path = labprod,oracle,dmap_extension,public;
create table "apirestriccionacceso"  (
usuario varchar(30) not null,
fecha timestamp(0) not null,
accion numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : apirestriccionacceso
set search_path = labprod,oracle,dmap_extension,public;
alter table apirestriccionacceso alter column usuario set not null;
-- dmap_object_gen_tag : type : alter table name : apirestriccionacceso
set search_path = labprod,oracle,dmap_extension,public;
alter table apirestriccionacceso alter column fecha set not null;
-- dmap_object_gen_tag : type : alter table name : apirestriccionacceso
set search_path = labprod,oracle,dmap_extension,public;
alter table apirestriccionacceso alter column accion set not null;
