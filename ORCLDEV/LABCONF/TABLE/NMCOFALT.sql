-- dmap_object_gen_tag : type : table name : nmcofalt
set search_path = labconf,oracle,dmap_extension,public;
create table "nmcofalt"  (
fal_keyemp numeric(10) not null,
fal_fecini timestamp(0),
fal_fecexp timestamp(0),
fal_diainc numeric(38),
fal_coninc varchar(1),
fal_numinc varchar(14),
fal_tipims varchar(2),
fal_tipemp varchar(6),
fal_dianoa numeric(38),
fal_emiinc varchar(20),
fal_keyims varchar(5),
fal_codaux varchar(10),
fal_pertra varchar(7),
fal_contra varchar(3),
fal_perpag varchar(7),
fal_conpag varchar(3),
fal_recinc varchar(1),
fal_cirinc varchar(2),
fal_prorie varchar(1),
fal_tiprie varchar(1),
fal_tipdic varchar(1),
fal_porval decimal(6, 2),
fal_folst1 numeric(38),
fal_folst2 numeric(38),
fal_folst3 numeric(38),
fal_folst4 numeric(38),
fal_codau2 varchar(10),
fal_codau3 varchar(10),
fal_codau4 varchar(10),
fal_codau5 varchar(10),
fal_keytrp decimal(16, 6)
) ;
-- dmap_object_gen_tag : type : alter table name : nmcofalt
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcofalt alter column fal_keyemp set not null;
