-- dmap_object_gen_tag : type : table name : cfdi2deduccionestotal
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2deduccionestotal"  (
idnomina numeric(10) not null,
totalotrasdeducciones decimal(18, 2),
totalimpuestosretenidos decimal(18, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2deduccionestotal
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2deduccionestotal add constraint pk_cfdi2deduccionestotal primary key (idnomina);
-- dmap_object_gen_tag : type : alter table name : cfdi2deduccionestotal
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2deduccionestotal alter column idnomina set not null;
