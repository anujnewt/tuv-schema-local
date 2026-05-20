-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create foreign  table ps_txn (
id numeric(20) options (key 'true') not null,
parentid numeric(20),
collid numeric(10) options (key 'true') not null,
content bytea,
creation_date timestamp(0)
) server  options(schema 'XXLM_IBOPE', table 'PS_TXN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create foreign  table xxlmk_archivos_generados_tab (
id_archivo_gen numeric options (key 'true') not null,
id_archivo_ibope numeric not null,
nom_archivo varchar(256) not null,
des_archivo bytea,
ind_tipo numeric not null,
ind_estatus numeric not null,
des_desc_archivo varchar(2000),
fec_creacion timestamp(0) not null,
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0) not null,
cve_actualizado_por varchar(100) not null
) server  options(schema 'XXLM_IBOPE', table 'XXLMK_ARCHIVOS_GENERADOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create foreign  table xxlmk_archivos_tab (
id_archivo numeric options (key 'true') not null,
nom_archivo varchar(1000) not null,
des_archivo bytea,
des_desc_archivo varchar(4000),
ind_estatus numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0) not null,
cve_actualizado_por varchar(100) not null
) server  options(schema 'XXLM_IBOPE', table 'XXLMK_ARCHIVOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create foreign  table xxlmk_bitacora_procesos_tab (
id_bitacora numeric options (key 'true') not null,
ind_proceso numeric not null,
des_observaciones varchar(2000),
ind_estatus numeric,
nom_archivo varchar(500),
fec_creacion timestamp(0),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100) not null
) server  options(schema 'XXLM_IBOPE', table 'XXLMK_BITACORA_PROCESOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create foreign  table xxlmk_config_parametros_tab (
id_parametro numeric options (key 'true') not null,
nom_parametro varchar(100) not null,
des_val_parametro varchar(500),
des_parametro varchar(500),
ind_tipo_parametro numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100) not null
) server  options(schema 'XXLM_IBOPE', table 'XXLMK_CONFIG_PARAMETROS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create foreign  table xxlmk_config_procesos_tab (
id_config numeric options (key 'true') not null,
id_proceso numeric not null,
num_hora_ejec numeric not null,
num_minunto_ejec numeric not null,
num_ejec_cada numeric not null,
des_ejec_dias varchar(100),
nom_config varchar(100) not null,
des_config varchar(1000),
ind_estatus numeric,
ind_time_unit numeric not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100) not null
) server  options(schema 'XXLM_IBOPE', table 'XXLMK_CONFIG_PROCESOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create foreign  table xxlmk_datos_cargados_tab (
id_datos numeric options (key 'true') not null,
fec_datos timestamp(0),
num_regs numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizado_por timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXLM_IBOPE', table 'XXLMK_DATOS_CARGADOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create foreign  table xxlmk_mapeos_vals_tab (
id_mapeo_val numeric options (key 'true') not null,
id_mapeo_fk numeric,
des_ibope varchar(200) not null,
des_landmark varchar(200) not null,
ind_orden numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100) not null,
num_ibope_ws numeric(38),
cve_plataforma varchar(5),
ind_tipo_arch numeric(38),
ind_targ_spoteo numeric(38),
ind_rating_fijo numeric
) server  options(schema 'XXLM_IBOPE', table 'XXLMK_MAPEOS_VALS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create foreign  table xxlmk_procesos_tab (
id_proceso numeric options (key 'true') not null,
nom_proceso varchar(100) not null,
des_proceso varchar(1000),
ind_estatus numeric,
ind_tipo_proceso numeric not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100) not null,
des_started_by_uuid varchar(100)
) server  options(schema 'XXLM_IBOPE', table 'XXLMK_PROCESOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create foreign  table xxlmk_vals_rtg_fijo_tab (
des_target varchar(200),
des_canal varchar(200),
num_year numeric(38),
num_month numeric(38),
des_franja_ini varchar(10),
des_franja_fin varchar(10),
num_ratings numeric,
num_unis numeric,
des_plataforma varchar(2),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXLM_IBOPE', table 'XXLMK_VALS_RTG_FIJO_TAB', readonly 'true');
