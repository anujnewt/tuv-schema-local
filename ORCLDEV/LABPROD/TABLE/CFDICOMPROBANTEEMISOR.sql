-- dmap_object_gen_tag : type : table name : cfdicomprobanteemisor
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdicomprobanteemisor"  (
idcomprobantepro numeric(38) not null,
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
codigopostal varchar(5)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemisor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemisor add constraint cfdicomprobanteemisor_pk primary key (idcomprobantepro);
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemisor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemisor alter column idcomprobantepro set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteemisor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteemisor alter column rfc set not null;
