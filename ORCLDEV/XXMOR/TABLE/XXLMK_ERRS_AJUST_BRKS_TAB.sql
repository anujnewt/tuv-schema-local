-- dmap_object_gen_tag : type : table name : xxlmk_errs_ajust_brks_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_errs_ajust_brks_tab"  (
id_error numeric(38) not null,
id_ajuste_breaks numeric(38) not null,
des_error varchar(1000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_ajust_brks_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_ajust_brks_tab alter column id_error set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_ajust_brks_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_ajust_brks_tab alter column id_ajuste_breaks set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_ajust_brks_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_ajust_brks_tab add constraint xxlmkerrsajustbrkstab_fk1 foreign key (id_ajuste_breaks) references xxlmk_ajuste_breaks_tab(id_ajuste_breaks) on delete no action not deferrable initially immediate;
