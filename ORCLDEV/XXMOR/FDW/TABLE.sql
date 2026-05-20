-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table ps_txn (
id numeric(20) options (key 'true') not null,
parentid numeric(20),
collid numeric(10) options (key 'true') not null,
content bytea,
creation_date timestamp(0)
) server  options(schema 'XXMOR', table 'PS_TXN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_agrupadores_psp_tab (
id_agrupador_psp numeric options (key 'true') not null,
nom_agrupador varchar(20) not null,
ind_activo numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_AGRUPADORES_PSP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_agrupador_solicitud_tab (
id_solicitud numeric(15) not null,
agrupador varchar(10) not null,
created_date timestamp(0) not null,
created_by varchar(20)
) server  options(schema 'XXMOR', table 'XXLMK_AGRUPADOR_SOLICITUD_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_agr_brk_typ_tab (
id_agr_brk_typ numeric(38) options (key 'true') not null,
des_prefijo varchar(100),
des_break_type varchar(5),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
id_agrupador_psp numeric(38) not null
) server  options(schema 'XXMOR', table 'XXLMK_AGR_BRK_TYP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_ajuste_breaks_tab (
id_ajuste_breaks numeric(38) options (key 'true') not null,
fec_inicio timestamp(0),
fec_fin timestamp(0),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_estatus numeric(38),
des_estatus varchar(1000),
ind_rep_only numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_AJUSTE_BREAKS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_ajus_brks_canales_tab (
id_ajuste_breaks numeric(38) options (key 'true') not null,
id_canal numeric(38) options (key 'true') not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
des_archivo bytea,
nom_archivo varchar(100),
ind_estatus numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_AJUS_BRKS_CANALES_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_ajus_brks_vals_tab (
id_ajuste_breaks numeric(38) options (key 'true') not null,
id_canal numeric(38) options (key 'true') not null,
num_break numeric(38) options (key 'true') not null,
num_brek_nom_time numeric(38),
num_capacidad_ini numeric(38),
num_venta numeric(38),
num_ajuste numeric(38),
num_filler numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_break_base numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_AJUS_BRKS_VALS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_ajus_can_hr_inc_tab (
id_ajuste_breaks numeric(38) options (key 'true') not null,
id_grupo numeric(38) options (key 'true') not null,
num_hr numeric(38) options (key 'true') not null,
num_dif_izzi numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_dif_sky numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_AJUS_CAN_HR_INC_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_ajus_dur_conf_grp_tab (
id_ajuste_breaks numeric(38) options (key 'true') not null,
id_grupo numeric(38) options (key 'true') not null,
num_dur_conf numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_break_time numeric(38) options (key 'true') not null
) server  options(schema 'XXMOR', table 'XXLMK_AJUS_DUR_CONF_GRP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_archivos_sol_tab (
id_archivo_sol numeric options (key 'true') not null,
nom_archivo_sol varchar(100),
des_archivo_sol bytea,
ind_tipo numeric,
num_ordenes numeric,
ind_estatus numeric,
ind_enviado_ws numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_ARCHIVOS_SOL_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_archs_carga_prog_tab (
id_archivo_plan numeric(38) options (key 'true') not null,
id_archivo_orig numeric(38),
des_archivo bytea,
nom_archivo varchar(100),
cve_creado_por varchar(100),
fec_creacion timestamp(0),
cve_actualizado_por varchar(100),
fec_actualizacion timestamp(0)
) server  options(schema 'XXMOR', table 'XXLMK_ARCHS_CARGA_PROG_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_autorizaciones_tab (
id_aut numeric options (key 'true') not null,
id_orden numeric not null,
ind_estatus numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_tipo_aut varchar(10) not null,
ind_nivel varchar(2),
num_linea numeric(38),
des_aut varchar(500)
) server  options(schema 'XXMOR', table 'XXLMK_AUTORIZACIONES_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_book_rules_tab (
id_rule numeric(38) options (key 'true') not null,
nom_rule varchar(200)
) server  options(schema 'XXMOR', table 'XXLMK_BOOK_RULES_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_book_rule_config_tab (
id_config numeric(38) options (key 'true') not null,
nom_config varchar(100),
id_platform numeric(38),
id_round varchar(2),
num_perc_aleatory1 numeric(38),
num_perc_aleatory2 numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_BOOK_RULE_CONFIG_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_camp_env_tab (
id_camp_env numeric options (key 'true') not null,
id_ordhdr numeric not null,
num_camp numeric not null,
ind_estatus varchar(10),
des_tipo_servicio varchar(200),
"fec creacion" timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_aprov_key_id numeric(38),
num_deal numeric(38),
fec_ini_camp timestamp(0),
fec_fin_camp timestamp(0),
num_product numeric(38),
des_camp_req text,
val_rev_budget numeric,
val_budget_no_col numeric(38),
num_preemption_status numeric(38),
num_preemptor_status numeric(38),
num_user_preempts numeric(38),
ind_acciones_especiales numeric(38),
ind_non_preemptible numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_CAMP_ENV_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_camp_lns_tab (
id_linea numeric(38) options (key 'true') not null,
id_camp_env numeric(38) not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_CAMP_LNS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_canales_lmk_tab (
id_canal numeric(38) options (key 'true') not null,
des_can_psp varchar(100),
num_can_lmk numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
cve_sales_area varchar(50),
id_agrupador_psp numeric(38),
ind_activo numeric(38),
ind_nivel numeric(38),
id_canal_network numeric(38),
num_duracion numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_CANALES_LMK_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_canales_nacional_tab (
id_canal numeric options (key 'true') not null,
nom_canal varchar(20),
ind_activo numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(20)
) server  options(schema 'XXMOR', table 'XXLMK_CANALES_NACIONAL_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_cancelacion_spots_tab (
id_cancelacion numeric(38) options (key 'true') not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
nom_archivo varchar(100),
des_archivo bytea,
ind_estatus numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_CANCELACION_SPOTS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_can_except_date_tab (
id_except numeric(38) options (key 'true') not null,
fec_except timestamp(0) options (key 'true') not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_CAN_EXCEPT_DATE_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_can_except_dur_tab (
id_except numeric(38) options (key 'true') not null,
id_grupo numeric(38) not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_CAN_EXCEPT_DUR_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_can_except_hora_tab (
id_except numeric(38) options (key 'true') not null,
des_hora_ini varchar(6) options (key 'true') not null,
des_hora_fin varchar(6) options (key 'true') not null,
num_duracion numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_CAN_EXCEPT_HORA_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_carga_programas_tab (
id_carga numeric(38) options (key 'true') not null,
nom_archivo_carga varchar(200),
des_archivo_carga bytea,
cve_creado_por varchar(100),
fec_creacion timestamp(0),
cve_actualizado_por varchar(100),
fec_actualizacion timestamp(0),
ind_estatus numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_CARGA_PROGRAMAS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_clientes_val_mcont_tab (
id_cliente numeric(38) options (key 'true') not null,
nom_cliente varchar(20),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_product numeric
) server  options(schema 'XXMOR', table 'XXLMK_CLIENTES_VAL_MCONT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_config_rules_tab (
id_config numeric(38) options (key 'true') not null,
id_rule numeric(38) options (key 'true') not null,
num_orden numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_CONFIG_RULES_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_conf_ord_urg_tab (
id_conf numeric(38) options (key 'true') not null,
id_seg_neg numeric(38),
id_fza_vtas numeric(38),
num_dia numeric(38),
num_dia_cierre numeric(38),
num_hora_cierre numeric(38),
num_minuto_cierre numeric(38),
fec_creacion timestamp(0) not null,
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0) not null,
cve_actualizado_por varchar(100) not null,
ind_tipo_orden numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_CONF_ORD_URG_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_correos_fmt_vers_tab (
id_correo numeric(38) options (key 'true') not null,
des_correo varchar(100),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_CORREOS_FMT_VERS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_correos_notif_tab (
id_correo_notif numeric options (key 'true') not null,
id_grupo_notif numeric not null,
des_correo_notif varchar(200),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_CORREOS_NOTIF_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_credito_corporativo_tab (
id_sol_cc numeric options (key 'true') not null,
id_orden numeric not null,
ind_estatus numeric,
ind_rechazo_gestor numeric,
id_motivo_ar_cc numeric,
des_coment_ar_cc varchar(2000),
num_carga numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_CREDITO_CORPORATIVO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_cred_corp_tab (
id_sol_cc numeric options (key 'true') not null,
id_aut numeric not null,
ind_rechazo_gestor numeric,
id_motivo_ar numeric,
des_coment_ar_cc varchar(4000)
) server  options(schema 'XXMOR', table 'XXLMK_CRED_CORP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_dist_cost_dayp_tab (
id_ordhdr numeric(38) options (key 'true') not null,
des_canal varchar(5) options (key 'true') not null,
des_franja varchar(3) options (key 'true') not null,
des_dias varchar(2) options (key 'true') not null,
num_porc numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_DIST_COST_DAYP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_dist_cost_fran_tab (
id_ordhdr numeric(38) options (key 'true') not null,
des_canal varchar(5) options (key 'true') not null,
des_franja varchar(3) options (key 'true') not null,
des_dias varchar(2) options (key 'true') not null,
num_porc numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_DIST_COST_FRAN_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_errores_arch_tab (
id_error numeric options (key 'true') not null,
id_archivo numeric,
cod_tipo_archivo varchar(10),
nom_orden varchar(50),
cve_posicion varchar(1),
num_linea numeric,
des_error varchar(4000),
fec_creacion timestamp(0),
cve_creado_por varchar(20),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(20)
) server  options(schema 'XXMOR', table 'XXLMK_ERRORES_ARCH_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_errores_ords_tab (
id_error numeric options (key 'true') not null,
des_error varchar(2000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
id_ordhdr numeric
) server  options(schema 'XXMOR', table 'XXLMK_ERRORES_ORDS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_errores_ord_lns_tab (
id_error numeric options (key 'true') not null,
id_linea numeric,
des_error varchar(2000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_ERRORES_ORD_LNS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_errs_ajust_brks_tab (
id_error numeric(38) not null,
id_ajuste_breaks numeric(38) not null,
des_error varchar(1000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_ERRS_AJUST_BRKS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_errs_ajus_can_tab (
id_error numeric(38) options (key 'true') not null,
id_ajuste_breaks numeric(38) not null,
id_canal numeric(38) not null,
des_error varchar(1000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_ERRS_AJUS_CAN_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_errs_book_spots_tab (
id_error numeric(38) options (key 'true') not null,
id_spot numeric(38),
num_msg numeric(38),
des_msg varchar(4000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_ERRS_BOOK_SPOTS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_errs_cancel_spots_tab (
id_spot_cancelado numeric(38) not null,
num_msg numeric(38),
des_msg varchar(4000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_ERRS_CANCEL_SPOTS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_errs_carga_prog_tab (
id_error numeric(38) options (key 'true') not null,
id_carga numeric(38) not null,
des_error varchar(500),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_ERRS_CARGA_PROG_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_errs_create_camp_tab (
id_error numeric(38) options (key 'true') not null,
id_ordhdr numeric(38) not null,
num_error numeric(38),
des_severity varchar(50),
des_error varchar(1000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_ERRS_CREATE_CAMP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_errs_recol_spots_tab (
id_spot numeric(38) not null,
num_spot numeric(38) not null,
des_error varchar(1000),
des_breaks varchar(1500),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_msg_err varchar(20)
) server  options(schema 'XXMOR', table 'XXLMK_ERRS_RECOL_SPOTS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_fac_cual_tab (
id_ordhdr numeric not null,
fec_inicio varchar(8),
fec_fin varchar(8),
pos1_2_ult numeric,
pos_3_pen numeric,
pos_ante numeric,
num_fac_cual numeric
) server  options(schema 'XXMOR', table 'XXLMK_FAC_CUAL_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_grupos_canales_tab (
id_grupo numeric(38) options (key 'true') not null,
num_duracion numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
nom_grupo varchar(20)
) server  options(schema 'XXMOR', table 'XXLMK_GRUPOS_CANALES_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_grupos_notif_tab (
id_grupo_notif numeric options (key 'true') not null,
nom_grupo varchar(200),
ind_tipo varchar(20),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_GRUPOS_NOTIF_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_grup_can_niv_tab (
id_grupo numeric(38) options (key 'true') not null,
id_canal numeric(38) options (key 'true') not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_GRUP_CAN_NIV_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_hiatus_tab (
id_ordhdr numeric not null,
fec_inicio varchar(8),
fec_fin varchar(8),
des_hora_ini varchar(4),
des_hora_fin varchar(4),
ind_lun varchar(5),
ind_mar varchar(5),
ind_mie varchar(5),
ind_jue varchar(5),
ind_vie varchar(5),
ind_sab varchar(5),
ind_dom varchar(5),
ind_2can varchar(5),
ind_5can varchar(5),
ind_9can varchar(5),
num_hiatus numeric
) server  options(schema 'XXMOR', table 'XXLMK_HIATUS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_inconsistent_spots_tab (
id_inconsistent_spot numeric(38) not null,
id_ordhdr numeric(38),
num_spot numeric(38),
ind_canceled numeric(1)
) server  options(schema 'XXMOR', table 'XXLMK_INCONSISTENT_SPOTS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_lineas_spots_tab (
id_spot numeric(38) options (key 'true') not null,
id_linea numeric(38) not null,
des_fecha_break varchar(8),
des_hora_inicio varchar(6),
des_hora_fin varchar(6),
des_hora_break varchar(6),
num_duracion numeric(38),
des_tolerancia varchar(6),
ind_estatus numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_prog numeric(38),
num_spot numeric(38),
nom_prog varchar(200),
brek_nom_time numeric(38),
val_tarifa numeric
) server  options(schema 'XXMOR', table 'XXLMK_LINEAS_SPOTS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_notif_elem_tab (
id_notif_elem numeric options (key 'true') not null,
id_grupo_notif numeric not null,
nom_elem varchar(200),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_NOTIF_ELEM_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_ordhdr_tab (
id_ordhdr numeric options (key 'true') not null,
id_seg_neg numeric,
id_archivo numeric,
ind_proc_x_lin varchar(2),
ind_garantizado varchar(10),
cve_advid varchar(20),
cve_mcontid varchar(30),
cve_mcont_cutin varchar(30),
des_email varchar(4000),
des_ref_folio varchar(50),
cve_agyestnum varchar(50),
cve_accthdrid varchar(50),
des_rtcrd varchar(50),
des_rtcrd_cutin varchar(50),
des_coment varchar(200),
des_secnum varchar(20),
des_plat_canal varchar(20),
id_prddes varchar(50),
num_total_spts numeric,
can_tot_sin_desc numeric,
can_tot_con_desc numeric,
des_tip_factur varchar(50),
can_desc numeric,
des_target varchar(50),
cve_modulo varchar(200),
num_ord_agen varchar(50),
des_targ_afin varchar(50),
des_tipo_serv varchar(200),
ind_kids varchar(5),
ind_fav_lo_mejor varchar(5),
num_grps_totales numeric,
num_ejecucion numeric,
des_tipo_orden varchar(50),
des_version_fich varchar(50),
fec_creacion timestamp(0),
cve_creado_por varchar(50),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(50),
can_inversion_total numeric,
ind_tipo_orden numeric,
ind_estatus numeric,
des_agrupador varchar(10),
id_fza_ventas numeric,
ind_subtipo_ord numeric,
id_deal numeric(38),
des_marca_prod varchar(500)
) server  options(schema 'XXMOR', table 'XXLMK_ORDHDR_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_ordln_tab (
id_linea numeric options (key 'true') not null,
id_ordhdr numeric,
num_linea numeric,
cve_canal varchar(50),
des_fec_ini varchar(8),
des_fec_fin varchar(8),
num_duracion numeric,
id_buyunt varchar(50),
des_hora_ini varchar(4),
des_hora_fin varchar(4),
can_spots numeric,
can_lun numeric,
can_mar numeric,
can_mie numeric,
can_jue numeric,
can_vie numeric,
can_sab numeric,
can_dom numeric,
des_tipo_servicio varchar(200),
ind_bn varchar(10),
ind_p varchar(5),
des_marca varchar(200),
des_version varchar(50),
can_tar_sp_sin_desc numeric,
can_tar_sp_con_des numeric,
can_tot_lin_sin_desc numeric,
can_tot_lin_con_desc numeric,
des_sobrecargo varchar(50),
des_observaciones varchar(100),
des_plataforma varchar(20),
pos1 varchar(50),
pos2 varchar(50),
pos3 varchar(50),
pos_ant varchar(50),
pos_pen varchar(50),
pos_ult varchar(50),
fec_creacion timestamp(0),
cve_creado_por varchar(50),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(50),
des_campana varchar(200),
can_grps numeric,
des_sptchr numeric,
des_usrchr varchar(2),
can_spots_x_sem numeric,
ind_estatus numeric(38),
num_porc_line numeric
) server  options(schema 'XXMOR', table 'XXLMK_ORDLN_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_osmod_conf_cans_tab (
id_ordhdr numeric(38) options (key 'true') not null,
num_grupo numeric(38) options (key 'true') not null,
nom_canal varchar(100) options (key 'true') not null,
ind_network numeric(38),
ind_sky numeric(38),
ind_izzi numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_OSMOD_CONF_CANS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_osmod_grup_cans_tab (
id_ordhdr numeric(38) options (key 'true') not null,
num_grupo numeric(38) options (key 'true') not null,
nom_grupo varchar(100),
num_spots_plat numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_spots_network numeric(38),
num_spots_sky numeric(38),
num_spots_izzi numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_OSMOD_GRUP_CANS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_parametros_tab (
id_parametro numeric options (key 'true') not null,
nom_parametro varchar(50) not null,
des_valor varchar(4000) not null,
des_parametro varchar(4000),
ind_tipo numeric,
ind_cifrado numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(50),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(50)
) server  options(schema 'XXMOR', table 'XXLMK_PARAMETROS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_platforms_tab (
id_platform numeric(38) options (key 'true') not null,
nom_platform varchar(100) not null,
nom_short varchar(10)
) server  options(schema 'XXMOR', table 'XXLMK_PLATFORMS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_preempt_cli_conf_tab (
id_config numeric(38) options (key 'true') not null,
nom_cliente varchar(10) not null,
des_tipo_compra varchar(100),
num_preemptor_status numeric(38),
num_preemption_status numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_non_preemptible numeric(38),
num_plat numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_PREEMPT_CLI_CONF_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_preempt_config_tab (
id_config numeric(38) options (key 'true') not null,
id_tipo_servicio numeric not null,
num_preemptor_status numeric(38),
num_preemption_status numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_PREEMPT_CONFIG_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_preempt_ts_conf_tab (
id_config numeric(38) options (key 'true') not null,
id_tipo_servicio numeric not null,
num_preemptor_status numeric(38),
num_preemption_status numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_non_preemptible numeric(38),
num_plat numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_PREEMPT_TS_CONF_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_preemp_cli_ts_val_tab (
id_preemp_cli_val numeric(38) not null,
business_type varchar(200),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_PREEMP_CLI_TS_VAL_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_razons_cancel_spt_tab (
id_razon_cancel numeric(38) options (key 'true') not null,
des_razon_cancel varchar(200),
cve_creado_por varchar(100),
fec_creacion timestamp(0),
cve_actualizado_por varchar(100),
fec_actualizacion timestamp(0)
) server  options(schema 'XXMOR', table 'XXLMK_RAZONS_CANCEL_SPT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_recol_spots_ctrl_tab (
id_spot numeric(38) options (key 'true') not null,
num_spot numeric(38) not null,
num_sched_time_orig varchar(10),
ind_status_lmk_orig varchar(2),
ind_estatus_mov numeric(38),
id_razon_cancel numeric(38),
ind_cambio_status numeric(38),
ind_num_movs numeric(38),
cve_creado_por varchar(100),
fec_creacion timestamp(0),
cve_actualizado_por varchar(100),
fec_actualizacion timestamp(0)
) server  options(schema 'XXMOR', table 'XXLMK_RECOL_SPOTS_CTRL_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_recol_spots_file_spt_tab (
id_recol_spots numeric(38) options (key 'true') not null,
num_spot_lmk numeric(38) options (key 'true') not null,
ind_status varchar(1),
original_scheduled_date timestamp(0),
original_scheduled_time varchar(6),
scheduled_date timestamp(0),
scheduled_time varchar(6),
des_error varchar(500),
original_status varchar(1),
status varchar(1),
channel varchar(50),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizado_por timestamp(0),
cve_actualizado_por varchar(100),
fec_processed timestamp(0)
) server  options(schema 'XXMOR', table 'XXLMK_RECOL_SPOTS_FILE_SPT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_recol_spots_file_tab (
id_recol_spots numeric(38) options (key 'true') not null,
nom_file varchar(500),
type varchar(4),
ind_status varchar(1),
des_error varchar(500)
) server  options(schema 'XXMOR', table 'XXLMK_RECOL_SPOTS_FILE_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_rtc_spttype_tab (
id_rtc numeric(38) options (key 'true') not null,
nom_rtc varchar(100) not null,
des_spttype varchar(10) not null
) server  options(schema 'XXMOR', table 'XXLMK_RTC_SPTTYPE_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_smod_conf_cans_tab (
num_canal numeric(38) options (key 'true') not null,
id_grupo numeric(38) not null,
ind_network numeric(38),
ind_sky numeric(38),
ind_izzi numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_orden numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_SMOD_CONF_CANS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_smod_grp_ncans_tab (
id_grupo numeric(38) options (key 'true') not null,
num_cans numeric(38) options (key 'true') not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_SMOD_GRP_NCANS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_smod_grup_cans_tab (
id_grupo numeric(38) options (key 'true') not null,
nom_grupo varchar(100) not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_SMOD_GRUP_CANS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_smod_ncans_dist_tab (
id_grupo numeric(38) options (key 'true') not null,
num_cans numeric(38) options (key 'true') not null,
num_can numeric(38) options (key 'true') not null,
num_porc_dist numeric(38) not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_SMOD_NCANS_DIST_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_spots_cancelados_tab (
id_spot_cancelado numeric(38) options (key 'true') not null,
id_cancelacion numeric(38) not null,
id_spot numeric(38),
num_spot_lmk numeric(38),
ind_estatus numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_SPOTS_CANCELADOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_spot_length_factor_tab (
num_spot_length numeric(38) options (key 'true') not null,
num_price_factor numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion numeric(38),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_SPOT_LENGTH_FACTOR_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_targets_psp_lmk_tab (
id_target numeric(38) options (key 'true') not null,
des_target_short varchar(100),
num_demog_lmk numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_TARGETS_PSP_LMK_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_timslc_book_cfg_tab (
id_config numeric(38) options (key 'true') not null,
id_franja varchar(5) options (key 'true') not null,
ind_selected numeric(38),
num_start_time varchar(4),
num_end_time varchar(4)
) server  options(schema 'XXMOR', table 'XXLMK_TIMSLC_BOOK_CFG_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_tipos_serv_psp_tab (
id_tipo_servicio_psp numeric options (key 'true') not null,
id_tipo_servicio numeric not null,
ind_activo numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_inc_br_evesp_tm numeric(38),
num_business_type numeric(38),
ind_acciones_esp numeric(38),
ind_enviar_fmt_asig numeric(38),
ind_business_primary numeric(38),
nom_business_type varchar(200)
) server  options(schema 'XXMOR', table 'XXLMK_TIPOS_SERV_PSP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_tip_serv_brk_typ_tab (
id_tipo_servicio_psp numeric(38) options (key 'true') not null,
des_break_type varchar(6) options (key 'true') not null,
ind_prioridad numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_TIP_SERV_BRK_TYP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_ts_break_types_tab (
id_ts_break_type numeric(38) options (key 'true') not null,
des_tipo_servicio varchar(200),
cve_break_type varchar(4),
num_business_type numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_ignora_aut_tm numeric(38),
num_int_breaks numeric(38),
ind_varios_ts numeric(38),
ind_preemptor numeric(38)
) server  options(schema 'XXMOR', table 'XXLMK_TS_BREAK_TYPES_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_universos_lmk_tab (
num_sare numeric(38),
num_demo numeric(38),
fec_uni timestamp(0),
num_uni numeric,
cve_creado_por varchar(100),
fec_creacion timestamp(0),
cve_actualizado_por varchar(100),
fec_actualizacion timestamp(0)
) server  options(schema 'XXMOR', table 'XXLMK_UNIVERSOS_LMK_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxlmk_users_overbook_tab (
id_user_overbook numeric(38) options (key 'true') not null,
cve_usuario varchar(100),
ind_status numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) server  options(schema 'XXMOR', table 'XXLMK_USERS_OVERBOOK_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_agrupador_solicitud_tab (
id_solicitud numeric(15) options (key 'true') not null,
agrupador varchar(10) options (key 'true') not null,
created_date timestamp(0) not null,
created_by varchar(20)
) server  options(schema 'XXMOR', table 'XXMOR_AGRUPADOR_SOLICITUD_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_archivos_ftp_tab (
nom_archivo varchar(240) not null,
estatus varchar(5) not null,
desc_error varchar(4000),
id_archivo numeric(15),
created_date timestamp(0) not null,
created_by varchar(20)
) server  options(schema 'XXMOR', table 'XXMOR_ARCHIVOS_FTP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_cat_agrupador_mult_tab (
agrupador_multiple varchar(15) options (key 'true') not null,
prefijo_canal varchar(5) options (key 'true') not null,
pivote char(1),
rtcrd_substr varchar(15),
ca_rtcrd_substr varchar(15),
ca_rtcrd_aux varchar(15)
) server  options(schema 'XXMOR', table 'XXMOR_CAT_AGRUPADOR_MULT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_cat_buyunit_mkt_tab (
id_seg_neg numeric(38) options (key 'true') not null,
id_fza_ventas numeric(38) options (key 'true') not null,
buyuntid varchar(15) not null,
mkt_director varchar(50),
mkt_gerente varchar(50),
mkt_coordinador varchar(50),
mkt_ejecutivo varchar(50),
mkt_mail_director varchar(50),
mkt_mail_gerente varchar(50),
mkt_mail_coordinador varchar(50),
mkt_mail_ejecutivo varchar(50),
created_by varchar(20) not null,
created_date timestamp(0) not null,
updated_by varchar(20),
updated_date timestamp(0),
id_buyunit_mkt numeric(15) options (key 'true') not null
) server  options(schema 'XXMOR', table 'XXMOR_CAT_BUYUNIT_MKT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_cat_tipo_serv_tab (
id_tipo_servicio numeric options (key 'true') not null,
desc_tipo_servicio varchar(200) not null,
spt_chr varchar(2),
usr_chr varchar(2)
) server  options(schema 'XXMOR', table 'XXMOR_CAT_TIPO_SERV_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_cat_urls_tab (
id_seg_neg numeric options (key 'true') not null,
id_url numeric options (key 'true') not null,
url varchar(250) not null,
desc_url varchar(260),
orden_url numeric
) server  options(schema 'XXMOR', table 'XXMOR_CAT_URLS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_concom_rpta_tab (
id_solicitud numeric options (key 'true') not null,
id_rpta_concom numeric options (key 'true') not null,
resultadogeneral varchar(50),
trackingid varchar(50),
desc_concom varchar(128),
posicion_concom varchar(15),
id_concom varchar(250),
numlinea_concom varchar(20),
estatus_concom varchar(20),
campo_concom varchar(2000),
detalle_concom varchar(2000),
accion_concom varchar(50),
tiporegla_concom varchar(50),
estatus_orduni char(2),
created_date timestamp(0) options (key 'true') not null,
created_by varchar(20) options (key 'true') not null,
updated_date timestamp(0),
updated_by varchar(20),
id_seg_neg numeric
) server  options(schema 'XXMOR', table 'XXMOR_CONCOM_RPTA_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_conf_notific_tab (
id_seg_neg numeric options (key 'true') not null,
id_fza_ventas numeric options (key 'true') not null,
id_notificacion numeric options (key 'true') not null,
usuario_interno char(1),
usuario_agencia char(1),
created_by varchar(20) not null,
created_date timestamp(0) not null,
updated_date timestamp(0),
updated_by varchar(20),
usuario_factur char(1)
) server  options(schema 'XXMOR', table 'XXMOR_CONF_NOTIFIC_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_conf_ords_urgentes_tab (
id_seg_neg numeric options (key 'true') not null,
id_fza_ventas numeric options (key 'true') not null,
dia numeric(1) options (key 'true') not null,
dia_cierre numeric(1) options (key 'true') not null,
hora_cierre timestamp(0) not null,
created_by varchar(20) not null,
created_date timestamp(0) not null,
updated_date timestamp(0),
updated_by varchar(20)
) server  options(schema 'XXMOR', table 'XXMOR_CONF_ORDS_URGENTES_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_conf_params_grls_tab (
id_parametro numeric options (key 'true') not null,
nombre_parametro varchar(30) not null,
descripcion_parametro varchar(250),
valor_parametro varchar(3001) not null,
tipo_parametro varchar(30)
) server  options(schema 'XXMOR', table 'XXMOR_CONF_PARAMS_GRLS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_conf_tipo_srv_tab (
id_seg_neg numeric options (key 'true') not null,
id_fza_ventas numeric options (key 'true') not null,
id_tipo_servicio numeric options (key 'true') not null,
inclusion numeric(1),
sptchr varchar(2),
usrchr varchar(2)
) server  options(schema 'XXMOR', table 'XXMOR_CONF_TIPO_SRV_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_ejecuciones_prog_tab (
id_ejecucion numeric options (key 'true') not null,
nombre_proceso varchar(50),
hora_ini_ejecucion timestamp(0),
status_ejecucion char(1),
hoa_fin_ejecucion timestamp(0)
) server  options(schema 'XXMOR', table 'XXMOR_EJECUCIONES_PROG_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_errores_lectura_arch_tab (
id_error numeric(15) options (key 'true') not null,
id_archivo numeric(15) not null,
cod_tipo_archivo varchar(10) not null,
nom_orden varchar(35),
cve_posicion varchar(1) not null,
num_linea numeric(38),
des_aux1 varchar(240),
des_aux2 varchar(240),
des_aux3 varchar(240),
des_aux4 varchar(240),
des_aux5 varchar(240),
fec_creacion timestamp(0) not null,
cve_creado_por varchar(20),
fec_actualizacion timestamp(0) not null,
cve_actualizado_por varchar(20),
des_error varchar(4000) not null
) server  options(schema 'XXMOR', table 'XXMOR_ERRORES_LECTURA_ARCH_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_esquemas_factur_tab (
id_esquema numeric(15) options (key 'true') not null,
codigo varchar(50) not null,
descripcion varchar(240),
activo varchar(1),
created_date timestamp(0) not null,
created_by varchar(20)
) server  options(schema 'XXMOR', table 'XXMOR_ESQUEMAS_FACTUR_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_fzas_vtas_archivos_tab (
id_seg_neg numeric options (key 'true') not null,
id_fza_ventas numeric options (key 'true') not null,
id_archivo_fza numeric options (key 'true') not null,
archivo_sol bytea not null,
nombre_archivo_fza varchar(128) not null,
desc_archivo_fza varchar(128) not null,
created_by varchar(20) not null,
created_date timestamp(0) not null,
updated_date timestamp(0),
updated_by varchar(20)
) server  options(schema 'XXMOR', table 'XXMOR_FZAS_VTAS_ARCHIVOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_fzas_vtas_canales_tab (
id_seg_neg numeric options (key 'true') not null,
id_fza_ventas numeric options (key 'true') not null,
stnid_padre varchar(10) options (key 'true') not null,
stnid_hijo varchar(10) options (key 'true') not null,
stnid_porcentaje decimal(5,2) not null,
created_by varchar(20) not null,
created_date timestamp(0) not null,
updated_date timestamp(0),
updated_by varchar(20)
) server  options(schema 'XXMOR', table 'XXMOR_FZAS_VTAS_CANALES_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_fzas_vtas_ident_tab (
id_seg_neg numeric options (key 'true') not null,
id_fza_ventas numeric options (key 'true') not null,
ident_fza_tipo char(1) options (key 'true') not null,
ident_fza_val varchar(10) options (key 'true') not null
) server  options(schema 'XXMOR', table 'XXMOR_FZAS_VTAS_IDENT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_fzas_vtas_mult_tab (
id_seg_neg numeric options (key 'true') not null,
id_fza_ventas numeric options (key 'true') not null,
id_seg_neg_hijo numeric,
id_fza_ventas_hija numeric
) server  options(schema 'XXMOR', table 'XXMOR_FZAS_VTAS_MULT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_fzas_vtas_sistemas_tab (
id_sist numeric(3) options (key 'true') not null,
id_seg_neg numeric options (key 'true') not null,
id_fza_ventas numeric options (key 'true') not null
) server  options(schema 'XXMOR', table 'XXMOR_FZAS_VTAS_SISTEMAS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_fzas_vtas_tab (
id_seg_neg numeric options (key 'true') not null,
id_fza_ventas numeric options (key 'true') not null,
ident_fza_ventas varchar(6),
nombre_fza_ventas varchar(50) not null,
region varchar(4),
copys_x_orden char(1),
copys_x_fecha char(1),
multifuerza char(1),
rtcrd_auth_aut char(1),
aut_x_correo char(1),
mercadotecnia char(1),
div_x_canal char(1),
condiciones_comerciales varchar(4000),
activa char(1),
notificacion_ext_int char(1),
created_by varchar(20) not null,
created_date timestamp(0) not null,
updated_by varchar(20),
updated_date timestamp(0),
matloc char(2),
aut_tolerancia decimal(10,2),
get_rate char(2),
matloc_null char(1),
matloc_busqueda varchar(2),
mkt_version_ws char(1),
esquema_factur varchar(50),
id_empresa_erp numeric(15),
empresa_erp varchar(240),
seg_neg_erp varchar(30),
respeta_canal varchar(1),
comp_empresa varchar(400),
por_iva numeric,
usar_buyunit_mkt varchar(1)
) server  options(schema 'XXMOR', table 'XXMOR_FZAS_VTAS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_fzas_vtas_tab_resp (
id_seg_neg numeric not null,
id_fza_ventas numeric not null,
ident_fza_ventas varchar(6),
nombre_fza_ventas varchar(50) not null,
region varchar(4),
copys_x_orden char(1),
copys_x_fecha char(1),
multifuerza char(1),
rtcrd_auth_aut char(1),
aut_x_correo char(1),
mercadotecnia char(1),
div_x_canal char(1),
condiciones_comerciales varchar(3000),
activa char(1),
notificacion_ext_int char(1),
created_by varchar(20) not null,
created_date timestamp(0) not null,
updated_by varchar(20),
updated_date timestamp(0),
matloc char(2),
aut_tolerancia decimal(10,2),
get_rate char(2),
matloc_null char(1),
matloc_busqueda varchar(2),
mkt_version_ws char(1),
esquema_factur varchar(50)
) server  options(schema 'XXMOR', table 'XXMOR_FZAS_VTAS_TAB_RESP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_fzas_vtas_usuarios_tab (
id_seg_neg numeric options (key 'true') not null,
id_fza_ventas numeric options (key 'true') not null,
id_user varchar(20) options (key 'true') not null,
administrador char(1),
created_by varchar(20) not null,
created_date timestamp(0) not null,
updated_by varchar(20),
updated_date timestamp(0)
) server  options(schema 'XXMOR', table 'XXMOR_FZAS_VTAS_USUARIOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_log_accesos_tab (
id_log_acceso numeric options (key 'true') not null,
id_seg_neg numeric,
created_by varchar(20) not null,
created_date timestamp(0) not null
) server  options(schema 'XXMOR', table 'XXMOR_LOG_ACCESOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_log_errores_tab (
id_error numeric options (key 'true') not null,
desc_error varchar(4000),
archivo_error varchar(350),
metodo_error varchar(1000),
hora_error timestamp(0)
) server  options(schema 'XXMOR', table 'XXMOR_LOG_ERRORES_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_log_movimientos_tab (
id_seg_neg numeric,
id_solicitud numeric,
id_log_movimiento numeric options (key 'true') not null,
nom_tabla varchar(50) not null,
nom_campo varchar(50) not null,
valor_antiguo varchar(1000),
valor_nuevo varchar(1000),
created_by varchar(20) not null,
created_date timestamp(0) not null
) server  options(schema 'XXMOR', table 'XXMOR_LOG_MOVIMIENTOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_mapeo_campos_tab (
id_seg_neg numeric options (key 'true') not null,
id_obj numeric options (key 'true') not null,
desc_obj varchar(50),
texto_obj varchar(50),
visible_obj char(1),
editable_obj char(1),
url_obj varchar(250),
posicion_pantalla varchar(50)
) server  options(schema 'XXMOR', table 'XXMOR_MAPEO_CAMPOS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_map_canal_tserv_rech_tab (
id_mapeo numeric(15) options (key 'true') not null,
canal varchar(15) not null,
tipo_servicio varchar(150) not null,
activo varchar(1) not null,
created_date timestamp(0) not null,
created_by varchar(20)
) server  options(schema 'XXMOR', table 'XXMOR_MAP_CANAL_TSERV_RECH_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_map_concom_orduni_tab (
campo_orduni varchar(30),
campo_posicion_concom varchar(500)
) server  options(schema 'XXMOR', table 'XXMOR_MAP_CONCOM_ORDUNI_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_motivos_aut_rech_tab (
id_motivo numeric(15) options (key 'true') not null,
descripcion varchar(240) not null,
tipo varchar(1) not null,
estatus varchar(1) not null,
created_date timestamp(0) not null,
created_by varchar(20)
) server  options(schema 'XXMOR', table 'XXMOR_MOTIVOS_AUT_RECH_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_ordenes_estatus_tab (
id_notificacion numeric options (key 'true') not null,
desc_notificacion varchar(100),
id_seg_neg numeric options (key 'true') not null,
tipo_estatus char(1)
) server  options(schema 'XXMOR', table 'XXMOR_ORDENES_ESTATUS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_ordenes_evetv_tab (
id_orden numeric options (key 'true') not null,
des_fuerza_ventas varchar(100),
num_orden numeric not null,
ind_proc_por_linea varchar(5),
ind_garantizado varchar(5),
ind_apo_rep varchar(5),
cve_cliente varchar(100) not null,
des_cps_mcontract varchar(100),
des_email_resp varchar(100),
des_ref_folio varchar(100),
cve_enc_cli_agencia varchar(100),
des_marca varchar(100),
nom_tarifa varchar(100),
des_comentarios varchar(500),
ind_canal_x_ord varchar(5),
des_cat_prod varchar(100),
can_total_spots numeric,
val_total_ord_sd numeric,
val_total_ord_cd numeric,
nom_dir_merca varchar(100),
ind_tipo_factur varchar(100),
des_target varchar(100),
fec_inicio timestamp(0),
fec_fin timestamp(0),
val_total_orden numeric not null,
des_seg_neg varchar(100),
ind_estatus varchar(2),
fec_creacion timestamp(0),
cve_creado_por varchar(50),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(50),
ind_rechazo_gestor char(2),
id_motivo_ar_cc numeric,
des_coment_ar_cc varchar(500),
num_carga numeric
) server  options(schema 'XXMOR', table 'XXMOR_ORDENES_EVETV_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_segm_neg_tab (
id_seg_neg numeric options (key 'true') not null,
nombre_sn varchar(30) not null,
url_concom varchar(250)
) server  options(schema 'XXMOR', table 'XXMOR_SEGM_NEG_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_sistemas_finales_tab (
id_sist numeric(3) options (key 'true') not null,
desc_sist char(10) not null,
url_ws char(10) not null
) server  options(schema 'XXMOR', table 'XXMOR_SISTEMAS_FINALES_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_solicitudes_arch_tab (
id_seg_neg numeric options (key 'true') not null,
id_archivo_sol numeric options (key 'true') not null,
archivo_sol bytea not null,
nom_archivo_sol varchar(150) not null,
archivo_procesado char(1),
envio_ws char(1),
created_date timestamp(0),
created_by varchar(20),
num_ordenes numeric(15),
observaciones varchar(4000)
) server  options(schema 'XXMOR', table 'XXMOR_SOLICITUDES_ARCH_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_solicitudes_det_tab (
id_solicitud numeric options (key 'true') not null,
linea numeric options (key 'true') not null,
linea_hna numeric,
stnid varchar(15),
fecha_inicio varchar(15),
fecha_fin varchar(15),
duracion varchar(8),
buyuntid varchar(15),
hora_inicio varchar(8),
hora_fin varchar(8),
spots varchar(5),
lunes varchar(3),
martes varchar(3),
miercoles varchar(3),
jueves varchar(3),
viernes varchar(3),
sabado varchar(3),
domingo varchar(3),
spots_x_semana varchar(15),
tipo_servicio varchar(100),
usr_chr varchar(1),
spot_chr numeric(5),
bn varchar(10),
p varchar(3),
marca varchar(50),
version varchar(30),
tarifasp_sin_desc varchar(15),
tarifasp_con_desc varchar(15),
tot_linea_sin_desc varchar(15),
tot_linea_con_desc varchar(15),
sobrecargo varchar(50),
observaciones varchar(150),
created_by varchar(20),
created_date timestamp(0),
updated_date timestamp(0),
updated_by varchar(20),
linea_estatus varchar(2),
fecha_concom varchar(35),
tracking_id_concom varchar(50),
getrate_sin_ajuste decimal(20,2),
getrate_con_ajuste decimal(20,2),
division_montos numeric(2),
des_plataforma varchar(150)
) server  options(schema 'XXMOR', table 'XXMOR_SOLICITUDES_DET_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_solicitudes_enc_tab (
id_solicitud numeric options (key 'true') not null,
id_request numeric,
id_seg_neg numeric,
id_fza_ventas numeric,
id_solicitud_hna numeric,
proc_por_linea varchar(2),
garantizado varchar(2),
advid varchar(12),
mcontid varchar(20),
mcontid_cutin varchar(20),
email varchar(80),
agyestnum varchar(25),
accthdrid varchar(50),
rtcrddscr varchar(40),
rtcrd varchar(50),
rtcrddscr_cutin varchar(50),
rtcrd_cutin varchar(50),
comentarios varchar(250),
secnum varchar(3),
plataforma_canal varchar(70),
agrupador varchar(10),
prdid_desc varchar(50),
prdid varchar(50),
total_spots varchar(5),
total_sin_desc varchar(15),
total_con_desc varchar(15),
tipo_facturacion varchar(20),
descuento varchar(20),
target varchar(50),
created_date timestamp(0),
created_by varchar(20),
updated_date timestamp(0),
updated_by varchar(20),
orden_estatus varchar(2),
fecha_concom varchar(35),
tracking_id_concom varchar(50),
aux1 varchar(15),
aux2 varchar(15),
aux3 varchar(15),
motivo_ar_cc numeric,
coment_ar_cc varchar(240),
rechazo_gestor varchar(1)
) server  options(schema 'XXMOR', table 'XXMOR_SOLICITUDES_ENC_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_solicitudes_est_rep_tab (
id_solicitud numeric options (key 'true') not null,
linea numeric options (key 'true') not null,
id_sist numeric(3) options (key 'true') not null,
estat_rep char(2),
estat_id_foraneo varchar(25),
estat_reintento numeric(2),
created_date timestamp(0),
updated_date timestamp(0),
rotid varchar(20),
aux1 varchar(15),
aux2 varchar(15),
aux3 varchar(15),
estat_error_msg varchar(500)
) server  options(schema 'XXMOR', table 'XXMOR_SOLICITUDES_EST_REP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_solicitudes_orig_det_tab (
id_request numeric options (key 'true') not null,
linea_request numeric options (key 'true') not null,
stnid varchar(15),
fecha_inicio varchar(15),
fecha_fin varchar(15),
duracion varchar(8),
buyuntid varchar(15),
hora_inicio varchar(8),
hora_fin varchar(8),
spots varchar(5),
lunes varchar(3),
martes varchar(3),
miercoles varchar(3),
jueves varchar(3),
viernes varchar(3),
sabado varchar(3),
domingo varchar(3),
spots_x_semana varchar(5),
tipo_servicio varchar(100),
bn varchar(10),
p varchar(3),
marca varchar(50),
version varchar(30),
tarifasp_sin_desc varchar(15),
tarifasp_con_desc varchar(15),
tot_linea_sin_desc varchar(15),
tot_linea_con_desc varchar(15),
sobrecargo varchar(50),
observaciones varchar(150),
aux1 varchar(15),
aux2 varchar(15),
aux3 varchar(15),
aux4 varchar(15),
aux5 varchar(15),
des_plataforma varchar(150)
) server  options(schema 'XXMOR', table 'XXMOR_SOLICITUDES_ORIG_DET_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_solicitudes_orig_enc_tab (
id_request numeric options (key 'true') not null,
id_archivo_sol numeric,
id_seg_neg numeric,
proc_por_linea varchar(2),
garantizado varchar(2),
advid varchar(12),
mcontid varchar(20),
mcontid_cutin varchar(20),
email varchar(80),
agyestnum varchar(25),
accthdrid varchar(50),
rtcrddscr varchar(40),
rtcrddscr_cutin varchar(50),
comentarios varchar(252),
secnum varchar(3),
plataforma_canal varchar(70),
prdid_desc varchar(50),
total_spots varchar(5),
total_sin_desc varchar(15),
total_con_desc varchar(15),
tipo_facturacion varchar(20),
descuento varchar(20),
target varchar(50),
aux1 varchar(15),
aux2 varchar(15),
aux3 varchar(15),
aux4 varchar(15),
aux5 varchar(15),
created_by varchar(20) not null,
created_date timestamp(0) not null
) server  options(schema 'XXMOR', table 'XXMOR_SOLICITUDES_ORIG_ENC_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_sol_est_rep_bak_tab (
id_solicitud numeric not null,
linea numeric not null,
id_sist numeric(3) not null,
estat_rep char(2),
estat_id_foraneo varchar(25),
estat_reintento numeric(2),
created_date timestamp(0),
updated_date timestamp(0),
rotid varchar(20),
aux1 varchar(15),
aux2 varchar(15),
aux3 varchar(15),
estat_error_msg varchar(500)
) server  options(schema 'XXMOR', table 'XXMOR_SOL_EST_REP_BAK_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxmor_sol_factur_mails_tab (
id_solicitud numeric options (key 'true') not null,
linea numeric options (key 'true') not null,
mails_factur varchar(250)
) server  options(schema 'XXMOR', table 'XXMOR_SOL_FACTUR_MAILS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxtdl_int_cron_config_tab (
id_configuration numeric options (key 'true') not null,
id_service numeric,
ind_periodicity varchar(50),
ind_begin_schedule varchar(50),
ind_begin_minute varchar(5),
ind_begin_second varchar(5),
ind_end_schedule varchar(50),
ind_end_minute varchar(5),
ind_end_second varchar(5),
ind_type_schedule varchar(50),
ind_val_type_schedule varchar(150),
ind_monday numeric,
ind_tuesday numeric,
ind_wednesday numeric,
ind_thursday numeric,
ind_friday numeric,
ind_saturday numeric,
ind_sunday numeric,
ind_day_month numeric,
ind_week_month numeric,
ind_cron_expression varchar(150),
ind_estatus varchar(1),
attribute_category varchar(150),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
attribute6 varchar(150),
attribute7 varchar(150),
attribute8 varchar(150),
attribute9 varchar(150),
attribute10 varchar(150),
attribute11 varchar(150),
attribute12 varchar(150),
attribute13 varchar(150),
attribute14 varchar(150),
attribute15 varchar(150),
fec_creation_date timestamp(0) not null,
num_created_by numeric not null,
fec_last_update_date timestamp(0) not null,
num_last_updated_by numeric not null,
num_last_update_login numeric
) server  options(schema 'XXMOR', table 'XXTDL_INT_CRON_CONFIG_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxtdl_int_dataxchange_req_tab (
id_dataxchange_req numeric options (key 'true') not null,
id_dataxchange numeric not null,
id_nprogrammeuid numeric,
id_nepisodeuid numeric,
id_nversionuid numeric,
id_material_uid numeric,
last_update_date_pgm timestamp(0),
last_update_date_ep timestamp(0),
last_update_date_ver timestamp(0),
ind_operation_type varchar(1),
ind_estatus_tdl varchar(1),
ind_user_name varchar(150),
ind_estatus varchar(1),
attribute_category varchar(150),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
attribute6 varchar(150),
attribute7 varchar(150),
attribute8 varchar(150),
attribute9 varchar(150),
attribute10 varchar(150),
attribute11 varchar(150),
attribute12 varchar(150),
attribute13 varchar(150),
attribute14 varchar(150),
attribute15 varchar(150),
fec_creation_date timestamp(0) not null,
num_created_by numeric not null,
fec_last_update_date timestamp(0) not null,
num_last_updated_by numeric not null,
num_last_update_login numeric
) server  options(schema 'XXMOR', table 'XXTDL_INT_DATAXCHANGE_REQ_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxtdl_int_dataxchange_tab (
id_dataxchange numeric options (key 'true') not null,
id_channel_group_uid numeric,
ind_channel_group varchar(150),
des_description varchar(250),
id_nprogrammeuid numeric,
id_programme_type_uid numeric,
last_update_date_pgm timestamp(0),
id_series_uid numeric,
id_nepisodeuid numeric,
last_update_date_ep timestamp(0),
num_no_of_versions numeric,
id_nversionuid numeric,
id_nversionstatusuid numeric,
id_vversionstatuscode varchar(150),
id_vversioncode varchar(150),
des_title varchar(250),
last_update_date_ver timestamp(0),
id_material_type_uid numeric,
id_material_uid numeric,
id_media_type_uid numeric,
fec_creation_pgm timestamp(0),
fec_creation_epd timestamp(0),
fec_creation_ver timestamp(0),
id_creation_versioncd varchar(150),
fec_pivot_date_pgm timestamp(0),
fec_pivot_date_epd timestamp(0),
fec_pivot_date_ver timestamp(0),
id_pivot_versioncd varchar(150),
ind_estatus_lmk varchar(1),
ind_estatus_int varchar(1),
ind_estatus_tdl varchar(1),
id_request numeric,
id_request_row numeric,
fec_updated_tdl timestamp(0),
fec_updated_int timestamp(0),
ind_estatus varchar(1),
attribute_category varchar(150),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
attribute6 varchar(150),
attribute7 varchar(150),
attribute8 varchar(150),
attribute9 varchar(150),
attribute10 varchar(150),
attribute11 varchar(150),
attribute12 varchar(150),
attribute13 varchar(150),
attribute14 varchar(150),
attribute15 varchar(150),
fec_creation_date timestamp(0) not null,
num_created_by numeric not null,
fec_last_update_date timestamp(0) not null,
num_last_updated_by numeric not null,
num_last_update_login numeric
) server  options(schema 'XXMOR', table 'XXTDL_INT_DATAXCHANGE_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxtdl_int_requests_tab (
id_request numeric options (key 'true') not null,
id_service numeric,
ind_service_type varchar(50),
nom_user_name varchar(150),
ind_estatus varchar(1),
attribute_category varchar(150),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
attribute6 varchar(150),
attribute7 varchar(150),
attribute8 varchar(150),
attribute9 varchar(150),
attribute10 varchar(150),
attribute11 varchar(150),
attribute12 varchar(150),
attribute13 varchar(150),
attribute14 varchar(150),
attribute15 varchar(150),
fec_creation_date timestamp(0) not null,
num_created_by numeric not null,
fec_last_update_date timestamp(0) not null,
num_last_updated_by numeric not null,
num_last_update_login numeric
) server  options(schema 'XXMOR', table 'XXTDL_INT_REQUESTS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxtdl_int_services_cat_tab (
id_service numeric options (key 'true') not null,
nom_service varchar(150),
ind_desc_service varchar(150),
ind_service_wsdl varchar(250),
ind_origin varchar(100),
ind_destiny varchar(100),
ind_system varchar(100),
ind_synchronous varchar(1),
ind_estatus varchar(1),
attribute_category varchar(150),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
attribute6 varchar(150),
attribute7 varchar(150),
attribute8 varchar(150),
attribute9 varchar(150),
attribute10 varchar(150),
attribute11 varchar(150),
attribute12 varchar(150),
attribute13 varchar(150),
attribute14 varchar(150),
attribute15 varchar(150),
fec_creation_date timestamp(0) not null,
num_created_by numeric not null,
fec_last_update_date timestamp(0) not null,
num_last_updated_by numeric not null,
num_last_update_login numeric
) server  options(schema 'XXMOR', table 'XXTDL_INT_SERVICES_CAT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxtdl_int_services_log_tab (
id_log_services numeric options (key 'true') not null,
id_service numeric options (key 'true') not null,
ind_process numeric,
ind_response varchar(1),
num_user numeric,
fec_response timestamp(0),
fec_request timestamp(0),
num_process_id numeric,
num_pgm_process_id numeric,
ind_service_type varchar(150),
ind_estatus varchar(1),
attribute_category varchar(150),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
attribute6 varchar(150),
attribute7 varchar(150),
attribute8 varchar(150),
attribute9 varchar(150),
attribute10 varchar(150),
attribute11 varchar(150),
attribute12 varchar(150),
attribute13 varchar(150),
attribute14 varchar(150),
attribute15 varchar(150),
fec_creation_date timestamp(0) options (key 'true') not null,
num_created_by numeric not null,
fec_last_update_date timestamp(0) not null,
num_last_updated_by numeric not null,
num_last_update_login numeric
) server  options(schema 'XXMOR', table 'XXTDL_INT_SERVICES_LOG_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxtdl_int_services_params_tab (
id_parameter_serv numeric options (key 'true') not null,
id_service numeric,
ind_parameter varchar(50),
ind_val_parameter varchar(150),
ind_estatus varchar(1),
attribute_category varchar(150),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
attribute6 varchar(150),
attribute7 varchar(150),
attribute8 varchar(150),
attribute9 varchar(150),
attribute10 varchar(150),
attribute11 varchar(150),
attribute12 varchar(150),
attribute13 varchar(150),
attribute14 varchar(150),
attribute15 varchar(150),
fec_creation_date timestamp(0) not null,
num_created_by numeric not null,
fec_last_update_date timestamp(0) not null,
num_last_updated_by numeric not null,
num_last_update_login numeric
) server  options(schema 'XXMOR', table 'XXTDL_INT_SERVICES_PARAMS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxtdl_int_service_bitacora_tab (
id_bitacora varchar(150) options (key 'true') not null,
id_log_services numeric,
id_service numeric,
ind_process numeric,
num_process_id numeric,
num_pgm_process_id numeric,
ind_evento varchar(500),
ind_estatus varchar(1),
attribute_category varchar(150),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
attribute6 varchar(150),
attribute7 varchar(150),
attribute8 varchar(150),
attribute9 varchar(150),
attribute10 varchar(150),
attribute11 varchar(150),
attribute12 varchar(150),
attribute13 varchar(150),
attribute14 varchar(150),
attribute15 varchar(150),
fec_creation_date timestamp(0) not null,
num_created_by numeric not null,
fec_last_update_date timestamp(0) not null,
num_last_updated_by numeric not null,
num_last_update_login numeric
) server  options(schema 'XXMOR', table 'XXTDL_INT_SERVICE_BITACORA_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = xxmor,oracle,dmap_extension,public;
create foreign  table xxtdl_int_xml_files_tab (
id_file_xml numeric options (key 'true') not null,
id_request numeric,
id_service numeric,
nom_file varchar(150),
ind_file_type varchar(50),
ind_service_type varchar(50),
ind_file_stream bytea,
nom_user_name varchar(150),
nom_path_file varchar(150),
ind_estatus varchar(1),
attribute_category varchar(150),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
attribute6 varchar(150),
attribute7 varchar(150),
attribute8 varchar(150),
attribute9 varchar(150),
attribute10 varchar(150),
attribute11 varchar(150),
attribute12 varchar(150),
attribute13 varchar(150),
attribute14 varchar(150),
attribute15 varchar(150),
fec_creation_date timestamp(0) options (key 'true') not null,
num_created_by numeric not null,
fec_last_update_date timestamp(0) not null,
num_last_updated_by numeric not null,
num_last_update_login numeric
) server  options(schema 'XXMOR', table 'XXTDL_INT_XML_FILES_TAB', readonly 'true');
