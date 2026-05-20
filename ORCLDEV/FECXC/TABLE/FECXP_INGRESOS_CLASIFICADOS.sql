-- dmap_object_gen_tag : type : table name : fecxp_ingresos_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ingresos_clasificados"  (
cla_fe_id varchar(25),
e_codigo numeric(38),
folio_set numeric(38),
tipo_operacion numeric(38),
fecha timestamp(0),
moneda varchar(3),
importe_linea decimal(20, 4)
) ;
