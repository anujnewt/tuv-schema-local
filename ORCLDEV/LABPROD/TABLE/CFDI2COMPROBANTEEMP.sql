-- dmap_object_gen_tag : type : table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdi2comprobanteemp"  (
idcomprobanteemp numeric(10) not null,
idcomprobantepro numeric(10) not null,
com_keyemp numeric(10) not null,
com_status varchar(1) not null,
com_keyusu numeric(10) not null,
com_fecgen timestamp not null,
com_fectim timestamp,
version varchar(5),
serie varchar(25),
folio varchar(20),
fecha timestamp,
sello varchar(2000),
formadepago varchar(50),
nocertificado varchar(20),
certificado varchar(4000),
condicionesdepago varchar(20),
subtotal decimal(18, 6) not null,
descuento decimal(18, 6) not null,
motivodescuento varchar(50),
tipocambio varchar(50),
moneda varchar(50),
total decimal(18, 6) not null,
tipodecomprobante varchar(20) not null,
metododepago varchar(20) not null,
lugarexpedicion varchar(50) not null,
totalimpuestosretenidos decimal(18, 2),
exportacion varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp add constraint pk_2comprobanteemp primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column idcomprobantepro set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column com_status set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column com_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column com_fecgen set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column subtotal set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column descuento set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column total set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column tipodecomprobante set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column metododepago set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemp alter column lugarexpedicion set not null;
