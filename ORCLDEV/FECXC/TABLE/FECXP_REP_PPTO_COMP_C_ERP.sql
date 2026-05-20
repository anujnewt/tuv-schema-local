-- dmap_object_gen_tag : type : table name : fecxp_rep_ppto_comp_c_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_rep_ppto_comp_c_erp"  (
e_codigo numeric(38) not null,
periodo_extraccion numeric(15) not null,
mes_de_extraccion numeric(15) not null,
periodo_ppto numeric(38) not null,
libro_id numeric(15) not null,
version_id numeric(15) not null,
moneda varchar(3) not null,
code_combination_id numeric not null,
ppto_01 numeric default (0),
ppto_02 numeric default (0),
ppto_03 numeric default (0),
ppto_04 numeric default (0),
ppto_05 numeric default (0),
ppto_06 numeric default (0),
ppto_07 numeric default (0),
ppto_08 numeric default (0),
ppto_09 numeric default (0),
ppto_10 numeric default (0),
ppto_11 numeric default (0),
ppto_12 numeric default (0),
presupuesto_estatus varchar(20) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_c_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_c_erp alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_c_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_c_erp alter column periodo_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_c_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_c_erp alter column mes_de_extraccion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_c_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_c_erp alter column periodo_ppto set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_c_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_c_erp alter column libro_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_c_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_c_erp alter column version_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_c_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_c_erp alter column moneda set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_c_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_c_erp alter column code_combination_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_ppto_comp_c_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_ppto_comp_c_erp alter column presupuesto_estatus set not null;
