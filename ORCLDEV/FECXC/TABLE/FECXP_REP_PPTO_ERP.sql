-- dmap_object_gen_tag : type : table name : fecxp_rep_ppto_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_rep_ppto_erp"  (
cod_empresa numeric(38),
des_empresa varchar(100),
rubro varchar(25),
orden_id numeric(38),
cla_id_fe varchar(25),
cla_fe_des varchar(25),
id_sesion numeric(38),
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20, 11),
importe_linea decimal(20, 4),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) ;
