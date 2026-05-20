-- dmap_object_gen_tag : type : table name : fecxp_forecast_ns
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_forecast_ns"  (
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
id_sesion_rc varchar(256) not null,
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20, 11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(100) not null,
importe_linea decimal(20, 4),
estatus varchar(25) default ('EXTRAIDO'),
tipo_caratula varchar(2),
id_version varchar(100) not null,
tipo_ppto_real varchar(1),
tipo_empresa varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_ns
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_ns alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_ns
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_ns alter column des_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_ns
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_ns alter column id_sesion_rc set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_ns
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_ns alter column cla_fe_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_ns
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_ns alter column cla_fe_des set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_ns
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_ns alter column id_version set not null;
