-- dmap_object_gen_tag : type : table name : cfdimovtos
set search_path = usrsiho,oracle,dmap_extension,public;
create table "cfdimovtos"  (
idcomprobanteemp numeric(10),
com_keyemp numeric(10),
com_keycon varchar(3),
calificador varchar(1),
tiposat varchar(3),
clave varchar(6),
concepto varchar(100),
importegravado decimal(18, 6),
importeexento decimal(18, 6)
) ;
