-- dmap_object_gen_tag : type : table name : cfdi2percepcionestotal
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2percepcionestotal"  (
idnomina numeric(10) not null,
totalsueldos decimal(18, 2),
totalseparacionindemnizacion decimal(18, 2),
totaljubilacionpensionretiro decimal(18, 2),
totalgravado decimal(18, 2) not null,
totalexento decimal(18, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionestotal
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionestotal add constraint pk_cfdi2percepcionestotal primary key (idnomina);
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionestotal
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionestotal alter column idnomina set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionestotal
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionestotal alter column totalgravado set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2percepcionestotal
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2percepcionestotal alter column totalexento set not null;
