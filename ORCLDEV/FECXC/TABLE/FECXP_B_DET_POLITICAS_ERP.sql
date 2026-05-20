-- dmap_object_gen_tag : type : table name : fecxp_b_det_politicas_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_b_det_politicas_erp"  (
version_id numeric(38) not null,
politica_erp_id numeric(38) not null,
cla_fe_id varchar(25) not null,
prioridad numeric(38),
oracle_segmento1_ini varchar(25),
oracle_segmento1_fin varchar(25),
oracle_segmento2_ini varchar(25),
oracle_segmento2_fin varchar(25),
oracle_segmento3_ini varchar(25),
oracle_segmento3_fin varchar(25),
oracle_segmento4_ini varchar(25),
oracle_segmento4_fin varchar(25),
oracle_segmento5_ini varchar(25),
oracle_segmento5_fin varchar(25),
oracle_segmento6_ini varchar(25),
oracle_segmento6_fin varchar(25),
oracle_segmento7_ini varchar(25),
oracle_segmento7_fin varchar(25),
activa_regla numeric(38) not null default 1,
tipo_operacion_ini numeric(38),
tipo_operacion_fin numeric(38),
id_tipo_movto varchar(1),
id_banco_ini numeric(38),
id_banco_fin numeric(38),
id_chequera_ini varchar(20),
id_chequera_fin varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_det_politicas_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_det_politicas_erp add constraint pkfecxp_b_det_politicas_erp primary key (version_id,cla_fe_id,politica_erp_id);
-- dmap_object_gen_tag : type : alter table name : fecxp_b_det_politicas_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_det_politicas_erp alter column version_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_det_politicas_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_det_politicas_erp alter column politica_erp_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_det_politicas_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_det_politicas_erp alter column cla_fe_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_det_politicas_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_det_politicas_erp alter column activa_regla set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_det_politicas_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_det_politicas_erp add constraint fkfecxp_b_det_politicas_erp foreign key (version_id) references fecxp_b_enc_politicas_erp(version_id) on delete no action not deferrable initially immediate;
