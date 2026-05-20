-- dmap_object_gen_tag : type : table name : cfdi2comprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdi2comprobanteconceptos"  (
idcomprobanteemp numeric(10) not null,
com_keyemp numeric(10) not null,
com_numsec numeric(10) not null,
cantidad decimal(18, 6) not null,
unidad varchar(100) not null,
noidentificacion varchar(100),
descripcion varchar(100) not null,
valorunitario decimal(18, 6) not null,
importe decimal(18, 6) not null,
objetoimp varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteconceptos add constraint pk_2comprobanteconceptos primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteconceptos alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteconceptos alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteconceptos alter column com_numsec set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteconceptos alter column cantidad set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteconceptos alter column unidad set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteconceptos alter column descripcion set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteconceptos alter column valorunitario set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobanteconceptos
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2comprobanteconceptos alter column importe set not null;
