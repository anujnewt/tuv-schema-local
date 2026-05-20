-- dmap_object_gen_tag : type : table name : fucfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
create table "fucfdicomprobanteemp"  (
idcomprobanteemp numeric(10),
idcomprobantepro numeric(10),
com_keyemp numeric(10),
com_status varchar(1),
com_keyusu numeric(10),
com_fecgen timestamp,
com_fectim timestamp,
version varchar(5),
serie varchar(25),
folio varchar(20),
fecha timestamp,
sello varchar(2000),
formadepago varchar(50),
nocertificado varchar(20),
certificado varchar(2000),
condicionesdepago varchar(20),
subtotal decimal(18, 6) not null,
descuento decimal(18, 6) not null,
motivodescuento varchar(50),
tipocambio varchar(50),
moneda varchar(50),
total decimal(18, 6),
tipodecomprobante varchar(20),
metododepago varchar(20),
lugarexpedicion varchar(50),
totalimpuestosretenidos decimal(18, 2),
exportacion varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : fucfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table fucfdicomprobanteemp alter column subtotal set not null;
-- dmap_object_gen_tag : type : alter table name : fucfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table fucfdicomprobanteemp alter column descuento set not null;
