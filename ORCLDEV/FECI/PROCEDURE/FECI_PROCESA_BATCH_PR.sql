CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_PROCESA_BATCH_PR" 
(
    p_FECHA_INICIO  DATE,
    p_ERROR           VARCHAR2 DEFAULT NULL,
    p_TIPO_EJECUCION      VARCHAR
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  CONTADOR_RECIBOS NUMBER;
  CONTADOR_EMPRESA NUMBER;
  CONTADOR_MONEDAS NUMBER;
  CONTADOR_TC NUMBER;
  TIPO_RESULTADO_ VARCHAR(32767);
  STR_ERROR VARCHAR2(32767);
BEGIN
    IF p_ERROR IS  NULL THEN
        BEGIN
            STR_ERROR := '-';
            --Elimina registros de FECI_CARGA_RECIBOS_BATCH donde CIA='CIA'
            DELETE FROM FECI_CARGA_RECIBOS_BATCH WHERE CIA = 'CIA';
            SELECT
               COUNT(DISTINCT TRIM(CIA)) INTO CONTADOR_EMPRESA
            FROM FECI_CARGA_RECIBOS_BATCH
            WHERE TRIM(CIA) IS NOT NULL
            AND TRIM(CIA) NOT IN (SELECT TRIM(COD_EMPRESA) FROM FECI_EMPRESA_CAT);
            IF CONTADOR_EMPRESA > 0 THEN
                -- Registra empresas que no est?en el cat?go FECI_EMPRESA_CAT
                INSERT INTO FECI_EMPRESA_CAT (
                    COD_EMPRESA,
                    DES_EMPRESA,
                    FEC_CREACION,
                    FEC_ULT_MODIFICACION,
                    ID_USUARIO_CREACION,
                    ID_USUARIO_ULT_MODIF,
                    IND_ESTADO
                )
                SELECT DISTINCT
                    TRIM(CIA) AS COD_EMPRESA,
                    TRIM(DESC_CIA) AS DES_EMPRESA,
                    SYSDATE AS FEC_CREACION,
                    SYSDATE AS FEC_ULT_MODIFICACION,
                    0 AS ID_USUARIO_CREACION,
                    0 AS ID_USUARIO_ULT_MODIF,
                    1 AS IND_ESTADO
                FROM FECI_CARGA_RECIBOS_BATCH
                WHERE TRIM(CIA) IS NOT NULL
                AND TRIM(CIA) NOT IN (SELECT TRIM(COD_EMPRESA) FROM FECI_EMPRESA_CAT);
            END IF;
            SELECT
                COUNT( DISTINCT TRIM(CURRENCY_CODE))  INTO CONTADOR_MONEDAS
            FROM FECI_CARGA_RECIBOS_BATCH
            WHERE TRIM(CURRENCY_CODE) IS NOT NULL
            AND TRIM(CURRENCY_CODE) NOT IN (SELECT TRIM(COD_MONEDA) FROM FECI_MONEDA_CAT);
            IF CONTADOR_MONEDAS > 0 THEN
               -- Registra monedas que no est?en el cat?go FECI_MONEDA_CAT
               INSERT INTO FECI_MONEDA_CAT (
                    COD_MONEDA,
                    DES_MONEDA,
                    FEC_CREACION,
                    FEC_ULT_MODIFICACION,
                    ID_USUARIO_CREACION,
                    ID_USUARIO_ULT_MODIF,
                    IND_ESTADO
                )
                SELECT DISTINCT
                    TRIM(CURRENCY_CODE) AS MONEDA,
                    TRIM(CURRENCY) AS DES_MONEDA,
                    SYSDATE AS FEC_CREACION,
                    SYSDATE AS FEC_ULT_MODIFICACION,
                    0 AS ID_USUARIO_CREACION,
                    0 AS ID_USUARIO_ULT_MODIF,
                    1 AS IND_ESTADO
                FROM FECI_CARGA_RECIBOS_BATCH
                WHERE TRIM(CURRENCY_CODE) IS NOT NULL
                AND TRIM(CURRENCY_CODE) NOT IN (SELECT TRIM(COD_MONEDA) FROM FECI_MONEDA_CAT);
            END IF;
            SELECT
               COUNT(FOLIO_RECIBO) INTO CONTADOR_RECIBOS
            FROM FECI_CARGA_RECIBOS_BATCH
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
                    FOLIO_RECIBO,
                    TO_DATE(RECEIPT_DATE,'DD/MM/YYYY')  AS FEC_INGRESO,
                    TO_DATE(DEPOSIT_DATE,'DD/MM/YYYY') AS FEC_DEPOSITO,
                    TO_DATE(FECHA_GL,'DD/MM/YYYY') AS FEC_CONTABILIDAD,
                    TO_DATE(FECHA_GL,'DD/MM/YYYY') AS FEC_OPERATIVA,
                    AMOUNT AS IMPORTE,
                    CURRENCY_CODE AS COD_MONEDA,
                    CIA AS COD_EMPRESA,
                    NUMERO_CLIENTE AS COD_CLIENTE,
                    NOMBRE_CLIENTE AS NOM_CLIENTE,
                    REFERENCIA_CLIENTE AS REF_CLIENTE,
                    CLASE_CLIENTE AS CLASE_CLIENTE,
                    RECEIPT_METHOD AS METODO_PAGO,
                    BANK_NAME AS NOM_BANCO_EMISOR,
                    BANK_ACCOUNT_NAME AS NUM_CHEQUERA,
                    NUM_CHEQUE,
                    TIPO_OPERACION AS NUM_OPERACION,
                    NULL AS TIPO_CAMBIO_ORIGEN,
                    NULL AS FEC_TC_ORIGEN,
                    NULL AS TIPO_CAMBIO_DOLAR,
                    NULL AS FEC_TC_DOLAR,
                    NULL AS ID_USUARIO_CLASIFICACION,
                    NULL AS FEC_CLASIFICACION,
                    NULL AS ID_USUARIO_APLICACION,
                    NULL AS FEC_APLICACION,
                    'PEND' AS COD_ESTADO_RECIBO,
                    SYSDATE AS FEC_CREACION,
                    SYSDATE AS FEC_ULT_MODIFICACION,
                    0 AS ID_USUARIO_CREACION,
                    0 AS ID_USUARIO_ULT_MODIF,
                    1 AS IND_ESTADO
                FROM FECI_CARGA_RECIBOS_BATCH
                WHERE
                FOLIO_RECIBO NOT IN (SELECT FOLIO_RECIBO FROM FECI_RECIBO_TAB );
            END IF;
            DELETE FECI_CARGA_RECIBOS_BATCH;
           ---AQUI SE DEBE COLOCAR LO DE TIPOS DE CAMBIO PARA EL CONTADOR
            SELECT
                COUNT(FECHA) INTO CONTADOR_TC
                FROM FECI_CARGA_TIPOCAMBIO_BATCH tcb
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM FECI_TC_MONEDA_CAT tcm
                    WHERE
                        tcm.FEC_FECHA_TC = TO_DATE(tcb.FECHA,'DD/MM/YYYY')
                        AND tcm.COD_MON_ORIGEN = tcb.DE
                        AND tcm.COD_MON_DESTINO = tcb.A
                );
            IF CONTADOR_TC > 0 THEN
                INSERT INTO FECI_TC_MONEDA_CAT (
                    FEC_FECHA_TC,
                    COD_MON_ORIGEN,
                    COD_MON_DESTINO,
                    NUM_TIPO_CAMBIO,
                    NUM_FACTOR,
                    FEC_CREACION,
                    FEC_ULT_MODIFICACION,
                    ID_USUARIO_CREACION,
                    ID_USUARIO_ULT_MODIF,
                    IND_ESTADO
                )
                SELECT
                    TO_DATE(tcb.FECHA,'DD/MM/YYYY') AS FEC_FECHA_TC,
                    tcb.DE AS COD_MON_ORIGEN,
                    tcb.A AS COD_MON_DESTINO,
                    tcb.TIPO_CAMBIO AS NUM_TIPO_CAMBIO,
                    tcb.FACTOR AS NUM_FACTOR,
                    SYSDATE AS FEC_CREACION,
                    SYSDATE AS FEC_ULT_MODIFICACION,
                    0 AS ID_USUARIO_CREACION,
                    0 AS ID_USUARIO_ULT_MODIF,
                    1 AS IND_ESTADO
                FROM FECI_CARGA_TIPOCAMBIO_BATCH tcb
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM FECI_TC_MONEDA_CAT tcm
                    WHERE
                        tcm.FEC_FECHA_TC = TO_DATE(tcb.FECHA,'DD/MM/YYYY')
                        AND tcm.COD_MON_ORIGEN = tcb.DE
                        AND tcm.COD_MON_DESTINO = tcb.A
                );
                -----------------REGISTRO DE TIPO DE CAMBIO
                INSERT INTO FECI_TIPO_CAMBIO_CAT (
                        FEC_FECHA_TC,
                        COD_MONEDA,
                        NUM_VALOR,
                        FEC_CREACION,
                        FEC_ULT_MODIFICACION,
                        ID_USUARIO_CREACION,
                        ID_USUARIO_ULT_MODIF,
                        IND_ESTADO
                    )
                    SELECT DISTINCT
                        TO_DATE(tcb.FECHA,'DD/MM/YYYY') AS FEC_FECHA_TC,
                        tcb.DE AS COD_MON_ORIGEN,
                        tcb.TIPO_CAMBIO AS NUM_TIPO_CAMBIO,
                        SYSDATE AS FEC_CREACION,
                        SYSDATE AS FEC_ULT_MODIFICACION,
                        0 AS ID_USUARIO_CREACION,
                        0 AS ID_USUARIO_ULT_MODIF,
                        1 AS IND_ESTADO
                    FROM FECI_CARGA_TIPOCAMBIO_BATCH tcb
                    WHERE NOT EXISTS (
                        SELECT 1
                        FROM FECI_TIPO_CAMBIO_CAT tcm
                        WHERE
                            tcm.FEC_FECHA_TC = TO_DATE(tcb.FECHA,'DD/MM/YYYY')
                            --AND tcm.COD_MONEDA = 'MXN'
                            --OR tcm.COD_MONEDA = 'USD'
                            --AND tcm.COD_MONEDA = tcb.A
                            AND tcm.COD_MONEDA = tcb.DE
                    );
            END IF;
            DELETE FECI_CARGA_TIPOCAMBIO_BATCH;
            ------------------
            FECI_MODIFICA_TIPO_CAMBIO_RECIBO_MASIVO_PR(0);
            TIPO_RESULTADO_ := 'EXITO';
        EXCEPTION
        -- Captura y maneja las excepciones
        WHEN OTHERS THEN
            STR_ERROR := SQLERRM;
            CONTADOR_RECIBOS := 0;
            CONTADOR_EMPRESA := 0;
            CONTADOR_MONEDAS := 0;
            CONTADOR_TC := 0;
            TIPO_RESULTADO_ := 'ERROR';
            -- Realiza rollback en caso de error para deshacer los cambios
            ROLLBACK;
        END;
    ELSE
        CONTADOR_RECIBOS := 0;
        CONTADOR_EMPRESA := 0;
        CONTADOR_MONEDAS := 0;
        CONTADOR_TC := 0;
        TIPO_RESULTADO_ := 'ERROR';
        STR_ERROR := p_ERROR;
    END IF;
    INSERT INTO FECI_RESULTADO_BATCH_TAB
        (FEC_INICIO,FEC_FIN,TIPO_EJECUCION,NUM_NUEVOS_RECIBOS,NUM_NUEVAS_EMPRESAS,NUM_NUEVAS_MONEDAS,NUM_NUEVOS_TC,TIPO_RESULTADO,OBSERVACIONES,
        FEC_CREACION,FEC_ULT_MODIFICACION,ID_USUARIO_CREACION,ID_USUARIO_ULT_MODIF,IND_ESTADO)
        VALUES
        (p_FECHA_INICIO,SYSDATE,p_TIPO_EJECUCION,CONTADOR_RECIBOS,CONTADOR_EMPRESA,CONTADOR_MONEDAS,CONTADOR_TC,TIPO_RESULTADO_,STR_ERROR,
        SYSDATE,SYSDATE,0,0,1);
    -- Actualiza FECI_CARGA_RECIBOS_BATCH
    --SE CAMBIA A UN DELTE FECI_CARGA_RECIBOS_BATCH
     --- SE DEBE LLENAR LA TABLA DE FECI_RESULTADO_BATCH_TAB
END FECI_PROCESA_BATCH_PR ;
/
