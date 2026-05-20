-- dmap_object_gen_tag : type : table name : xxmor_solicitudes_orig_det_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_solicitudes_orig_det_tab"  (
id_request numeric not null,
linea_request numeric not null,
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
spots_x_semana varchar(5),
tipo_servicio varchar(100),
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
aux1 varchar(15),
aux2 varchar(15),
aux3 varchar(15),
aux4 varchar(15),
aux5 varchar(15),
des_plataforma varchar(150)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_orig_det_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_orig_det_tab add constraint xxmor_solicitudes_orig_det_pk primary key (id_request,linea_request);
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_orig_det_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_orig_det_tab alter column id_request set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_orig_det_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_orig_det_tab alter column linea_request set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_orig_det_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_orig_det_tab add constraint fk_sol_enc_sol_det_orig foreign key (id_request) references xxmor_solicitudes_orig_enc_tab(id_request) on delete no action not deferrable initially immediate;
