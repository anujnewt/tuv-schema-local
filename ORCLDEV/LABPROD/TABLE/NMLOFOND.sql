-- dmap_object_gen_tag : type : table name : nmlofond
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlofond"  (
fon_keyreg numeric(10) not null,
fon_keyfon numeric(10) not null,
no_fonacot varchar(15),
rfc varchar(13),
nombre varchar(100),
no_credito varchar(10),
retencion_mensual varchar(20),
clave_empleado varchar(15),
plazo varchar(10),
cuotas_pagadas varchar(10),
retencion_real varchar(20),
incidencia varchar(1),
fecha_ini_baja varchar(10),
fecha_fin varchar(10),
reubicado varchar(1),
fon_keyemp numeric(10),
fon_keypre decimal(16, 6),
fon_keyerr numeric(5)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlofond
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlofond alter column fon_keyreg set not null;
-- dmap_object_gen_tag : type : alter table name : nmlofond
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlofond alter column fon_keyfon set not null;
