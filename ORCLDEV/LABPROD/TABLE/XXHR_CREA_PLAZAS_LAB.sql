-- dmap_object_gen_tag : type : table name : xxhr_crea_plazas_lab
set search_path = labprod,oracle,dmap_extension,public;
create table "xxhr_crea_plazas_lab"  (
clave varchar(60),
titulo varchar(60),
ubicacion varchar(60),
dpto_name varchar(240),
presupuesto varchar(150),
compania varchar(150),
estado varchar(150),
munc_del varchar(150),
zona char(1),
numero_imss_pat varchar(150),
proceso numeric(15),
clasif_ubic char(1),
valor_plaza varchar(150),
plaza_supervisor varchar(240),
valor_ocupante varchar(150),
cc varchar(150),
tipo_empleado varchar(30),
position_id numeric(38),
estatus_interface varchar(1),
fecha_interface timestamp(0),
labora_id numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxhr_crea_plazas_lab
set search_path = labprod,oracle,dmap_extension,public;
alter table xxhr_crea_plazas_lab alter column labora_id set not null;
