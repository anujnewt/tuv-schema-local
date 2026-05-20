-- dmap_object_gen_tag : type : table name : cfdi2cancelaciones
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdi2cancelaciones"  (
idcomprobanteemp numeric(10) not null,
can_keyemp numeric(10) not null,
can_keypro numeric(5) not null,
can_keyper varchar(7) not null,
can_uuid varchar(36),
can_estatus numeric(5),
can_xmlcancelado varchar(4000),
can_fechacancelacion timestamp,
can_pac varchar(10),
motivocancelacion varchar(2),
foliosustitucion varchar(36) default '',
idcomprobanteempsustitucion numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2cancelaciones
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2cancelaciones add constraint pk_cfdi2cancelaciones primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdi2cancelaciones
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2cancelaciones alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2cancelaciones
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2cancelaciones alter column can_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2cancelaciones
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2cancelaciones alter column can_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2cancelaciones
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2cancelaciones alter column can_keyper set not null;
