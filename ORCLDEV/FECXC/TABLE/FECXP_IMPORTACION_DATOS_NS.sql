-- dmap_object_gen_tag : type : table name : fecxp_importacion_datos_ns
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_importacion_datos_ns"  (
tipo_importacion varchar(2),
id_segmento numeric,
e_empresa_imp varchar(25),
cla_fe_id_imp varchar(25),
importe_linea decimal(20, 4),
moneda_imp varchar(3),
mes numeric(38),
fecha timestamp(0),
atributo_1 varchar(256),
atributo_2 varchar(256),
atributo_3 varchar(256),
atributo_4 varchar(256),
estatus_origen varchar(25) default 'EN ESPERA',
utilizar_reporte varchar(1)
) ;
-- function used in indexes must be immutable, use immutable_to_char() instead of to_char()
