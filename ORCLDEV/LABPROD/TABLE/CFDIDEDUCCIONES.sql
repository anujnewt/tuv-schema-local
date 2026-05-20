-- dmap_object_gen_tag : type : table name : cfdideducciones
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdideducciones"  (
idcomprobanteemp numeric(38) not null,
com_keyemp numeric(38) not null,
com_keycon varchar(3),
tipodeduccion varchar(3) not null,
clave varchar(6) not null,
concepto varchar(100) not null,
importegravado decimal(18, 6),
importeexento decimal(18, 6)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdideducciones
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdideducciones alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdideducciones
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdideducciones alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdideducciones
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdideducciones alter column tipodeduccion set not null;
-- dmap_object_gen_tag : type : alter table name : cfdideducciones
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdideducciones alter column clave set not null;
-- dmap_object_gen_tag : type : alter table name : cfdideducciones
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdideducciones alter column concepto set not null;
