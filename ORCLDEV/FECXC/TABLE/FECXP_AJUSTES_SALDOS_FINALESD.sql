-- dmap_object_gen_tag : type : table name : fecxp_ajustes_saldos_finalesd
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ajustes_saldos_finalesd"  (
tipo_dato varchar(1),
e_codigo numeric(38),
importe decimal(20, 4),
moneda varchar(3),
fecha timestamp(0)
) ;
