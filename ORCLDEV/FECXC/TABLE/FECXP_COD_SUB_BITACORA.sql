-- dmap_object_gen_tag : type : table name : fecxp_cod_sub_bitacora
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_cod_sub_bitacora"  (
secuencia_cod_sub_bit numeric(38),
ins_no_empresa numeric(38),
ins_id_codigo varchar(2),
ins_id_subcodigo varchar(3),
ins_desc_subcodigo varchar(40),
del_no_empresa numeric(38),
del_id_codigo varchar(2),
del_id_subcodigo varchar(3),
del_desc_subcodigo varchar(40),
accion varchar(40),
usuario varchar(40),
fecha_sincronizacion timestamp(0) default (statement_timestamp()),
fecha_modificacion timestamp(0) default (to_timestamp('19000101',
'YYYYMMDD')),
sincronizado_fe varchar(2) default ('NO'),
comentario_sincronizado_fe varchar(255) default ('<SIN COMENTARIO>')
) ;
