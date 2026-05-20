-- dmap_object_gen_tag : type : table name : fecxp_rep_forecast
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_rep_forecast"  (
cla_fe_id varchar(25) not null,
e_codigo numeric(38) not null,
tipo_dato varchar(2),
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20, 11),
importe_linea decimal(20, 4),
cla_fe_des varchar(100),
des_empresa varchar(100),
id_sesion_rc varchar(256),
estatus varchar(25) default 'E'
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_forecast
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_forecast add constraint pk_fecxp_rep_forecast primary key (cla_fe_id,e_codigo);
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_forecast
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_forecast alter column cla_fe_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_forecast
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_forecast alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_forecast
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_forecast add constraint fk_fecxp_re_forecast__fecxp_cl foreign key (cla_fe_id) references fecxp_clasificacion_fe(cla_fe_id) on delete no action not deferrable initially immediate;
