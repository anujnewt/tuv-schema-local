-- dmap_object_gen_tag : type : table name : fecxp_saldos_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_saldos_operativo_soin"  (
secuencia_saldos_opera_soin numeric(38) not null,
e_codigo numeric(38) not null,
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
moneda varchar(3),
periodo numeric(38),
mes numeric(38),
saldo_inicial_mo decimal(20, 2),
debito_inicial_mo decimal(20, 2),
credito_inicial_mo decimal(20, 2),
saldo_inicial_me decimal(20, 2),
debito_inicial_me decimal(20, 2),
credito_inicial_me decimal(20, 2),
mes_extraccion numeric(38) default (nullif(to_char(statement_timestamp(),
'mm'),
'')::numeric),
periodo_extraccion numeric(15) default (nullif(to_char(statement_timestamp(),
'yy'),
'')::numeric)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_soin add constraint pk_fexcp_saldos_operativo_soin primary key (e_codigo,secuencia_saldos_opera_soin);
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_soin alter column secuencia_saldos_opera_soin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_saldos_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_saldos_operativo_soin alter column e_codigo set not null;
