-- dmap_object_gen_tag : type : table name : feci_regn_conc_cat
set search_path = feci,oracle,dmap_extension,public;
create table "feci_regn_conc_cat"  (
id_region numeric,
id_concepto numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_regn_conc_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_regn_conc_cat alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_regn_conc_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_regn_conc_cat alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_regn_conc_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_regn_conc_cat alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_regn_conc_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_regn_conc_cat alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_regn_conc_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_regn_conc_cat alter column ind_estado set not null;
-- dmap_object_gen_tag : type : alter table name : feci_regn_conc_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_regn_conc_cat add constraint fk_feci_reg_feci_reco_feci_con foreign key (id_concepto) references feci_concepto_cat(id_concepto) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : feci_regn_conc_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_regn_conc_cat add constraint fk_feci_reg_feci_reco_feci_reg foreign key (id_region) references feci_region_cat(id_region) on delete no action not deferrable initially immediate;
