-- dmap_object_gen_tag : type : view name : feci_clasificaciones_vw
set search_path = feci,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "feci_clasificaciones_vw"  ("folio_recibo", "tipo_recibo", "fec_operativa", "importe", "cod_moneda", "des_moneda", "cod_empresa", "des_empresa", "cod_cliente", "ref_cliente", "nom_cliente", "clase_cliente", "metodo_pago", "nom_banco_emisor", "num_chequera", "num_cheque", "num_operacion", "tipo_cambio_origen", "tipo_cambio_dolar", "fec_clasificacion", "fec_aplicacion", "cod_estado_recibo", "fec_deposito", "id_clasificacion", "orden", "porcentaje_iva", "importe_org", "monto_base_org", "monto_iva_org", "importe_mxn", "monto_base_mxn", "monto_iva_mxn", "importe_usd", "monto_base_usd", "monto_iva_usd", "cod_segmento", "des_segmento", "cod_moneda_segmento", "cod_grupo_forecast", "des_grupo_forecast", "cod_concepto", "des_concepto", "cod_region", "des_region", "cod_pais", "des_pais", "desc_cps") as select  rec.folio_recibo
, rec.tipo_recibo
, rec.fec_operativa
, rec.importe
, rec.cod_moneda
, rec.des_moneda
, rec.cod_empresa
, rec.des_empresa
, rec.cod_cliente
, rec.ref_cliente
, rec.nom_cliente
, rec.clase_cliente
, rec.metodo_pago
, rec.nom_banco_emisor
, rec.num_chequera
, rec.num_cheque
, rec.num_operacion
, rec.tipo_cambio_origen
, rec.tipo_cambio_dolar
, rec.fec_clasificacion
, rec.fec_aplicacion
, rec.cod_estado_recibo
, rec.fec_deposito
, cls.id_clasificacion
, cls.orden
, cls.porcentaje_iva
, cls.importe_org
, cls.monto_base_org
, cls.monto_iva_org
, cls.importe_mxn
, cls.monto_base_mxn
, cls.monto_iva_mxn
, cls.importe_usd
, cls.monto_base_usd
, cls.monto_iva_usd
, cls.cod_segmento
, seg.des_segmento
, seg.cod_moneda as cod_moneda_segmento
, cls.cod_grupo_forecast
, gfc.des_grupo_forecast
, cls.cod_concepto
, con.des_concepto
, cls.cod_region
, reg.des_region
, cls.cod_pais
, pai.des_pais
, cls.desc_cps
from feci_clasificacion_tab cls
inner join feci_recibos_vw rec on cls.folio_recibo = rec.folio_recibo and cls.tipo_recibo=rec.tipo_recibo
inner join feci_grupo_forecast_cat gfc on cls.cod_grupo_forecast = gfc.cod_grupo_forecast
inner join feci_segmento_cat seg on cls.cod_segmento = seg.cod_segmento
inner join feci_concepto_cat con on cls.cod_concepto = con.cod_concepto
left outer join feci_region_cat reg on cls.cod_region = reg.cod_region
left outer join feci_pais_cat pai on cls.cod_pais = pai.cod_pais
where rec.ind_estado = 1 and cls.ind_estado = 1 and rec.cod_estado_recibo = 'APLC' and gfc.ind_estado = 1;/* dmap converted statement end */
-- estimed cost of view [ feci_clasificaciones_vw ]: 1.00;
