-- dmap_object_gen_tag : type : table name : fecxp_monedas_set
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_monedas_set"  (
mon_set varchar(3) not null,
des_set varchar(20) not null,
mon_oracle varchar(3),
mon_sybase varchar(3),
fec_ingreso timestamp(0) not null default statement_timestamp()
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas_set add constraint pk_fecxp_monedas_set primary key (mon_set);
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas_set alter column mon_set set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas_set alter column des_set set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_monedas_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_monedas_set alter column fec_ingreso set not null;
