-- dmap_object_gen_tag : type : table name : eolohplz
set search_path = labconf,oracle,dmap_extension,public;
create table "eolohplz"  (
hpl_keyplz numeric(10) not null,
hpl_keysol numeric(10) not null,
hpl_keypro numeric(5),
hpl_keyest varchar(3) not null,
hpl_keydep varchar(16) not null,
hpl_keypue varchar(16) not null,
hpl_keycen varchar(16),
hpl_keycat varchar(16),
hpl_keyloc varchar(16),
hpl_keyims varchar(5),
hpl_tipplz varchar(3) not null,
hpl_tipcon varchar(1) not null,
hpl_contra varchar(1) not null,
hpl_fecini timestamp(0),
hpl_fecfin timestamp(0),
hpl_turnop numeric(5),
hpl_keyhor varchar(16),
hpl_keyemp numeric(10),
hpl_cveuoc numeric(10),
hpl_titula numeric(10),
hpl_cverem numeric(10),
hpl_status varchar(1),
hpl_keymot varchar(6),
hpl_fecmov timestamp(0),
hpl_hormov varchar(8),
hpl_cosplz decimal(14, 2),
hpl_keysue varchar(4),
hpl_tiptab varchar(2),
hpl_sueniv numeric(10),
hpl_subniv numeric(10),
hpl_cobert varchar(2),
hpl_fecocu timestamp(0),
hpl_salplz decimal(14, 2),
hpl_origen varchar(6),
hpl_codocu varchar(6),
hpl_limocu timestamp(0),
hpl_tipope varchar(2),
hpl_ca1aux varchar(10),
hpl_ca2aux varchar(10),
hpl_ca3aux varchar(10),
hpl_ca4aux varchar(10),
hpl_ca5aux varchar(10),
hpl_ca6aux varchar(10),
hpl_ca7aux varchar(10),
hpl_ca8aux varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labconf,oracle,dmap_extension,public;
alter table eolohplz alter column hpl_keyplz set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labconf,oracle,dmap_extension,public;
alter table eolohplz alter column hpl_keysol set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labconf,oracle,dmap_extension,public;
alter table eolohplz alter column hpl_keyest set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labconf,oracle,dmap_extension,public;
alter table eolohplz alter column hpl_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labconf,oracle,dmap_extension,public;
alter table eolohplz alter column hpl_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labconf,oracle,dmap_extension,public;
alter table eolohplz alter column hpl_tipplz set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labconf,oracle,dmap_extension,public;
alter table eolohplz alter column hpl_tipcon set not null;
-- dmap_object_gen_tag : type : alter table name : eolohplz
set search_path = labconf,oracle,dmap_extension,public;
alter table eolohplz alter column hpl_contra set not null;
