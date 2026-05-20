-- dmap_object_gen_tag : type : table name : nmcocvac
set search_path = labconf,oracle,dmap_extension,public;
create table "nmcocvac"  (
vac_keyemp numeric(38) not null,
vac_antigu numeric(38) not null,
vac_diavac decimal(6, 2),
vac_period varchar(10),
vac_fecini timestamp(0),
vac_fecfin timestamp(0),
vac_fecpre timestamp(0),
vac_dtomad decimal(6, 2),
vac_salper decimal(6, 2),
vac_status varchar(1),
vac_cosrea decimal(10, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : nmcocvac
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcocvac alter column vac_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmcocvac
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcocvac alter column vac_antigu set not null;
