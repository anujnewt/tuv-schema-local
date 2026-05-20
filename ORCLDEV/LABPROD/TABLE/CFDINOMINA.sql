-- dmap_object_gen_tag : type : table name : cfdinomina
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdinomina"  (
idcomprobanteemp numeric(38) not null,
idcomprobantepro numeric(38),
com_keyemp numeric(38) not null,
version varchar(5) not null,
registropatronal varchar(20),
numempleado varchar(15) not null,
curp varchar(18),
tiporegimen numeric(38),
numseguridadsocial varchar(20),
fechapago timestamp(0) not null,
fechainicialpago timestamp(0) not null,
fechafinalpago timestamp(0) not null,
numdiaspagados decimal(18, 6),
departamento varchar(100),
clabe varchar(20),
banco varchar(5),
fechainiciorellaboral timestamp(0),
antiguedad numeric(38),
puesto varchar(100),
tipocontrato varchar(50),
tipojornada varchar(50),
periodicidadpago varchar(100) not null,
salariobasecotapor decimal(18, 6),
riesgopuesto numeric(38),
salariodiariointegrado decimal(18, 6),
totalgravadopercepcion decimal(18, 6),
totalexentopercepcion decimal(18, 6),
totalgravadodeduccion decimal(18, 6),
totalexentodeduccion decimal(18, 6)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdinomina
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdinomina add constraint cfdinomina_pk primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdinomina
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdinomina alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdinomina
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdinomina alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdinomina
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdinomina alter column version set not null;
-- dmap_object_gen_tag : type : alter table name : cfdinomina
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdinomina alter column numempleado set not null;
-- dmap_object_gen_tag : type : alter table name : cfdinomina
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdinomina alter column fechapago set not null;
-- dmap_object_gen_tag : type : alter table name : cfdinomina
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdinomina alter column fechainicialpago set not null;
-- dmap_object_gen_tag : type : alter table name : cfdinomina
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdinomina alter column fechafinalpago set not null;
-- dmap_object_gen_tag : type : alter table name : cfdinomina
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdinomina alter column periodicidadpago set not null;
