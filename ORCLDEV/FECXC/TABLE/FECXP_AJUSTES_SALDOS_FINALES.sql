-- dmap_object_gen_tag : type : table name : fecxp_ajustes_saldos_finales
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ajustes_saldos_finales"  (
tipo_dato varchar(1),
e_codigo numeric(38),
importe decimal(20, 4),
moneda varchar(3),
mes numeric(38)
) ;
