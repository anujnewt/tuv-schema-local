-- dmap_object_gen_tag : type : table name : nmloacum
set search_path = labprod,oracle,dmap_extension,public;
create table "nmloacum"  (
acu_keyemp numeric(38) not null,
acu_keycon varchar(3) not null,
acu_keypro numeric(38),
acu_uniuno decimal(14, 2),
acu_unidos decimal(14, 2),
acu_unitre decimal(14, 2),
acu_unicua decimal(14, 2),
acu_unicin decimal(14, 2),
acu_unisei decimal(14, 2),
acu_unisie decimal(14, 2),
acu_unioch decimal(14, 2),
acu_uninue decimal(14, 2),
acu_unidie decimal(14, 2),
acu_unionc decimal(14, 2),
acu_unidoc decimal(14, 2),
acu_unitrc decimal(14, 2),
acu_unicat decimal(14, 2),
acu_uniqui decimal(14, 2),
acu_impuno decimal(14, 2),
acu_impdos decimal(14, 2),
acu_imptre decimal(14, 2),
acu_impcua decimal(14, 2),
acu_impcin decimal(14, 2),
acu_impsei decimal(14, 2),
acu_impsie decimal(14, 2),
acu_impoch decimal(14, 2),
acu_impnue decimal(14, 2),
acu_impdie decimal(14, 2),
acu_imponc decimal(14, 2),
acu_impdoc decimal(14, 2),
acu_imptrc decimal(14, 2),
acu_impcat decimal(14, 2),
acu_impqui decimal(14, 2),
acu_anioac numeric(4)
) ;
-- dmap_object_gen_tag : type : alter table name : nmloacum
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloacum alter column acu_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmloacum
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloacum alter column acu_keycon set not null;
