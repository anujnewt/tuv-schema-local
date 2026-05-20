-- dmap_object_gen_tag : type : table name : fuarchivodetalle
set search_path = labprod,oracle,dmap_extension,public;
create table "fuarchivodetalle"  (
id numeric(38),
idarchivo numeric(38),
serie varchar(10),
folio varchar(10),
condiciones varchar(50),
lugarexpedicion varchar(5),
subtotal decimal(18, 2),
total decimal(18, 2),
nombreemisor varchar(200),
regimenemisor varchar(3),
rfcemisor varchar(14),
nombrereceptor varchar(100),
rfcreceptor varchar(14),
domicilioreceptor varchar(5),
regimenreceptor varchar(3),
com_status varchar(1)
) ;
