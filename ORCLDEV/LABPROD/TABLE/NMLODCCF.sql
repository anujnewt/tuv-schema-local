-- dmap_object_gen_tag : type : table name : nmlodccf
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlodccf"  (
dcc_keycia varchar(5) not null,
dcc_keyper varchar(7) not null,
dcc_keynom numeric(38) not null,
dcc_fecini timestamp(0) not null,
dcc_fecfin timestamp(0) not null,
dcc_tipare varchar(1),
dcc_camare varchar(16),
dcc_tabare varchar(6),
dcc_tipcal varchar(1),
dcc_camcal varchar(16),
dcc_valcal varchar(2),
dcc_tipsin varchar(1),
dcc_camsin varchar(16),
dcc_tabsin varchar(6),
dcc_tipasi varchar(1),
dcc_camasi varchar(16),
dcc_tabasi varchar(6),
dcc_tipent varchar(1),
dcc_cament varchar(16),
dcc_tabent varchar(6),
dcc_datrf1 varchar(6),
dcc_datrf2 varchar(6),
dcc_datrf3 varchar(6),
dcc_tabrub varchar(6),
dcc_fecpre timestamp(0),
dcc_folpre varchar(16)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlodccf
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodccf alter column dcc_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodccf
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodccf alter column dcc_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodccf
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodccf alter column dcc_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodccf
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodccf alter column dcc_fecini set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodccf
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodccf alter column dcc_fecfin set not null;
