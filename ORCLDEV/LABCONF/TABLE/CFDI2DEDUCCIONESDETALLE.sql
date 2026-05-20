-- dmap_object_gen_tag : type : table name : cfdi2deduccionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2deduccionesdetalle"  (
iddeduccion numeric(10) not null,
idnomina numeric(10) not null,
tipodeduccion varchar(3) not null,
clave varchar(15) not null,
concepto varchar(100) not null,
importe decimal(18, 2) not null,
importegravado decimal(18, 2) not null,
importeexento decimal(18, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2deduccionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2deduccionesdetalle add constraint pk_cfdi2deduccionesdetalle primary key (iddeduccion);
-- dmap_object_gen_tag : type : alter table name : cfdi2deduccionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2deduccionesdetalle alter column iddeduccion set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2deduccionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2deduccionesdetalle alter column idnomina set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2deduccionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2deduccionesdetalle alter column tipodeduccion set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2deduccionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2deduccionesdetalle alter column clave set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2deduccionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2deduccionesdetalle alter column concepto set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2deduccionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2deduccionesdetalle alter column importe set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2deduccionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2deduccionesdetalle alter column importegravado set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2deduccionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2deduccionesdetalle alter column importeexento set not null;
