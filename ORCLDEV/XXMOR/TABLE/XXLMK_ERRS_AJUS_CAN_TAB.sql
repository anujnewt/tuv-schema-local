-- dmap_object_gen_tag : type : table name : xxlmk_errs_ajus_can_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_errs_ajus_can_tab"  (
id_error numeric(38) not null,
id_ajuste_breaks numeric(38) not null,
id_canal numeric(38) not null,
des_error varchar(1000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_ajus_can_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_ajus_can_tab add primary key (id_error);
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_ajus_can_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_ajus_can_tab alter column id_ajuste_breaks set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_ajus_can_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_ajus_can_tab alter column id_canal set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_ajus_can_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_ajus_can_tab add constraint xxlmkerrsajuscantab_fk1 foreign key (id_ajuste_breaks,id_canal) references xxlmk_ajus_brks_canales_tab(id_ajuste_breaks,id_canal) on delete no action not deferrable initially immediate;
