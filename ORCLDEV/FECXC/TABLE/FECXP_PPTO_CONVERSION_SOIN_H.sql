-- dmap_object_gen_tag : type : table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ppto_conversion_soin_h"  (
e_codigo numeric(38) not null,
secuencia_ppto_operativo_soin numeric(38) not null,
periodo numeric(38) not null,
mescod numeric(38) not null,
arsmap varchar(3) not null,
aejmap varchar(3) not null,
cncmap varchar(3) not null,
ctacr1 varchar(3),
ctacr2 varchar(4),
importe_linea decimal(20, 4) not null,
moneda varchar(3) not null,
tipo_cambio decimal(20, 11) not null,
periodo_extraccion numeric(15) default (nullif(to_char(statement_timestamp(),
'yyyy'),
'')::numeric),
mes_extraccion numeric(38) default (nullif(to_char(statement_timestamp(),
'mm'),
'')::numeric),
presupuesto_estatus varchar(20),
version_fe numeric(38) not null default (0),
id_version numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_soin_h add constraint pk_fecxp_ppto_cnversn_soin_h primary key (e_codigo,secuencia_ppto_operativo_soin,version_fe,id_version);
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_soin_h alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_soin_h alter column secuencia_ppto_operativo_soin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_soin_h alter column periodo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_soin_h alter column mescod set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_soin_h alter column arsmap set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_soin_h alter column aejmap set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_soin_h alter column cncmap set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_soin_h alter column importe_linea set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_soin_h alter column moneda set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_conversion_soin_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_conversion_soin_h alter column tipo_cambio set not null;
