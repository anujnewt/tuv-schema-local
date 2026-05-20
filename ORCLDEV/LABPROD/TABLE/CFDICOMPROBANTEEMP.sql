-- dmap_object_gen_tag : type : table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdicomprobanteemp"  (
idcomprobanteemp numeric(38) not null,
idcomprobantepro numeric(38) not null,
com_keyemp numeric(38) not null,
com_status varchar(1) not null,
com_keyusu numeric(38) not null,
com_fecgen timestamp(0) not null,
com_fectim timestamp(0),
version varchar(5),
serie varchar(25),
folio varchar(20),
fecha timestamp(0),
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
total decimal(18, 6) not null,
tipodecomprobante varchar(20) not null,
metododepago varchar(20) not null,
lugarexpedicion varchar(50) not null,
numctapago varchar(18),
foliofiscalorig varchar(20),
seriefoliofiscalorig varchar(20),
fechafoliofiscalorig timestamp(0),
montofoliofiscalorig decimal(18, 6),
totalimpuestosretenidos decimal(18, 6)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp add constraint cfdicomprobanteemp_pk primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column idcomprobantepro set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column com_status set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column com_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column com_fecgen set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column subtotal set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column descuento set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column total set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column tipodecomprobante set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column metododepago set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemp
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemp alter column lugarexpedicion set not null;
