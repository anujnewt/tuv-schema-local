-- dmap_object_gen_tag : type : table name : xxhr_elim_empleados_lab
set search_path = labprod,oracle,dmap_extension,public;
create table "xxhr_elim_empleados_lab"  (
no_empleado varchar(30),
motivo_abandono varchar(100),
fecha_terminacion timestamp(0),
ult_fecha_proc_estandar timestamp(0),
fecha_final_proceso timestamp(0),
fecha_sipros timestamp(0),
submovimiento numeric(38),
estatus_interface varchar(1),
fecha_interface timestamp(0),
id_labora numeric(38)
) ;
