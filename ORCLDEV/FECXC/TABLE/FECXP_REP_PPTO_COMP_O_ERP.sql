-- dmap_object_gen_tag : type : table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_rep_ppto_comp_o_erp"  (
e_codigo numeric(38) not null,
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
tipo_cambio_01 numeric default (0),
ppto_02 numeric not null,
pss_02 numeric not null,
usd_02 numeric not null,
eur_02 numeric not null,
tipo_cambio_02 numeric default (0),
ppto_03 numeric not null,
pss_03 numeric not null,
usd_03 numeric not null,
eur_03 numeric not null,
tipo_cambio_03 numeric default (0),
ppto_04 numeric not null,
pss_04 numeric not null,
usd_04 numeric not null,
eur_04 numeric not null,
tipo_cambio_04 numeric default (0),
ppto_05 numeric not null,
pss_05 numeric not null,
usd_05 numeric not null,
eur_05 numeric not null,
tipo_cambio_05 numeric default (0),
ppto_06 numeric not null,
pss_06 numeric not null,
usd_06 numeric not null,
eur_06 numeric not null,
tipo_cambio_06 numeric default (0),
ppto_07 numeric not null,
pss_07 numeric not null,
usd_07 numeric not null,
eur_07 numeric not null,
tipo_cambio_07 numeric default (0),
ppto_08 numeric not null,
pss_08 numeric not null,
usd_08 numeric not null,
eur_08 numeric not null,
tipo_cambio_08 numeric default (0),
ppto_09 numeric not null,
pss_09 numeric not null,
usd_09 numeric not null,
eur_09 numeric not null,
tipo_cambio_09 numeric default (0),
ppto_10 numeric not null,
pss_10 numeric not null,
usd_10 numeric not null,
eur_10 numeric not null,
tipo_cambio_10 numeric default (0),
ppto_11 numeric not null,
pss_11 numeric not null,
usd_11 numeric not null,
eur_11 numeric not null,
tipo_cambio_11 numeric default (0),
ppto_12 numeric not null,
pss_12 numeric not null,
usd_12 numeric not null,
eur_12 numeric not null,
tipo_cambio_12 numeric default (0)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column periodo_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column mes_de_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column periodo_ppto set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column libro_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column version_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column moneda set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column code_combination_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column oracle_segmento1 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column oracle_segmento2 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column oracle_segmento3 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column oracle_segmento4 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column oracle_segmento5 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column oracle_segmento6 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column oracle_segmento7 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_01 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_01 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_01 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_01 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_02 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_02 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_02 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_02 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_03 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_03 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_03 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_03 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_04 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_04 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_04 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_04 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_05 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_05 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_05 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_05 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_06 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_06 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_06 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_06 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_07 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_07 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_07 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_07 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_08 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_08 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_08 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_08 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_09 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_09 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_09 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_09 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_10 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_10 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_10 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_10 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_11 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_11 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_11 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_11 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column ppto_12 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column pss_12 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column usd_12 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_o_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_o_erp alter column eur_12 set not null;
