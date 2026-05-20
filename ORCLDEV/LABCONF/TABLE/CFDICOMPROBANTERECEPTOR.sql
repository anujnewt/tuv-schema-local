-- dmap_object_gen_tag : type : table name : cfdicomprobantereceptor
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdicomprobantereceptor"  (
idcomprobanteemp numeric(38) not null,
com_keyemp numeric(38) not null,
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
-- dmap_object_gen_tag : type : alter table name : cfdicomprobantereceptor
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdicomprobantereceptor add constraint cfdicomprobantereceptor_pk primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdicomprobantereceptor
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdicomprobantereceptor alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobantereceptor
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdicomprobantereceptor alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobantereceptor
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdicomprobantereceptor alter column rfc set not null;
