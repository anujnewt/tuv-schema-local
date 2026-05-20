-- dmap_object_gen_tag : type : table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2nomina"  (
idnomina numeric(10) not null,
idcomprobanteemp numeric(10) not null,
com_keyemp numeric(10) not null,
com_keypro numeric(10) not null,
com_keyper varchar(7) not null,
version varchar(5) not null,
tiponomina varchar(1) not null,
fechapago timestamp(0) not null,
fechainicialpago timestamp(0) not null,
fechafinalpago timestamp(0) not null,
numdiaspagados decimal(10, 3) not null,
totalpercepciones decimal(18, 2),
totaldeducciones decimal(18, 2),
totalotrospagos decimal(18, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina add constraint pk_cfdi2nomina primary key (idnomina);
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina alter column idnomina set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina alter column com_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina alter column com_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina alter column version set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina alter column tiponomina set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina alter column fechapago set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina alter column fechainicialpago set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina alter column fechafinalpago set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2nomina
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nomina alter column numdiaspagados set not null;
