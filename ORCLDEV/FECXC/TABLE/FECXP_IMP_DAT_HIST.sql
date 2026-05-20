-- dmap_object_gen_tag : type : table name : fecxp_imp_dat_hist
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_imp_dat_hist"  (
tipo_empresa_imp varchar(2),
tipo_importacion varchar(2),
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
estatus_origen varchar(25) default ('IMPORTADO'),
utilizar_reporte varchar(1),
procesado numeric(38) default 0 --1 si 0 no
) ;
-- function used in indexes must be immutable, use immutable_to_char() instead of to_char()
