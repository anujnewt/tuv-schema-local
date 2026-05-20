-- dmap_object_gen_tag : type : table name : fecxc_conciliacion_det_rep
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_conciliacion_det_rep"  (
usuario varchar(50),
empresa varchar(60),
moneda varchar(40),
referencia varchar(10),
importe decimal(20, 2),
folio numeric(10),
anno_rep numeric(4),
mes_rep varchar(20),
tipo varchar(30)
) ;
