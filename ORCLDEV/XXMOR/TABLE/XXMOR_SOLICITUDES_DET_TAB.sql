-- dmap_object_gen_tag : type : table name : xxmor_solicitudes_det_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_solicitudes_det_tab"  (
id_solicitud numeric not null,
linea numeric not null,
linea_hna numeric,
stnid varchar(15),
fecha_inicio varchar(15),
fecha_fin varchar(15),
duracion varchar(8),
buyuntid varchar(15),
hora_inicio varchar(8),
hora_fin varchar(8),
spots varchar(5),
lunes varchar(3),
martes varchar(3),
miercoles varchar(3),
jueves varchar(3),
viernes varchar(3),
sabado varchar(3),
domingo varchar(3),
spots_x_semana varchar(15),
tipo_servicio varchar(100),
usr_chr varchar(1),
spot_chr numeric(5),
bn varchar(10),
p varchar(3),
marca varchar(50),
version varchar(30),
tarifasp_sin_desc varchar(15),
tarifasp_con_desc varchar(15),
tot_linea_sin_desc varchar(15),
tot_linea_con_desc varchar(15),
sobrecargo varchar(50),
observaciones varchar(150),
created_by varchar(20),
created_date timestamp(0) default statement_timestamp(),
updated_date timestamp(0),
updated_by varchar(20),
linea_estatus varchar(2),
fecha_concom varchar(35),
tracking_id_concom varchar(50),
getrate_sin_ajuste decimal(20, 2),
getrate_con_ajuste decimal(20, 2),
division_montos numeric(2),
des_plataforma varchar(150)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_det_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_det_tab add constraint xxmor_solicitudes_det_tab_pk primary key (id_solicitud,linea);
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_det_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_det_tab alter column id_solicitud set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_det_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_det_tab alter column linea set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_det_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_det_tab add constraint fk_sol_det_sol_enc foreign key (id_solicitud) references xxmor_solicitudes_enc_tab(id_solicitud) on delete no action not deferrable initially immediate;
