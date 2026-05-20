-- dmap_object_gen_tag : type : table name : xxlmk_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create table "xxlmk_procesos_tab"  (
id_proceso numeric not null,
nom_proceso varchar(100) not null,
des_proceso varchar(1000),
ind_estatus numeric,
ind_tipo_proceso numeric not null,
fec_creacion timestamp(0) default statement_timestamp(),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0) default statement_timestamp(),
cve_actualizado_por varchar(100) not null,
des_started_by_uuid varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_procesos_tab add primary key (id_proceso);
-- dmap_object_gen_tag : type : alter table name : xxlmk_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_procesos_tab alter column id_proceso set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_procesos_tab alter column nom_proceso set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_procesos_tab alter column ind_tipo_proceso set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_procesos_tab alter column cve_creado_por set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_procesos_tab alter column cve_actualizado_por set not null;
