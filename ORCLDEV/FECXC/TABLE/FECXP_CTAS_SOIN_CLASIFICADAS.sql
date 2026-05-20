-- dmap_object_gen_tag : type : table name : fecxp_ctas_soin_clasificadas
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ctas_soin_clasificadas"  (
cla_fe_id varchar(25),
e_codigo numeric(38),
tipo_operacion numeric(38),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
tipo varchar(1),
division numeric(38),
rubro numeric(38),
ctacr1 varchar(3),
ctacr2 varchar(4),
moneda varchar(3),
id_sesion varchar(25)
) ;
