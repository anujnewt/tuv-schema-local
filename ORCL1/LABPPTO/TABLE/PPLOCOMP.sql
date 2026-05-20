-- dmap_object_gen_tag : type : table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
create table "pplocomp"  (
com_keycia varchar(4) not null,
com_keyver numeric(38) not null,
com_keycen varchar(16) not null,
com_keyemp numeric(38) not null,
com_keycon numeric(38) not null,
com_keytpo numeric(38) not null,
com_descen varchar(41) not null,
com_nomemp varchar(60) not null,
com_puesto varchar(40) not null,
com_tipemp varchar(6) not null,
com_descon varchar(35) not null,
com_eneppt decimal(20, 2) not null default 0.00,
com_febppt decimal(20, 2) not null default 0.00,
com_marppt decimal(20, 2) not null default 0.00,
com_abrppt decimal(20, 2) not null default 0.00,
com_mayppt decimal(20, 2) not null default 0.00,
com_junppt decimal(20, 2) not null default 0.00,
com_julppt decimal(20, 2) not null default 0.00,
com_agoppt decimal(20, 2) not null default 0.00,
com_sepppt decimal(20, 2) not null default 0.00,
com_octppt decimal(20, 2) not null default 0.00,
com_novppt decimal(20, 2) not null default 0.00,
com_dicppt decimal(20, 2) not null default 0.00,
com_enegto decimal(20, 2) not null default 0.00,
com_febgto decimal(20, 2) not null default 0.00,
com_margto decimal(20, 2) not null default 0.00,
com_abrgto decimal(20, 2) not null default 0.00,
com_maygto decimal(20, 2) not null default 0.00,
com_jungto decimal(20, 2) not null default 0.00,
com_julgto decimal(20, 2) not null default 0.00,
com_agogto decimal(20, 2) not null default 0.00,
com_sepgto decimal(20, 2) not null default 0.00,
com_octgto decimal(20, 2) not null default 0.00,
com_novgto decimal(20, 2) not null default 0.00,
com_dicgto decimal(20, 2) not null default 0.00
) ;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_keyver set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_keycen set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_keytpo set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_descen set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_nomemp set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_puesto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_tipemp set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_descon set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_eneppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_febppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_marppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_abrppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_mayppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_junppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_julppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_agoppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_sepppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_octppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_novppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_dicppt set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_enegto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_febgto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_margto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_abrgto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_maygto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_jungto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_julgto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_agogto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_sepgto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_octgto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_novgto set not null;
-- dmap_object_gen_tag : type : alter table name : pplocomp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocomp alter column com_dicgto set not null;
