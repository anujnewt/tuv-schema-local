-- dmap_object_gen_tag : type : table name : fecxp_saldos_finales_set
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_saldos_finales_set"  (
e_codigo numeric(38),
importe decimal(20, 4),
moneda varchar(3),
mes numeric(38),
periodo numeric(38) default ((nullif(to_char(statement_timestamp(),
'YYYY'),
'')::numeric) )
) ;
