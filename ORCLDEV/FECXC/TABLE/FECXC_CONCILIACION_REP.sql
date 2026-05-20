-- dmap_object_gen_tag : type : table name : fecxc_conciliacion_rep
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_conciliacion_rep"  (
usuario varchar(50),
secuencia numeric(38),
titulo varchar(50),
totaldercxc decimal(20, 2),
totalizqcxc decimal(20, 2),
totalderfe decimal(20, 2),
totalizqfe decimal(20, 2),
anno_rep numeric(4),
mes_rep varchar(20),
moneda varchar(40),
segrestar varchar(50)
) ;
