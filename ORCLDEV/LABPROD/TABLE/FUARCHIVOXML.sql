-- dmap_object_gen_tag : type : table name : fuarchivoxml
set search_path = labprod,oracle,dmap_extension,public;
create table "fuarchivoxml"  (
id numeric(10) not null,
xmlcfdi varchar(4000),
timbrado numeric(1),
cadenaoriginal varchar(4000),
pac varchar(100),
uuid varchar(36),
sellosat varchar(4000),
nocertificadosat varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : fuarchivoxml
set search_path = labprod,oracle,dmap_extension,public;
alter table fuarchivoxml add constraint pk_fuarchivoxml primary key (id);
-- dmap_object_gen_tag : type : alter table name : fuarchivoxml
set search_path = labprod,oracle,dmap_extension,public;
alter table fuarchivoxml alter column id set not null;
