-- dmap_object_gen_tag : type : table name : cfdicomprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdicomprobanteconceptos"  (
idcomprobanteemp numeric(38) not null,
com_keyemp numeric(38) not null,
com_numsec numeric(38) not null,
cantidad decimal(18, 6) not null,
unidad varchar(100) not null,
noidentificacion varchar(100),
descripcion varchar(100) not null,
valorunitario decimal(18, 6) not null,
importe decimal(18, 6) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteconceptos add constraint cfdicomprobanteconceptos_pk primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteconceptos alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteconceptos alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteconceptos alter column com_numsec set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteconceptos alter column cantidad set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteconceptos alter column unidad set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteconceptos alter column descripcion set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteconceptos alter column valorunitario set not null;
-- dmap_object_gen_tag : type : alter table name : cfdicomprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdicomprobanteconceptos alter column importe set not null;
