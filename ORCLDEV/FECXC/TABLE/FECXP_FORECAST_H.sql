-- dmap_object_gen_tag : type : table name : fecxp_forecast_h
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_forecast_h"  (
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
id_version numeric(38) not null,
tipo_ppto_real varchar(1),
id_version_forecast numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_h alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_h alter column des_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_h alter column id_sesion_rc set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_h alter column cla_fe_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_h alter column cla_fe_des set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_forecast_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_forecast_h alter column id_version set not null;
