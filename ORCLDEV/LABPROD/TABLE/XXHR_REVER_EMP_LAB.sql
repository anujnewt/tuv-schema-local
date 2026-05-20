-- dmap_object_gen_tag : type : table name : xxhr_rever_emp_lab
set search_path = labprod,oracle,dmap_extension,public;
create table "xxhr_rever_emp_lab"  (
no_empleado varchar(30),
estatus_interface varchar(1),
fecha_interface timestamp(0),
id_labora numeric(38)
) ;
