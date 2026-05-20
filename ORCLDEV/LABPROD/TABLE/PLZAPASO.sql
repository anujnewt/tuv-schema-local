-- dmap_object_gen_tag : type : table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
create table "plzapaso"  (
ora_noctvo numeric(38) not null,
plz_keyest varchar(3) not null,
plz_keydep varchar(16) not null,
plz_keypue varchar(16) not null,
plz_keyplz numeric(38) not null,
plz_keycat varchar(16),
plz_keyloc varchar(16),
plz_tippla varchar(2) not null,
plz_fecini timestamp(0) not null,
plz_fecfin timestamp(0),
plz_diavig numeric(38),
plz_turnop numeric(38),
plz_keyhor varchar(16),
plz_keyemp numeric(38) not null,
plz_cveuoc numeric(38),
plz_cverem numeric(38),
plz_fecmov timestamp(0),
plz_submov varchar(2),
plz_cosplz decimal(14, 2),
plz_ca1aux varchar(16) not null,
plz_ca2aux varchar(16) not null,
plz_ca3aux varchar(16),
plz_nu1aux varchar(10),
plz_nu2aux varchar(10),
plz_nu3aux varchar(10),
plz_fe1aux varchar(10),
plz_fe2aux varchar(10),
plz_fe3aux timestamp(0),
plz_co1aux decimal(14, 2),
plz_co2aux decimal(14, 2),
plz_co3aux decimal(14, 2),
plz_co4aux decimal(14, 2),
plz_co5aux decimal(14, 2),
plz_keysue varchar(4),
plz_sueniv numeric(38),
plz_subniv numeric(38),
plz_cobert varchar(2),
plz_keypro numeric(38) not null,
plz_keydpl decimal(16, 6),
plz_fecocu timestamp(0),
plz_salplz decimal(12, 2) not null,
plz_titula numeric(38),
plz_origen varchar(2),
plz_valimp varchar(2),
plz_limocu timestamp(0),
plz_tiptab varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column ora_noctvo set not null;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column plz_keyest set not null;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column plz_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column plz_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column plz_keyplz set not null;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column plz_tippla set not null;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column plz_fecini set not null;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column plz_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column plz_ca1aux set not null;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column plz_ca2aux set not null;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column plz_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : plzapaso
set search_path = labprod,oracle,dmap_extension,public;
alter table plzapaso alter column plz_salplz set not null;
