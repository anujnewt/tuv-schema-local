-- dmap_object_gen_tag : type : table name : xxhr_crear_candidatos_lab
set search_path = labprod,oracle,dmap_extension,public;
create table "xxhr_crear_candidatos_lab"  (
idcandidato numeric,
apellido_paterno varchar(150),
apellido_materno varchar(150),
nombre varchar(150),
fecha_recepcion varchar(10),
calle_num_ext_int varchar(240),
colonia varchar(240),
codigo_postal varchar(30),
ciudad varchar(30),
estado varchar(120),
del_munic varchar(240),
pais varchar(60),
telefono varchar(60),
telefono2 varchar(60),
telefono3 varchar(60),
estatus_interface varchar(1),
fecha_interface timestamp(0),
emp_keyemp numeric(38),
id_labora numeric(38)
) ;
