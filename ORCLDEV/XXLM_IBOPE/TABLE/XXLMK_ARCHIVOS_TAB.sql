-- dmap_object_gen_tag : type : table name : xxlmk_archivos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create table "xxlmk_archivos_tab"  (
id_archivo numeric not null,
nom_archivo varchar(1000) not null,
des_archivo bytea,
des_desc_archivo varchar(4000),
ind_estatus numeric,
fec_creacion timestamp(0) default statement_timestamp(),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0) not null default statement_timestamp(),
cve_actualizado_por varchar(100) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_tab add constraint xxmkl_archivos_pk primary key (id_archivo);
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_tab alter column id_archivo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_tab alter column nom_archivo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_tab alter column cve_creado_por set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_tab alter column fec_actualizacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_archivos_tab alter column cve_actualizado_por set not null;
