-- dmap_object_gen_tag : type : table name : fecxp_rep_ppto_com_cta_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_rep_ppto_com_cta_erp"  (
cla_fe_id varchar(25),
e_codigo numeric(38),
code_combination_id numeric not null,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
moneda varchar(3),
id_sesion varchar(25)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_com_cta_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_com_cta_erp alter column code_combination_id set not null;
