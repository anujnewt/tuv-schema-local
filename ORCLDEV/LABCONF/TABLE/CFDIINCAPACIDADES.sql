-- dmap_object_gen_tag : type : table name : cfdiincapacidades
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdiincapacidades"  (
idcomprobanteemp numeric(38) not null,
com_keyemp numeric(38) not null,
diasincapacidad decimal(18, 6) not null,
tipoincapacidad numeric(38) not null,
descuento decimal(18, 6) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cfdiincapacidades
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiincapacidades alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdiincapacidades
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiincapacidades alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdiincapacidades
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiincapacidades alter column diasincapacidad set not null;
-- dmap_object_gen_tag : type : alter table name : cfdiincapacidades
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiincapacidades alter column tipoincapacidad set not null;
-- dmap_object_gen_tag : type : alter table name : cfdiincapacidades
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiincapacidades alter column descuento set not null;
