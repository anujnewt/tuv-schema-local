-- dmap_object_gen_tag : type : table name : fecxp_ctas_clasif_ppto_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ctas_clasif_ppto_erp"  (
cla_fe_id varchar(25),
e_codigo numeric(38),
code_combination_id numeric(38),
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_ctas_clasif_ppto_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ctas_clasif_ppto_erp add constraint idx_segmentos_car_erp primary key (oracle_segmento1,oracle_segmento2,oracle_segmento3,oracle_segmento4,oracle_segmento5,oracle_segmento6,oracle_segmento7);
