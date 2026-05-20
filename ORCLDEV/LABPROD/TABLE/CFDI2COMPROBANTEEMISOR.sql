-- dmap_object_gen_tag : type : table name : cfdi2comprobanteemisor
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdi2comprobanteemisor"  (
idcomprobantepro numeric(10) not null,
rfc varchar(13) not null,
nombre varchar(100),
calle varchar(100),
noexterior varchar(100),
nointerior varchar(100),
colonia varchar(100),
localidad varchar(100),
referencia varchar(100),
municipio varchar(100),
estado varchar(100),
pais varchar(100),
codigopostal varchar(5),
regimen varchar(4000) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemisor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemisor add constraint pk_cfdi2comprobanteemisor primary key (idcomprobantepro);
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemisor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemisor alter column idcomprobantepro set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemisor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemisor alter column rfc set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteemisor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteemisor alter column regimen set not null;
