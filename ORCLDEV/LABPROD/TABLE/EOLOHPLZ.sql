-- dmap_object_gen_tag : type : table name : eolohplz
set search_path = labprod,oracle,dmap_extension,public;
create table "eolohplz"  (
id numeric(38) not null,
plz_keyplz numeric(38) not null,
plz_keysol numeric(38) not null,
plz_keypro numeric(38) not null,
plz_keyest varchar(3) not null,
plz_keydep varchar(16) not null,
plz_keypue varchar(16) not null,
plz_keycen varchar(16),
plz_keycat varchar(16),
plz_keyloc varchar(16),
plz_keyims varchar(5),
plz_tipplz varchar(3),
plz_tipcon varchar(1),
plz_contra varchar(3),
plz_fecini timestamp(0),
plz_fecfin timestamp(0),
plz_turnop numeric(38),
plz_keyhor varchar(16),
plz_keyemp numeric(38),
plz_cveuoc numeric(38),
plz_titula numeric(38),
plz_cverem numeric(38),
plz_status varchar(1),
plz_keymot varchar(6),
plz_fecmov timestamp(0),
plz_hormov varchar(8),
plz_cosplz decimal(14, 2),
plz_keysue varchar(4),
plz_tiptab varchar(2),
plz_sueniv numeric(38),
plz_subniv numeric(38),
plz_cobert varchar(2),
plz_fecocu timestamp(0),
plz_salplz decimal(14, 2),
plz_origen varchar(6),
plz_codocu varchar(6),
plz_limocu timestamp(0),
plz_ca1aux varchar(100),
plz_ca2aux varchar(100),
plz_ca3aux varchar(100),
plz_ca4aux varchar(100),
plz_ca5aux varchar(100),
plz_ca6aux varchar(100),
plz_ca7aux varchar(100),
plz_ca8aux varchar(100),
plz_tipope varchar(2),
plz_keyusu numeric
) ;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolohplz add constraint eolohplz_pk primary key (id);
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolohplz alter column id set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolohplz alter column plz_keyplz set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolohplz alter column plz_keysol set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolohplz alter column plz_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolohplz alter column plz_keyest set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolohplz alter column plz_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolohplz alter column plz_keypue set not null;
