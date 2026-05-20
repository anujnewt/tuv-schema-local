-- dmap_object_gen_tag : type : table name : cfdi2percepcionesjubilacion
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2percepcionesjubilacion"  (
idnomina numeric(10) not null,
totalunaexhibicion decimal(18, 2),
totalparcialidad decimal(18, 2),
montodiario decimal(18, 2),
ingresoacumulable decimal(18, 2) not null,
ingresonoacumulable decimal(18, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesjubilacion
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesjubilacion add constraint pk_cfdi2percepcionesjubilacion primary key (idnomina);
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesjubilacion
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesjubilacion alter column idnomina set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesjubilacion
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesjubilacion alter column ingresoacumulable set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesjubilacion
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesjubilacion alter column ingresonoacumulable set not null;
