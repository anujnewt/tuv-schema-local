-- dmap_object_gen_tag : type : table name : cfdicancelaciones
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdicancelaciones"  (
idcomprobanteemp numeric(38),
can_keyemp varchar(50),
can_keypro numeric(38),
can_keyper varchar(10),
can_uuid varchar(36),
can_estatus numeric(38),
can_xmlcancelado varchar(200),
can_fechacancelacion timestamp(0),
can_pac varchar(50)
) ;
