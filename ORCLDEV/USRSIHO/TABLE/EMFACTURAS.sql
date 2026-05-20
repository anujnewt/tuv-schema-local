-- dmap_object_gen_tag : type : table name : emfacturas
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emfacturas"  (
fac_numfac numeric(10) not null,
fac_cencos varchar(16) not null,
fac_numage numeric(10) not null,
fac_fecha timestamp(0) not null,
fac_descri varchar(100) not null,
fac_import decimal(18, 2) not null,
fac_iva decimal(15, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : emfacturas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emfacturas alter column fac_numfac set not null;
-- dmap_object_gen_tag : type : alter table name : emfacturas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emfacturas alter column fac_cencos set not null;
-- dmap_object_gen_tag : type : alter table name : emfacturas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emfacturas alter column fac_numage set not null;
-- dmap_object_gen_tag : type : alter table name : emfacturas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emfacturas alter column fac_fecha set not null;
-- dmap_object_gen_tag : type : alter table name : emfacturas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emfacturas alter column fac_descri set not null;
-- dmap_object_gen_tag : type : alter table name : emfacturas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emfacturas alter column fac_import set not null;
-- dmap_object_gen_tag : type : alter table name : emfacturas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emfacturas alter column fac_iva set not null;
