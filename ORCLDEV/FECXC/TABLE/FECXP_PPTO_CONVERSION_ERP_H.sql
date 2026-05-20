-- dmap_object_gen_tag : type : table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ppto_conversion_erp_h"  (
e_codigo numeric(38) not null,
secuencia_ptto_conversion numeric(38) not null,
periodo numeric(38) not null,
mes numeric(38) not null,
libro_id numeric(15) not null,
version_id numeric(15) not null,
moneda varchar(3) not null,
tipo_cambio decimal(20, 11) not null,
code_combination numeric(38) not null,
importe_linea decimal(20, 4) not null,
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null,
periodo_extraccion numeric(15) not null,
mes_extraccion numeric(38) not null,
presupuesto_estatus varchar(20) not null,
version_fe numeric(38) default (0),
mon_func varchar(3),
mon_orig varchar(3),
id_version numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column secuencia_ptto_conversion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column periodo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column mes set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column libro_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column version_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column moneda set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column tipo_cambio set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column code_combination set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column importe_linea set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column oracle_segmento1 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column oracle_segmento2 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column oracle_segmento3 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column oracle_segmento4 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column oracle_segmento5 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column oracle_segmento6 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column oracle_segmento7 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column periodo_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column mes_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_erp_h alter column presupuesto_estatus set not null;
