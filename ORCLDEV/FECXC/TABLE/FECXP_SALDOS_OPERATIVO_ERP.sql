-- dmap_object_gen_tag : type : table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_saldos_operativo_erp"  (
secuencia_saldos_opera_erp numeric(38) not null,
periodo numeric(38),
mes numeric(38),
e_codigo numeric(38) not null,
periodo_extraccion numeric(15) not null default (nullif(to_char(statement_timestamp(),
'YYYY'),
'')::numeric),
mes_de_extraccion numeric(15) not null,
libro_id numeric(15) not null,
moneda varchar(3) not null,
code_combination_id numeric not null,
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null,
saldo_inicial_mo decimal(20, 2) not null,
debito_inicial_mo decimal(20, 2) not null,
credito_inicial_mo decimal(20, 2) not null,
saldo_final_mo decimal(20, 2) not null,
saldo_inicial_me decimal(20, 2) not null,
debito_inicial_me decimal(20, 2) not null,
credito_inicial_me decimal(20, 2) not null,
saldo_final_me decimal(20, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp add constraint pk_fecxp_saldos_operativo_erp primary key (e_codigo,secuencia_saldos_opera_erp);
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column secuencia_saldos_opera_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column periodo_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column mes_de_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column libro_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column moneda set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column code_combination_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column oracle_segmento1 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column oracle_segmento2 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column oracle_segmento3 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column oracle_segmento4 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column oracle_segmento5 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column oracle_segmento6 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column oracle_segmento7 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column saldo_inicial_mo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column debito_inicial_mo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column credito_inicial_mo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column saldo_final_mo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column saldo_inicial_me set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column debito_inicial_me set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column credito_inicial_me set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_erp alter column saldo_final_me set not null;
