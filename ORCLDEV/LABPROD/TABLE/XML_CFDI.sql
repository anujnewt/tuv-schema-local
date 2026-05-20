-- dmap_object_gen_tag : type : table name : xml_cfdi
set search_path = labprod,oracle,dmap_extension,public;
create table "xml_cfdi"  (
idcomprobanteemp numeric(38),
com_keyemp varchar(50),
com_keypro numeric(38),
com_keyper varchar(50),
xmlcfdi varchar(200),
timbrado numeric(38),
sociedad varchar(50),
error varchar(200),
cadenaoriginal varchar(200),
pac varchar(100),
uuid varchar(36),
sellosat varchar(200),
nocertificadosat varchar(50)
) ;
