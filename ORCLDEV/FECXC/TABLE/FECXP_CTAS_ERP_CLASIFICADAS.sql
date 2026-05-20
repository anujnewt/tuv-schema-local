-- dmap_object_gen_tag : type : table name : fecxp_ctas_erp_clasificadas
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ctas_erp_clasificadas"  (
cla_fe_id varchar(25),
e_codigo numeric(38),
tipo_operacion numeric(38),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
moneda varchar(3),
id_sesion varchar(25)
) ;
