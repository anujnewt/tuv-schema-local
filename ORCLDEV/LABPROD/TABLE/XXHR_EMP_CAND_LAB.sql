-- dmap_object_gen_tag : type : table name : xxhr_emp_cand_lab
set search_path = labprod,oracle,dmap_extension,public;
create table "xxhr_emp_cand_lab"  (
no_empleado varchar(15),
fecha_contratacion timestamp(0),
estatus_interface numeric,
fecha_interface timestamp(0),
id_labora numeric
) ;
