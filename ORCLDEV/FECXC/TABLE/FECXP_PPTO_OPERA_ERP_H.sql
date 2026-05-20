-- dmap_object_gen_tag : type : table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ppto_opera_erp_h"  (
e_codigo numeric(38) not null,
secuencia_ptto_oracle numeric(38) not null,
periodo_extraccion numeric(15) not null,
mes_de_extraccion numeric(15) not null,
periodo_ppto numeric(38) not null,
libro_id numeric(15) not null,
version_id numeric(15) not null,
moneda varchar(3) not null,
code_combination_id numeric not null,
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null,
ppto_01 numeric not null,
pss_01 numeric not null,
usd_01 numeric not null,
eur_01 numeric not null,
ppto_02 numeric not null,
pss_02 numeric not null,
usd_02 numeric not null,
eur_02 numeric not null,
ppto_03 numeric not null,
pss_03 numeric not null,
usd_03 numeric not null,
eur_03 numeric not null,
ppto_04 numeric not null,
pss_04 numeric not null,
usd_04 numeric not null,
eur_04 numeric not null,
ppto_05 numeric not null,
pss_05 numeric not null,
usd_05 numeric not null,
eur_05 numeric not null,
ppto_06 numeric not null,
pss_06 numeric not null,
usd_06 numeric not null,
eur_06 numeric not null,
ppto_07 numeric not null,
pss_07 numeric not null,
usd_07 numeric not null,
eur_07 numeric not null,
ppto_08 numeric not null,
pss_08 numeric not null,
usd_08 numeric not null,
eur_08 numeric not null,
ppto_09 numeric not null,
pss_09 numeric not null,
usd_09 numeric not null,
eur_09 numeric not null,
ppto_10 numeric not null,
pss_10 numeric not null,
usd_10 numeric not null,
eur_10 numeric not null,
ppto_11 numeric not null,
pss_11 numeric not null,
usd_11 numeric not null,
eur_11 numeric not null,
ppto_12 numeric not null,
pss_12 numeric not null,
usd_12 numeric not null,
eur_12 numeric not null,
version_fe numeric(38) not null default (0),
tc_01 numeric,
tc_02 numeric,
tc_03 numeric,
tc_04 numeric,
tc_05 numeric,
tc_06 numeric,
tc_07 numeric,
tc_08 numeric,
tc_09 numeric,
tc_10 numeric,
tc_11 numeric,
tc_12 numeric,
mon_func varchar(3),
mon_orig varchar(3),
id_version numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h add constraint pk_fecxp_presupuesto_h primary key (e_codigo,secuencia_ptto_oracle,version_fe,id_version);
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column secuencia_ptto_oracle set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column periodo_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column mes_de_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column periodo_ppto set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column libro_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column version_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column moneda set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column code_combination_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column oracle_segmento1 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column oracle_segmento2 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column oracle_segmento3 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column oracle_segmento4 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column oracle_segmento5 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column oracle_segmento6 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column oracle_segmento7 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_01 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_01 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_01 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_01 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_02 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_02 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_02 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_02 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_03 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_03 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_03 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_03 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_04 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_04 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_04 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_04 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_05 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_05 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_05 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_05 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_06 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_06 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_06 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_06 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_07 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_07 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_07 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_07 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_08 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_08 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_08 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_08 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_09 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_09 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_09 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_09 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_10 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_10 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_10 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_10 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_11 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_11 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_11 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_11 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column ppto_12 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column pss_12 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column usd_12 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_opera_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_opera_erp_h alter column eur_12 set not null;
