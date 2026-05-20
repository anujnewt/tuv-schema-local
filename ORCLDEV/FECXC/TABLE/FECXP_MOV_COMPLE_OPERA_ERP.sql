-- dmap_object_gen_tag : type : table name : fecxp_mov_comple_opera_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_mov_comple_opera_erp"  (
secuencia_mc_erp numeric(38) not null,
origen_poliza varchar(25) not null,
je_header_id varchar(15) not null,
moneda varchar(3),
fecha_efectiva timestamp(0),
importe_linea decimal(20, 4),
monto_deb_mon_orig numeric,
monto_cre_mon_orig numeric,
monto_deb_mon_conv numeric,
monto_cre_mon_conv numeric,
libro_id numeric(15),
code_combination_id numeric,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_opera_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_opera_erp add constraint pk_fecxp_mov_comple_opera_erp primary key (secuencia_mc_erp);
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_opera_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_opera_erp alter column secuencia_mc_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_opera_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_opera_erp alter column origen_poliza set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_opera_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_opera_erp alter column je_header_id set not null;
