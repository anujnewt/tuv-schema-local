-- dmap_object_gen_tag : type : table name : fecxp_monedas
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_monedas"  (
mon_sybase varchar(3) not null,
mon_oracle varchar(3) not null,
des_sybase varchar(40) not null,
des_oracle varchar(80) not null,
mon_set varchar(3) not null,
tipo_cambio decimal(20, 11) not null default 1,
fec_ingreso timestamp(0) not null default statement_timestamp(),
mes numeric(38) not null,
periodo numeric(38) not null,
des_set varchar(20),
atributo1 varchar(255),
fecha_actualizacion timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas add constraint pk_fecxp_monedas primary key (mon_set,mes,periodo);
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas alter column mon_sybase set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas alter column mon_oracle set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas alter column des_sybase set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas alter column des_oracle set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas alter column mon_set set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas alter column tipo_cambio set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas alter column fec_ingreso set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas alter column mes set not null;
