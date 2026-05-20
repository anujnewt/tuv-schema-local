-- dmap_object_gen_tag : type : table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ppto_opera_erp_tmp"  (
periodo_extraccion numeric(15) not null,
mes_extraccion numeric(15) not null,
yyyy numeric(38) not null,
libro_id numeric(15) not null,
version_id numeric(15) not null,
moneda varchar(3) not null,
code_combination_id numeric not null,
cia varchar(25) not null,
neg varchar(25) not null,
cta varchar(25) not null,
scta varchar(25) not null,
cc varchar(25) not null,
icia varchar(25) not null,
top varchar(25) not null,
ppto_01 numeric not null,
ppto_02 numeric not null,
ppto_03 numeric not null,
ppto_04 numeric not null,
ppto_05 numeric not null,
ppto_06 numeric not null,
ppto_07 numeric not null,
ppto_08 numeric not null,
ppto_09 numeric not null,
ppto_10 numeric not null,
ppto_11 numeric not null,
ppto_12 numeric not null,
tc_01 numeric not null,
tc_02 numeric not null,
tc_03 numeric not null,
tc_04 numeric not null,
tc_05 numeric not null,
tc_06 numeric not null,
tc_07 numeric not null,
tc_08 numeric not null,
tc_09 numeric not null,
tc_10 numeric not null,
tc_11 numeric not null,
tc_12 numeric not null,
mf varchar(3),
mo varchar(3),
version_fe numeric(38) default (0)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column periodo_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column mes_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column yyyy set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column libro_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column version_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column moneda set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column code_combination_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column cia set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column neg set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column cta set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column scta set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column cc set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column icia set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column top set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_01 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_02 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_03 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_04 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_05 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_06 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_07 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_08 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_09 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_10 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_11 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column ppto_12 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_01 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_02 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_03 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_04 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_05 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_06 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_07 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_08 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_09 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_10 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_11 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_tmp alter column tc_12 set not null;
