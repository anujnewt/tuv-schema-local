-- dmap_object_gen_tag : type : table name : fecxp_ppto_opera_erp_enc
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ppto_opera_erp_enc"  (
version_fe numeric(38),
comentario varchar(255),
usuario_id varchar(15),
fecha_extraccion timestamp(0),
version_reglas numeric(38),
fecha_version_reglas timestamp(0),
periodo_origen numeric(38),
version_origen numeric(38),
estatus_origen varchar(255),
version_fe_origen numeric(38),
mes_extraccion numeric(38) default ((nullif(to_char(statement_timestamp(),
'MM'),
'')::numeric) ),
periodo_extraccion numeric(38) default ((nullif(to_char(statement_timestamp(),
'YYYY'),
'')::numeric) ),
estatus_fe varchar(25) default ('APLICADA')
) ;
