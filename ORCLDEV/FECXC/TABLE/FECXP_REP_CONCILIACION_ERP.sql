-- dmap_object_gen_tag : type : table name : fecxp_rep_conciliacion_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_rep_conciliacion_erp"  (
cla_id_fe varchar(25),
cla_fe_des varchar(25),
concepto varchar(40),
moneda varchar(3),
importe_linea decimal(20, 4),
tipo_cambio decimal(20, 11),
fecha_aplicacion timestamp(0),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
oracle_segmento1_des varchar(240),
oracle_segmento2_des varchar(240),
oracle_segmento3_des varchar(240),
oracle_segmento4_des varchar(240),
oracle_segmento5_des varchar(240),
oracle_segmento6_des varchar(240),
oracle_segmento7_des varchar(240),
estatus varchar(25) default 'EXTRAIDO'
) ;
