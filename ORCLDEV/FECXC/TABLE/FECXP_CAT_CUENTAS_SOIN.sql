-- dmap_object_gen_tag : type : table name : fecxp_cat_cuentas_soin
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_cat_cuentas_soin"  (
e_codigo numeric(38) not null,
ctam01 varchar(3) not null,
ctam02 varchar(3) not null,
ctam03 varchar(3) not null,
cg13di numeric(38),
cg13gr numeric(38),
cg13ru numeric(38),
ctatip varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_cat_cuentas_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_cat_cuentas_soin add constraint pk_fecxp_cat_cuentas_soin primary key (e_codigo,ctam01,ctam02,ctam03);
-- dmap_object_gen_tag : type : alter table name : fecxp_cat_cuentas_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_cat_cuentas_soin alter column e_codigo set not null;
