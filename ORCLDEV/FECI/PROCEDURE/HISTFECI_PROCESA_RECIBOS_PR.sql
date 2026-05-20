CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."HISTFECI_PROCESA_RECIBOS_PR" 
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  CONTADOR_RECIBOS NUMBER;
BEGIN
  CONTADOR_RECIBOS:=0;
    SELECT
           COUNT(FOLIO_RECIBO) INTO CONTADOR_RECIBOS
            FROM HISTFECI_RECIBOS_MASIVO_TAB
            WHERE
            FOLIO_RECIBO NOT IN (SELECT FOLIO_RECIBO FROM FECI_RECIBO_TAB);
            IF CONTADOR_RECIBOS > 0 THEN
                -- Registra recibos en FECI_RECIBO_TAB
                INSERT INTO FECI_RECIBO_TAB (
                    FOLIO_RECIBO,
                    FEC_INGRESO,
                    FEC_DEPOSITO,
                    FEC_CONTABILIDAD,
                    FEC_OPERATIVA,
                    IMPORTE,
                    COD_MONEDA,
                    COD_EMPRESA,
                    COD_CLIENTE,
                    NOM_CLIENTE,
                    REF_CLIENTE,
                    CLASE_CLIENTE,
                    METODO_PAGO,
                    NOM_BANCO_EMISOR,
                    NUM_CHEQUERA,
                    NUM_CHEQUE,
                    NUM_OPERACION,
                    TIPO_CAMBIO_ORIGEN,
                    FEC_TC_ORIGEN,
                    TIPO_CAMBIO_DOLAR,
                    FEC_TC_DOLAR,
                    ID_USUARIO_CLASIFICACION,
                    FEC_CLASIFICACION,
                    ID_USUARIO_APLICACION,
                    FEC_APLICACION,
                    COD_ESTADO_RECIBO,
                    FEC_CREACION,
                    FEC_ULT_MODIFICACION,
                    ID_USUARIO_CREACION,
                    ID_USUARIO_ULT_MODIF,
                    IND_ESTADO
                )
                SELECT
                    MAX(FOLIO_RECIBO) AS FOLIO_RECIBO,
                    MAX(FEC_INGRESO) AS FEC_INGRESO,
                    MAX(FEC_DEPOSITO) AS FEC_DEPOSITO,
                    MAX(FEC_CONTABILIDAD) AS FEC_CONTABILIDAD,
                    MAX(FEC_CONTABILIDAD) AS FEC_OPERATIVA,
                    MAX(IMPORTE) AS IMPORTE,
                    MAX(COD_MONEDA) AS COD_MONEDA,
                    MAX(COD_EMPRESA) AS COD_EMPRESA,
                    MAX(COD_CLIENTE) AS COD_CLIENTE,
                    MAX(NOM_CLIENTE) AS NOM_CLIENTE,
                    MAX(REF_CLIENTE) AS REF_CLIENTE,
                    MAX(COD_CLASE_CLIENTE) AS CLASE_CLIENTE,
                    MAX(METODO_PAGO) AS METODO_PAGO,
                    MAX(NOM_BANCO_EMISOR) AS NOM_BANCO_EMISOR,
                    MAX(NUM_CHEQUERA) AS NUM_CHEQUERA,
                    MAX(NUM_CHEQUE) AS NUM_CHEQUE,
                    MAX(NUM_OPERACION) AS NUM_OPERACION,
                    MAX(TIPO_CAMBIO_ORIGEN) AS TIPO_CAMBIO_ORIGEN,
                    MAX(FEC_TC_ORIGEN) AS FEC_TC_ORIGEN,
                    MAX(TIPO_CAMBIO_DOLAR) AS TIPO_CAMBIO_DOLAR,
                    MAX(FEC_TC_DOLAR) AS FEC_TC_DOLAR,
                    0 AS ID_USUARIO_CLASIFICACION,
                    MAX(FEC_CLASIFICACION) AS FEC_CLASIFICACION,
                    0 AS ID_USUARIO_APLICACION,
                    MAX(FEC_APLICACION) AS FEC_APLICACION,
                    'APLC' AS COD_ESTADO_RECIBO,
                    SYSDATE AS FEC_CREACION,
                    SYSDATE AS FEC_ULT_MODIFICACION,
                    0 AS ID_USUARIO_CREACION,
                    0 AS ID_USUARIO_ULT_MODIF,
                    1 AS IND_ESTADO
                FROM HISTFECI_RECIBOS_MASIVO_TAB
                WHERE
                    FOLIO_RECIBO NOT IN (SELECT FOLIO_RECIBO FROM FECI_RECIBO_TAB)
                GROUP BY
                    FOLIO_RECIBO;
            END IF;
END;
/
