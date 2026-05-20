-- dmap_object_gen_tag : type : table name : fecxp_rep_conciliacion_soin
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_rep_conciliacion_soin"  (
cod_empresa numeric(38),
des_empresa varchar(100),
cla_id_fe varchar(25),
cla_fe_des varchar(25),
concepto varchar(40),
moneda varchar(3),
importe_linea decimal(20, 4),
tipo_cambio decimal(20, 11),
fecha_aplicacion timestamp(0),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3)
) ;
