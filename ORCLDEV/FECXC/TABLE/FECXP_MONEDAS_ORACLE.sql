-- dmap_object_gen_tag : type : table name : fecxp_monedas_oracle
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_monedas_oracle"  (
mon_oracle varchar(3) not null,
des_oracle varchar(80) not null,
fec_ingreso timestamp(0) not null default statement_timestamp()
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas_oracle
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas_oracle add constraint pk_fecxp_monedas_oracle primary key (mon_oracle);
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas_oracle
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas_oracle alter column mon_oracle set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas_oracle
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas_oracle alter column des_oracle set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas_oracle
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas_oracle alter column fec_ingreso set not null;
