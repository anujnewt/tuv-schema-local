-- dmap_object_gen_tag : type : table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
create table "pptohyperion"  (
pto_ciamadre varchar(3),
pto_tipocia varchar(1),
pto_cia varchar(3) not null,
pto_neg varchar(2) not null,
pto_cta varchar(3) not null,
pto_scta varchar(6) not null,
pto_cc varchar(8) not null,
pto_icia varchar(3) not null,
pto_top varchar(1) not null,
pto_moneda numeric(1) not null,
pto_keyver numeric(6) not null,
pto_ene decimal(20, 2) not null,
pto_feb decimal(20, 2) not null,
pto_mar decimal(20, 2) not null,
pto_abr decimal(20, 2) not null,
pto_may decimal(20, 2) not null,
pto_jun decimal(20, 2) not null,
pto_jul decimal(20, 2) not null,
pto_ago decimal(20, 2) not null,
pto_sep decimal(20, 2) not null,
pto_oct decimal(20, 2) not null,
pto_nov decimal(20, 2) not null,
pto_dic decimal(20, 2) not null,
pto_tipreg varchar(2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_cia set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_neg set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_cta set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_scta set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_cc set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_icia set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_top set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_keyver set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_ene set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_feb set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_mar set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_abr set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_may set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_jun set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_jul set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_ago set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_sep set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_oct set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_nov set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_dic set not null;
-- dmap_object_gen_tag : type : alter table name : pptohyperion
set search_path = labppto,oracle,dmap_extension,public;
alter table pptohyperion alter column pto_tipreg set not null;
