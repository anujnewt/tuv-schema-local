-- dmap_object_gen_tag : type : table name : cfdi2incapacidades
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2incapacidades"  (
idnomina numeric(10) not null,
diasincapacidad numeric(10) not null,
tipoincapacidad varchar(2) not null,
importemonetario decimal(18, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2incapacidades
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2incapacidades alter column idnomina set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2incapacidades
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2incapacidades alter column diasincapacidad set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2incapacidades
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2incapacidades alter column tipoincapacidad set not null;
