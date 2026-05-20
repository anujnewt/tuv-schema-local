-- dmap_object_gen_tag : type : table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create table "xxlmk_archivos_generados_tab"  (
id_archivo_gen numeric not null,
id_archivo_ibope numeric not null,
nom_archivo varchar(256) not null,
des_archivo bytea,
ind_tipo numeric not null,
ind_estatus numeric not null,
des_desc_archivo varchar(2000),
fec_creacion timestamp(0) not null default statement_timestamp(),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0) not null default statement_timestamp(),
cve_actualizado_por varchar(100) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_generados_tab add primary key (id_archivo_gen);
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_generados_tab alter column id_archivo_gen set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_generados_tab alter column id_archivo_ibope set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_generados_tab alter column nom_archivo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_generados_tab alter column ind_tipo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_generados_tab alter column ind_estatus set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_generados_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_generados_tab alter column cve_creado_por set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_generados_tab alter column fec_actualizacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_generados_tab alter column cve_actualizado_por set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_generados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_generados_tab add constraint xxlmk_archivos_gen_tab_fk01 foreign key (id_archivo_ibope) references xxlmk_archivos_tab(id_archivo) on delete no action not deferrable initially immediate;
