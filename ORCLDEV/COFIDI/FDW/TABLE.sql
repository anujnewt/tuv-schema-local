-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_bitacora_tab (
id_bitacora_pk numeric(38) options (key 'true') not null,
fec_evento timestamp,
evento varchar(20),
id_usuario_fk numeric(38)
) server  options(schema 'COFIDI', table 'XXCOFIDI_BITACORA_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_cfdi_concepto_tab (
id_cfdi_concepto_pk numeric options (key 'true') not null,
id_factura_fk numeric not null,
clave_prod_serv varchar(20) not null,
no_identificacion varchar(500),
cantidad varchar(20) not null,
clave_unidad varchar(20) not null,
unidad varchar(20),
descripcion varchar(1500) not null,
valor_unitario varchar(20) not null,
importe varchar(20) not null,
descuento varchar(20),
cod_objeto_imp varchar(10)
) server  options(schema 'COFIDI', table 'XXCOFIDI_CFDI_CONCEPTO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_cfdi_emisor_recep_tab (
id_cfdi_emisor_recep_pk numeric options (key 'true') not null,
id_factura_fk numeric not null,
emisor numeric(1) not null,
rfc varchar(20),
nombre varchar(255),
regimen_fiscal varchar(20),
num_reg_id_trib varchar(20),
uso_cfdi varchar(20),
residencia_fiscal varchar(20)
) server  options(schema 'COFIDI', table 'XXCOFIDI_CFDI_EMISOR_RECEP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_cfdi_impuesto_con_tab (
id_cfdi_impuesto_concepto_pk numeric options (key 'true') not null,
id_factura_fk numeric not null,
id_cfdi_concepto_fk numeric,
traslado numeric(1) not null,
base varchar(20),
impuesto varchar(20) not null,
tipo_factor varchar(20),
tasa_o_cuota varchar(20),
importe varchar(20)
) server  options(schema 'COFIDI', table 'XXCOFIDI_CFDI_IMPUESTO_CON_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_cfdi_pago_tab (
id_cfdi_pago_pk numeric options (key 'true') not null,
uuid varchar(40),
importe_pagado varchar(20),
importe_saldo_ant varchar(20),
importe_saldo_insoluto varchar(20),
moneda_dr varchar(20),
num_parcialidad varchar(20),
tipo_cambio_dr varchar(20),
metodo_pago_dr varchar(20),
id_factura_fk numeric not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_CFDI_PAGO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_cfdi_relacionado_tab (
id_cfdi_relacionado_pk numeric options (key 'true') not null,
id_factura_fk numeric not null,
tipo_comprobante varchar(1) not null,
tipo_relacion varchar(2) not null,
uuid varchar(50) not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_CFDI_RELACIONADO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_documento_tab (
id_documento_pk numeric(38) options (key 'true') not null,
tipo_archivo varchar(3) not null,
nom_archivo varchar(150),
archivo bytea not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_DOCUMENTO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_empresa_ct_tab (
id_empresa_pk numeric(38) options (key 'true') not null,
nom_empresa varchar(255) not null,
id_estado_fk numeric not null,
rfc varchar(13) not null,
cod_cia varchar(3)
) server  options(schema 'COFIDI', table 'XXCOFIDI_EMPRESA_CT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_empresa_serie_usu_tab (
id_empresa_serie_usu_pk numeric(38) options (key 'true') not null,
id_usuario_fk numeric not null,
id_empresa_fk numeric not null,
id_serie_fk numeric not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_EMPRESA_SERIE_USU_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_emp_ori_ser_tab (
id_emp_ori_ser_pk numeric options (key 'true') not null,
id_empresa_fk numeric not null,
id_origen_fk numeric not null,
id_serie_fk numeric
) server  options(schema 'COFIDI', table 'XXCOFIDI_EMP_ORI_SER_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_estado_ct_tab (
id_estado_pk numeric(38) options (key 'true') not null,
estado varchar(50) not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_ESTADO_CT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_factura_tab (
id_factura_pk numeric(38) options (key 'true') not null,
cliente_transaccional varchar(100),
fec_timbrado timestamp,
folio numeric(38),
nom_emisor varchar(255),
nom_receptor varchar(255),
rfc_emisor varchar(13),
rfc_receptor varchar(13),
serie varchar(50),
uuid varchar(50),
id_documento_pdf_fk numeric(38),
id_documento_xml_fk numeric(38),
id_estado_fk numeric not null,
fec_emision timestamp,
tipo_comprobante varchar(20) not null,
val_subtotal varchar(20),
val_impuesto varchar(20),
val_total varchar(20),
pac varchar(10),
origen varchar(50),
folio_alfanumerico varchar(50),
cve_exportacion varchar(10),
cve_periodicidad varchar(10),
cve_meses varchar(10),
cve_anio numeric,
cve_base varchar(10),
cod_dom_fiscal_r varchar(20),
cod_reg_fiscal_r varchar(20),
cod_rfc_a_terceros varchar(20),
cve_nom_acuent_aterc varchar(256),
cod_reg_fis_aterc varchar(20),
cod_dom_fiscal_aterc varchar(20)
) server  options(schema 'COFIDI', table 'XXCOFIDI_FACTURA_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_historico_clave_tab (
id_historico_clave_pk numeric options (key 'true') not null,
id_usuario_fk numeric not null,
cve_usuario varchar(50) not null,
fec_movimiento timestamp not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_HISTORICO_CLAVE_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_historico_usuario_tab (
id_historico_usuario_pk numeric options (key 'true') not null,
id_usuario_movimiento_fk numeric,
user_name_movimiento varchar(50) not null,
id_usuario_afectado_fk numeric not null,
user_name_afectado varchar(50) not null,
fec_movimiento timestamp not null,
des_movimiento varchar(255) not null,
tipo_abc varchar(6),
nom_afectado varchar(255),
ip_origen varchar(15)
) server  options(schema 'COFIDI', table 'XXCOFIDI_HISTORICO_USUARIO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_origen_ct_tab (
id_origen_pk numeric(38) options (key 'true') not null,
origen varchar(255) not null,
tipo numeric(1),
id_estado_fk numeric,
procesar_solo_xml numeric(1) not null,
folio_numerico numeric(1) not null,
descripcion varchar(150) not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_ORIGEN_CT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_pac_ct_tab (
id_pac_pk numeric(38) options (key 'true') not null,
pac varchar(255) not null,
id_estado_fk numeric
) server  options(schema 'COFIDI', table 'XXCOFIDI_PAC_CT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_paginacion_ct_tab (
id_paginacion_pk numeric(38) options (key 'true') not null,
pagina numeric(38)
) server  options(schema 'COFIDI', table 'XXCOFIDI_PAGINACION_CT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_parametro_ct_tab (
id_parametro_pk numeric(38) options (key 'true') not null,
valor varchar(255) not null,
des_parametro varchar(255),
orden numeric(2)
) server  options(schema 'COFIDI', table 'XXCOFIDI_PARAMETRO_CT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_rol_ct_tab (
id_rol_pk numeric(38) options (key 'true') not null,
rol varchar(50) not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_ROL_CT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_series_empresa_tab (
id_series_empresa_pk numeric options (key 'true') not null,
id_serie_fk numeric not null,
id_empresa_fk numeric not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_SERIES_EMPRESA_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_serie_ct_tab (
id_serie_pk numeric(38) options (key 'true') not null,
serie varchar(10) not null,
id_estado_fk numeric(38) not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_SERIE_CT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_usuario_correo_tab (
id_usuario_correo_pk numeric options (key 'true') not null,
nom_usuario_correo varchar(50) not null,
cve_usuario_correo varchar(50) not null,
host varchar(100) not null,
puerto varchar(10) not null,
autenticacion varchar(10) not null,
remitente varchar(100) not null,
remitente_no_enviar varchar(100)
) server  options(schema 'COFIDI', table 'XXCOFIDI_USUARIO_CORREO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_usuario_ldap_tab (
id_usuario_ldap_pk numeric options (key 'true') not null,
nom_usuario_ldap varchar(50) not null,
cve_usuario_ldap varchar(50) not null,
puerto varchar(10) not null,
host varchar(50) not null,
dominio varchar(50) not null,
tipo_autenticacion varchar(50) not null,
dc1 varchar(20),
dc2 varchar(20),
dc3 varchar(20),
dc4 varchar(20)
) server  options(schema 'COFIDI', table 'XXCOFIDI_USUARIO_LDAP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_usuario_ldap_tab_bk (
id_usuario_ldap_pk numeric not null,
nom_usuario_ldap varchar(50) not null,
cve_usuario_ldap varchar(50) not null,
puerto varchar(10) not null,
host varchar(50) not null,
dominio varchar(50) not null,
tipo_autenticacion varchar(50) not null,
dc1 varchar(20),
dc2 varchar(20),
dc3 varchar(20),
dc4 varchar(20)
) server  options(schema 'COFIDI', table 'XXCOFIDI_USUARIO_LDAP_TAB_BK', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_usuario_login_tab (
id_usuario_login_pk numeric options (key 'true') not null,
id_usuario_fk numeric not null,
fec_ultimo_logeo timestamp not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_USUARIO_LOGIN_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_usuario_origen_tab (
id_usuario_origen_pk numeric options (key 'true') not null,
id_usuario_fk numeric not null,
id_origen_fk numeric not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_USUARIO_ORIGEN_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_usuario_tab (
id_usuario_pk numeric(38) options (key 'true') not null,
user_name varchar(50) not null,
cve_usuario varchar(50),
nom_usuario varchar(255),
ap_paterno varchar(255),
ap_materno varchar(255),
puesto varchar(255),
correo_electronico varchar(255),
fec_vigencia timestamp,
fec_creacion timestamp not null,
fec_ultima_modificacion timestamp,
comentarios varchar(255),
id_rol_fk numeric(38) not null,
id_estado_fk numeric(38) not null,
cambiar_contrasenia numeric(1),
eliminar_reg numeric(1),
consultar_usuarios numeric(1),
generar_reporte_usuarios numeric(1),
administrar_usuarios numeric(1),
consultar_bitacora numeric(1),
consultar_documentos numeric(1),
administrar_catalogos numeric(1),
tipo_usuario numeric(1),
intentos_logeo numeric(3) not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_USUARIO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxcofidi_usu_ori_emp_tab (
id_usu_ori_emp_pk numeric options (key 'true') not null,
id_usuario_fk numeric not null,
id_origen_fk numeric not null,
id_empresa_fk numeric not null
) server  options(schema 'COFIDI', table 'XXCOFIDI_USU_ORI_EMP_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = cofidi,oracle,dmap_extension,public;
create foreign  table xxprtechx (
id_factura numeric,
archivo text
) server  options(schema 'COFIDI', table 'XXPRTECHX', readonly 'true');
