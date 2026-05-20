-- dmap_object_gen_tag : type : table name : xxhr_transferencias_lab
set search_path = labprod,oracle,dmap_extension,public;
create table "xxhr_transferencias_lab"  (
no_empleado varchar(15),
no_empleado_n varchar(15),
estatus_interface numeric,
fecha_interface timestamp(0),
id_labora numeric
) ;
