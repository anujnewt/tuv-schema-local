-- dmap_object_gen_tag : type : table name : xxhr_trasp_asig_candidatos
set search_path = labprod,oracle,dmap_extension,public;
create table "xxhr_trasp_asig_candidatos"  (
no_empleado varchar(30),
primaria varchar(1),
plaza varchar(240),
tipo_contrato varchar(60),
tipo_jornada varchar(150),
horas_jornada decimal(22, 3),
frecuencia varchar(30),
ubicacion_de_pago varchar(150),
tipo_de_submovimiento varchar(150),
fecha_de_ingreso varchar(150),
criterio_de_impuesto_estatal varchar(150),
fecha_cambio varchar(10),
fecha_de_salario varchar(10),
fecha_de_salario_imss varchar(10),
salario numeric,
tipo_de_salario varchar(150),
submovimiento varchar(150),
estatus_interface varchar(1),
fecha_interface timestamp(0)
) ;
