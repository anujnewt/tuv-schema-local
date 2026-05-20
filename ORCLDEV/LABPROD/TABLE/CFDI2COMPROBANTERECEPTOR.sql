-- dmap_object_gen_tag : type : table name : cfdi2comprobantereceptor
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdi2comprobantereceptor"  (
idcomprobanteemp numeric(10) not null,
com_keyemp numeric(10) not null,
rfc varchar(13),
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
domiciliofiscalreceptor varchar(5),
regimenfiscalreceptor varchar(5),
usocfdi varchar(5)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobantereceptor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobantereceptor add constraint pk_cfdi2comprobantereceptor primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobantereceptor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobantereceptor alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobantereceptor
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobantereceptor alter column com_keyemp set not null;
