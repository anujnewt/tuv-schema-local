-- dmap_object_gen_tag : type : table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ppto_operativo_soin"  (
secuencia_ppto_operativo_soin numeric(38) not null,
e_codigo numeric(38) not null,
periodo numeric(38) not null,
mescod numeric(38) not null,
arsmap varchar(3) not null,
aejmap varchar(3) not null,
cncmap varchar(3) not null,
ctacr1 varchar(3),
ctacr2 varchar(4),
importe_linea decimal(20, 4) not null,
moneda varchar(3) not null,
periodo_extraccion numeric(15) default (nullif(to_char(statement_timestamp(),
'yyyy'),
'')::numeric),
mes_extraccion numeric(38) default (nullif(to_char(statement_timestamp(),
'mm'),
'')::numeric),
tipo_cambio decimal(20, 11) not null,
version_fe numeric(38) not null default (0)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_operativo_soin add constraint pk_fecxp_ppto_operativo_soin primary key (e_codigo,secuencia_ppto_operativo_soin,version_fe);
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_operativo_soin alter column secuencia_ppto_operativo_soin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_operativo_soin alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_operativo_soin alter column periodo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_operativo_soin alter column mescod set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_operativo_soin alter column arsmap set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_operativo_soin alter column aejmap set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_operativo_soin alter column cncmap set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_operativo_soin alter column importe_linea set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_operativo_soin alter column moneda set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_operativo_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_operativo_soin alter column tipo_cambio set not null;
