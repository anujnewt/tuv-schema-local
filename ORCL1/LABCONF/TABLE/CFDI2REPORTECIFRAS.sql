-- dmap_object_gen_tag : type : table name : cfdi2reportecifras
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2reportecifras"  (
idnomina numeric(38) not null,
com_keyemp numeric(38) not null,
com_codimp varchar(2) not null,
com_keycon varchar(3) not null,
con_tipcon varchar(3) not null,
tipo varchar(3) not null,
desctipo varchar(100),
clave varchar(15) not null,
concepto varchar(100),
importegravado decimal(18, 2) not null,
importeexento decimal(18, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2reportecifras
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2reportecifras alter column idnomina set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2reportecifras
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2reportecifras alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2reportecifras
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2reportecifras alter column com_codimp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2reportecifras
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2reportecifras alter column com_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2reportecifras
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2reportecifras alter column con_tipcon set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2reportecifras
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2reportecifras alter column tipo set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2reportecifras
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2reportecifras alter column clave set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2reportecifras
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2reportecifras alter column importegravado set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2reportecifras
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2reportecifras alter column importeexento set not null;
