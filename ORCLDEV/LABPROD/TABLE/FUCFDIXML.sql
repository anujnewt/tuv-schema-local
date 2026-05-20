-- dmap_object_gen_tag : type : table name : fucfdixml
set search_path = labprod,oracle,dmap_extension,public;
create table "fucfdixml"  (
idcomprobanteemp numeric(10) not null,
xmlcfdi varchar(4000),
timbrado numeric(1),
cadenaoriginal varchar(4000),
pac varchar(100),
uuid varchar(36),
sellosat varchar(4000),
nocertificadosat varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : fucfdixml
set search_path = labprod,oracle,dmap_extension,public;
alter table fucfdixml add constraint pk_fucfdixml primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : fucfdixml
set search_path = labprod,oracle,dmap_extension,public;
alter table fucfdixml alter column idcomprobanteemp set not null;
