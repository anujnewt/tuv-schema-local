-- dmap_object_gen_tag : type : table name : fecxp_politicas_soin
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_politicas_soin"  (
cla_fe_id varchar(25) not null,
politica_soin_id numeric(38) not null,
prioridad numeric(38),
e_codigo_ini numeric(38),
e_codigo_fin numeric(38),
ctam01_ini varchar(3),
ctam01_fin varchar(3),
ctam02_ini varchar(3),
ctam02_fin varchar(3),
ctam03_ini varchar(3),
ctam03_fin varchar(3),
tipo_ini varchar(1),
tipo_fin varchar(1),
division_ini numeric(38),
division_fin numeric(38),
rubro_ini numeric(38),
rubro_fin numeric(38),
activa_regla numeric(38) not null default 1,
ctacr1_ini varchar(3),
ctacr1_fin varchar(3),
ctacr2_ini varchar(4),
ctacr2_fin varchar(4),
tipo_operacion_ini numeric(38),
tipo_operacion_fin numeric(38),
id_tipo_movto varchar(1) default ('E'),
id_banco_ini numeric(38),
id_banco_fin numeric(38),
id_chequera_ini varchar(20),
id_chequera_fin varchar(20),
version_id numeric(38) default (0)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_politicas_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_politicas_soin add constraint pk_fecxp_politicas_soin primary key (cla_fe_id,politica_soin_id);
-- dmap_object_gen_tag : type : alter table name : fecxp_politicas_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_politicas_soin alter column cla_fe_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_politicas_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_politicas_soin alter column politica_soin_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_politicas_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_politicas_soin alter column activa_regla set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_politicas_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_politicas_soin add constraint fk_fecxp_politicas_soin foreign key (cla_fe_id) references fecxp_clasificacion_fe(cla_fe_id) on delete no action not deferrable initially immediate;
