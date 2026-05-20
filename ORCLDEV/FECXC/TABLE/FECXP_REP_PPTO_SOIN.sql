-- dmap_object_gen_tag : type : table name : fecxp_rep_ppto_soin
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_rep_ppto_soin"  (
cod_empresa numeric(38),
des_empresa varchar(100),
cla_id_fe varchar(25),
cla_fe_des varchar(25),
rubro varchar(25),
orden_id numeric(38),
id_sesion numeric(38),
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20, 11),
importe_linea decimal(20, 4),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
cg13di numeric(38),
cg13ru numeric(38),
ctatip varchar(1)
) ;
