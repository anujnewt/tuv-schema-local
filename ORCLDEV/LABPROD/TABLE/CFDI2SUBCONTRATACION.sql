-- dmap_object_gen_tag : type : table name : cfdi2subcontratacion
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdi2subcontratacion"  (
idnomina numeric(10) not null,
rfclabora varchar(13),
porcentajetiempo decimal(10, 3)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2subcontratacion
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2subcontratacion alter column idnomina set not null;
