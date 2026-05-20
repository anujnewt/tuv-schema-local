-- dmap_object_gen_tag : type : table name : notificaciones
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
create table "notificaciones"  (
idnotificacion numeric(38) not null,
idsolicitud numeric(38) not null,
tiponotificacion numeric(38) not null,
fechacreacion timestamp(0) not null,
estatus numeric(38) not null,
intentos numeric(38) not null,
mensaje varchar(200)
) ;
-- dmap_object_gen_tag : type : alter table name : notificaciones
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table notificaciones add constraint notificaciones_pk primary key (idnotificacion);
-- dmap_object_gen_tag : type : alter table name : notificaciones
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table notificaciones alter column idnotificacion set not null;
-- dmap_object_gen_tag : type : alter table name : notificaciones
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table notificaciones alter column idsolicitud set not null;
-- dmap_object_gen_tag : type : alter table name : notificaciones
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table notificaciones alter column tiponotificacion set not null;
-- dmap_object_gen_tag : type : alter table name : notificaciones
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table notificaciones alter column fechacreacion set not null;
-- dmap_object_gen_tag : type : alter table name : notificaciones
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table notificaciones alter column estatus set not null;
-- dmap_object_gen_tag : type : alter table name : notificaciones
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table notificaciones alter column intentos set not null;
