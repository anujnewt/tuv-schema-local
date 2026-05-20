-- dmap_object_gen_tag : type : table name : cfdi2horasextra
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdi2horasextra"  (
idnomina numeric(10) not null,
idpercepcion numeric(10) not null,
dias numeric(10),
tipohoras varchar(2),
horasextra numeric(10),
importepagado decimal(18, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2horasextra
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2horasextra alter column idnomina set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2horasextra
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2horasextra alter column idpercepcion set not null;
