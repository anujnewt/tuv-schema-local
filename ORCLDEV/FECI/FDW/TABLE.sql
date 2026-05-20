-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_carga_recibos_batch (
cia varchar(500),
desc_cia varchar(500),
business_unit varchar(500),
folio_recibo varchar(500),
fecha_gl varchar(500),
receipt_date varchar(500),
deposit_date varchar(500),
currency_code varchar(500),
currency varchar(500),
type varchar(500),
tipo_operacion varchar(500),
clase_tipo_cambio varchar(500),
tipo_cambio varchar(500),
fecha_tipo_cambio varchar(500),
amount varchar(500),
nombre_cliente varchar(500),
numero_cliente varchar(500),
referencia_cliente varchar(500),
clase_cliente varchar(500),
tipo_cliente varchar(500),
receipt_method varchar(500),
bank_name varchar(500),
bank_account_name varchar(500),
bank_account_name2 varchar(500),
bank_deposit_number varchar(500),
batch_number varchar(500),
num_secuencia_set varchar(500),
num_cheque varchar(500),
num_cta_origen varchar(500)
) server  options(schema 'FECI', table 'FECI_CARGA_RECIBOS_BATCH', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_carga_tipocambio_batch (
fecha varchar(20),
de varchar(20),
a varchar(20),
tipo_cambio varchar(100),
factor varchar(100)
) server  options(schema 'FECI', table 'FECI_CARGA_TIPOCAMBIO_BATCH', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_clase_cliente_cat (
id_clase_cliente numeric options (key 'true') not null,
cod_clase_cliente varchar(20) not null,
des_clase_cliente varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_CLASE_CLIENTE_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_clasificacion_tab (
id_clasificacion numeric options (key 'true') not null,
folio_recibo varchar(30) not null,
tipo_recibo varchar(20) not null,
orden numeric not null,
porcentaje_iva numeric not null,
importe_org numeric not null,
monto_base_org numeric not null,
monto_iva_org numeric not null,
importe_mxn numeric not null,
monto_base_mxn numeric not null,
monto_iva_mxn numeric not null,
importe_usd numeric not null,
monto_base_usd numeric not null,
monto_iva_usd numeric not null,
cod_segmento varchar(20) not null,
cod_grupo_forecast varchar(20) not null,
cod_concepto varchar(20),
cod_region varchar(20),
cod_pais varchar(20),
desc_cps varchar(100),
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_CLASIFICACION_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_clasificacion_tab_temp (
id_clasificacion numeric not null,
folio_recibo numeric not null,
tipo_recibo varchar(20) not null,
orden numeric not null,
porcentaje_iva numeric not null,
importe_org numeric not null,
monto_base_org numeric not null,
monto_iva_org numeric not null,
importe_mxn numeric not null,
monto_base_mxn numeric not null,
monto_iva_mxn numeric not null,
importe_usd numeric not null,
monto_base_usd numeric not null,
monto_iva_usd numeric not null,
cod_segmento varchar(20) not null,
cod_grupo_forecast varchar(20) not null,
cod_concepto varchar(20),
cod_region varchar(20),
cod_pais varchar(20),
desc_cps varchar(100),
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_CLASIFICACION_TAB_TEMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_concepto_cat (
id_concepto numeric options (key 'true') not null,
cod_concepto varchar(20) not null,
des_concepto varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_CONCEPTO_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_configuracion_cat (
id_configuracion numeric options (key 'true') not null,
cod_configuracion varchar(20) not null,
des_configuracion varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_CONFIGURACION_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_empresa_cat (
id_empresa numeric options (key 'true') not null,
cod_empresa varchar(20) not null,
des_empresa varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_EMPRESA_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_emp_usu_tab (
id_usuario numeric,
id_empresa numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_EMP_USU_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_estimacion_tab (
id_estimacion numeric options (key 'true') not null,
cod_grupo_forecast varchar(20) not null,
cod_segmento varchar(20) not null,
num_anio numeric not null,
num_mes numeric not null,
num_semana numeric not null,
num_importe_mxn numeric not null,
num_importe_usd numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_ESTIMACION_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_grfc_segm_cat (
id_segmento numeric,
id_grupo_forecast numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_GRFC_SEGM_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_grupo_forecast_cat (
id_grupo_forecast numeric options (key 'true') not null,
cod_grupo_forecast varchar(20) not null,
des_grupo_forecast varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_GRUPO_FORECAST_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_log_tab (
id_log numeric options (key 'true') not null,
clase varchar(250) not null,
mensaje varchar(500) not null,
excepcion varchar(4000),
nivel varchar(100) not null,
fecha_hora timestamp(0) not null,
clave_rastreo varchar(100) not null
) server  options(schema 'FECI', table 'FECI_LOG_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_moneda_cat (
id_moneda numeric options (key 'true') not null,
cod_moneda varchar(20) not null,
des_moneda varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_MONEDA_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_operacion_tab (
id_operacion numeric options (key 'true') not null,
des_agrupador varchar(100) not null,
cod_operacion varchar(100) not null,
des_nombre varchar(100) not null,
cod_tipo_operacion varchar(20),
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_OPERACION_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_pais_cat (
id_pais numeric options (key 'true') not null,
id_region numeric,
cod_pais varchar(20) not null,
des_pais varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_PAIS_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_porcentaje_iva_cat (
id_porcentaje_iva numeric options (key 'true') not null,
cod_porcentaje_iva varchar(20) not null,
num_valor numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_PORCENTAJE_IVA_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_presupuesto_tab (
id_presupuesto numeric options (key 'true') not null,
cod_segmento varchar(20) not null,
cod_concepto varchar(20) not null,
cod_region varchar(20),
cod_moneda varchar(20) not null,
fec_presupuesto timestamp(0) not null,
num_gestion numeric not null,
num_importe numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_PRESUPUESTO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_recibo_manual_tab (
folio_recibo_manual numeric options (key 'true') not null,
fec_contabilidad timestamp(0) not null,
fec_operativa timestamp(0) not null,
importe numeric not null,
cod_moneda varchar(20) not null,
cod_empresa varchar(20) not null,
cod_cliente varchar(100),
ref_cliente varchar(100),
nom_cliente varchar(250),
clase_cliente varchar(100),
metodo_pago varchar(100),
nom_banco_emisor varchar(250),
num_chequera varchar(100),
num_cheque varchar(100),
num_operacion varchar(100),
tipo_cambio_origen numeric,
fec_tc_origen timestamp(0),
tipo_cambio_dolar numeric,
fec_tc_dolar timestamp(0),
id_usuario_clasificacion numeric,
fec_clasificacion timestamp(0),
id_usuario_aplicacion numeric,
fec_aplicacion timestamp(0),
cod_estado_recibo varchar(20) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_RECIBO_MANUAL_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_recibo_tab (
folio_recibo varchar(30) options (key 'true') not null,
fec_ingreso timestamp(0) not null,
fec_deposito timestamp(0) not null,
fec_contabilidad timestamp(0) not null,
fec_operativa timestamp(0) not null,
importe numeric not null,
cod_moneda varchar(20) not null,
cod_empresa varchar(20) not null,
cod_cliente varchar(100),
nom_cliente varchar(250),
ref_cliente varchar(100),
clase_cliente varchar(100),
metodo_pago varchar(100) not null,
nom_banco_emisor varchar(250),
num_chequera varchar(100),
num_cheque varchar(100),
num_operacion varchar(100),
tipo_cambio_origen numeric,
fec_tc_origen timestamp(0),
tipo_cambio_dolar numeric,
fec_tc_dolar timestamp(0),
id_usuario_clasificacion numeric,
fec_clasificacion timestamp(0),
id_usuario_aplicacion numeric,
fec_aplicacion timestamp(0),
cod_estado_recibo varchar(20) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_RECIBO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_recibo_tab_temp (
folio_recibo numeric not null,
fec_ingreso timestamp(0) not null,
fec_deposito timestamp(0) not null,
fec_contabilidad timestamp(0) not null,
fec_operativa timestamp(0) not null,
importe numeric not null,
cod_moneda varchar(20) not null,
cod_empresa varchar(20) not null,
cod_cliente varchar(100),
nom_cliente varchar(250),
ref_cliente varchar(100),
clase_cliente varchar(100),
metodo_pago varchar(100),
nom_banco_emisor varchar(250),
num_chequera varchar(100),
num_cheque varchar(100),
num_operacion varchar(100),
tipo_cambio_origen numeric,
fec_tc_origen timestamp(0),
tipo_cambio_dolar numeric,
fec_tc_dolar timestamp(0),
id_usuario_clasificacion numeric,
fec_clasificacion timestamp(0),
id_usuario_aplicacion numeric,
fec_aplicacion timestamp(0),
cod_estado_recibo varchar(20) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_RECIBO_TAB_TEMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_region_cat (
id_region numeric options (key 'true') not null,
cod_region varchar(20) not null,
des_region varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_REGION_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_regn_conc_cat (
id_region numeric,
id_concepto numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_REGN_CONC_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_resultado_batch_tab (
id_resultado_batch numeric options (key 'true') not null,
fec_inicio timestamp(0) not null,
fec_fin timestamp(0) not null,
tipo_ejecucion varchar(20) not null,
num_nuevos_recibos numeric,
num_nuevas_empresas numeric,
num_nuevas_monedas numeric,
num_nuevos_tc numeric,
tipo_resultado varchar(20) not null,
observaciones varchar(500) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_RESULTADO_BATCH_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_rol_operacion_tab (
id_rol numeric,
id_operacion numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_ROL_OPERACION_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_rol_tab (
id_rol numeric options (key 'true') not null,
cod_rol varchar(20) not null,
nom_rol varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_ROL_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_segmento_cat (
id_segmento numeric options (key 'true') not null,
cod_segmento varchar(20) not null,
des_segmento varchar(250) not null,
cod_moneda varchar(20) not null,
ind_cps numeric not null,
ind_pais numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_SEGMENTO_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_segm_conc_cat (
id_segmento numeric,
id_grupo_forecast numeric,
id_concepto numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_SEGM_CONC_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_semanas_estimacion_tab (
id_semanas_estimacion numeric options (key 'true') not null,
num_anio numeric not null,
num_mes numeric not null,
fec_inicio_semana_1 timestamp(0) not null,
fec_fin_semana_1 timestamp(0) not null,
fec_inicio_semana_2 timestamp(0) not null,
fec_fin_semana_2 timestamp(0) not null,
fec_inicio_semana_3 timestamp(0) not null,
fec_fin_semana_3 timestamp(0) not null,
fec_inicio_semana_4 timestamp(0) not null,
fec_fin_semana_4 timestamp(0) not null,
fec_inicio_semana_5 timestamp(0),
fec_fin_semana_5 timestamp(0),
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_SEMANAS_ESTIMACION_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_tc_moneda_cat (
id_tc_moneda numeric options (key 'true') not null,
fec_fecha_tc timestamp(0) not null,
cod_mon_origen varchar(20) not null,
cod_mon_destino varchar(20) not null,
num_tipo_cambio numeric not null,
num_factor numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_TC_MONEDA_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_tipo_cambio_cat (
id_tipo_cambio numeric options (key 'true') not null,
fec_fecha_tc timestamp(0) not null,
cod_moneda varchar(20) not null,
num_valor numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_TIPO_CAMBIO_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table feci_usuario_tab (
id_usuario numeric options (key 'true') not null,
id_rol numeric,
des_email varchar(255) not null,
des_nombres varchar(255) not null,
des_apellidos varchar(255) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECI', table 'FECI_USUARIO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table hf_aggregated_counter (
id numeric(10) options (key 'true') not null,
"key" varchar(255),
value numeric(10),
expire_at timestamp
) server  options(schema 'FECI', table 'HF_AGGREGATED_COUNTER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table hf_counter (
id numeric(10) options (key 'true') not null,
"key" varchar(255),
value numeric(10),
expire_at timestamp
) server  options(schema 'FECI', table 'HF_COUNTER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table hf_distributed_lock (
resource varchar(100),
created_at timestamp
) server  options(schema 'FECI', table 'HF_DISTRIBUTED_LOCK', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table hf_hash (
id numeric(10) options (key 'true') not null,
"key" varchar(255),
value text,
expire_at timestamp,
field varchar(40)
) server  options(schema 'FECI', table 'HF_HASH', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table hf_job (
id numeric(10) options (key 'true') not null,
state_id numeric(10),
state_name varchar(20),
invocation_data text,
arguments text,
created_at timestamp,
expire_at timestamp
) server  options(schema 'FECI', table 'HF_JOB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table hf_job_parameter (
id numeric(10) options (key 'true') not null,
name varchar(40),
value text,
job_id numeric(10)
) server  options(schema 'FECI', table 'HF_JOB_PARAMETER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table hf_job_queue (
id numeric(10) options (key 'true') not null,
job_id numeric(10),
queue varchar(50),
fetched_at timestamp,
fetch_token varchar(36)
) server  options(schema 'FECI', table 'HF_JOB_QUEUE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table hf_job_state (
id numeric(10) options (key 'true') not null,
job_id numeric(10),
name varchar(20),
reason varchar(100),
created_at timestamp,
data text
) server  options(schema 'FECI', table 'HF_JOB_STATE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table hf_list (
id numeric(10) options (key 'true') not null,
"key" varchar(255),
value text,
expire_at timestamp
) server  options(schema 'FECI', table 'HF_LIST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table hf_server (
id varchar(100) options (key 'true') not null,
data text,
last_heart_beat timestamp
) server  options(schema 'FECI', table 'HF_SERVER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table hf_set (
id numeric(10) options (key 'true') not null,
"key" varchar(255),
value varchar(255),
score double precision,
expire_at timestamp
) server  options(schema 'FECI', table 'HF_SET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = feci,oracle,dmap_extension,public;
create foreign  table histfeci_recibos_masivo_tab (
folio_recibo varchar(30) not null,
cod_empresa varchar(20) not null,
des_empresa varchar(250) not null,
fec_ingreso timestamp(0) not null,
fec_contabilidad timestamp(0) not null,
fec_deposito timestamp(0) not null,
importe numeric not null,
cod_moneda varchar(20) not null,
des_moneda varchar(250) not null,
cod_cliente varchar(100),
cod_clase_cliente varchar(100),
nom_cliente varchar(250),
ref_cliente varchar(100),
metodo_pago varchar(100),
nom_banco_emisor varchar(250),
num_chequera varchar(100),
num_cheque varchar(100),
num_operacion varchar(100),
fec_tc_origen timestamp(0),
tipo_cambio_origen numeric,
fec_tc_dolar timestamp(0),
tipo_cambio_dolar numeric,
fec_clasificacion timestamp(0),
fec_aplicacion timestamp(0),
porcentaje_iva numeric not null,
cod_porcentaje_iva varchar(20) not null,
importe_org numeric not null,
monto_base_org numeric not null,
monto_iva_org numeric not null,
importe_mxn numeric not null,
monto_base_mxn numeric not null,
monto_iva_mxn numeric not null,
importe_usd numeric not null,
monto_base_usd numeric not null,
monto_iva_usd numeric not null,
cod_segmento varchar(20) not null,
des_segmento varchar(250) not null,
cod_grupo_forecast varchar(20) not null,
des_grupo_forecast varchar(250) not null,
cod_concepto varchar(20) not null,
des_concepto varchar(250) not null,
cod_region varchar(20),
des_region varchar(250),
cod_pais varchar(20),
des_pais varchar(250),
desc_cps varchar(100)
) server  options(schema 'FECI', table 'HISTFECI_RECIBOS_MASIVO_TAB', readonly 'true');
