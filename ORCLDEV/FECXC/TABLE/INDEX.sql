-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_catxemp on fecxc_cat_xempresa (e_codigo, cod_sec_tipcat);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_fecxc_dep_esp_d01 on fecxc_dep_especiales_d (secuencia_det_dep_esp, secuencia_dep_especiales);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_det_cat on fecxc_det_catalogos (tipo_cat, cod_valor);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_clasifica on fecxc_det_clasfecxc (codclasif, cod_subclasif);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_pres_diario on fecxc_det_pres_diario (diario, segmento1, segmento2, segmento3, segmento4, segmento5, segmento6, segmento7, segmento8, segmento9, segmento10, sec_presup);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_enc_cat on fecxc_enc_catalogos (tipo_cat);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_cat_clasif on fecxc_enc_clasfecxc (codclasif);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_e_cat_calsif on fecxc_enc_clasificados (e_codigo, codfolio);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_enc_presup on fecxc_enc_de_presu (codanno, secmoneda);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxc_inpc_idx on fecxc_inpc (ano_inpc, mes_inpc);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_monedas on fecxc_monedas (codmoneda);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_bit_cont_din_aper_enc_01 on fecxp_bit_cont_din_aper_enc (secuencia_pagos_erp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_bit_cont_din_aper_enc_02 on fecxp_bit_cont_din_aper_enc (e_codigo, folio_set, estatus_movimiento);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_cancelados_sincambios_01 on fecxp_cancelados_sincambios (e_codigo, secuencia_pagos_erp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_canc_sin_apli_01 on fecxp_cancelados_sin_aplicado (e_codigo, secuencia_pagos_erp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_crear_aperturados_01 on fecxp_crear_aperturados (e_codigo, secuencia_aplicada);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_clafe_id_soin_tmp000 on fecxp_ctas_clasif_ppto_soin (cla_fe_id, e_codigo, ctam01, ctam02, ctam03, ctacr1, ctacr2);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_ctas_clasif_real_erp03 on fecxp_ctas_clasif_real_erp (e_codigo, tipo_operacion, id_banco, id_chequera, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_ctas_clasif_real_erp03_h on fecxp_ctas_clasif_real_erp_h (e_codigo, tipo_operacion, id_banco, id_chequera, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, periodo, mes, id_version);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_ctas_clasif_real_soin01 on fecxp_ctas_clasif_real_soin (e_codigo, tipo_operacion, id_banco, id_chequera, ctam01, ctam02, ctam03, ctacr1, ctacr2);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_ctas_clsf_rl_soin01_h on fecxp_ctas_clasif_real_soin_h (e_codigo, tipo_operacion, id_banco, id_chequera, ctam01, ctam02, ctam03, ctacr1, ctacr2, periodo, mes, id_version);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_clafe_id_soin00 on fecxp_ctas_soin_caratula (cla_fe_id, e_codigo, ctam01, ctam02, ctam03, ctacr1, ctacr2);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_del_clasif_real_soin01 on fecxp_del_clasif_real_soin (e_codigo, tipo_operacion, id_banco, id_chequera, ctam01, ctam02, ctam03, ctacr1, ctacr2);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_del_ctas_real_erp03 on fecxp_del_ctas_real_erp (e_codigo, tipo_operacion, id_banco, id_chequera, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_del_ppto_com_cta_erp_01 on fecxp_del_ppto_com_cta_erp (oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_del_soin_caratula00 on fecxp_del_soin_caratula (e_codigo, ctam01, ctam02, ctam03, ctacr1, ctacr2);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_pag_erp_folio on fecxp_enc_pagos_erp (folio_set, estatus_movimiento, tipo_operacion);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_enc_pagos_erp_tmp00 on fecxp_enc_pagos_erp_tmp (e_codigo, secuencia_pagos_erp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_pag_soin_folio on fecxp_enc_pagos_soin (folio_set, estatus_movimiento, tipo_operacion);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_enc_replicas_proc_tmp_01 on fecxp_enc_replicas_proc_tmp (e_codigo, secuencia_pagos_erp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_folios_prov_enc_01 on fecxp_folios_prov_enc (fecxp_e_codigo, fecxp_no_folio_det);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index pk_fecxp_imp_datos_param on fecxp_importacion_datos_params (tipoempresa, tipo_importacion);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_mon_oracle on fecxp_monedas (mon_oracle, mes, periodo);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_mon_sybase on fecxp_monedas (mon_sybase, mes, periodo);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index pk_fecxp_monedas_ns on fecxp_monedas_no_set (mon_set, mes, periodo);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_fecxp_org_inv_flujo on fecxp_org_inv_flujo (organization_id);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_fecxp_pagos_cuentas_ap on fecxp_pagos_cuentas_apertura (oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_fecxp_ppto_conversion_erp on fecxp_ppto_conversion_erp (e_codigo, version_fe, periodo, mes, libro_id, version_id, moneda, code_combination);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_fecxp_ppto_conversion_soin on fecxp_ppto_conversion_soin (e_codigo, version_fe, periodo, mescod, arsmap, aejmap, cncmap, ctacr1, ctacr2, moneda);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_fecxp_ppto_cnversn_soin_h on fecxp_ppto_conversion_soin_h (e_codigo, version_fe, periodo, mescod, arsmap, aejmap, cncmap, ctacr1, ctacr2, moneda, id_version);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_ppto_ext_params_idx on fecxp_ppto_extraccion_params (proceso_id);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_fecxp_ppto_operativo_soin on fecxp_ppto_operativo_soin (e_codigo, version_fe, periodo, mescod, arsmap, aejmap, cncmap, ctacr1, ctacr2, moneda);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_fecxp_ppto_opera_soin_h on fecxp_ppto_operativo_soin_h (e_codigo, version_fe, periodo, mescod, arsmap, aejmap, cncmap, ctacr1, ctacr2, moneda, id_version);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_fecxp_ppto_operativo_erp on fecxp_ppto_opera_erp (e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index idx_fecxp_ppto_operativo_erp_h on fecxp_ppto_opera_erp_h (e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, id_version);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_replicas_por_cerrar_01 on fecxp_replicas_por_cerrar (e_codigo, secuencia_aplicada);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_rep_ppto_com_cta_erp_01 on fecxp_rep_ppto_com_cta_erp (oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_rep_ppto_com_ver_erp_01 on fecxp_rep_ppto_com_ver_erp (version_id, cla_fe_id, code_combination_id, periodo, mes, moneda);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_rep_ppto_com_ver_soin_01 on fecxp_rep_ppto_com_ver_soin (version_id, cla_fe_id, e_codigo, ctam01, ctam02, ctam03, ctacr1, ctacr2, periodo, mes, moneda);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index fecxp_saldos_finales_setd00 on fecxp_saldos_finales_setd (e_codigo, moneda, fecha);
-- dmap_object_gen_tag : type : unique name : index
set search_path = fecxc,oracle,dmap_extension,public;
create unique index xxchk_mapeo_de_estados_pk on xxchk_mapeo_de_estados (id_tipo_operacion_set);
