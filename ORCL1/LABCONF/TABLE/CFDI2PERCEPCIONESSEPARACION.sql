-- dmap_object_gen_tag : type : table name : cfdi2percepcionesseparacion
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2percepcionesseparacion"  (
idnomina numeric(10) not null,
totalpagado decimal(18, 2) not null,
numaniosservicio numeric(10) not null,
ultimosueldomensord decimal(18, 2) not null,
ingresoacumulable decimal(18, 2) not null,
ingresonoacumulable decimal(18, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesseparacion
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesseparacion add constraint pk_cfdi2percepcionesseparacion primary key (idnomina);
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesseparacion
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesseparacion alter column idnomina set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesseparacion
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesseparacion alter column totalpagado set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesseparacion
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesseparacion alter column numaniosservicio set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesseparacion
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesseparacion alter column ultimosueldomensord set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesseparacion
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesseparacion alter column ingresoacumulable set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionesseparacion
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionesseparacion alter column ingresonoacumulable set not null;
