-- dmap_object_gen_tag : type : table name : fecxp_monedas_no_set
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_monedas_no_set"  (
mon_sybase varchar(3),
mon_oracle varchar(3),
des_sybase varchar(40),
des_oracle varchar(80),
mon_set varchar(3),
tipo_cambio decimal(20, 11) not null default 1,
fec_ingreso timestamp(0) not null default statement_timestamp(),
mes numeric(38) not null,
periodo numeric(38),
des_set varchar(20),
atributo1 varchar(255),
fecha_actualizacion timestamp(0),
mon_no_set varchar(5),
des_no_set varchar(255),
tipo_empresa varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas_no_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas_no_set alter column tipo_cambio set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas_no_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas_no_set alter column fec_ingreso set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas_no_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas_no_set alter column mes set not null;
