-- dmap_object_gen_tag : type : table name : cfdi2repositorioxml
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdi2repositorioxml"  (
idcomprobanteemp numeric(10) not null,
xmlcfdi varchar(4000),
timbrado numeric(1),
cadenaoriginal varchar(4000),
pac varchar(100),
uuid varchar(36),
sellosat varchar(4000),
nocertificadosat varchar(50),
xmlcfdi2 text
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2repositorioxml
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2repositorioxml add constraint pk_cfdi2repositorioxml primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdi2repositorioxml
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2repositorioxml alter column idcomprobanteemp set not null;
