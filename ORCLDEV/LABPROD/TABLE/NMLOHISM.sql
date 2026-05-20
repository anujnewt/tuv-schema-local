-- dmap_object_gen_tag : type : table name : nmlohism
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlohism"  (
his_keyemp numeric(10) not null,
his_keycon varchar(3) not null,
his_keypro numeric(5) not null,
his_keydep varchar(16),
his_keypue varchar(16),
his_cantid decimal(16, 2),
his_import decimal(16, 2),
his_fecmov timestamp(0),
his_keyper varchar(7) not null,
his_keynom numeric(5),
his_codimp varchar(2),
his_codacu varchar(2),
his_ca1aux varchar(16),
his_ca2aux varchar(16),
his_rowide decimal(16, 6),
his_uniope numeric(5),
his_keyplz numeric(38),
his_tipplz varchar(2),
his_keyben numeric(5),
his_comfam numeric(5)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlohism
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlohism alter column his_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmlohism
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlohism alter column his_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : nmlohism
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlohism alter column his_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : nmlohism
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlohism alter column his_keyper set not null;
