CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXP_GENERA_VER_PPTO_ERP" (
    V_VERSION_FE IN INTEGER,
    V_USUARIO_ID IN VARCHAR2,
    V_COMENTARIO IN VARCHAR2,
    V_PERIODO_EXTRACCION IN INTEGER,
    V_VERSION_EXTRACCION IN INTEGER,
    V_ESTATUS_EXTRACCION IN VARCHAR2
) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    V_REGISTROS_VERSION INTEGER;
    /*Agredados 10/11/2010 para hacer la insercion mensual*/
    TYPE arreglo IS VARRAY(12) OF VARCHAR2(10);
    valores_cortar ARREGLO;
    contador_mensual INTEGER ;
    /*Modificado 20090713  Abrir presupuesto a varias monedas*/
    -- V_E_CODIGO INTEGER;
/*    V_VERSION_FE INTEGER:= 11;
    V_USUARIO_ID VARCHAR2 (25):= 'fecxc';
    V_COMENTARIO VARCHAR2 (255):= 'Prueba para Empresa SOIN';
    V_PERIODO_EXTRACCION INTEGER:= 2007;
    V_VERSION_EXTRACCION INTEGER:= 0;
    V_ESTATUS_EXTRACCION VARCHAR2 (255):= 'EXITOSO';
*/
BEGIN
    SELECT    NVL (COUNT (1), 0) CUENTA
    INTO    V_REGISTROS_VERSION
    FROM    GL.GL_CODE_COMBINATIONS@ERP_PROD CC,
            INTERFACE.XXGLB_PPTOS@ERP_PROD GLP,
            GL.GL_SETs_OF_BOOKs@ERP_PROD     sob,
             GL.GL_TRANSLATION_RATEs@ERP_PROD tc,
             GL.GL_PERIODs@ERP_PROD           per
    WHERE    sob.SET_OF_BOOKS_ID = tc.SET_OF_BOOKS_ID
       and sob.ATTRIBUTE1      ='O'
       and tc.ACTUAL_FLAG      ='B'
       and sob.PERIOD_SET_NAME = per.PERIOD_SET_NAME
       and per.PERIOD_NAME     = tc.PERIOD_NAME
       and GLP.YYYY = V_PERIODO_EXTRACCION   --PARAMETRO
       and CC.CHART_OF_ACCOUNTS_ID = sob.CHART_OF_ACCOUNTS_ID
       and GLP.MONEDA <> sob.CURRENCY_CODE
       and per.PERIOD_YEAR = GLP.YYYY
       and sob.SET_OF_BOOKS_ID = GLP.LIBRO_ID
       AND        CC.SEGMENT1 = GLP.CIA
        AND        CC.SEGMENT2 = GLP.NEG
        AND        CC.SEGMENT3 = GLP.CTA
        AND        CC.SEGMENT4 = GLP.SCTA
        AND        CC.SEGMENT5 = GLP.CC
        AND        CC.SEGMENT6 = GLP.ICIA
        AND        CC.SEGMENT7 = GLP.TOP
        AND        GLP.MONEDA = tc.TO_CURRENCY_CODE  ---LIGAR por moneda
    ;
    valores_cortar := arreglo('ENE-'||TO_CHAR(SYSDATE,'YY'),'FEB-'||TO_CHAR(SYSDATE,'YY'),'MAR-'||TO_CHAR(SYSDATE,'YY'),'ABR-'||TO_CHAR(SYSDATE,'YY'),'MAY-'||TO_CHAR(SYSDATE,'YY'),'JUN-'||TO_CHAR(SYSDATE,'YY'),'JUL-'||TO_CHAR(SYSDATE,'YY'),'AGO-'||TO_CHAR(SYSDATE,'YY'),'SEP-'||TO_CHAR(SYSDATE,'YY'),'OCT-'||TO_CHAR(SYSDATE,'YY'),'NOV-'||TO_CHAR(SYSDATE,'YY'),'DIC-'||TO_CHAR(SYSDATE,'YY'));
    IF V_REGISTROS_VERSION > 0 THEN
        DELETE    FECXP_PPTO_OPERA_ERP
        WHERE    VERSION_FE = V_VERSION_FE; -- AND E_CODIGO = NVL (V_E_CODIGO, E_CODIGO);
        COMMIT;
        DELETE    FECXP_PPTO_CONVERSION_ERP
        WHERE    VERSION_FE = V_VERSION_FE; -- AND E_CODIGO = NVL (V_E_CODIGO, E_CODIGO);
        COMMIT;
        /*Agregado 08/11/2010*/
        DELETE FECXC.FECXP_PPTO_OPERA_ERP_TMP;
        COMMIT;
        /*Modificado 08/11/2010 extraer los datos sin sumarizar a una tabla intermedia (FECXC.FECXP_PPTO_OPERA_ERP_TMP) y de ahi sumarizarlos hacia la tabla original(FECXP_PPTO_OPERA_ERP)*/
        /*Modificado 10/11/2010 Para Extraer Los Datos Mensualmente*/
       FOR contador_mensual IN 1..12 LOOP
       DBMS_OUTPUT.PUT_LINE('PERIODO-> '||valores_cortar(contador_mensual)||' INICIA'||TO_CHAR(SYSDATE, 'HH:MI:SS'));
       INSERT INTO FECXC.FECXP_PPTO_OPERA_ERP_TMP (PERIODO_EXTRACCION, MES_EXTRACCION, YYYY,LIBRO_ID, VERSION_ID, MONEDA,CODE_COMBINATION_ID, CIA, NEG,
                                                    CTA, SCTA, CC,ICIA, TOP, PPTO_01,PPTO_02, PPTO_03, PPTO_04,PPTO_05, PPTO_06, PPTO_07, PPTO_08, PPTO_09, PPTO_10,
                                                    PPTO_11, PPTO_12, TC_01, TC_02, TC_03, TC_04, TC_05, TC_06, TC_07, TC_08, TC_09, TC_10, TC_11, TC_12, MF, MO, VERSION_FE)
               SELECT                               TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) PERIODO_EXTRACCION,
                                                    TO_NUMBER(TO_CHAR(SYSDATE,'MM')) MES_EXTRACCION,
                                                    GLP.YYYY,
                                                    GLP.LIBRO_ID,
                                                    GLP.VERSION_ID,
                                                    GLP.MONEDA,
                                                    CC.CODE_COMBINATION_ID,
                                                    GLP.CIA, GLP.NEG, GLP.CTA, GLP.SCTA, GLP.CC, GLP.ICIA, GLP.TOP,
                                                    GLP.PPTO_01,
                                                    GLP.PPTO_02,
                                                    GLP.PPTO_03,
                                                    GLP.PPTO_04,
                                                    GLP.PPTO_05,
                                                    GLP.PPTO_06,
                                                    GLP.PPTO_07,
                                                    GLP.PPTO_08,
                                                    GLP.PPTO_09,
                                                    GLP.PPTO_10,
                                                    GLP.PPTO_11,
                                                    GLP.PPTO_12,
                                                    case when per.PERIOD_NUM= 1 then tc.EOP_RATE else 0 end TC_01,
                                                    case when per.PERIOD_NUM= 2 then tc.EOP_RATE else 0 end TC_02,
                                                    case when per.PERIOD_NUM= 3 then tc.EOP_RATE else 0 end TC_03,
                                                    case when per.PERIOD_NUM= 4 then tc.EOP_RATE else 0 end TC_04,
                                                    case when per.PERIOD_NUM= 5 then tc.EOP_RATE else 0 end TC_05,
                                                    case when per.PERIOD_NUM= 6 then tc.EOP_RATE else 0 end TC_06,
                                                    case when per.PERIOD_NUM= 7 then tc.EOP_RATE else 0 end TC_07,
                                                    case when per.PERIOD_NUM= 8 then tc.EOP_RATE else 0 end TC_08,
                                                    case when per.PERIOD_NUM= 9 then tc.EOP_RATE else 0 end TC_09,
                                                    case when per.PERIOD_NUM=10 then tc.EOP_RATE else 0 end TC_10,
                                                    case when per.PERIOD_NUM=11 then tc.EOP_RATE else 0 end TC_11,
                                                    case when per.PERIOD_NUM=12 then tc.EOP_RATE else 0 end TC_12,
                                                    sob.CURRENCY_CODE     MF,
                                                    tc.TO_CURRENCY_CODE   MO,
                                                    V_VERSION_FE
                                            FROM    GL.GL_CODE_COMBINATIONS@ERP_PROD CC,
                                                    INTERFACE.XXGLB_PPTOS@ERP_PROD GLP,
                                                    GL.GL_SETs_OF_BOOKs@ERP_PROD     sob,
                                                     GL.GL_TRANSLATION_RATEs@ERP_PROD tc,
                                                     GL.GL_PERIODs@ERP_PROD           per
                                            WHERE    sob.SET_OF_BOOKS_ID = tc.SET_OF_BOOKS_ID
                                                   and sob.ATTRIBUTE1      ='O'
                                                   and tc.ACTUAL_FLAG      ='B'
                                                   and sob.PERIOD_SET_NAME = per.PERIOD_SET_NAME
                                                   and per.PERIOD_NAME     = tc.PERIOD_NAME
                                                   and GLP.YYYY = V_PERIODO_EXTRACCION   --PARAMETRO
                                                   and CC.CHART_OF_ACCOUNTS_ID = sob.CHART_OF_ACCOUNTS_ID
                                                   and GLP.MONEDA <> sob.CURRENCY_CODE
                                                   and per.PERIOD_YEAR = GLP.YYYY
                                                   and sob.SET_OF_BOOKS_ID = GLP.LIBRO_ID
                                                   AND        CC.SEGMENT1 = GLP.CIA
                                                   AND        CC.SEGMENT2 = GLP.NEG
                                                   AND        CC.SEGMENT3 = GLP.CTA
                                                   AND        CC.SEGMENT4 = GLP.SCTA
                                                   AND        CC.SEGMENT5 = GLP.CC
                                                   AND        CC.SEGMENT6 = GLP.ICIA
                                                   AND        CC.SEGMENT7 = GLP.TOP
                                                   AND        GLP.MONEDA = tc.TO_CURRENCY_CODE   --ligar por moneda
                                                   AND        per.PERIOD_NAME     = valores_cortar(contador_mensual);   ---PARA HACERLO MENSUALMENTE
         DBMS_OUTPUT.PUT_LINE('PERIODO-> '||valores_cortar(contador_mensual)||' TERMINA'||TO_CHAR(SYSDATE, 'HH:MI:SS'));
         END LOOP;
        /*Los tipos de cambio ahora estaran en las columnas TC_01, TC_02...TC_n*/
        INSERT    INTO FECXP_PPTO_OPERA_ERP (E_CODIGO, SECUENCIA_PTTO_ORACLE, PERIODO_EXTRACCION, MES_DE_EXTRACCION, PERIODO_PPTO, LIBRO_ID, VERSION_ID,
                                             MONEDA, CODE_COMBINATION_ID, ORACLE_SEGMENTO1, ORACLE_SEGMENTO2, ORACLE_SEGMENTO3, ORACLE_SEGMENTO4, ORACLE_SEGMENTO5, ORACLE_SEGMENTO6, ORACLE_SEGMENTO7,
                                            PPTO_01, PSS_01, USD_01, EUR_01,PPTO_02, PSS_02, USD_02, EUR_02,PPTO_03, PSS_03, USD_03, EUR_03,
                                            PPTO_04, PSS_04, USD_04, EUR_04, PPTO_05, PSS_05, USD_05, EUR_05,
                                            PPTO_06, PSS_06, USD_06, EUR_06, PPTO_07, PSS_07, USD_07, EUR_07,
                                            PPTO_08, PSS_08, USD_08, EUR_08, PPTO_09, PSS_09, USD_09, EUR_09,
                                            PPTO_10, PSS_10, USD_10, EUR_10, PPTO_11, PSS_11, USD_11, EUR_11,
                                            PPTO_12, PSS_12, USD_12, EUR_12, VERSION_FE, TC_01, TC_02, TC_03, TC_04, TC_05, TC_06,
                                            TC_07, TC_08, TC_09, TC_10, TC_11, TC_12, MON_FUNC,  MON_ORIG
                                            )
                            SELECT          E.E_CODIGO,
                                            FECXC.SECUENCIA_PTTO_ORACLE.NEXTVAL,
                                            P.PERIODO_EXTRACCION,
                                            P.MES_EXTRACCION,
                                            P.YYYY,
                                            P.LIBRO_ID,
                                            P.VERSION_ID,
                                            P.MONEDA,
                                            P.CODE_COMBINATION_ID,
                                            P.CIA, P.NEG, P.CTA, P.SCTA, P.CC, P.ICIA, P.TOP,
                                            P.PPTO_01, 1,1,1,
                                            P.PPTO_02, 1,1,1,
                                            P.PPTO_03, 1,1,1,
                                            P.PPTO_04, 1,1,1,
                                            P.PPTO_05, 1,1,1,
                                            P.PPTO_06, 1,1,1,
                                            P.PPTO_07, 1,1,1,
                                            P.PPTO_08, 1,1,1,
                                            P.PPTO_09, 1,1,1,
                                            P.PPTO_10, 1,1,1,
                                            P.PPTO_11, 1,1,1,
                                            P.PPTO_12, 1,1,1,
                                            V_VERSION_FE,
                                            P.TC_01,
                                            P.TC_02,
                                            P.TC_03,
                                            P.TC_04,
                                            P.TC_05,
                                            P.TC_06,
                                            P.TC_07,
                                            P.TC_08,
                                            P.TC_09,
                                            P.TC_10,
                                            P.TC_11,
                                            P.TC_12,
                                            P.MF,
                                            P.MO
                                     FROM   (
                                            SELECT
                                            P.PERIODO_EXTRACCION,
                                            P.MES_EXTRACCION,
                                            P.YYYY,
                                            P.LIBRO_ID,
                                            P.VERSION_ID,
                                            P.MONEDA,
                                            P.CODE_COMBINATION_ID,
                                            P.CIA, P.NEG, P.CTA, P.SCTA, P.CC, P.ICIA, P.TOP,
                                            P.PPTO_01,
                                            P.PPTO_02,
                                            P.PPTO_03,
                                            P.PPTO_04,
                                            P.PPTO_05,
                                            P.PPTO_06,
                                            P.PPTO_07,
                                            P.PPTO_08,
                                            P.PPTO_09,
                                            P.PPTO_10,
                                            P.PPTO_11,
                                            P.PPTO_12,
                                            sum (TC_01) TC_01,
                                            sum (TC_02) TC_02,
                                            sum (TC_03) TC_03,
                                            sum (TC_04) TC_04,
                                            sum (TC_05) TC_05,
                                            sum (TC_06) TC_06,
                                            sum (TC_07) TC_07,
                                            sum (TC_08) TC_08,
                                            sum (TC_09) TC_09,
                                            sum (TC_10) TC_10,
                                            sum (TC_11) TC_11,
                                            sum (TC_12) TC_12,
                                            P.MF,
                                            P.MO
                                    FROM   FECXC.FECXP_PPTO_OPERA_ERP_TMP P
                                    GROUP BY P.YYYY,
                                             P.LIBRO_ID,
                                             P.VERSION_ID,
                                             P.MONEDA,
                                             P.CODE_COMBINATION_ID,
                                             P.CIA, P.NEG, P.CTA, P.SCTA, P.CC, P.ICIA, P.TOP,
                                             P.PPTO_01,
                                             P.PPTO_02,
                                             P.PPTO_03,
                                             P.PPTO_04,
                                             P.PPTO_05,
                                             P.PPTO_06,
                                             P.PPTO_07,
                                             P.PPTO_08,
                                             P.PPTO_09,
                                             P.PPTO_10,
                                             P.PPTO_11,
                                             P.PPTO_12,
                                             P.MF,
                                             P.MO,
                                             P.PERIODO_EXTRACCION,
                                             P.MES_EXTRACCION) P,
                                             FECXC.FECXC_EMPRESAS E
                                             WHERE LTRIM(E.E_CODIGO_SOIN,'0') = LTRIM(P.CIA,'0');
        COMMIT;
        UPDATE    FECXP_PPTO_OPERA_ERP
        SET        MONEDA = 'MXP'
        WHERE    MONEDA = 'PSS'
        AND        VERSION_FE = V_VERSION_FE; -- AND E_CODIGO = NVL (V_E_CODIGO, E_CODIGO);
        COMMIT;
        /*Manejar la moneda BOV como USD*/
        UPDATE    FECXP_PPTO_OPERA_ERP
        SET        MONEDA = 'USD'
        WHERE    MONEDA = 'BOV'
        AND        VERSION_FE = V_VERSION_FE; -- AND E_CODIGO = NVL (V_E_CODIGO, E_CODIGO);
        COMMIT;
        /*Manejar la funcional USP como USD*/
        UPDATE    FECXP_PPTO_OPERA_ERP
        SET        MONEDA = 'USD'
        WHERE    MONEDA = 'USP'
        AND        MON_FUNC = 'USD'
        AND        VERSION_FE = V_VERSION_FE; -- AND E_CODIGO = NVL (V_E_CODIGO, E_CODIGO);
        COMMIT;
        /*Manejar la funcional USP como USD*/
        UPDATE    FECXP_PPTO_OPERA_ERP
        SET        MONEDA = 'ARS'
        WHERE    MONEDA = 'ARG'
        AND        MON_FUNC = 'ARS'
        AND        VERSION_FE = V_VERSION_FE; -- AND E_CODIGO = NVL (V_E_CODIGO, E_CODIGO);
        COMMIT;
        DELETE    FECXP_PPTO_OPERA_ERP_ENC
        WHERE    VERSION_FE = V_VERSION_FE;
        COMMIT;
        DELETE    FECXP_PPTO_CONVERSION_ERP_ENC
        WHERE    VERSION_FE = V_VERSION_FE;
        COMMIT;
        INSERT    INTO FECXC.FECXP_PPTO_OPERA_ERP_ENC (
                VERSION_FE, COMENTARIO, USUARIO_ID, FECHA_EXTRACCION, VERSION_REGLAS, FECHA_VERSION_REGLAS, PERIODO_ORIGEN, VERSION_ORIGEN, ESTATUS_ORIGEN, VERSION_FE_ORIGEN)
        SELECT    VERSION_FE, V_COMENTARIO, V_USUARIO_ID, SYSDATE, 0, TO_DATE ('19000101', 'YYYYMMDD'), PERIODO_EXTRACCION, VERSION_ID, V_ESTATUS_EXTRACCION, 0
        FROM    FECXP_PPTO_OPERA_ERP
        WHERE    VERSION_FE = V_VERSION_FE
        GROUP BY VERSION_FE, PERIODO_EXTRACCION, VERSION_ID;
        COMMIT;
        INSERT    INTO FECXP_PPTO_BITACORA_PROCESOS (
                SEC_EXT_BITACORA, PROCESO_ID, FECHA_EXT_ULT_EJECUCION, ESTATUS_EXT_ULT_EJECUCION, PERIODO_PPTO_ULT_EJECUCION, VERSION_PPTO_ULT_EJECUCION, ESTATUS_PPTO_ULT_EJECUCION, VERSION_PPTO_GENERADO)
        SELECT    SEC_EXT_BITACORA.NEXTVAL, 1, SYSDATE, 'EXTRACCION EXITOSA', PERIODO_EXTRACCION, VERSION_ID, V_ESTATUS_EXTRACCION, VERSION_FE
        FROM    (
                    SELECT    PERIODO_EXTRACCION, VERSION_ID, VERSION_FE
                    FROM    FECXP_PPTO_OPERA_ERP
                    WHERE    VERSION_FE = V_VERSION_FE -- AND E_CODIGO = NVL (V_E_CODIGO, E_CODIGO)
                    GROUP BY PERIODO_EXTRACCION, VERSION_ID, VERSION_FE
                );
        COMMIT;
    ELSE
        UPDATE    FECXC.FECXP_PPTO_OPERA_ERP_ENC
        SET        COMENTARIO = 'ESTA VERSION DE PRESUPUESTO NO EXISTE'
        WHERE    VERSION_FE = V_VERSION_FE;
        COMMIT;
    END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
   RAISE_APPLICATION_ERROR(-20000,'NO HAY DATOS NUEVOS.');
   WHEN OTHERS THEN
   --DBMS_OUTPUT.PUT_LINE('ERROR '||SQLERRM||' '||SQLCODE);
    RAISE_APPLICATION_ERROR(-20000,'Error:' || SQLCODE || ' - ' || SQLERRM);
END FECXP_GENERA_VER_PPTO_ERP;
/
