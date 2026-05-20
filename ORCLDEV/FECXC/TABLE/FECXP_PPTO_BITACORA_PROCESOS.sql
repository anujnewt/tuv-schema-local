-- dmap_object_gen_tag : type : table name : fecxp_ppto_bitacora_procesos
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ppto_bitacora_procesos"  (
sec_ext_bitacora numeric(38),
proceso_id numeric(38),
fecha_ext_ult_ejecucion timestamp(0) default (to_timestamp('19000101',
'YYYYMMDD')),
estatus_ext_ult_ejecucion varchar(255) default ('NO APLICA'),
periodo_ppto_ult_ejecucion numeric(38),
version_ppto_ult_ejecucion numeric(38),
estatus_ppto_ult_ejecucion varchar(255),
version_ppto_generado numeric(38)
) ;
