-- dmap_object_gen_tag : type : table name : xxar_control_nc_tab
set search_path = labprod,oracle,dmap_extension,public;
create table "xxar_control_nc_tab"  (
id_control numeric not null,
num_anio numeric,
num_mes numeric,
ind_tipo_pago numeric,
num_proceso numeric,
num_periodo numeric,
des_descripcion varchar(200),
fec_ejecucion timestamp(0),
can_regs numeric,
val_monto numeric,
ind_fuente varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : xxar_control_nc_tab
set search_path = labprod,oracle,dmap_extension,public;
alter table xxar_control_nc_tab add constraint xxar_control_nc_pk primary key (id_control);
