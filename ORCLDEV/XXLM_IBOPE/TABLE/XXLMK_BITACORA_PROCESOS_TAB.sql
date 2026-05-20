-- dmap_object_gen_tag : type : table name : xxlmk_bitacora_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create table "xxlmk_bitacora_procesos_tab"  (
id_bitacora numeric not null,
ind_proceso numeric not null,
des_observaciones varchar(2000),
ind_estatus numeric,
nom_archivo varchar(500),
fec_creacion timestamp(0) default statement_timestamp(),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0) default statement_timestamp(),
cve_actualizado_por varchar(100) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_bitacora_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_bitacora_procesos_tab add primary key (id_bitacora);
-- dmap_object_gen_tag : type : alter table name : xxlmk_bitacora_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_bitacora_procesos_tab alter column id_bitacora set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_bitacora_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_bitacora_procesos_tab alter column ind_proceso set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_bitacora_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_bitacora_procesos_tab alter column cve_creado_por set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_bitacora_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_bitacora_procesos_tab alter column cve_actualizado_por set not null;
