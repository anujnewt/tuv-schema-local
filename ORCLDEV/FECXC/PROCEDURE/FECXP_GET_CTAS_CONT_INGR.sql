CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXP_GET_CTAS_CONT_INGR" 
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
/*Sept 2009  Se crea este procedimiento para obtener las cuentas contables de ingresos*/
/*Las CC se obtienen a partir del recibo y no son las cuentas finales de la facturaci?n*/
/*Para ingresos miscel?neos y de cobranza marcados en el recibo por el tipo (Misc y CASH)*/
/*V2 elimina detalles previos si los hubiese*/
/*24-Oct-2011 Se Desactiva el detalle de Oracle y solo se deja el de SOIN, el de Oracle se ejcuta por las ma?anas (5am) mediante un cron de SO*/
/*12-Ene-2012 Se Re-activa del Detalle de Reales Oracle (se le quita la parte de aperturacion para que se haga lamitad en la noche y la mitad en la ma?ana)
              Tambien se Reactiva el Detalle de Reales SOIN  */
        V_FEC_FEC_EJECUCION DATE:= SYSDATE;
        V_FOLIO_SET VARCHAR2 (150); -- := '';
        V_CONTADOR INTEGER:=0;
        V_SQLCODE VARCHAR2 (4000);
        V_SQLERRM VARCHAR2 (4000);
        c_1 varchar2(200);
        c_2 varchar2(200);
        c_3 varchar2(200);
        c_4 varchar2(200);
        folio_c integer;
        CURSOR CURSOR_1 IS SELECT A.NO_EMPRESA, A.NO_FOLIO_DET, A.RECEIPT_NUMBER, A.NUM_RECIBO,
                                    A.FEC_VALOR, A.ID_STATUS_MOV, A.ID_TIPO_OPERACION_SET, A.FECHA_ACTUALIZACION,
                                    A.CASH_RECEIPT_ID, A.RECEIVABLES_TRX_ID, A.STATUS_RECIBO, A.SECUENCIA_DEP_ESPECIALES, A.ID_DIVISA, A.IMPORTE, A.IMPORTE_RECIBO,
                                    A.CODE_COMBINATION, A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3,
                                    A.ORACLE_SEGMENTO4, A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7
                                FROM  FECXP_MISC_INI A
                                WHERE A.ES_REPETIDO =0;
        CURSOR CURSOR_2 IS SELECT A.NO_EMPRESA, A.NO_FOLIO_DET, A.RECEIPT_NUMBER, A.NUM_RECIBO,
                                  D.FEC_VALOR, D.ID_STATUS_MOV, A.ID_TIPO_OPERACION_SET, A.FECHA_ACTUALIZACION,
                                  A.CASH_RECEIPT_ID, A.RECEIVABLES_TRX_ID, A.STATUS_RECIBO, D.SECUENCIA_DEP_ESPECIALES, A.ID_DIVISA, D.IMPORTE, A.IMPORTE_RECIBO,
                                  A.CODE_COMBINATION, A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3,
                                  A.ORACLE_SEGMENTO4, A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7
                                  FROM  FECXP_BIT_INGR_MISC A,
                                        FECXP_CREAR_MISCELANEOS B,
                                        FECXC.FECXC_DEP_ESPECIALES D
                                    WHERE A.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_APLICADA
                                        AND D.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_DEP_ESPECIALES
                                        AND B.ESTATUS_DIN_CC_APLI = 'C';
         CURSOR CURSOR_3 IS SELECT distinct        D.SECUENCIA_DEP_ESPECIALES, A.NO_EMPRESA, A.NO_FOLIO_DET, D.ID_STATUS_MOV,
                                                  'MISC' as MISC , A.ESTATUS_DIN_CC, V_FEC_FEC_EJECUCION AS V_FEC_FEC_EJECUCION1, V_FEC_FEC_EJECUCION AS V_FEC_FEC_EJECUCION2,
                                                    A.CODE_COMBINATION,
                                                    A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3, A.ORACLE_SEGMENTO4,
                                                    A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7,
                                                    A.ID_DIVISA, D.FEC_VALOR, D.IMPORTE
                                                FROM FECXP_BIT_INGR_CC A,
                                                     FECXP_CREAR_MISCELANEOS B,
                                                     FECXC.FECXC_DEP_ESPECIALES D
                                                WHERE A.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_APLICADA
                                                AND D.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_DEP_ESPECIALES;
        CURSOR CURSOR_4 IS  SELECT NO_EMPRESA, NO_FOLIO_DET,
                                    FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
                                    SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE,
                                    CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
                                    ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7
                                    FROM FECXP_FACT_INI
                                    GROUP BY NO_EMPRESA, NO_FOLIO_DET,
                                        FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
                                        SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE,
                                        CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
                                        ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7   ;
        CURSOR CURSOR_5 IS  SELECT   a.no_empresa, a.no_folio_det, b.receipt_number, b.num_recibo,
                                     a.fec_valor, a.id_status_mov, a.id_tipo_operacion_set,
                                     a.fecha_actualizacion, b.cash_receipt_id, b.customer_trx_id,
                                     b.customer_trx_line_id, b.status_recibo, a.secuencia_dep_especiales,
                                     a.id_divisa, a.importe, b.importe_recibo, a.code_combination,
                                     a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3,
                                     a.oracle_segmento4, a.oracle_segmento5, a.oracle_segmento6,
                                     a.oracle_segmento7
                                FROM fecxp_fact_grp1 a, fecxp_fact_ini b
                               WHERE a.no_folio_det = b.no_folio_det AND a.es_repetido = 0
                            GROUP BY a.no_empresa,a.no_folio_det,b.receipt_number,b.num_recibo,a.fec_valor,a.id_status_mov,
                                     a.id_tipo_operacion_set,a.fecha_actualizacion,b.cash_receipt_id,
                                     b.customer_trx_id,b.customer_trx_line_id,b.status_recibo,
                                     a.secuencia_dep_especiales,a.id_divisa,a.importe,b.importe_recibo,a.code_combination,a.oracle_segmento1,
                                     a.oracle_segmento2,a.oracle_segmento3,a.oracle_segmento4,a.oracle_segmento5,a.oracle_segmento6,
                                     a.oracle_segmento7;
BEGIN
    /*Verifica la conexi?n a AR*/
    SELECT COUNT(CASH_RECEIPT_ID)
        INTO V_CONTADOR
    FROM AR.AR_CASH_RECEIPTS_ALL@ERP_PROD
    where RECEIPT_DATE>= SYSDATE;
    --- ======== CONTROL DIN?MICO ======== ---
    -- INHABILITA PARA proceso AQUELLOS REGISTROS QUE SOBREPASEN LA VIGENCIA --
    -- ESTATUS_DIN_CC= 'P' [PENDIENTE], 'S' [SIN CUADRAR], 'C' [CERRADO]  'V' [CON VARIAS CUENTAS]--
    -- En la bit?cora permanecer?n vigentes pero despu?s se dejan de procesar para evitar encontrar duplicados y cancelaciones---
    -- La bit?cora s?lo tiene folios aplicados, los cancelados se replican hasta que el aplicado encontr? cuenta --
    -- Pendientes son aquellos que en su ejecuci?n no encontraron alguna cuenta contable a pesar de amarrar recibo, sobretodo en cobranza --
    UPDATE FECXP_BIT_INGR_CC
    SET     ESTATUS_DIN_CC = CASE WHEN DIAS_VIGENCIA_APERTURA > ROUND (V_FEC_FEC_EJECUCION - FEC_PRIMERA_EJECUCION) THEN 'P' ELSE 'S' END,
            FEC_ULTIMA_EJECUCION = CASE WHEN DIAS_VIGENCIA_APERTURA > ROUND (V_FEC_FEC_EJECUCION - FEC_PRIMERA_EJECUCION) THEN V_FEC_FEC_EJECUCION ELSE FEC_ULTIMA_EJECUCION END
    WHERE    ESTATUS_DIN_CC = 'P';
    COMMIT;
    --Marcar los que no cuadraron
  UPDATE FECXC.FECXC_DEP_ESPECIALES A
   SET PROCESADO = 3
   WHERE EXISTS
           (
            SELECT 1
            FROM FECXP_BIT_INGR_CC B
            WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
            AND B.ESTATUS_DIN_CC = 'S'
            AND B.FEC_VALOR>=SYSDATE-90 --OPTIMIZACION
           )
    AND A.FEC_VALOR>=SYSDATE-90; --OPTIMIZACION
    commit;
    /*----------------------   MISCELANEOS ----------------*/
    /*Obtiene los recibos miscel?neos amarrados, excluyendo los folios cancelados y los guiones*/
    DELETE FECXP_MISC_INI;
    COMMIT;
    INSERT INTO FECXP_MISC_INI (NO_EMPRESA, NO_FOLIO_DET,RECEIPT_NUMBER, NUM_RECIBO,
            FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
            CASH_RECEIPT_ID, RECEIVABLES_TRX_ID, STATUS_RECIBO, SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE, IMPORTE_RECIBO,
            CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
            ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
    SELECT D.NO_EMPRESA, D.NO_FOLIO_DET,B.RECEIPT_NUMBER,
        TO_NUMBER(TRIM(REPLACE(TRANSLATE(B.RECEIPT_NUMBER,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ',''))) as NUM_RECIBO,
        D.FEC_VALOR, D.ID_STATUS_MOV,D.ID_TIPO_OPERACION_SET, V_FEC_FEC_EJECUCION,
        B.CASH_RECEIPT_ID, B.RECEIVABLES_TRX_ID,
        B.STATUS AS STATUS_RECIBO,
        D.SECUENCIA_DEP_ESPECIALES,D.ID_DIVISA, D.IMPORTE, B.AMOUNT,
        A.CODE_COMBINATION_ID, G.SEGMENT1, G.SEGMENT2, G.SEGMENT3, G.SEGMENT4, G.SEGMENT5, G.SEGMENT6, G.SEGMENT7
    FROM ar.ar_receivables_trx_all@ERP_PROD A,
            AR.AR_CASH_RECEIPTS_ALL@ERP_PROD B,
            gl.gl_code_combinations@ERP_PROD G
            ,FECXC.FECXC_DEP_ESPECIALES D
    WHERE B.RECEIVABLES_TRX_ID = A.RECEIVABLES_TRX_ID
            AND B.ORG_ID = A.ORG_ID
            AND A.CODE_COMBINATION_ID = G.CODE_COMBINATION_ID (+)
            AND D.NO_FOLIO_DET = TO_NUMBER(TRIM(REPLACE(TRANSLATE(B.RECEIPT_NUMBER,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ','')))
            AND B.TYPE= 'MISC'
            AND NOT INSTR(B.RECEIPT_NUMBER, '_')>0
            AND NOT INSTR(B.RECEIPT_NUMBER, '-')>0
            AND D.PROCESADO = 0
            AND D.ID_STATUS_MOV NOT IN ('X','Y','Z')
            --AND D.PLATAFORMA = 'O'
            ;
    COMMIT;
    /*Una vez obtenidos los movimientos verificar si hay duplicados*/
    DELETE FECXP_MISC_FOLIOS_REPE;
    COMMIT;
    INSERT INTO FECXP_MISC_FOLIOS_REPE (NO_FOLIO_DET, CUANTOS)
    SELECT NO_FOLIO_DET, count(*)
    FROM FECXP_MISC_INI
    GROUP BY NO_FOLIO_DET
    HAVING COUNT(*)>1
    ;
    COMMIT;
    /*Dejar bit?cora de repetidos*/
    INSERT INTO FECXP_MISC_REPE (NO_FOLIO_DET, RECEIPT_NUMBER, CASH_RECEIPT_ID)
    SELECT A.NO_FOLIO_DET, A.RECEIPT_NUMBER, A.CASH_RECEIPT_ID
    FROM FECXP_MISC_INI A,
        FECXP_MISC_FOLIOS_REPE B
    WHERE A.NO_FOLIO_DET = B.NO_FOLIO_DET
    ;
    COMMIT;
    /*Marcar los que est?n duplicados*/
    UPDATE  FECXP_MISC_INI A
    SET ES_REPETIDO=1
    WHERE EXISTS
        (  SELECT 1
            FROM FECXP_MISC_FOLIOS_REPE B
            WHERE B.NO_FOLIO_DET = A.NO_FOLIO_DET
         )
    ;
    COMMIT;
-------
DBMS_OUTPUT.PUT_LINE('PASO POR BANDERA 1');
-------
    /*Pasar a bit?cora de miscel?neos los registros que no son duplicados*/
   /* INSERT INTO FECXP_BIT_INGR_MISC (NO_EMPRESA, NO_FOLIO_DET,RECEIPT_NUMBER, NUM_RECIBO,
            FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
            CASH_RECEIPT_ID, RECEIVABLES_TRX_ID, STATUS_RECIBO, SECUENCIA_DEP_ESPECIALES, ID_DIVISA, IMPORTE, IMPORTE_RECIBO,
            CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
            ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
    SELECT A.NO_EMPRESA, A.NO_FOLIO_DET, A.RECEIPT_NUMBER, A.NUM_RECIBO,
        A.FEC_VALOR, A.ID_STATUS_MOV, A.ID_TIPO_OPERACION_SET, A.FECHA_ACTUALIZACION,
        A.CASH_RECEIPT_ID, A.RECEIVABLES_TRX_ID, A.STATUS_RECIBO, A.SECUENCIA_DEP_ESPECIALES, A.ID_DIVISA, A.IMPORTE, A.IMPORTE_RECIBO,
        A.CODE_COMBINATION, A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3,
        A.ORACLE_SEGMENTO4, A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7
    FROM  FECXP_MISC_INI A
    WHERE A.ES_REPETIDO =0;
   COMMIT;*/
------------------------------------------APLICANDO CURSOR 1 ----------------------------------------------------------------------
       for contador_1 in CURSOR_1 loop
                    BEGIN
                            INSERT INTO FECXP_BIT_INGR_MISC (NO_EMPRESA, NO_FOLIO_DET,RECEIPT_NUMBER, NUM_RECIBO,
                                        FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
                                        CASH_RECEIPT_ID, RECEIVABLES_TRX_ID, STATUS_RECIBO, SECUENCIA_DEP_ESPECIALES, ID_DIVISA, IMPORTE, IMPORTE_RECIBO,
                                        CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
                                        ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7) VALUES
                                        ( contador_1.NO_EMPRESA,       contador_1.NO_FOLIO_DET,       contador_1.RECEIPT_NUMBER,        contador_1.NUM_RECIBO,
                                          contador_1.FEC_VALOR,        contador_1.ID_STATUS_MOV,      contador_1.ID_TIPO_OPERACION_SET, contador_1.FECHA_ACTUALIZACION,
                                          contador_1.CASH_RECEIPT_ID,  contador_1.RECEIVABLES_TRX_ID, contador_1.STATUS_RECIBO,         contador_1.SECUENCIA_DEP_ESPECIALES, contador_1.ID_DIVISA, contador_1.IMPORTE, contador_1.IMPORTE_RECIBO,
                                          contador_1.CODE_COMBINATION, contador_1.ORACLE_SEGMENTO1,   contador_1.ORACLE_SEGMENTO2,      contador_1.ORACLE_SEGMENTO3,
                                          contador_1.ORACLE_SEGMENTO4, contador_1.ORACLE_SEGMENTO5,   contador_1.ORACLE_SEGMENTO6,      contador_1.ORACLE_SEGMENTO7
                                        );
                                     EXCEPTION
                                     WHEN DUP_VAL_ON_INDEX THEN
                                     NULL;
                                     WHEN OTHERS THEN
                                       ROLLBACK;
                                       RAISE_APPLICATION_ERROR(-20000,'Error:' || SQLCODE || ' - ' || SQLERRM);
                    END;
             end loop;
---------------------------------------------------------------------------------------------------------------------
-------
DBMS_OUTPUT.PUT_LINE('PASO POR BANDERA 2');
-------
   --Eliminar en detalle especiales si existe una cuenta previa por cambio de tipo de empresa
   DELETE FECXC_DEP_ESPECIALES_D D
   WHERE EXISTS
   (
           SELECT 1
        FROM FECXP_MISC_INI A
        WHERE A.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES
        AND A.ES_REPETIDO = 0
   )
   ;
   /*Generar el detalle de cuentas para los ingresos encontrados*/
   INSERT INTO FECXC_DEP_ESPECIALES_D (SECUENCIA_DET_DEP_ESP, SECUENCIA_DEP_ESPECIALES, CODE_COMBINATION,IMPORTE_LINEA,
           ORA_SOIN_SEGMENTO1, ORA_SOIN_SEGMENTO2, ORA_SOIN_SEGMENTO3, ORACLE_SEGMENTO4, ORACLE_SEGMENTO5,
        ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
    SELECT SECUENCIA_DET_DEP_ESP.NEXTVAL, -------------VERIFICAR EL CONTADOR
    A.SECUENCIA_DEP_ESPECIALES, A.CODE_COMBINATION, A.IMPORTE,
    A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3, A.ORACLE_SEGMENTO4,
    A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7
    FROM FECXP_MISC_INI A
    WHERE A.ES_REPETIDO =0;
    COMMIT;
    /*Pasar a bit?cora de ingresos primero los ingresos que encontraron su cuenta y Cerrarlos*/
    /*S?lo aquellos que no est?n ya en bit?cora, es decir que hayan estado pendientes */
    INSERT INTO FECXP_BIT_INGR_CC (SECUENCIA_DEP_ESPECIALES, NO_EMPRESA, NO_FOLIO_DET, ID_STATUS_MOV,
        TIPO_CUENTA, ESTATUS_DIN_CC, FEC_PRIMERA_EJECUCION, FEC_ULTIMA_EJECUCION,CODE_COMBINATION,
        ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
        ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7,
        ID_DIVISA, FEC_VALOR, IMPORTE
        )
    SELECT A.SECUENCIA_DEP_ESPECIALES, A.NO_EMPRESA, A.NO_FOLIO_DET, A.ID_STATUS_MOV,
        'MISC', 'C', V_FEC_FEC_EJECUCION, V_FEC_FEC_EJECUCION,
        A.CODE_COMBINATION,
        A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3, A.ORACLE_SEGMENTO4,
        A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7,
        A.ID_DIVISA, A.FEC_VALOR, A.IMPORTE
    FROM FECXP_MISC_INI A,
    FECXC_DEP_ESPECIALES_D D
    WHERE A.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES
    AND A.ES_REPETIDO =0
    AND NOT EXISTS
    (
        SELECT 1
        FROM FECXP_BIT_INGR_CC B
        WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
    )
    ;
    COMMIT;
    /*Pasar a la bit?cora los que tuvieron m?s de una cuenta y marcarlos como 'V'arias Ctas*/
    /*S?lo insertar los que no existan previemente por estar pendientes*/
    INSERT INTO FECXP_BIT_INGR_CC (SECUENCIA_DEP_ESPECIALES, NO_EMPRESA, NO_FOLIO_DET, ID_STATUS_MOV,
        TIPO_CUENTA, ESTATUS_DIN_CC, FEC_PRIMERA_EJECUCION, FEC_ULTIMA_EJECUCION,
        ID_DIVISA, FEC_VALOR, IMPORTE
        )
    SELECT A.SECUENCIA_DEP_ESPECIALES, A.NO_EMPRESA, A.NO_FOLIO_DET, A.ID_STATUS_MOV,
        'MISC', 'V', V_FEC_FEC_EJECUCION, V_FEC_FEC_EJECUCION,
        A.ID_DIVISA, A.FEC_VALOR, A.IMPORTE
    FROM FECXP_MISC_INI A,
        FECXC.FECXC_DEP_ESPECIALES D
    WHERE A.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES
    AND A.ES_REPETIDO =1
    AND NOT EXISTS
    (
        SELECT 1
        FROM FECXP_BIT_INGR_CC B
        WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
    )
    GROUP BY      A.SECUENCIA_DEP_ESPECIALES, A.NO_EMPRESA, A.NO_FOLIO_DET, A.ID_STATUS_MOV,
        A.ID_DIVISA, A.FEC_VALOR, A.IMPORTE
    ;
    COMMIT;
    /*Cerrar los folios que estuvieron pendientes y ya encontraron una sola cuenta contable*/
    /*Si est? pendiente no existen r?plicas del cancelado*/
    UPDATE FECXP_BIT_INGR_CC A
    SET ( CODE_COMBINATION, ORACLE_SEGMENTO1,ORACLE_SEGMENTO2,
            ORACLE_SEGMENTO3,ORACLE_SEGMENTO4,ORACLE_SEGMENTO5,
            ORACLE_SEGMENTO6,ORACLE_SEGMENTO7,ESTATUS_DIN_CC, FEC_ULTIMA_EJECUCION) =
         (SELECT B.CODE_COMBINATION, B.ORACLE_SEGMENTO1,B.ORACLE_SEGMENTO2,
            B.ORACLE_SEGMENTO3,B.ORACLE_SEGMENTO4,B.ORACLE_SEGMENTO5,
            B.ORACLE_SEGMENTO6,B.ORACLE_SEGMENTO7,'C', V_FEC_FEC_EJECUCION
           FROM  FECXP_MISC_INI B
           WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
            AND B.ES_REPETIDO =0
         )
    WHERE ESTATUS_DIN_CC = 'P'
     AND EXISTS
    (
        SELECT 1
        FROM FECXP_MISC_INI C
        WHERE C.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
        AND C.ES_REPETIDO =0
    );
    COMMIT;
    /*Marcar como folio con varias cuentas si estaba pendiente*/
    /*Si est? pendiente no hay r?plica del cancelado*/
    UPDATE FECXP_BIT_INGR_CC A
    SET ESTATUS_DIN_CC = 'V',
        FEC_ULTIMA_EJECUCION = V_FEC_FEC_EJECUCION
    WHERE ESTATUS_DIN_CC = 'P'
    AND EXISTS
    (
        SELECT 1
        FROM FECXP_MISC_INI B
        WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
        AND B.ES_REPETIDO =1
    );
    COMMIT;
    /*Replicar para los estatus cancelados para los cerrados y repetidos*/
    /*Identificar los folios que tienen r?plica cancelada s?lo para los que cerraron o tienen varias cuentas de esta ejecuci?n*/
    /*Si quedaran pendientes s?lo estar?an los aplicados*/
    DELETE  FECXP_CREAR_MISCELANEOS;
    COMMIT;
    INSERT INTO FECXP_CREAR_MISCELANEOS
    SELECT A.NO_EMPRESA, A.NO_FOLIO_DET, D.SECUENCIA_DEP_ESPECIALES, A.SECUENCIA_DEP_ESPECIALES AS SECUENCIA_APLICADA, A.ESTATUS_DIN_CC
    FROM FECXP_BIT_INGR_CC A,
            FECXC.FECXC_DEP_ESPECIALES D
    WHERE  A.NO_EMPRESA = D.NO_EMPRESA
    AND    A.NO_FOLIO_DET = D.NO_FOLIO_DET
    AND A.TIPO_CUENTA = 'MISC'
    AND    D.ID_STATUS_MOV IN ('X','Y','Z')
    AND    D.PROCESADO = 0
    --AND A.FEC_ULTIMA_EJECUCION = V_FEC_FEC_EJECUCION
    AND A.ESTATUS_DIN_CC IN ('C', 'V', 'S')
    ;
   COMMIT;
   /*Una vez identificados replicar las cuentas para aquellos que est?n cerrados*/
   --Eliminar en detalle especiales si existe una cuenta previa por cambio de tipo de empresa
   DELETE FECXC_DEP_ESPECIALES_D D
   WHERE EXISTS
   (
           SELECT 1
        FROM FECXP_BIT_INGR_CC A,
        FECXP_CREAR_MISCELANEOS B
    WHERE D.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_DEP_ESPECIALES
    AND A.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_APLICADA
    AND A.ESTATUS_DIN_CC = 'C'
   )
   ;
   /*Primero pasar las cuentas al detalle*/
   /*Generar el detalle de cuentas para los ingresos encontrados*/
   INSERT INTO FECXC_DEP_ESPECIALES_D (SECUENCIA_DET_DEP_ESP, SECUENCIA_DEP_ESPECIALES, CODE_COMBINATION,IMPORTE_LINEA,
           ORA_SOIN_SEGMENTO1, ORA_SOIN_SEGMENTO2, ORA_SOIN_SEGMENTO3, ORACLE_SEGMENTO4, ORACLE_SEGMENTO5,
        ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
    SELECT SECUENCIA_DET_DEP_ESP.NEXTVAL,
    B.SECUENCIA_DEP_ESPECIALES, A.CODE_COMBINATION, (-1) * A.IMPORTE,
    A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3, A.ORACLE_SEGMENTO4,
    A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7
    FROM FECXP_BIT_INGR_CC A,
        FECXP_CREAR_MISCELANEOS B
    WHERE A.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_APLICADA
    AND A.ESTATUS_DIN_CC = 'C'
    ;
    COMMIT;
    /*Generar las bit?coras*/
    /*La de miscel?neos*/
    /*INSERT INTO FECXP_BIT_INGR_MISC (NO_EMPRESA, NO_FOLIO_DET,RECEIPT_NUMBER, NUM_RECIBO,
            FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
            CASH_RECEIPT_ID, RECEIVABLES_TRX_ID, STATUS_RECIBO, SECUENCIA_DEP_ESPECIALES, ID_DIVISA, IMPORTE, IMPORTE_RECIBO,
            CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
            ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
    SELECT A.NO_EMPRESA, A.NO_FOLIO_DET, A.RECEIPT_NUMBER, A.NUM_RECIBO,
        D.FEC_VALOR, D.ID_STATUS_MOV, A.ID_TIPO_OPERACION_SET, A.FECHA_ACTUALIZACION,
        A.CASH_RECEIPT_ID, A.RECEIVABLES_TRX_ID, A.STATUS_RECIBO, D.SECUENCIA_DEP_ESPECIALES, A.ID_DIVISA, D.IMPORTE, A.IMPORTE_RECIBO,
        A.CODE_COMBINATION, A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3,
        A.ORACLE_SEGMENTO4, A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7
    FROM  FECXP_BIT_INGR_MISC A,
            FECXP_CREAR_MISCELANEOS B,
            FECXC_DEP_ESPECIALES D
    WHERE A.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_APLICADA
        AND D.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_DEP_ESPECIALES
        AND B.ESTATUS_DIN_CC_APLI = 'C'
    ;
       COMMIT;*/
 -------
DBMS_OUTPUT.PUT_LINE('PASO POR BANDERA 4');
-------
       ------------------------------------------APLICANDO CURSOR 2 ----------------------------------------------------------------------
      for contador_2 in CURSOR_2 loop
            c_2:= contador_2.SECUENCIA_DEP_ESPECIALES;
           BEGIN
            INSERT INTO FECXP_BIT_INGR_MISC (NO_EMPRESA, NO_FOLIO_DET,RECEIPT_NUMBER, NUM_RECIBO,
                        FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
                        CASH_RECEIPT_ID, RECEIVABLES_TRX_ID, STATUS_RECIBO, SECUENCIA_DEP_ESPECIALES, ID_DIVISA, IMPORTE, IMPORTE_RECIBO,
                        CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
                        ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7) VALUES
                        (contador_2.NO_EMPRESA,       contador_2.NO_FOLIO_DET,       contador_2.RECEIPT_NUMBER,        contador_2.NUM_RECIBO,
                         contador_2.FEC_VALOR,        contador_2.ID_STATUS_MOV,      contador_2.ID_TIPO_OPERACION_SET, contador_2.FECHA_ACTUALIZACION,
                         contador_2.CASH_RECEIPT_ID,  contador_2.RECEIVABLES_TRX_ID, contador_2.STATUS_RECIBO,         contador_2.SECUENCIA_DEP_ESPECIALES, contador_2.ID_DIVISA, contador_2.IMPORTE, contador_2.IMPORTE_RECIBO,
                         contador_2.CODE_COMBINATION, contador_2.ORACLE_SEGMENTO1,   contador_2.ORACLE_SEGMENTO2,      contador_2.ORACLE_SEGMENTO3,
                         contador_2.ORACLE_SEGMENTO4, contador_2.ORACLE_SEGMENTO5,   contador_2.ORACLE_SEGMENTO6,      contador_2.ORACLE_SEGMENTO7
                        );
              EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                NULL;
                WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20000,'Error:' || SQLCODE || ' - ' || SQLERRM);
           END;
     end loop;
---------------------------------------------------------------------------------------------------------------------
-------
DBMS_OUTPUT.PUT_LINE('PASO POR BANDERA 5');
-------
    /*La bit?cora de ingresos*/
   /*INSERT INTO FECXP_BIT_INGR_CC (SECUENCIA_DEP_ESPECIALES, NO_EMPRESA, NO_FOLIO_DET, ID_STATUS_MOV,
        TIPO_CUENTA, ESTATUS_DIN_CC, FEC_PRIMERA_EJECUCION, FEC_ULTIMA_EJECUCION,CODE_COMBINATION,
        ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
        ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7,
        ID_DIVISA, FEC_VALOR, IMPORTE
        )
    SELECT distinct D.SECUENCIA_DEP_ESPECIALES, A.NO_EMPRESA, A.NO_FOLIO_DET, D.ID_STATUS_MOV,
    'MISC', A.ESTATUS_DIN_CC, V_FEC_FEC_EJECUCION, V_FEC_FEC_EJECUCION,
        A.CODE_COMBINATION,
        A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3, A.ORACLE_SEGMENTO4,
        A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7,
        A.ID_DIVISA, D.FEC_VALOR, D.IMPORTE
    FROM FECXP_BIT_INGR_CC A,
    FECXP_CREAR_MISCELANEOS B,
            FECXC.FECXC_DEP_ESPECIALES D
    WHERE A.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_APLICADA
        AND D.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_DEP_ESPECIALES
    ;*/
----------------------------------------APLICANDO CURSOR 3 ----------------------------------------------------------------------
       for contador_3 in CURSOR_3 loop
                    --c_3:= contador_3.SECUENCIA_DEP_ESPECIALES;
                    BEGIN
                            INSERT INTO FECXP_BIT_INGR_CC (SECUENCIA_DEP_ESPECIALES, NO_EMPRESA, NO_FOLIO_DET, ID_STATUS_MOV,
                                        TIPO_CUENTA, ESTATUS_DIN_CC, FEC_PRIMERA_EJECUCION, FEC_ULTIMA_EJECUCION,CODE_COMBINATION,
                                        ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
                                        ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7,
                                        ID_DIVISA, FEC_VALOR, IMPORTE
                                        ) VALUES
                                        (    contador_3.SECUENCIA_DEP_ESPECIALES,  contador_3.NO_EMPRESA,       contador_3.NO_FOLIO_DET,         contador_3.ID_STATUS_MOV,
                                             contador_3.MISC,                      contador_3.ESTATUS_DIN_CC,   contador_3.V_FEC_FEC_EJECUCION1, contador_3.V_FEC_FEC_EJECUCION2,contador_3.CODE_COMBINATION,
                                             contador_3.ORACLE_SEGMENTO1 ,         contador_3.ORACLE_SEGMENTO2, contador_3.ORACLE_SEGMENTO3,
                                             contador_3.ORACLE_SEGMENTO4 ,         contador_3.ORACLE_SEGMENTO5, contador_3.ORACLE_SEGMENTO6,     contador_3.ORACLE_SEGMENTO7,
                                             contador_3.ID_DIVISA,                 contador_3.FEC_VALOR,        contador_3.IMPORTE
                                        );
                                      EXCEPTION
                                        WHEN DUP_VAL_ON_INDEX THEN
                                        NULL;
                                        WHEN OTHERS THEN
                                        ROLLBACK;
                                        RAISE_APPLICATION_ERROR(-20000,'Error:' || SQLCODE || ' - ' || SQLERRM);
                                null;
                 END;
           end loop;
---------------------------------------------------------------------------------------------------------------------
-------
DBMS_OUTPUT.PUT_LINE('PASO POR BANDERA 6');
-------
   COMMIT;
   /* termina cancelados*/
   /*Marcar los miscel?neos encontrados: cerrados, con varias cuentas y sin encontrar cuenta */
   UPDATE FECXC.FECXC_DEP_ESPECIALES A
   SET PROCESADO = 1
   WHERE PROCESADO= 0
   AND EXISTS
           (
               SELECT 1
            FROM FECXP_BIT_INGR_CC B
            WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
            AND B.TIPO_CUENTA = 'MISC'
            AND B.ESTATUS_DIN_CC IN ('C','V','S')
           )
   ;
   COMMIT;
   /*===============================================================================================================================*/
   /***---------------------COBRANZA--------------------------*/
   /*===============================================================================================================================*/
   /*Una vez obtenidas las cuentas de recibos miscel?neos obtener las cuentas de factura para cobranza*/
   DELETE FROM FECXP_FACT_INI;
   COMMIT;
   INSERT INTO FECXP_FACT_INI (NO_EMPRESA, NO_FOLIO_DET,RECEIPT_NUMBER, NUM_RECIBO,
            FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
            CASH_RECEIPT_ID, CUSTOMER_TRX_ID,CUSTOMER_TRX_LINE_ID,
            STATUS_RECIBO, SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE, IMPORTE_RECIBO,
            CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
            ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
   SELECT D.NO_EMPRESA, D.NO_FOLIO_DET,R.RECEIPT_NUMBER,
            TO_NUMBER(TRIM(REPLACE(TRANSLATE(R.RECEIPT_NUMBER,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ',''))) as NUM_RECIBO,
            D.FEC_VALOR, D.ID_STATUS_MOV,D.ID_TIPO_OPERACION_SET, V_FEC_FEC_EJECUCION,
            R.CASH_RECEIPT_ID, A.APPLIED_CUSTOMER_TRX_ID,F.CUSTOMER_TRX_LINE_ID,
               R.STATUS AS STATUS_RECIBO,  D.SECUENCIA_DEP_ESPECIALES,D.ID_DIVISA, D.IMPORTE, R.AMOUNT,
               H.CODE_COMBINATION_ID, G.SEGMENT1, G.SEGMENT2, G.SEGMENT3, G.SEGMENT4, G.SEGMENT5, G.SEGMENT6, G.SEGMENT7
    FROM    AR.AR_CASH_RECEIPTS_ALL@ERP_PROD R,
            APPS.AR_RECEIVABLE_APPLICATIONS_ALL@ERP_PROD A,
            AR.RA_CUSTOMER_TRX_ALL@ERP_PROD  CT, --Encabezado
            AR.RA_CUSTOMER_TRX_LINES_ALL@ERP_PROD F, --detalle
            --AR.RA_CUSTOMER_TRX_LINES_ALL@ERP_PROD FF, --detalle2
            AR.RA_CUST_TRX_LINE_GL_DIST_ALL@ERP_PROD H,
            gl.gl_code_combinations@ERP_PROD G,
            FECXC.FECXC_DEP_ESPECIALES D
    WHERE NOT INSTR(R.RECEIPT_NUMBER, '_')>0
            AND NOT INSTR(R.RECEIPT_NUMBER, '-')>0
            AND R.TYPE='CASH'
            AND D.PROCESADO = 0
            AND D.ID_STATUS_MOV NOT IN ('X','Y','Z')
            --AND D.PLATAFORMA = 'O'
            AND D.NO_FOLIO_DET= TO_NUMBER(TRIM(REPLACE(TRANSLATE(R.RECEIPT_NUMBER,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',' '),' ','')))
            AND A.CASH_RECEIPT_ID = R.CASH_RECEIPT_ID
            AND A.ORG_ID = R.ORG_ID
            AND A.STATUS='APP'
            AND A.DISPLAY = 'Y'
            AND    CT.CUSTOMER_TRX_ID = A.APPLIED_CUSTOMER_TRX_ID
            and CT.ORG_ID = A.ORG_ID
            AND F.ORG_ID = CT.ORG_ID
            AND F.CUSTOMER_TRX_ID = CT.CUSTOMER_TRX_ID
            --para facturas
            --AND F.CUSTOMER_TRX_LINE_ID = FF.LINK_TO_CUST_TRX_LINE_ID (+)
            --AND CT.ORG_ID = H.ORG_ID
            --AND CT.CUSTOMER_TRX_ID = H.CUSTOMER_TRX_ID
            AND F.LINE_TYPE ='LINE'
            AND H.CUSTOMER_TRX_LINE_ID = F.CUSTOMER_TRX_LINE_ID
            AND    H.ACCOUNT_CLASS IN ('REV')
            AND G.CODE_COMBINATION_ID = H.CODE_COMBINATION_ID
    GROUP BY  D.NO_EMPRESA, D.NO_FOLIO_DET,R.RECEIPT_NUMBER,
                TO_NUMBER(TRIM(REPLACE(TRANSLATE(R.RECEIPT_NUMBER,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ',''))),
                D.FEC_VALOR, D.ID_STATUS_MOV,D.ID_TIPO_OPERACION_SET, V_FEC_FEC_EJECUCION,
                R.CASH_RECEIPT_ID, A.APPLIED_CUSTOMER_TRX_ID,F.CUSTOMER_TRX_LINE_ID,
                   R.STATUS,  D.SECUENCIA_DEP_ESPECIALES,D.ID_DIVISA, D.IMPORTE, R.AMOUNT,
                   H.CODE_COMBINATION_ID, G.SEGMENT1, G.SEGMENT2, G.SEGMENT3, G.SEGMENT4, G.SEGMENT5, G.SEGMENT6, G.SEGMENT7
    ;
    COMMIT;
    /*Se agrupan las cuentas por recibo para trabajar sobre las diferencias*/
    /*Posibilidades:  Un folio con varios recibos, las cuentas finales pueden coincidir o no*/
    /*Un folio con un recibo y varias aplicaciones cuyas cuentas pueden coincidir o no*/
    DELETE FROM FECXP_FACT_GRP1;
    COMMIT;
    /*INSERT INTO FECXP_FACT_GRP1 (NO_EMPRESA, NO_FOLIO_DET,
        FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
        SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE,
        CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
        ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
    SELECT NO_EMPRESA, NO_FOLIO_DET,
        FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
        SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE,
        CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
        ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7
    FROM FECXP_FACT_INI
    GROUP BY NO_EMPRESA, NO_FOLIO_DET,
        FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
        SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE,
        CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
        ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7
    ;*/
----------------------------------------APLICANDO CURSOR 4 ----------------------------------------------------------------------
 for contador_4 in CURSOR_4 loop
                    BEGIN
                            INSERT INTO FECXP_FACT_GRP1 (NO_EMPRESA, NO_FOLIO_DET,FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
                                                         SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE,CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2,
                                                         ORACLE_SEGMENTO3,ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
                                         VALUES
                                        (    contador_4.NO_EMPRESA,              contador_4.NO_FOLIO_DET,    contador_4.FEC_VALOR,        contador_4.ID_STATUS_MOV,   contador_4.ID_TIPO_OPERACION_SET,contador_4.FECHA_ACTUALIZACION,
                                             contador_4.SECUENCIA_DEP_ESPECIALES,contador_4.ID_DIVISA,       contador_4.IMPORTE,          contador_4.CODE_COMBINATION,contador_4.ORACLE_SEGMENTO1,     contador_4.ORACLE_SEGMENTO2,
                                             contador_4.ORACLE_SEGMENTO3,        contador_4.ORACLE_SEGMENTO4,contador_4.ORACLE_SEGMENTO5, contador_4.ORACLE_SEGMENTO6,contador_4.ORACLE_SEGMENTO7
                                        );
                                     EXCEPTION
                                        WHEN DUP_VAL_ON_INDEX THEN
                                        NULL;
                                        WHEN OTHERS THEN
                                        ROLLBACK;
                                        RAISE_APPLICATION_ERROR(-20000,'Error:' || SQLCODE || ' - ' || SQLERRM);
             END;
           end loop;
---------------------------------------------------------------------------------------------------------------------
-------
DBMS_OUTPUT.PUT_LINE('PASO POR BANDERA 7');
-------
    COMMIT;
    /*Una vez agrupado identificar los folios que tienen varias cuentas contables para un mismo folio*/
   /*Una vez obtenidos los movimientos verificar si hay duplicados*/
    DELETE FECXP_FACT_FOLIOS_VAR;
    COMMIT;
    INSERT INTO FECXP_FACT_FOLIOS_VAR (NO_FOLIO_DET, CUANTOS)
    SELECT NO_FOLIO_DET, count(*)
    FROM FECXP_FACT_GRP1
    GROUP BY NO_FOLIO_DET
    HAVING COUNT(*)>1
    ;
    COMMIT;
    /*Dejar una bit?cora de folios de factura con m?s de una cuenta contable*/
   INSERT INTO FECXP_FACT_VAR (NO_FOLIO_DET, RECEIPT_NUMBER, CASH_RECEIPT_ID, CUSTOMER_TRX_ID, CUSTOMER_TRX_LINE_ID, CODE_COMBINATION)
   SELECT A.NO_FOLIO_DET, A.RECEIPT_NUMBER, A.CASH_RECEIPT_ID, A.CUSTOMER_TRX_ID, A.CUSTOMER_TRX_LINE_ID, A.CODE_COMBINATION
   FROM FECXP_FACT_INI A,
           FECXP_FACT_FOLIOS_VAR B
    WHERE A.NO_FOLIO_DET = B.NO_FOLIO_DET
    GROUP BY A.NO_FOLIO_DET, A.RECEIPT_NUMBER, A.CASH_RECEIPT_ID, A.CUSTOMER_TRX_ID, A.CUSTOMER_TRX_LINE_ID, A.CODE_COMBINATION
    ;
   COMMIT;
   /*Marcar en la tabla agrupada los folios que est?n repetidos*/
   UPDATE FECXP_FACT_GRP1 A
   SET ES_REPETIDO = 1
   WHERE EXISTS
   (
           SELECT 1
        FROM FECXP_FACT_FOLIOS_VAR B
        WHERE B.NO_FOLIO_DET = A.NO_FOLIO_DET
   );
   COMMIT;
   /*Una vez agrupados e identificados los de cuenta m?ltiple, tomar los que son v?lidos*/
   /*Existe la posibilidad de que un mismo folio se haya ligado a varias cuentas y que al final todas coincidan*/
   /*Se esta duplicando informacion
   INSERT INTO FECXP_BIT_INGR_FACT (NO_EMPRESA, NO_FOLIO_DET,RECEIPT_NUMBER, NUM_RECIBO,
            FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
            CASH_RECEIPT_ID, CUSTOMER_TRX_ID,CUSTOMER_TRX_LINE_ID,
            STATUS_RECIBO, SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE, IMPORTE_RECIBO,
            CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
            ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
  SELECT  A.NO_EMPRESA, A.NO_FOLIO_DET, B.RECEIPT_NUMBER, B.NUM_RECIBO,
            A.FEC_VALOR, A.ID_STATUS_MOV,A.ID_TIPO_OPERACION_SET,A.FECHA_ACTUALIZACION,
            B.CASH_RECEIPT_ID, B.CUSTOMER_TRX_ID,B.CUSTOMER_TRX_LINE_ID,
            B.STATUS_RECIBO, A.SECUENCIA_DEP_ESPECIALES,A.ID_DIVISA, A.IMPORTE, B.IMPORTE_RECIBO,
            A.CODE_COMBINATION,A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3,
            A.ORACLE_SEGMENTO4, A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7
  FROM   FECXP_FACT_GRP1 A,
          FECXP_FACT_INI B
  WHERE A.NO_FOLIO_DET = B.NO_FOLIO_DET
  AND    A.ES_REPETIDO=0
  GROUP BY A.NO_EMPRESA, A.NO_FOLIO_DET, B.RECEIPT_NUMBER, B.NUM_RECIBO,
            A.FEC_VALOR, A.ID_STATUS_MOV,A.ID_TIPO_OPERACION_SET,A.FECHA_ACTUALIZACION,
            B.CASH_RECEIPT_ID, B.CUSTOMER_TRX_ID,B.CUSTOMER_TRX_LINE_ID,
            B.STATUS_RECIBO, A.SECUENCIA_DEP_ESPECIALES,A.ID_DIVISA, A.IMPORTE, B.IMPORTE_RECIBO,
            A.CODE_COMBINATION,A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3,
            A.ORACLE_SEGMENTO4, A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7
  ;
  */
  for u in CURSOR_5 loop
        folio_c:=u.NO_FOLIO_DET;
        begin
        INSERT INTO FECXP_BIT_INGR_FACT (NO_EMPRESA, NO_FOLIO_DET,RECEIPT_NUMBER, NUM_RECIBO,
            FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
            CASH_RECEIPT_ID, CUSTOMER_TRX_ID,CUSTOMER_TRX_LINE_ID,
            STATUS_RECIBO, SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE, IMPORTE_RECIBO,
            CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
            ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
         VALUES(
            u.NO_EMPRESA,       u.NO_FOLIO_DET,            u.RECEIPT_NUMBER, u.NUM_RECIBO,
            u.FEC_VALOR,        u.ID_STATUS_MOV,           u.ID_TIPO_OPERACION_SET,u.FECHA_ACTUALIZACION,
            u.CASH_RECEIPT_ID,  u.CUSTOMER_TRX_ID,         u.CUSTOMER_TRX_LINE_ID,
            u.STATUS_RECIBO,    u.SECUENCIA_DEP_ESPECIALES,u.ID_DIVISA, u.IMPORTE, u.IMPORTE_RECIBO,
            u.CODE_COMBINATION, u.ORACLE_SEGMENTO1,        u.ORACLE_SEGMENTO2, u.ORACLE_SEGMENTO3,
            u.ORACLE_SEGMENTO4, u.ORACLE_SEGMENTO5,        u.ORACLE_SEGMENTO6, u.ORACLE_SEGMENTO7);
        EXCEPTION
          WHEN DUP_VAL_ON_INDEX THEN
              NULL;
          WHEN OTHERS THEN
              ROLLBACK;
              RAISE_APPLICATION_ERROR(-20000,folio_c|| 'Error:' || SQLCODE || ' - ' || SQLERRM);
        END;
 end loop;
  COMMIT;
  --Eliminar si existiese un detalle previo por cambio de empresa
  DELETE FECXC_DEP_ESPECIALES_D D
  WHERE EXISTS
  (
      SELECT 1
    FROM FECXP_FACT_GRP1 A
    WHERE D.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
    AND A.ES_REPETIDO =0
  );
  /*Generar el detalle de cuentas para los ingresos encontrados*/
   INSERT INTO FECXC_DEP_ESPECIALES_D (SECUENCIA_DET_DEP_ESP, SECUENCIA_DEP_ESPECIALES, CODE_COMBINATION,IMPORTE_LINEA,
           ORA_SOIN_SEGMENTO1, ORA_SOIN_SEGMENTO2, ORA_SOIN_SEGMENTO3, ORACLE_SEGMENTO4, ORACLE_SEGMENTO5,
        ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
    SELECT SECUENCIA_DET_DEP_ESP.NEXTVAL, -------------VERIFICAR EL CONTADOR
    A.SECUENCIA_DEP_ESPECIALES, A.CODE_COMBINATION, A.IMPORTE,
    A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3, A.ORACLE_SEGMENTO4,
    A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7
    FROM FECXP_FACT_GRP1 A
    WHERE A.ES_REPETIDO =0;
   COMMIT;
   /*Pasar a bit?cora de ingresos primero los ingresos que encontraron su cuenta y Cerrarlos*/
   /*Ingresa s?lo los folios que no exist?an */
    INSERT INTO FECXP_BIT_INGR_CC (SECUENCIA_DEP_ESPECIALES, NO_EMPRESA, NO_FOLIO_DET, ID_STATUS_MOV,
        TIPO_CUENTA, ESTATUS_DIN_CC, FEC_PRIMERA_EJECUCION, FEC_ULTIMA_EJECUCION,CODE_COMBINATION,
        ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
        ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7,
        ID_DIVISA, FEC_VALOR, IMPORTE
        )
    SELECT A.SECUENCIA_DEP_ESPECIALES, A.NO_EMPRESA, A.NO_FOLIO_DET, A.ID_STATUS_MOV,
        'CASH', 'C', V_FEC_FEC_EJECUCION, V_FEC_FEC_EJECUCION,
        A.CODE_COMBINATION,
        A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3, A.ORACLE_SEGMENTO4,
        A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7,
        A.ID_DIVISA, A.FEC_VALOR, A.IMPORTE
    FROM FECXP_FACT_GRP1 A,
    FECXC_DEP_ESPECIALES_D D
    WHERE A.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES
    AND A.ES_REPETIDO =0
    AND NOT EXISTS
    (
        SELECT 1
        FROM FECXP_BIT_INGR_CC B
        WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
    )
    ;
    COMMIT;
    /*Pasar a la bit?cora los que tuvieron m?s de una cuenta y marcarlos como 'V'arias Ctas*/
    /*Ingresa s?lo los folios que no exist?an*/
    INSERT INTO FECXP_BIT_INGR_CC (SECUENCIA_DEP_ESPECIALES, NO_EMPRESA, NO_FOLIO_DET, ID_STATUS_MOV,
        TIPO_CUENTA, ESTATUS_DIN_CC, FEC_PRIMERA_EJECUCION, FEC_ULTIMA_EJECUCION,
        ID_DIVISA, FEC_VALOR, IMPORTE
        )
    SELECT A.SECUENCIA_DEP_ESPECIALES, A.NO_EMPRESA, A.NO_FOLIO_DET, A.ID_STATUS_MOV,
        'CASH', 'V', V_FEC_FEC_EJECUCION, V_FEC_FEC_EJECUCION,
        A.ID_DIVISA, A.FEC_VALOR, A.IMPORTE
    FROM FECXP_FACT_GRP1 A,
        FECXC.FECXC_DEP_ESPECIALES D
    WHERE A.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES
    AND A.ES_REPETIDO =1
    AND NOT EXISTS
    (
        SELECT 1
        FROM FECXP_BIT_INGR_CC B
        WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
    )
    GROUP BY      A.SECUENCIA_DEP_ESPECIALES, A.NO_EMPRESA, A.NO_FOLIO_DET, A.ID_STATUS_MOV,
        A.ID_DIVISA, A.FEC_VALOR, A.IMPORTE
    ;
    COMMIT;
    /*Cerrar los folios que estuvieron pendientes y ya encontraron una sola cuenta contable*/
    /*Si est? pendiente no existe r?plica cancelada si la tuviera*/
    UPDATE FECXP_BIT_INGR_CC A
    SET ( CODE_COMBINATION, ORACLE_SEGMENTO1,ORACLE_SEGMENTO2,
            ORACLE_SEGMENTO3,ORACLE_SEGMENTO4,ORACLE_SEGMENTO5,
            ORACLE_SEGMENTO6,ORACLE_SEGMENTO7,ESTATUS_DIN_CC, FEC_ULTIMA_EJECUCION) =
         (SELECT B.CODE_COMBINATION, B.ORACLE_SEGMENTO1,B.ORACLE_SEGMENTO2,
            B.ORACLE_SEGMENTO3,B.ORACLE_SEGMENTO4,B.ORACLE_SEGMENTO5,
            B.ORACLE_SEGMENTO6,B.ORACLE_SEGMENTO7,'C', V_FEC_FEC_EJECUCION
           FROM  FECXP_FACT_GRP1 B
           WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
            AND B.ES_REPETIDO =0
         )
    WHERE ESTATUS_DIN_CC = 'P'
     AND EXISTS
    (
        SELECT 1
        FROM FECXP_FACT_GRP1 C
        WHERE C.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
        AND C.ES_REPETIDO =0
    );
    COMMIT;
    /*Marcar como folio con varias cuentas si estaba pendiente*/
    UPDATE FECXP_BIT_INGR_CC A
    SET ESTATUS_DIN_CC = 'V'
    WHERE EXISTS
    (
        SELECT 1
        FROM FECXP_FACT_GRP1 B
        WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
        AND B.ES_REPETIDO =1
    );
    COMMIT;
   /*Cancelados  para cobranza*/
   /*Replicar para los estatus cancelados para los cerrados y repetidos*/
    /*Identificar los folios que tienen r?plica cancelada s?lo para los que cerraron o tienen varias cuentas de esta ejecuci?n*/
    /*Si quedaran pendientes s?lo estar?an los aplicados*/
    DELETE  FECXP_CREAR_FACT;
    COMMIT;
    INSERT INTO FECXP_CREAR_FACT
    SELECT A.NO_EMPRESA, A.NO_FOLIO_DET, D.SECUENCIA_DEP_ESPECIALES, A.SECUENCIA_DEP_ESPECIALES AS SECUENCIA_APLICADA, A.ESTATUS_DIN_CC
    FROM FECXP_BIT_INGR_CC A,
            FECXC.FECXC_DEP_ESPECIALES D
    WHERE  A.NO_EMPRESA = D.NO_EMPRESA
    AND    A.NO_FOLIO_DET = D.NO_FOLIO_DET
    AND A.TIPO_CUENTA = 'CASH'
    AND    D.ID_STATUS_MOV IN ('X','Y','Z')
    AND    D.PROCESADO = 0
    --AND A.FEC_ULTIMA_EJECUCION = V_FEC_FEC_EJECUCION
    AND A.ESTATUS_DIN_CC IN ('C', 'V', 'S')
    ;
   COMMIT;
   /*Una vez identificados replicar las cuentas para aquellos que est?n cerrados*/
   DELETE FROM FECXC_DEP_ESPECIALES_D D
   WHERE EXISTS
   (
           SELECT 1
        FROM FECXP_BIT_INGR_CC A,
        FECXP_CREAR_FACT B
    WHERE D.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_DEP_ESPECIALES
    AND A.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_APLICADA
    AND A.ESTATUS_DIN_CC = 'C'
   )
   ;
   /*Primero pasar las cuentas al detalle*/
   /*Generar el detalle de cuentas para los ingresos encontrados*/
   INSERT INTO FECXC_DEP_ESPECIALES_D (SECUENCIA_DET_DEP_ESP, SECUENCIA_DEP_ESPECIALES, CODE_COMBINATION,IMPORTE_LINEA,
           ORA_SOIN_SEGMENTO1, ORA_SOIN_SEGMENTO2, ORA_SOIN_SEGMENTO3, ORACLE_SEGMENTO4, ORACLE_SEGMENTO5,
        ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
    SELECT SECUENCIA_DET_DEP_ESP.NEXTVAL,
    B.SECUENCIA_DEP_ESPECIALES, A.CODE_COMBINATION, (-1) * A.IMPORTE,
    A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3, A.ORACLE_SEGMENTO4,
    A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7
    FROM FECXP_BIT_INGR_CC A,
        FECXP_CREAR_FACT B
    WHERE A.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_APLICADA
    AND A.ESTATUS_DIN_CC = 'C'
    ;
    COMMIT;
    /*Generar las bit?coras*/
    /*La de facturas*/
    INSERT INTO FECXP_BIT_INGR_FACT (NO_EMPRESA, NO_FOLIO_DET,RECEIPT_NUMBER, NUM_RECIBO,
            FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
            CASH_RECEIPT_ID, CUSTOMER_TRX_ID,CUSTOMER_TRX_LINE_ID,
            STATUS_RECIBO, SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE, IMPORTE_RECIBO,
            CODE_COMBINATION,ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
            ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7)
    SELECT  A.NO_EMPRESA, A.NO_FOLIO_DET, A.RECEIPT_NUMBER, A.NUM_RECIBO,
            D.FEC_VALOR, D.ID_STATUS_MOV,A.ID_TIPO_OPERACION_SET,A.FECHA_ACTUALIZACION,
            A.CASH_RECEIPT_ID, A.CUSTOMER_TRX_ID,A.CUSTOMER_TRX_LINE_ID,
            A.STATUS_RECIBO, D.SECUENCIA_DEP_ESPECIALES,A.ID_DIVISA, D.IMPORTE, A.IMPORTE_RECIBO,
            A.CODE_COMBINATION,A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3,
            A.ORACLE_SEGMENTO4, A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7
    FROM   FECXP_BIT_INGR_FACT A,
              FECXP_CREAR_FACT B,
              FECXC.FECXC_DEP_ESPECIALES D
    WHERE A.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_APLICADA
            AND D.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_DEP_ESPECIALES
            AND B.ESTATUS_DIN_CC_APLI = 'C'
    ;
      COMMIT;
    /*La bit?cora de ingresos*/
     INSERT INTO FECXP_BIT_INGR_CC (SECUENCIA_DEP_ESPECIALES, NO_EMPRESA, NO_FOLIO_DET, ID_STATUS_MOV,
        TIPO_CUENTA, ESTATUS_DIN_CC, FEC_PRIMERA_EJECUCION, FEC_ULTIMA_EJECUCION,CODE_COMBINATION,
        ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3,
        ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7,
        ID_DIVISA, FEC_VALOR, IMPORTE
        )
    SELECT D.SECUENCIA_DEP_ESPECIALES, A.NO_EMPRESA, A.NO_FOLIO_DET, D.ID_STATUS_MOV,
    'CASH', A.ESTATUS_DIN_CC, V_FEC_FEC_EJECUCION, V_FEC_FEC_EJECUCION,
        A.CODE_COMBINATION,
        A.ORACLE_SEGMENTO1, A.ORACLE_SEGMENTO2, A.ORACLE_SEGMENTO3, A.ORACLE_SEGMENTO4,
        A.ORACLE_SEGMENTO5, A.ORACLE_SEGMENTO6, A.ORACLE_SEGMENTO7,
        A.ID_DIVISA, D.FEC_VALOR, D.IMPORTE
    FROM FECXP_BIT_INGR_CC A,
         FECXP_CREAR_FACT B,
         FECXC.FECXC_DEP_ESPECIALES D
    WHERE A.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_APLICADA
        AND D.SECUENCIA_DEP_ESPECIALES = B.SECUENCIA_DEP_ESPECIALES
    ;
   COMMIT;
   /* termina cancelados para cobranza*/
   /*Marcar los de cobranza*/
   /*Marcar los miscel?neos encontrados */
   UPDATE FECXC.FECXC_DEP_ESPECIALES A
   SET PROCESADO = 2
   WHERE PROCESADO= 0
   AND EXISTS
           (
               SELECT 1
            FROM FECXP_BIT_INGR_CC B
            WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
            AND B.TIPO_CUENTA = 'CASH'
            AND B.ESTATUS_DIN_CC IN ('C','V','S')
           )
   ;
   COMMIT;
   /*Ya que se han marcado todos los folios identificar los que no amarraron y que por tanto quedar?an pendientes*/
   -- MANEJA LA ?LTIMA FECHA DE PROCESAMIENTO para los pendientes--
   UPDATE    FECXP_BIT_INGR_CC
    SET        FEC_ULTIMA_EJECUCION = V_FEC_FEC_EJECUCION
    WHERE    ESTATUS_DIN_CC = 'P';
   ---Insertar en una estructura aquellos que tienen recibos
   DELETE FECXP_PEND_RECIBOS
   ;
   COMMIT;
   INSERT INTO FECXP_PEND_RECIBOS (NO_EMPRESA, NO_FOLIO_DET,RECEIPT_NUMBER, NUM_RECIBO,
            FEC_VALOR, ID_STATUS_MOV,ID_TIPO_OPERACION_SET,FECHA_ACTUALIZACION,
            CASH_RECEIPT_ID, STATUS_RECIBO, TIPO_RECIBO, SECUENCIA_DEP_ESPECIALES,ID_DIVISA, IMPORTE, IMPORTE_RECIBO)
   SELECT D.NO_EMPRESA, D.NO_FOLIO_DET,B.RECEIPT_NUMBER,
        TO_NUMBER(TRIM(REPLACE(TRANSLATE(B.RECEIPT_NUMBER,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ',''))) as NUM_RECIBO,
        D.FEC_VALOR, D.ID_STATUS_MOV,D.ID_TIPO_OPERACION_SET, V_FEC_FEC_EJECUCION,
        B.CASH_RECEIPT_ID, B.STATUS AS STATUS_RECIBO, B.TYPE,
        D.SECUENCIA_DEP_ESPECIALES,D.ID_DIVISA, D.IMPORTE, B.AMOUNT
    FROM    AR.AR_CASH_RECEIPTS_ALL@ERP_PROD B
            ,FECXC.FECXC_DEP_ESPECIALES D
    WHERE D.NO_FOLIO_DET = TO_NUMBER(TRIM(REPLACE(TRANSLATE(B.RECEIPT_NUMBER,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ','')))
            AND NOT INSTR(B.RECEIPT_NUMBER, '_')>0
            AND NOT INSTR(B.RECEIPT_NUMBER, '-')>0
            AND D.PROCESADO = 0
            AND D.ID_STATUS_MOV NOT IN ('X','Y','Z')
    GROUP BY D.NO_EMPRESA, D.NO_FOLIO_DET,B.RECEIPT_NUMBER,
        TO_NUMBER(TRIM(REPLACE(TRANSLATE(B.RECEIPT_NUMBER,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ',''))),
        D.FEC_VALOR, D.ID_STATUS_MOV,D.ID_TIPO_OPERACION_SET, V_FEC_FEC_EJECUCION,
        B.CASH_RECEIPT_ID, B.STATUS, B.TYPE,
        D.SECUENCIA_DEP_ESPECIALES,D.ID_DIVISA, D.IMPORTE, B.AMOUNT
   ;
   COMMIT;
   --una vez identificados  insertar a la bit?cora de ingresos con estatus pendiente y que no existan previamente
   INSERT INTO FECXP_BIT_INGR_CC (SECUENCIA_DEP_ESPECIALES, NO_EMPRESA, NO_FOLIO_DET, ID_STATUS_MOV,
        TIPO_CUENTA, ESTATUS_DIN_CC, FEC_PRIMERA_EJECUCION, FEC_ULTIMA_EJECUCION,
        ID_DIVISA, FEC_VALOR, IMPORTE
        )
   SELECT A.SECUENCIA_DEP_ESPECIALES, A.NO_EMPRESA, A.NO_FOLIO_DET, A.ID_STATUS_MOV,
       A.TIPO_RECIBO, 'P', V_FEC_FEC_EJECUCION, V_FEC_FEC_EJECUCION,
    A.ID_DIVISA, A.FEC_VALOR, A.IMPORTE
  FROM     FECXP_PEND_RECIBOS A
  WHERE NOT EXISTS
      (
        SELECT 1
        FROM   FECXP_BIT_INGR_CC B
        WHERE B.SECUENCIA_DEP_ESPECIALES = A.SECUENCIA_DEP_ESPECIALES
     )
  GROUP BY   A.SECUENCIA_DEP_ESPECIALES, A.NO_EMPRESA, A.NO_FOLIO_DET, A.ID_STATUS_MOV,
       A.TIPO_RECIBO, 'P', V_FEC_FEC_EJECUCION, V_FEC_FEC_EJECUCION,
    A.ID_DIVISA, A.FEC_VALOR, A.IMPORTE
  ;
  COMMIT;
  /*Iniciar la ejecuci?n autom?tica detalle reales*/
  /*Se desactiva el detalle de reales Oracle 24-oct-2011, esto se desactivo por que durante las noches o temrina de ejecutarse ya que bajan el ERP */
  /*Se reactiva el Detalle de reales Oracle 12/ene/2012, se le quito la Aperturacion para que se ejecute 1/2 en la noche y la paerturacion por las ma?anas*/
    UPDATE FECXP_PPTO_EXTRACCION_PARAMS
        SET FEC_INI = SYSDATE,
        ESTATUS_EXT_ULT_EJECUCION = 'ERROR',
        ALERTAR=0,
        ESTATUS_PROCESO='EN EJECUCION'
    WHERE PROCESO_ID = 11;
    UPDATE FECXP_PPTO_EXTRACCION_PARAMS
        SET ESTATUS_EXT_ULT_EJECUCION = 'ERROR',
        ALERTAR=0,
        ESTATUS_PROCESO='EN ESPERA'
    WHERE PROCESO_ID =12;
    /*Se Activa el detalle de reales SOIN 24-oct-2011 */
    /*Se Desactiva y se deja como originalmente estaba 12/01/2012*/
    /*UPDATE FECXP_PPTO_EXTRACCION_PARAMS
        SET FEC_INI = SYSDATE,
        ESTATUS_EXT_ULT_EJECUCION = 'ERROR',
        ALERTAR=0,
        ESTATUS_PROCESO='EN EJECUCION'
    WHERE PROCESO_ID = 12;*/
    COMMIT;
DBMS_OUTPUT.PUT_LINE('TERMINO CORRECTAMENTE');
EXCEPTION
     WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20000,'Error:' || SQLCODE || ' - ' || SQLERRM);
     WHEN OTHERS THEN
       ROLLBACK;
       RAISE_APPLICATION_ERROR(-20000,'Error:' || SQLCODE || ' - ' || SQLERRM);
END FECXP_GET_CTAS_CONT_INGR;
/
