-- dmap_object_gen_tag : type : table name : usuarioempleado
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
create table "usuarioempleado"  (
idusuario numeric not null,
usuario varchar(50) not null,
keyemp numeric not null,
fechaingreso timestamp(0) not null,
dirip varchar(16) not null,
nombrepc varchar(50) not null,
correo varchar(50),
rol varchar(20) not null,
nombreusuario varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : usuarioempleado
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table usuarioempleado add constraint usuarioempleado_uk1 unique (usuario);
-- dmap_object_gen_tag : type : alter table name : usuarioempleado
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table usuarioempleado add constraint usuarioempleado_pk primary key (idusuario);
-- dmap_object_gen_tag : type : alter table name : usuarioempleado
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table usuarioempleado alter column idusuario set not null;
-- dmap_object_gen_tag : type : alter table name : usuarioempleado
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table usuarioempleado alter column usuario set not null;
-- dmap_object_gen_tag : type : alter table name : usuarioempleado
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table usuarioempleado alter column keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : usuarioempleado
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table usuarioempleado alter column fechaingreso set not null;
-- dmap_object_gen_tag : type : alter table name : usuarioempleado
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table usuarioempleado alter column dirip set not null;
-- dmap_object_gen_tag : type : alter table name : usuarioempleado
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table usuarioempleado alter column nombrepc set not null;
-- dmap_object_gen_tag : type : alter table name : usuarioempleado
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table usuarioempleado alter column rol set not null;
