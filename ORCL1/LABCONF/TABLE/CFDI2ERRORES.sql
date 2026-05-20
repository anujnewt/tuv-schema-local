-- dmap_object_gen_tag : type : table name : cfdi2errores
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2errores"  (
iderror numeric(10) not null,
idcomprobanteemp numeric(10) not null,
com_tiperr numeric(5) not null,
com_keyerr varchar(10),
com_descrip varchar(2000)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2errores
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2errores add constraint pk_cfdi2errores primary key (iderror);
-- dmap_object_gen_tag : type : alter table name : cfdi2errores
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2errores alter column iderror set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2errores
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2errores alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2errores
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2errores alter column com_tiperr set not null;
