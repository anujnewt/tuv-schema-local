-- dmap_object_gen_tag : type : fdw name : table
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
create foreign  table bitacoraacceso (
usuario varchar(256),
fecha timestamp(0),
accion varchar(10),
mensaje varchar(256)
) server  options(schema 'XX_BLOQUEOBAJAS', table 'BITACORAACCESO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
create foreign  table destinatarios (
iddestinatario numeric(38) options (key 'true') not null,
tiponotificacion numeric(38) not null,
destinatario varchar(50) not null,
tipodestinatario numeric(38) not null,
fechacreacion timestamp(0) not null,
usuario varchar(50) not null
) server  options(schema 'XX_BLOQUEOBAJAS', table 'DESTINATARIOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
create foreign  table notificaciones (
idnotificacion numeric(38) options (key 'true') not null,
idsolicitud numeric(38) not null,
tiponotificacion numeric(38) not null,
fechacreacion timestamp(0) not null,
estatus numeric(38) not null,
intentos numeric(38) not null,
mensaje varchar(200)
) server  options(schema 'XX_BLOQUEOBAJAS', table 'NOTIFICACIONES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
create foreign  table solicitudes (
idsolicitud numeric options (key 'true') not null,
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
) server  options(schema 'XX_BLOQUEOBAJAS', table 'SOLICITUDES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
create foreign  table usuarioempleado (
idusuario numeric options (key 'true') not null,
usuario varchar(50) not null,
keyemp numeric not null,
fechaingreso timestamp(0) not null,
dirip varchar(16) not null,
nombrepc varchar(50) not null,
correo varchar(50),
rol varchar(20) not null,
nombreusuario varchar(100)
) server  options(schema 'XX_BLOQUEOBAJAS', table 'USUARIOEMPLEADO', readonly 'true');
