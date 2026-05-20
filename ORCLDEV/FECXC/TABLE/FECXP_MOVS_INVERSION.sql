-- dmap_object_gen_tag : type : table name : fecxp_movs_inversion
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_movs_inversion"  (
cla_fe_id varchar(25),
e_codigo numeric(38),
folio_set numeric(38),
secuencia_id numeric(38),
tipo_operacion numeric(38),
fecha timestamp(0),
moneda varchar(3),
importe decimal(20, 4),
importe_linea decimal(20, 4),
id_tipo_movto varchar(1),
des_empresa varchar(100),
id_status_mov varchar(1),
periodo numeric(38),
mes numeric(38),
tipo_cambio decimal(20, 11),
cla_fe_des varchar(50),
cla_atributo1 varchar(250),
cla_atributo2 varchar(250),
cla_atributo3 varchar(250)
) ;
