-- dmap_object_gen_tag : type : table name : fecxp_rep_ppto_com_ver_soin
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_rep_ppto_com_ver_soin"  (
version_id numeric(38),
version_fe numeric(38),
cla_fe_id varchar(25),
e_codigo numeric(38),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
tipo varchar(1),
division numeric(38),
rubro numeric(38),
ctacr1 varchar(3),
ctacr2 varchar(4),
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
importe_linea decimal(20, 4),
id_sesion varchar(25)
) ;
