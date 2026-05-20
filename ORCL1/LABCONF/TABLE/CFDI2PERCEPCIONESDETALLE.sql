-- dmap_object_gen_tag : type : table name : cfdi2percepcionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2percepcionesdetalle"  (
idpercepcion numeric(10) not null,
idnomina numeric(10) not null,
tipopercepcion varchar(3) not null,
clave varchar(15) not null,
concepto varchar(100) not null,
importegravado decimal(18, 2) not null,
importeexento decimal(18, 2) not null,
valormercado decimal(18, 2),
precioalotorgarse decimal(18, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesdetalle add constraint pk_cfdi2percepcionesdetalle primary key (idpercepcion);
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesdetalle alter column idpercepcion set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesdetalle alter column idnomina set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesdetalle alter column tipopercepcion set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesdetalle alter column clave set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesdetalle alter column concepto set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesdetalle alter column importegravado set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesdetalle
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesdetalle alter column importeexento set not null;
