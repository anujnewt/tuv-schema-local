-- dmap_object_gen_tag : type : table name : solicitudes
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
create table "solicitudes"  (
idsolicitud numeric not null,
keyemp numeric not null,
fechabaja timestamp(0) not null,
motivobaja varchar(2) not null,
tipo varchar(1) not null,
estatus numeric not null,
usuario varchar(50) not null,
fechacaptura timestamp(0),
dirip varchar(16),
nombrepc varchar(50),
usuarioaccion varchar(50),
fechaaccion timestamp(0),
diripaccion varchar(16),
nombrepcaccion varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : solicitudes
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table solicitudes add constraint solicitudes_pk primary key (idsolicitud);
-- dmap_object_gen_tag : type : alter table name : solicitudes
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table solicitudes alter column idsolicitud set not null;
-- dmap_object_gen_tag : type : alter table name : solicitudes
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table solicitudes alter column keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : solicitudes
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table solicitudes alter column fechabaja set not null;
-- dmap_object_gen_tag : type : alter table name : solicitudes
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table solicitudes alter column motivobaja set not null;
-- dmap_object_gen_tag : type : alter table name : solicitudes
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table solicitudes alter column tipo set not null;
-- dmap_object_gen_tag : type : alter table name : solicitudes
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table solicitudes alter column estatus set not null;
-- dmap_object_gen_tag : type : alter table name : solicitudes
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table solicitudes alter column usuario set not null;
