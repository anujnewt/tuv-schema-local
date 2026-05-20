-- dmap_object_gen_tag : type : table name : xxhr_actualizar_salario_lab
set search_path = labprod,oracle,dmap_extension,public;
create table "xxhr_actualizar_salario_lab"  (
no_empleado varchar(30),
fecha_de_salario timestamp(0),
fecha_de_salario_imss timestamp(0),
tipo_de_salario varchar(150),
submovimiento varchar(150),
salario numeric,
estatus_interface varchar(1),
fecha_interface timestamp(0),
id_labora numeric
) ;
