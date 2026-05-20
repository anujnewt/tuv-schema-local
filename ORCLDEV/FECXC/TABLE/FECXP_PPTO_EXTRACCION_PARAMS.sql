-- dmap_object_gen_tag : type : table name : fecxp_ppto_extraccion_params
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ppto_extraccion_params"  (
proceso_id numeric(38),
proceso_nombre varchar(255),
fecha_ext_sig_ejecucion timestamp(0) default (to_timestamp('19000101',
'YYYYMMDD')),
version_fe_sig_ejecucion numeric(38) default (0),
periodo_ppto_sig_ejecucion numeric(38),
version_ppto_sig_ejecucion numeric(38),
estatus_ppto_sig_ejecucion varchar(255),
usuario_ppto_sig_ejecucion varchar(25),
fecha_ext_ult_ejecucion timestamp(0) default (to_timestamp('19000101',
'YYYYMMDD')),
estatus_ext_ult_ejecucion varchar(255) default ('NO APLICA'),
version_fe_ult_ejecucion numeric(38) default (0),
periodo_ppto_ult_ejecucion numeric(38),
version_ppto_ult_ejecucion numeric(38),
estatus_ppto_ult_ejecucion varchar(255),
usuario_ppto_ult_ejecucion varchar(25),
atributo1 varchar(255) default ('SIN COMENTARIO'),
estatus_proceso varchar(255) default ('INACTIVO'),
fec_ini timestamp(0) default (statement_timestamp()),
fec_fin timestamp(0) default (statement_timestamp()),
alertar numeric(38) default (0),
atributo2 varchar(255)
) ;
