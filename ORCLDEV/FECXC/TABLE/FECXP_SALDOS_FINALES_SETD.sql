-- dmap_object_gen_tag : type : table name : fecxp_saldos_finales_setd
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_saldos_finales_setd"  (
e_codigo numeric(38),
importe decimal(20, 4),
moneda varchar(3),
fecha timestamp(0)
) ;
