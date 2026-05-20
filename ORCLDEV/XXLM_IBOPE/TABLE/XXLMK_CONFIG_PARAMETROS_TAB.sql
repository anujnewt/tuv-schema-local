-- dmap_object_gen_tag : type : table name : xxlmk_config_parametros_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create table "xxlmk_config_parametros_tab"  (
id_parametro numeric not null,
nom_parametro varchar(100) not null,
des_val_parametro varchar(500),
des_parametro varchar(500),
ind_tipo_parametro numeric,
fec_creacion timestamp(0) default statement_timestamp(),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0) default statement_timestamp(),
cve_actualizado_por varchar(100) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_parametros_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_parametros_tab add primary key (id_parametro);
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_parametros_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_parametros_tab alter column id_parametro set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_parametros_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_parametros_tab alter column nom_parametro set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_parametros_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_parametros_tab alter column cve_creado_por set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_parametros_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_parametros_tab alter column cve_actualizado_por set not null;
