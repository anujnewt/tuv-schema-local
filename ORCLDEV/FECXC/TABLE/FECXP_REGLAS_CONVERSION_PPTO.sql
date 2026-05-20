-- dmap_object_gen_tag : type : table name : fecxp_reglas_conversion_ppto
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_reglas_conversion_ppto"  (
regla_id_conversion numeric(38) not null,
plataforma varchar(25),
reg_segmento1_ini varchar(25),
reg_segmento1_fin varchar(25),
reg_segmento2_ini varchar(25),
reg_segmento2_fin varchar(25),
reg_segmento3_ini varchar(25),
reg_segmento3_fin varchar(25),
reg_segmento4_ini varchar(25),
reg_segmento4_fin varchar(25),
reg_segmento5_ini varchar(25),
reg_segmento5_fin varchar(25),
reg_segmento6_ini varchar(25),
reg_segmento6_fin varchar(25),
reg_segmento7_ini varchar(25),
reg_segmento7_fin varchar(25),
periodo numeric(38),
mes_ini numeric(38),
mes_fin numeric(38),
reg_segmento8_ini varchar(25),
reg_segmento8_fin varchar(25),
mes_acumulacion numeric(38) default (0)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_reglas_conversion_ppto
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_reglas_conversion_ppto add constraint pk_fecxp_reglas_conversion_ppt primary key (regla_id_conversion);
-- dmap_object_gen_tag : type : alter table name : fecxp_reglas_conversion_ppto
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_reglas_conversion_ppto add constraint ckc_plataforma_fecxp_re check (plataforma is null or ( plataforma in ('SOIN','ORACLE') ));
-- dmap_object_gen_tag : type : alter table name : fecxp_reglas_conversion_ppto
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_reglas_conversion_ppto alter column regla_id_conversion set not null;
