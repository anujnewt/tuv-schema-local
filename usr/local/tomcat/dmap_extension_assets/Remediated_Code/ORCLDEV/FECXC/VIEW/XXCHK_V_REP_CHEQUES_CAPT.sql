SET search_path = fecxc, oracle, dmap_extension, public;

CREATE OR REPLACE VIEW xxchk_v_rep_cheques_capt (
    estatus_cheque,
    id_estado_cheque,
    banco,
    cliente,
    referencia_cliente,
    no_cheque,
    no_cheque_reemplazo,
    fecha_ultima_modificacion,
    fecha_de_creacion,
    importe,
    moneda,
    antiguedad_origen,
    antiguedad_cambio_est,
    sysdate_fecha_cobro,
    cheques_a_depositar,
    fecha_emision,
    fecha_caputra,
    fecha_cambio,
    fecha_cobro,
    esrechazo
) AS
SELECT DISTINCT
    ce.descripcion                                                              AS estatus_cheque,
    ce.id_estado_cheque,
    cb.descripcion_banco                                                        AS banco,
    cc.desc_cliente                                                             AS cliente,
    cc.referencia_cliente,
    cc.no_cheque,
    cc.no_cheque_reemplazo,
    TO_CHAR(cc.last_modified_date)                                              AS fecha_ultima_modificacion,
    TO_CHAR(cc.date_created)                                                    AS fecha_de_creacion,
    cc.importe,
    cc.moneda,
    TO_CHAR(FLOOR(EXTRACT(EPOCH FROM (statement_timestamp() - cc.date_created))  / 86400)) AS antiguedad_origen,
    TO_CHAR(FLOOR(EXTRACT(EPOCH FROM (statement_timestamp() - cc.last_modified_date)) / 86400)) AS antiguedad_cambio_est,
    TO_CHAR(FLOOR(EXTRACT(EPOCH FROM (statement_timestamp() - cc.fecha_cobro))   / 86400)) AS sysdate_fecha_cobro,
    TO_CHAR(FLOOR(EXTRACT(EPOCH FROM (statement_timestamp() - cc.fecha_emision)) / 86400)) AS cheques_a_depositar,
    cc.fecha_emision,
    cc.date_created                                                             AS fecha_caputra,
    cc.last_modified_date                                                       AS fecha_cambio,
    cc.fecha_cobro,
    'NORMAL'                                                                    AS esrechazo
FROM xxchk_captura_cheques cc
JOIN xxchk_catalogo_bancos cb ON cc.id_banco = cb.id_banco
JOIN xxchk_cat_edos        ce ON cc.id_estado_cheque = ce.id_estado_cheque
WHERE ce.tipo_operacion = 'RECHAZADO'

UNION

SELECT DISTINCT
    ce.descripcion                                                              AS estatus_cheque,
    ce.id_estado_cheque,
    cb.descripcion_banco                                                        AS banco,
    cc.desc_cliente                                                             AS cliente,
    cc.referencia_cliente,
    cc.no_cheque,
    cc.no_cheque_reemplazo,
    TO_CHAR(cc.last_modified_date)                                              AS fecha_ultima_modificacion,
    TO_CHAR(cc.date_created)                                                    AS fecha_de_creacion,
    cc.importe,
    cc.moneda,
    TO_CHAR(FLOOR(EXTRACT(EPOCH FROM (statement_timestamp() - cc.date_created))  / 86400)) AS antiguedad_origen,
    TO_CHAR(FLOOR(EXTRACT(EPOCH FROM (statement_timestamp() - cc.last_modified_date)) / 86400)) AS antiguedad_cambio_est,
    TO_CHAR(FLOOR(EXTRACT(EPOCH FROM (statement_timestamp() - cc.fecha_cobro))   / 86400)) AS sysdate_fecha_cobro,
    TO_CHAR(FLOOR(EXTRACT(EPOCH FROM (statement_timestamp() - cc.fecha_emision)) / 86400)) AS cheques_a_depositar,
    cc.fecha_emision,
    cc.date_created                                                             AS fecha_caputra,
    cc.last_modified_date                                                       AS fecha_cambio,
    cc.fecha_cobro,
    'NORMAL'                                                                    AS esrechazo
FROM xxchk_captura_cheques cc
JOIN xxchk_catalogo_bancos cb ON cc.id_banco = cb.id_banco
JOIN xxchk_cat_edos        ce ON cc.id_estado_cheque = ce.id_estado_cheque
WHERE ce.tipo_operacion <> 'RECHAZADO';