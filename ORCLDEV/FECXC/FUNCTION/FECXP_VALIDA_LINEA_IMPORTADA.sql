CREATE OR REPLACE EDITIONABLE FUNCTION "FECXC"."FECXP_VALIDA_LINEA_IMPORTADA" (TIPO_IMPORTACION IN VARCHAR2, FOLIO_SET IN VARCHAR2,E_CODIGO IN VARCHAR2, NUMERO_DE_PARTIDA IN INTEGER, ESTATUS_MOVIMIENTO IN VARCHAR2, CODE_COMBINATION IN INTEGER, DIVISION IN VARCHAR2, AGRUPAMIENTO IN VARCHAR2, RUBRO IN VARCHAR2, DES_EMPRESA IN VARCHAR2, MONEDA IN VARCHAR2,SCT IN VARCHAR2,CTA IN VARCHAR2, CC IN VARCHAR2, ICIA IN VARCHAR2,  V_ID_SESION  in  FECXP_IMPORTACION_DATOS.ATRIBUTO_1%TYPE) RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
V_DIVISION              VARCHAR2 (50);
V_AGRUPAMIENTO          VARCHAR2 (50);
V_RUBRO                 VARCHAR2 (50);
V_CLA_FE_ID             VARCHAR2 (25);
V_CLA_FE_DES            VARCHAR2 (50);
V_E_CODIGO              VARCHAR2 (25);
V_E_EMPRESA_DES         VARCHAR2 (100);
V_FOLIO_SET             VARCHAR2 (150);
V_NO_CLIENTE            VARCHAR2 (15);
V_REFERENCIA            VARCHAR2 (30);
V_DESCRIPCION           VARCHAR2 (30);
V_TIPO_OPERACION        INTEGER;
V_ID_BANCO              INTEGER;
V_FORMA_PAGO            INTEGER;
V_ID_CHEQUERA           VARCHAR2 (20);
V_ESTATUS_MOVIMIENTO    VARCHAR2 (1);
V_BENEFICIARIO          VARCHAR2 (60);
V_CONCEPTO              VARCHAR2 (100);
V_ORIGEN_MOVIMIENTO     VARCHAR2 (3);
V_NUMERO_DE_PARTIDA     INTEGER;
V_CIA                   VARCHAR2 (25);
V_NEG                   VARCHAR2 (25);
V_CTA                   VARCHAR2 (25);
V_SCT                   VARCHAR2 (25);
V_CC                    VARCHAR2 (25);
V_ICIA                    VARCHAR2 (25);
V_TOP                    VARCHAR2 (25);
V_ESTATUS                VARCHAR2 (50);
V_FECHA_APLICACION        DATE;
V_MONEDA_IMP            VARCHAR2 (25);
V_IMPORTE_LINEA            NUMBER (20,4);
V_CONTADOR_C            INTEGER:=0;
V_MENSAJE               VARCHAR2 (4000);
V_CODE_COMBINATION INTEGER;
-- ************* CURSOR PARA REALES ORACLE ********************
CURSOR C_FOLIOS_ORACLE_REAL(V_FOLIO_SET_C VARCHAR2,V_NUMERO_DE_PARTIDA_C INTEGER, V_E_CODIGO_C VARCHAR2) IS SELECT DISTINCT
                                    E_CODIGO,DES_EMPRESA,FOLIO_SET,TIPO_OPERACION,CONCEPTO,BENEFICIARIO,
                                    ESTATUS_MOVIMIENTO,ID_CHEQUERA,ID_BANCO,NO_CLIENTE,FORMA_PAGO,FECHA_APLICACION,
                                    MONEDA,TC_ORIGINAL,TC_FLUJO,ORIGEN_MOVIMIENTO,DIVISION,AGRUPAMIENTO,
                                    RUBRO,CLA_FE_ID,CLA_FE_DES,NUMERO_DE_PARTIDA,ORACLE_SEGMENTO1,ORACLE_SEGMENTO2,
                                    ORACLE_SEGMENTO3,ORACLE_SEGMENTO4,ORACLE_SEGMENTO5,ORACLE_SEGMENTO6,ORACLE_SEGMENTO7,
                                    IMPORTE_LINEA,ESTATUS,MET_CLASIFICACION,REFERENCIA,DESCRIPCION
                                    FROM
                                    (
                                    SELECT    SF.ID_SEGMENTO, SF.DES_SEGMENTO, R.E_CODIGO, E.DES_EMPRESA, R.FOLIO_SET, TO_CHAR (R.TIPO_OPERACION) TIPO_OPERACION, R.CONCEPTO, R.BENEFICIARIO, R.ESTATUS_MOVIMIENTO, R.ID_CHEQUERA, TO_CHAR (R.ID_BANCO) ID_BANCO, NVL (R.NO_CLIENTE ,'0') NO_CLIENTE,
                                            TO_CHAR (R.FORMA_PAGO) FORMA_PAGO, R.FECHA_APLICACION, R.MONEDA, 'TC_ORIGINAL: ' || TO_CHAR (R.TC_ORIGINAL) TC_ORIGINAL, 'TC_FLUJO: ' || TO_CHAR (R.TC_FLUJO) TC_FLUJO, R.ORIGEN_MOVIMIENTO,
                                            R.DIVISION, R.AGRUPAMIENTO, R.RUBRO, R.CLA_FE_ID, R.CLA_FE_DES,
                                            TO_CHAR (R.NUMERO_DE_PARTIDA_ERP) NUMERO_DE_PARTIDA, R.ORACLE_SEGMENTO1, R.ORACLE_SEGMENTO2, R.ORACLE_SEGMENTO3, R.ORACLE_SEGMENTO4, R.ORACLE_SEGMENTO5, TRIM(R.ORACLE_SEGMENTO6) ORACLE_SEGMENTO6, R.ORACLE_SEGMENTO7,
                                            R.IMPORTE_LINEA,
                                            R.IMPORTE_LINEA * TC_ORIGINAL IMPORTE_LINEA_TC_O,
                                            R.IMPORTE_LINEA * TC_FLUJO IMPORTE_LINEA_TC_F,
                                            R.ESTATUS, R.MET_CLASIFICACION,
                                            R.REFERENCIA, R.DESCRIPCION
                                    FROM    (
                                            SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                    P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                    M.TIPO_CAMBIO TC_FLUJO,
                                                    P.ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                    NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                    NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                    NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                    CF.CLA_FE_ID,
                                                    CF.CLA_FE_DES,
                                                    P.NUMERO_DE_PARTIDA_ERP, P.ORACLE_SEGMENTO1, P.ORACLE_SEGMENTO2, P.ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5, P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7, P.IMPORTE_LINEA, 'EGRESO EXTRAIDO' ESTATUS, 'POL?TICAS' MET_CLASIFICACION,
                                                    P.REFERENCIA, P.DESCRIPCION
                                            FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                    FECXC.FECXP_PAGOS_ERP_CLASIF P,
                                                    FECXC.FECXP_CTAS_CLASIF_REAL_ERP C,
                                                    FECXC.FECXP_MONEDAS M
                                            WHERE    P.E_CODIGO = C.E_CODIGO
                                            AND        P.TIPO_OPERACION = C.TIPO_OPERACION
                                            AND        P.ID_BANCO = C.ID_BANCO
                                            AND        P.ID_CHEQUERA = C.ID_CHEQUERA
                                            AND        P.ORACLE_SEGMENTO1 = C.ORACLE_SEGMENTO1
                                            AND        P.ORACLE_SEGMENTO2 = C.ORACLE_SEGMENTO2
                                            AND        P.ORACLE_SEGMENTO3 = C.ORACLE_SEGMENTO3
                                            AND        P.ORACLE_SEGMENTO4 = C.ORACLE_SEGMENTO4
                                            AND        P.ORACLE_SEGMENTO5 = C.ORACLE_SEGMENTO5
                                            AND        P.ORACLE_SEGMENTO6 = C.ORACLE_SEGMENTO6
                                            AND        P.ORACLE_SEGMENTO7 = C.ORACLE_SEGMENTO7
                                            AND        M.MON_SET = P.MONEDA
                                            AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                            AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                            AND        CF.CLA_FE_ID = C.CLA_FE_ID
                                            UNION ALL
                                            SELECT    I.E_CODIGO, TO_CHAR (I.FOLIO_SET), I.TIPO_OPERACION, I.CONCEPTO, I.BENEFICIARIO, I.ID_STATUS_MOV, I.ID_CHEQUERA, I.ID_BANCO, I.NO_CLIENTE,
                                                    I.ID_FORMA_PAGO, I.FECHA, M.MON_ORACLE MONEDA, I.TIPO_CAMBIO, M.TIPO_CAMBIO, '',
                                                    I.IMPORTE,
                                                    NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                    NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                    NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                    CF.CLA_FE_ID, CF.CLA_FE_DES,
                                                    0, I.ORA_SOIN_SEGMENTO1, I.ORA_SOIN_SEGMENTO2, I.ORA_SOIN_SEGMENTO3, I.ORACLE_SEGMENTO4, I.ORACLE_SEGMENTO5, I.ORACLE_SEGMENTO6, I.ORACLE_SEGMENTO7, CASE I.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN I.IMPORTE ELSE I.IMPORTE_LINEA END, 'INGRESO EXTRAIDO', I.TIPO_CLASIFICACION,
                                                    I.REFERENCIA, I.DESCRIPCION
                                            FROM    FECXC.FECXP_INGRESOS_CLASIF I,
                                                    FECXC.FECXC_DEP_ESPECIALES R,
                                                    FECXC.FECXP_MONEDAS M,
                                                    FECXP_CLASIFICACION_FE CF
                                            WHERE    I.ID_STATUS_MOV NOT IN ('Q')
                                            AND        I.CLA_FE_ID = CF.CLA_FE_ID
                                            AND        M.MON_ORACLE = I.MONEDA
                                            AND        M.PERIODO = TO_NUMBER (TO_CHAR (I.FECHA, 'YYYY'))
                                            AND        M.MES = TO_NUMBER (TO_CHAR (I.FECHA, 'MM'))
                                            AND        R.NO_EMPRESA = I.E_CODIGO
                                            AND        R.NO_FOLIO_DET = I.FOLIO_SET
                                            AND        R.ID_STATUS_MOV = I.ID_STATUS_MOV
                                            UNION ALL
                                            SELECT    TO_NUMBER (H.E_EMPRESA_IMP), '0', 0, '', '', '', '', 0, '',
                                                    0, TO_DATE (TO_CHAR (H.FECHA,'YYYY') || LPAD (TO_CHAR (H.MES), 2, '0') || '01', 'YYYYMMDD') FECHA, H.MONEDA_IMP MONEDA, M.TIPO_CAMBIO, M.TIPO_CAMBIO, '', H.IMPORTE_LINEA,
                                                    NVL(C.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                    NVL(C.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                    NVL(C.CLA_ATRIBUTO2,'') RUBRO,
                                                    C.CLA_FE_ID, C.CLA_FE_DES,
                                                    0, 'X' ORACLE_SEGMENTO1, 'X' ORACLE_SEGMENTO2, 'X' ORACLE_SEGMENTO3, 'X' ORACLE_SEGMENTO4, 'X' ORACLE_SEGMENTO5, 'X' ORACLE_SEGMENTO6, 'X' ORACLE_SEGMENTO7, H.IMPORTE_LINEA, 'IMPORTADO', 'NA',
                                                    '<SIN REFERENCIA>' REFERENCIA, '<SIN DESCRIPCION>' DESCRIPCION
                                            FROM    FECXC.FECXP_IMPORTACION_DATOS_HIST H,
                                                    FECXC.FECXP_CLASIFICACION_FE C,
                                                    FECXC.FECXP_MONEDAS M
                                            WHERE    H.TIPO_IMPORTACION = 'R'
                                            AND        M.MON_ORACLE = H.MONEDA_IMP
                                            AND        M.MES = H.MES
                                            AND        M.PERIODO = TO_NUMBER (TO_CHAR (FECHA, 'YYYY'))
                                            AND        C.CLA_FE_ID = H.CLA_FE_ID_IMP
                                            ) R,
                                            FECXC.FECXC_EMP_X_SEGMENTO ES,
                                            FECXC.FECXC_SEGMENTOS_FLUJO SF,
                                            FECXC.FECXC_EMPRESAS E
                                    WHERE        ES.ID_SEGMENTO NOT IN (11,15, 17, 18, 20, 26, 6, 13, 25)
                                    AND        E.CUAL_ERP = 'O'
                                    AND        E.E_CODIGO = R.E_CODIGO
                                    AND        ES.E_CODIGO = R.E_CODIGO
                                    AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO
                                    UNION ALL
                                    SELECT    SF.ID_SEGMENTO, SF.DES_SEGMENTO, R.E_CODIGO, E.DES_EMPRESA, R.FOLIO_SET, TO_CHAR (R.TIPO_OPERACION) TIPO_OPERACION, R.CONCEPTO, R.BENEFICIARIO, R.ESTATUS_MOVIMIENTO, R.ID_CHEQUERA, TO_CHAR (R.ID_BANCO) ID_BANCO, NVL (R.NO_CLIENTE ,'0') NO_CLIENTE,
                                            TO_CHAR (R.FORMA_PAGO) FORMA_PAGO, R.FECHA_APLICACION, R.MONEDA, 'TC_ORIGINAL: ' || TO_CHAR (R.TC_ORIGINAL) TC_ORIGINAL, 'TC_FLUJO: ' || TO_CHAR (R.TC_FLUJO) TC_FLUJO, R.ORIGEN_MOVIMIENTO,
                                            R.DIVISION, R.AGRUPAMIENTO, R.RUBRO, R.CLA_FE_ID, R.CLA_FE_DES,
                                            TO_CHAR (R.NUMERO_DE_PARTIDA_ERP) NUMERO_DE_PARTIDA, R.ORACLE_SEGMENTO1, R.ORACLE_SEGMENTO2, R.ORACLE_SEGMENTO3, R.ORACLE_SEGMENTO4, R.ORACLE_SEGMENTO5, TRIM(R.ORACLE_SEGMENTO6) ORACLE_SEGMENTO6, R.ORACLE_SEGMENTO7,
                                            R.IMPORTE_LINEA,
                                            R.IMPORTE_LINEA * TC_ORIGINAL IMPORTE_LINEA_TC_O,
                                            R.IMPORTE_LINEA * TC_FLUJO IMPORTE_LINEA_TC_F,
                                            R.ESTATUS, R.MET_CLASIFICACION,
                                            R.REFERENCIA, R.DESCRIPCION
                                    FROM    (
                                                SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                        P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                        M.TIPO_CAMBIO TC_FLUJO,
                                                        'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        P.CLA_FE_ID,
                                                        CF.CLA_FE_DES,
                                                        P.NUMERO_DE_PARTIDA_ERP, P.ORA_SOIN_SEGMENTO1 AS ORACLE_SEGMENTO1, P.ORA_SOIN_SEGMENTO2 AS ORACLE_SEGMENTO2, P.ORA_SOIN_SEGMENTO3 AS ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5, P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7, P.IMPORTE_LINEA,
                                                        'COINV EGR' ESTATUS, 'COINVERSION' MET_CLASIFICACION,
                                                        P.REFERENCIA, P.DESCRIPCION
                                                FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                        FECXC.FECXP_DET_REALES_COINVERSION P,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    M.MON_SET = P.MONEDA
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                AND        P.ID_TIPO_MOVTO ='E'
                                                UNION ALL
                                                SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                        P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                        M.TIPO_CAMBIO TC_FLUJO,
                                                        'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        P.CLA_FE_ID,
                                                        CF.CLA_FE_DES,
                                                        P.NUMERO_DE_PARTIDA_ERP, P.ORA_SOIN_SEGMENTO1 AS ORACLE_SEGMENTO1, P.ORA_SOIN_SEGMENTO2 AS ORACLE_SEGMENTO2, P.ORA_SOIN_SEGMENTO3 AS ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5, P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7,
                                                        CASE P.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN P.IMPORTE ELSE P.IMPORTE_LINEA END,
                                                        'COINV ING' ESTATUS, 'COINVERSION' MET_CLASIFICACION,
                                                        P.REFERENCIA, P.DESCRIPCION
                                                FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                        FECXC.FECXP_DET_REALES_COINVERSION P,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    M.MON_SET = P.MONEDA
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                AND        P.ID_TIPO_MOVTO ='I'
                                                UNION ALL
                                                SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                        P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                        M.TIPO_CAMBIO TC_FLUJO,
                                                        'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        P.CLA_FE_ID,
                                                        CF.CLA_FE_DES,
                                                        P.NUMERO_DE_PARTIDA_ERP, P.ORA_SOIN_SEGMENTO1 AS ORACLE_SEGMENTO1, P.ORA_SOIN_SEGMENTO2 AS ORACLE_SEGMENTO2, P.ORA_SOIN_SEGMENTO3 AS ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5, P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7, P.IMPORTE_LINEA,
                                                        CASE P.ID_TIPO_MOVTO WHEN 'I' THEN 'INV INGR' ELSE 'INV EGR' END ESTATUS, 'INVERSION' MET_CLASIFICACION,
                                                        P.REFERENCIA, P.DESCRIPCION
                                                FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                        FECXC.FECXP_DET_REALES_INVERSION P,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    M.MON_SET = P.MONEDA
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                AND        P.ID_TIPO_MOVTO ='E'
                                                UNION ALL
                                                SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                        P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                        M.TIPO_CAMBIO TC_FLUJO,
                                                        'SET'AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        P.CLA_FE_ID,
                                                        CF.CLA_FE_DES,
                                                        P.NUMERO_DE_PARTIDA_ERP, P.ORA_SOIN_SEGMENTO1 AS ORACLE_SEGMENTO1, P.ORA_SOIN_SEGMENTO2 AS ORACLE_SEGMENTO2, P.ORA_SOIN_SEGMENTO3 AS ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5, P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7,
                                                        CASE P.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN P.IMPORTE ELSE P.IMPORTE_LINEA END,
                                                        CASE P.ID_TIPO_MOVTO WHEN 'I' THEN 'INV ING' ELSE 'INV EGR' END ESTATUS, 'INVERSION' MET_CLASIFICACION,
                                                        P.REFERENCIA, P.DESCRIPCION
                                                FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                        FECXC.FECXP_DET_REALES_INVERSION P,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    M.MON_SET = P.MONEDA
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                AND        P.ID_TIPO_MOVTO ='I'
                                            ) R,
                                            FECXC.FECXC_EMP_X_SEGMENTO ES,
                                            FECXC.FECXC_SEGMENTOS_FLUJO SF,
                                            FECXC.FECXC_EMPRESAS E
                                    WHERE    ES.ID_SEGMENTO NOT IN (11,15, 17, 18, 20, 26, 6, 13, 25)
                                    AND     E.CUAL_ERP = 'O'
                                    AND        E.E_CODIGO = R.E_CODIGO
                                    AND        ES.E_CODIGO = R.E_CODIGO
                                    AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO) where FOLIO_SET = V_FOLIO_SET_C
                                                                                AND   NUMERO_DE_PARTIDA=V_NUMERO_DE_PARTIDA_C
                                                                                AND E_CODIGO = V_E_CODIGO_C;
--------------++++++++CURSOR PARA REALES SOIN++++-----
CURSOR C_FOLIOS_SOIN_REAL(V_FOLIO_SET_C VARCHAR2,V_ESTATUS_MOVIMIENTO VARCHAR2) IS SELECT DISTINCT
                                                                         ID_SEGMENTO,DES_SEGMENTO,E_CODIGO,DES_EMPRESA,
                                                                      FOLIO_SET,TIPO_OPERACION,CONCEPTO,BENEFICIARIO,
                                                                      ESTATUS_MOVIMIENTO,ID_CHEQUERA,ID_BANCO,NO_CLIENTE,
                                                                      FORMA_PAGO,FECHA_APLICACION,MES,MONEDA,TC_ORIGINAL,
                                                                      TC_FLUJO,ORIGEN_MOVIMIENTO,DIVISION,AGRUPAMIENTO,RUBRO,
                                                                      CLA_FE_ID,CLA_FE_DES,NUMERO_DE_PARTIDA_SOIN,CTAM01,CTAM02,CTAM03,
                                                                      IMPORTE_LINEA,ESTATUS,MET_CLASIFICACION,IMPORTE_LINEA_TC_O,
                                                                      IMPORTE_LINEA_TC_F,REFERENCIA,DESCRIPCION
                                                                     FROM(
                                               SELECT SF.ID_SEGMENTO, SF.DES_SEGMENTO, R.E_CODIGO, E.DES_EMPRESA, R.FOLIO_SET,
                                                         TO_CHAR (R.TIPO_OPERACION) TIPO_OPERACION, R.CONCEPTO, R.BENEFICIARIO,
                                                      R.ESTATUS_MOVIMIENTO, R.ID_CHEQUERA, TO_CHAR (R.ID_BANCO) ID_BANCO, NVL (R.NO_CLIENTE ,'0') NO_CLIENTE,
                                                    TO_CHAR (R.FORMA_PAGO) FORMA_PAGO, R.FECHA_APLICACION,
                                                    TO_CHAR(TO_DATE(r.fecha_aplicacion,'DD-MM-YYYY'),'MONTH','NLS_DATE_LANGUAGE=SPANISH') mes
                                                , R.MONEDA, 'TC_ORIGINAL: ' || TO_CHAR (R.TC_ORIGINAL) TC_ORIGINAL, 'TC_FLUJO: ' || TO_CHAR (R.TC_FLUJO) TC_FLUJO, R.ORIGEN_MOVIMIENTO,
                                                R.DIVISION, R.AGRUPAMIENTO, R.RUBRO,R.CLA_FE_ID, R.CLA_FE_DES,
                                                TO_CHAR (R.NUMERO_DE_PARTIDA_SOIN) NUMERO_DE_PARTIDA_SOIN, R.CTAM01, R.CTAM02, R.CTAM03,
                                                R.IMPORTE_LINEA, R.ESTATUS, R.MET_CLASIFICACION,
                                                R.IMPORTE_LINEA * TC_ORIGINAL IMPORTE_LINEA_TC_O,
                                                R.IMPORTE_LINEA * TC_FLUJO IMPORTE_LINEA_TC_F,
                                                 R.REFERENCIA, R.DESCRIPCION
                                        FROM    (
                                                SELECT  P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                        P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL, M.TIPO_CAMBIO TC_FLUJO, P.ORIGEN_MOVIMIENTO,
                                                        P.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        CF.CLA_FE_ID,
                                                        CF.CLA_FE_DES,
                                                        P.NUMERO_DE_PARTIDA_SOIN, P.CTAM01, P.CTAM02, P.CTAM03, P.IMPORTE_LINEA, 'EGRESO EXTRAIDO' ESTATUS, 'POL?TICAS' MET_CLASIFICACION,
                                                        P.REFERENCIA, P.DESCRIPCION
                                                        FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                                FECXC.FECXP_PAGOS_SOIN_CLASIF P,
                                                                FECXC.FECXP_CTAS_CLASIF_REAL_SOIN C,
                                                                FECXC.FECXP_MONEDAS M
                                                        WHERE    P.E_CODIGO = C.E_CODIGO
                                                        AND        P.TIPO_OPERACION = C.TIPO_OPERACION
                                                        AND        P.ID_BANCO = C.ID_BANCO
                                                        AND        P.ID_CHEQUERA = C.ID_CHEQUERA
                                                        AND        P.CTAM01 = C.CTAM01
                                                        AND        P.CTAM02 = C.CTAM02
                                                        AND        P.CTAM03 = C.CTAM03
                                                        AND        CF.CLA_FE_ID = C.CLA_FE_ID
                                                        AND        M.MON_SET = P.MONEDA
                                                        AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                        AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                            UNION ALL
                                                SELECT    I.E_CODIGO, TO_CHAR (I.FOLIO_SET), I.TIPO_OPERACION, I.CONCEPTO, I.BENEFICIARIO, I.ID_STATUS_MOV, I.ID_CHEQUERA, I.ID_BANCO, I.NO_CLIENTE,
                                                        I.ID_FORMA_PAGO, I.FECHA, M.MON_ORACLE MONEDA, I.TIPO_CAMBIO, M.TIPO_CAMBIO, '',
                                                        I.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        CF.CLA_FE_ID, CF.CLA_FE_DES,
                                                        0, I.ORA_SOIN_SEGMENTO1, I.ORA_SOIN_SEGMENTO2, I.ORA_SOIN_SEGMENTO3, CASE I.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN I.IMPORTE ELSE I.IMPORTE_LINEA END, 'INGRESO EXTRAIDO', I.TIPO_CLASIFICACION,
                                                        I.REFERENCIA, I.DESCRIPCION
                                                FROM    FECXC.FECXP_INGRESOS_CLASIF I,
                                                        FECXC.FECXC_DEP_ESPECIALES R,
                                                        FECXC.FECXP_CLASIFICACION_FE CF,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    I.CLA_FE_ID = CF.CLA_FE_ID
                                                AND        M.MON_ORACLE = I.MONEDA
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (I.FECHA, 'YYYY'))
                                                AND        M.MES = TO_NUMBER (TO_CHAR (I.FECHA, 'MM'))
                                                AND        I.ID_STATUS_MOV NOT IN ('Q')
                                                AND        R.NO_EMPRESA = I.E_CODIGO
                                                AND        R.NO_FOLIO_DET = I.FOLIO_SET
                                                AND        R.ID_STATUS_MOV = I.ID_STATUS_MOV
                                                UNION ALL
                                                SELECT    TO_NUMBER (H.E_EMPRESA_IMP), '0', 0, '', '', '', '', 0, '',
                                                        0, TO_DATE (TO_CHAR (H.FECHA,'YYYY') || LPAD (TO_CHAR (H.MES), 2, '0') || '01', 'YYYYMMDD') FECHA, H.MONEDA_IMP, M.TIPO_CAMBIO, M.TIPO_CAMBIO, '',
                                                        H.IMPORTE_LINEA,
                                                        NVL(C.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(C.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(C.CLA_ATRIBUTO2,'') RUBRO,
                                                        C.CLA_FE_ID, C.CLA_FE_DES,
                                                        0, 'X' ARSMAP, 'X' AEJMAP, 'X' CNCMAP, H.IMPORTE_LINEA, 'IMPORTADO', 'NA',
                                                        '<SIN REFERENCIA>' REFERENCIA, '<SIN DESCRIPCION>' DESCRIPCION
                                                FROM    FECXC.FECXP_IMPORTACION_DATOS_HIST H,
                                                        FECXC.FECXP_CLASIFICACION_FE C,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    H.TIPO_IMPORTACION = 'R'
                                                AND        C.CLA_FE_ID = H.CLA_FE_ID_IMP
                                                AND        M.MON_ORACLE = H.MONEDA_IMP
                                                AND        M.MES = H.MES
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'))
                                                ) R,
                                                FECXC.FECXC_EMP_X_SEGMENTO ES,
                                                FECXC.FECXC_SEGMENTOS_FLUJO SF,
                                                FECXC.FECXC_EMPRESAS E
                                        WHERE    ES.ID_SEGMENTO NOT IN (11, 15, 17, 18 , 20, 26, 6, 13, 25)
                                        AND        E.CUAL_ERP = 'S'
                                        AND        ES.E_CODIGO = R.E_CODIGO
                                        AND        E.E_CODIGO = R.E_CODIGO
                                        AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO
                                        UNION ALL
                                        SELECT    SF.ID_SEGMENTO, SF.DES_SEGMENTO, R.E_CODIGO, E.DES_EMPRESA, R.FOLIO_SET, TO_CHAR (R.TIPO_OPERACION) TIPO_OPERACION, R.CONCEPTO, R.BENEFICIARIO, R.ESTATUS_MOVIMIENTO, R.ID_CHEQUERA, TO_CHAR (R.ID_BANCO) ID_BANCO, NVL (R.NO_CLIENTE ,'0') NO_CLIENTE,
                                                TO_CHAR (R.FORMA_PAGO) FORMA_PAGO, R.FECHA_APLICACION, TO_CHAR(TO_DATE(r.fecha_aplicacion,'DD-MM-YYYY'),'MONTH','NLS_DATE_LANGUAGE=SPANISH') mes
                                        , R.MONEDA, 'TC_ORIGINAL: ' || TO_CHAR (R.TC_ORIGINAL) TC_ORIGINAL, 'TC_FLUJO: ' || TO_CHAR (R.TC_FLUJO) TC_FLUJO, R.ORIGEN_MOVIMIENTO,
                                                R.DIVISION, R.AGRUPAMIENTO, R.RUBRO,R.CLA_FE_ID, R.CLA_FE_DES,
                                                TO_CHAR (R.NUMERO_DE_PARTIDA_SOIN) NUMERO_DE_PARTIDA_SOIN, R.CTAM01, R.CTAM02, R.CTAM03,
                                                R.IMPORTE_LINEA, R.ESTATUS, R.MET_CLASIFICACION,
                                                R.IMPORTE_LINEA * TC_ORIGINAL IMPORTE_LINEA_TC_O,
                                                R.IMPORTE_LINEA * TC_FLUJO IMPORTE_LINEA_TC_F,
                                                R.REFERENCIA, R.DESCRIPCION
                                        FROM    (
                                                    SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                            P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                            M.TIPO_CAMBIO TC_FLUJO,
                                                            'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                            NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                            NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                            NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                            P.CLA_FE_ID,
                                                            CF.CLA_FE_DES,
                                                            P.NUMERO_DE_PARTIDA_ERP as NUMERO_DE_PARTIDA_SOIN, P.ORA_SOIN_SEGMENTO1 AS CTAM01, P.ORA_SOIN_SEGMENTO2 AS CTAM02, P.ORA_SOIN_SEGMENTO3 AS CTAM03,
                                                            P.IMPORTE_LINEA,
                                                            'COINV EGR' ESTATUS, 'COINVERSION' MET_CLASIFICACION,
                                                            P.REFERENCIA, P.DESCRIPCION
                                                    FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                            FECXC.FECXP_DET_REALES_COINVERSION P,
                                                            FECXC.FECXP_MONEDAS M
                                                    WHERE    M.MON_SET = P.MONEDA
                                                    AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                    AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                    AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                    AND        P.ID_TIPO_MOVTO ='E'
                                                    UNION ALL
                                                    SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                            P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                            M.TIPO_CAMBIO TC_FLUJO,
                                                            'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                            NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                            NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                            NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                            P.CLA_FE_ID,
                                                            CF.CLA_FE_DES,
                                                            P.NUMERO_DE_PARTIDA_ERP as NUMERO_DE_PARTIDA_SOIN, P.ORA_SOIN_SEGMENTO1 AS CTAM01, P.ORA_SOIN_SEGMENTO2 AS CTAM02, P.ORA_SOIN_SEGMENTO3 AS CTAM03,
                                                            CASE P.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN P.IMPORTE ELSE P.IMPORTE_LINEA END,
                                                            'COINV ING' ESTATUS, 'COINVERSION' MET_CLASIFICACION,
                                                            P.REFERENCIA, P.DESCRIPCION
                                                    FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                            FECXC.FECXP_DET_REALES_COINVERSION P,
                                                            FECXC.FECXP_MONEDAS M
                                                    WHERE    M.MON_SET = P.MONEDA
                                                    AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                    AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                    AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                    AND        P.ID_TIPO_MOVTO ='I'
                                                    UNION ALL
                                                    SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                            P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                            M.TIPO_CAMBIO TC_FLUJO,
                                                            'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                            NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                            NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                            NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                            P.CLA_FE_ID,
                                                            CF.CLA_FE_DES,
                                                            P.NUMERO_DE_PARTIDA_ERP as NUMERO_DE_PARTIDA_SOIN, P.ORA_SOIN_SEGMENTO1 AS CTAM01, P.ORA_SOIN_SEGMENTO2 AS CTAM02, P.ORA_SOIN_SEGMENTO3 AS CTAM03,
                                                            P.IMPORTE_LINEA,
                                                            CASE P.ID_TIPO_MOVTO WHEN 'I' THEN 'INV ING' ELSE 'INV EGR' END ESTATUS, 'INVERSION' MET_CLASIFICACION,
                                                            P.REFERENCIA, P.DESCRIPCION
                                                    FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                            FECXC.FECXP_DET_REALES_INVERSION P,
                                                            FECXC.FECXP_MONEDAS M
                                                    WHERE    M.MON_SET = P.MONEDA
                                                    AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                    AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                    AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                    AND        P.ID_TIPO_MOVTO ='E'
                                                    UNION ALL
                                                    SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                            P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                            M.TIPO_CAMBIO TC_FLUJO,
                                                            'SET'AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                            NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                            NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                            NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                            P.CLA_FE_ID,
                                                            CF.CLA_FE_DES,
                                                            P.NUMERO_DE_PARTIDA_ERP as NUMERO_DE_PARTIDA_SOIN, P.ORA_SOIN_SEGMENTO1 AS CTAM01, P.ORA_SOIN_SEGMENTO2 AS CTAM02, P.ORA_SOIN_SEGMENTO3 AS CTAM03,
                                                            CASE P.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN P.IMPORTE ELSE P.IMPORTE_LINEA END,
                                                            CASE P.ID_TIPO_MOVTO WHEN 'I' THEN 'INV ING' ELSE 'INV EGR' END ESTATUS, 'INVERSION' MET_CLASIFICACION,
                                                            P.REFERENCIA, P.DESCRIPCION
                                                    FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                            FECXC.FECXP_DET_REALES_INVERSION P,
                                                            FECXC.FECXP_MONEDAS M
                                                    WHERE    M.MON_SET = P.MONEDA
                                                    AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                    AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                    AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                    AND        P.ID_TIPO_MOVTO ='I'
                                                ) R,
                                                FECXC.FECXC_EMP_X_SEGMENTO ES,
                                                FECXC.FECXC_SEGMENTOS_FLUJO SF,
                                                FECXC.FECXC_EMPRESAS E
                                        WHERE    ES.ID_SEGMENTO NOT IN (11, 15, 17, 18 , 20, 26, 6, 13, 25)
                                        AND        E.CUAL_ERP = 'S'
                                        AND        ES.E_CODIGO = R.E_CODIGO
                                        AND        E.E_CODIGO = R.E_CODIGO
                                        AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO) WHERE FOLIO_SET = V_FOLIO_SET AND ESTATUS_MOVIMIENTO = V_ESTATUS_MOVIMIENTO;
    --Termina
 --*******************CURSOR PARA PRESUPUESTO ORACLE *****************
CURSOR C_FOLIOS_ORACLE_PPTO(V_CODE_COMBINATION INTEGER, V_SCT VARCHAR2) IS SELECT DISTINCT
                           ID_SEGMENTO,DES_SEGMENTO,E_CODIGO,DES_EMPRESA,CLA_FE_ID,CLA_FE_DES,
                        DIVISION,AGRUPAMIENTO,RUBRO,LIBRO_ID,VERSION_ID,MONEDA,MES,MES_NUM,
                        CODE_COMBINATION,ORACLE_SEGMENTO1,ORACLE_SEGMENTO2,ORACLE_SEGMENTO3,
                        ORACLE_SEGMENTO4,ORACLE_SEGMENTO5,ORACLE_SEGMENTO6,ORACLE_SEGMENTO7,
                        TC_ORIGINAL_STR,TC_FLUJO_STR,PPTO_OPERATIVO_MO,PPTO_OPERATIVO_MF_ORIGINAL,
                        PPTO_OPERATIVO_MF_FLUJO,PPTO_FLUJO_MO,PPTO_FLUJO_MF_ORIGINAL,PPTO_FLUJO_MF_FLUJO,
                        PRESUPUESTO_ESTATUS,VERSION_EXTRAIDOS,VERSION_IMPORTADOS
    FROM(
       SELECT    SF.ID_SEGMENTO, SF.DES_SEGMENTO, P.E_CODIGO, P.DES_EMPRESA, P.CLA_FE_ID, P.CLA_FE_DES,
                P.DIVISION, P.AGRUPAMIENTO, P.RUBRO,TO_CHAR (P.LIBRO_ID) LIBRO_ID, TO_CHAR (P.VERSION_ID) VERSION_ID,
                P.MONEDA, P.MES, P.MES_NUM,    TO_CHAR (P.CODE_COMBINATION) CODE_COMBINATION,
                P.ORACLE_SEGMENTO1, P.ORACLE_SEGMENTO2, P.ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5,
                P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7,
                'TC ORIGINAL ' || P.MONEDA || ': ' || TO_CHAR (P.TC_ORIGINAL) TC_ORIGINAL_STR,
                'TC FLUJO ' || P.MONEDA || ': ' || TO_CHAR (P.TC_FLUJO) TC_FLUJO_STR,
                P.PPTO_OPERATIVO PPTO_OPERATIVO_MO,
                P.PPTO_OPERATIVO * P.TC_ORIGINAL PPTO_OPERATIVO_MF_ORIGINAL,
                P.PPTO_OPERATIVO * P.TC_FLUJO PPTO_OPERATIVO_MF_FLUJO,
                P.PPTO_FLUJO PPTO_FLUJO_MO,
                P.PPTO_FLUJO * P.TC_ORIGINAL PPTO_FLUJO_MF_ORIGINAL,
                P.PPTO_FLUJO * P.TC_FLUJO PPTO_FLUJO_MF_FLUJO,
                P.PRESUPUESTO_ESTATUS,
                P.VERSION_EXTRAIDOS, P.VERSION_IMPORTADOS
        FROM    (
                SELECT    PP.E_CODIGO, PP.VERSION_FE, PP.DES_EMPRESA, CF.CLA_FE_ID, CF.CLA_FE_DES,
                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,
                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                        PP.LIBRO_ID, PP.VERSION_ID, PP.MONEDA,
                        PP.MES,
                        PP.MES_NUM,
                        PP.CODE_COMBINATION,
                        PP.ORACLE_SEGMENTO1, PP.ORACLE_SEGMENTO2, PP.ORACLE_SEGMENTO3, PP.ORACLE_SEGMENTO4, PP.ORACLE_SEGMENTO5, PP.ORACLE_SEGMENTO6, PP.ORACLE_SEGMENTO7,
                        PP.PPTO_OPERATIVO * TO_NUMBER (CF.CLA_ATRIBUTO5) PPTO_OPERATIVO, PP.PPTO_FLUJO * TO_NUMBER (CF.CLA_ATRIBUTO5) PPTO_FLUJO, PP.TC_ORIGINAL, PP.TC_FLUJO, PP.PRESUPUESTO_ESTATUS,
                        PP.VERSION_EXTRAIDOS, NULL AS VERSION_IMPORTADOS
                FROM    (
                        SELECT    E.E_CODIGO, PO.VERSION_FE, E.DES_EMPRESA,
                                PC.LIBRO_ID, PC.VERSION_ID,
                                PC.MONEDA, TO_CHAR (TO_DATE (PO.MES, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') AS MES,
                                PO.MES MES_NUM,
                                PC.CODE_COMBINATION,
                                PC.ORACLE_SEGMENTO1, PC.ORACLE_SEGMENTO2, PC.ORACLE_SEGMENTO3, PC.ORACLE_SEGMENTO4, PC.ORACLE_SEGMENTO5, PC.ORACLE_SEGMENTO6, PC.ORACLE_SEGMENTO7,
                                PO.PPTO PPTO_OPERATIVO, PC.IMPORTE_LINEA PPTO_FLUJO, PC.TIPO_CAMBIO TC_ORIGINAL, M.TIPO_CAMBIO TC_FLUJO, PC.PRESUPUESTO_ESTATUS,
                                PO.VERSION_FE  AS VERSION_EXTRAIDOS
                        FROM    (
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 1 MES, PPTO_01 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 2 MES, PPTO_02 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 3 MES, PPTO_03 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 4 MES, PPTO_04 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 5 MES, PPTO_05 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 6 MES, PPTO_06 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 7 MES, PPTO_07 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 8 MES, PPTO_08 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 9 MES, PPTO_09 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 10 MES, PPTO_10 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 11 MES, PPTO_11 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 12 MES, PPTO_12 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                ) PO,
                                FECXC.FECXP_PPTO_CONVERSION_ERP PC,
                                FECXC_EMPRESAS E,
                                FECXC.FECXP_MONEDAS M
                        WHERE    PO.E_CODIGO = PC.E_CODIGO
                        AND        PO.VERSION_FE = PC.VERSION_FE
                        AND        PO.PERIODO_PPTO = PC.PERIODO
                        AND        PO.LIBRO_ID = PC.LIBRO_ID
                        AND        PO.VERSION_ID = PC.VERSION_ID
                        AND        PO.MONEDA = PC.MONEDA
                        AND        PO.CODE_COMBINATION_ID = PC.CODE_COMBINATION
                        AND        PO.MES = PC.MES
                        AND        E.E_CODIGO = PO.E_CODIGO
                        AND        M.MON_ORACLE = PO.MONEDA
                        AND        M.PERIODO = PO.PERIODO_PPTO
                        AND        M.MES = PO.MES
                        ) PP,
                        FECXC.FECXP_REP_PPTO_COM_CTA_ERP C,
                        FECXC.FECXP_CLASIFICACION_FE CF
                WHERE    C.CLA_FE_ID = CF.CLA_FE_ID
                AND        C.CODE_COMBINATION_ID = PP.CODE_COMBINATION
                AND                    C.E_CODIGO=PP.E_CODIGO
                -- AND        P.CODE_COMBINATION = 580865
                UNION ALL
                SELECT    E.E_CODIGO, TO_NUMBER (ATRIBUTO_3), E.DES_EMPRESA, C.CLA_FE_ID, C.CLA_FE_DES,
                        NVL(C.CLA_ATRIBUTO6,'') DIVISION,
                        NVL(C.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                        NVL(C.CLA_ATRIBUTO2,'') RUBRO,
                        0 LIBRO_ID, 0 VERSION_ID, H.MONEDA_IMP MONEDA,
                        TO_CHAR (TO_DATE (H.MES, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') AS MES,
                        H.MES MES_NUM,
                        0,
                        E.E_CODIGO_SOIN ORACLE_SEGMENTO1, 'X' ORACLE_SEGMENTO2, 'X' ORACLE_SEGMENTO3, 'X' ORACLE_SEGMENTO4, 'X' ORACLE_SEGMENTO5, H.ATRIBUTO_2 ORACLE_SEGMENTO6, 'X' ORACLE_SEGMENTO7,
                        0 PPTO_OPERATIVO, SUM (H.IMPORTE_LINEA * TO_NUMBER (C.CLA_ATRIBUTO5)) PPTO_FLUJO,
                        M.TIPO_CAMBIO, M.TIPO_CAMBIO, 'IMPORTADO',
                        NULL AS VERSION_EXTRAIDOS, H.ATRIBUTO_3 AS VERSION_IMPORTADOS
                FROM    FECXC.FECXP_IMPORTACION_DATOS_HIST H,
                        FECXC_EMPRESAS E,
                        FECXC.FECXP_CLASIFICACION_FE C,
                        FECXC.FECXP_MONEDAS M
                WHERE    H.TIPO_IMPORTACION = 'P'
                AND        E.E_CODIGO = H.E_EMPRESA_IMP
                AND        E.CUAL_ERP = 'O'
                AND        M.MON_ORACLE = H.MONEDA_IMP
                AND        M.MES = H.MES
                AND        M.PERIODO = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'))
                AND        C.CLA_FE_ID = H.CLA_FE_ID_IMP
                -- AND        E.E_CODIGO = 19
                -- AND        C.CLA_FE_ID = 'A6'
                GROUP BY E.E_CODIGO, TO_NUMBER (ATRIBUTO_3), E.DES_EMPRESA, C.CLA_FE_ID, C.CLA_FE_DES,
                        NVL(C.CLA_ATRIBUTO6,''),
                        NVL(C.CLA_ATRIBUTO4,''),
                        NVL(C.CLA_ATRIBUTO2,''),
                        TO_CHAR (TO_DATE (H.MES, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH'),
                        H.MES,
                        E.E_CODIGO_SOIN,
                        H.ATRIBUTO_2,
                        H.MONEDA_IMP, M.TIPO_CAMBIO, H.ATRIBUTO_3
                ) P,
                FECXC.FECXC_EMP_X_SEGMENTO ES,
                FECXC.FECXC_SEGMENTOS_FLUJO SF
        WHERE    ES.ID_SEGMENTO NOT IN (11, 15,  17, 18, 20,  26, 6, 13, 25)
        AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO
        AND        ES.E_CODIGO = P.E_CODIGO) WHERE CODE_COMBINATION = V_CODE_COMBINATION AND SCT = V_SCT ;
    --Termina
    --********* CURSOR PARA PPTO SOIN ********
    CURSOR C_FOLIOS_SOIN_PPTO(V_DIVISION VARCHAR2,V_AGRUPAMIENTO VARCHAR2,V_RUBRO VARCHAR2,V_E_EMPRESA_DES VARCHAR2,V_MONEDA_IMP VARCHAR2,V_CIA VARCHAR2,V_NEG VARCHAR2,V_CTA VARCHAR2, V_SCT VARCHAR2)
    IS SELECT DISTINCT
                                        ID_SEGMENTO,DES_SEGMENTO,E_CODIGO,DES_EMPRESA,
                                        CLA_FE_ID,CLA_FE_DES,DIVISION,AGRUPAMIENTO,RUBRO,
                                        ARSMAP,AEJMAP,CNCMAP,CTACR1,CTACR2,MES,MONEDA,
                                        TC_ORIGINAL_STR,TC_FLUJO_STR,PPTO_OPERATIVO_MO,
                                        PPTO_OPERATIVO_MF_ORIGINAL,PPTO_OPERATIVO_MF_FLUJO,
                                        PPTO_FLUJO_MO,PPTO_FLUJO_MF_ORIGINAL,PPTO_FLUJO_MF_FLUJO,
                                        PRESUPUESTO_ESTATUS,VERSION_IMPORTADOS,VERSION_EXTRAIDOS
    FROM(
    SELECT    SF.ID_SEGMENTO, SF.DES_SEGMENTO, P.E_CODIGO, P.DES_EMPRESA, P.CLA_FE_ID, P.CLA_FE_DES,
        P.DIVISION, P.AGRUPAMIENTO, P.RUBRO,
        P.ARSMAP, P.AEJMAP, P.CNCMAP, P.CTACR1, P.CTACR2, P.MES, P.MONEDA, 'TC ORIGINAL ' || P.MONEDA || ':' || TO_CHAR (P.TC_ORIGINAL) TC_ORIGINAL_STR, 'TC FLUJO ' || P.MONEDA || ':' || TO_CHAR (P.TC_FLUJO) TC_FLUJO_STR,
        P.PPTO_OPERATIVO * 1.0 PPTO_OPERATIVO_MO,
        P.PPTO_OPERATIVO * P.TC_ORIGINAL PPTO_OPERATIVO_MF_ORIGINAL,
        P.PPTO_OPERATIVO * P.TC_FLUJO PPTO_OPERATIVO_MF_FLUJO,
        P.PPTO_FLUJO * 1.0 PPTO_FLUJO_MO,
        P.PPTO_FLUJO * P.TC_ORIGINAL PPTO_FLUJO_MF_ORIGINAL,
        P.PPTO_FLUJO * P.TC_FLUJO PPTO_FLUJO_MF_FLUJO,
        P.PRESUPUESTO_ESTATUS,
        P.VERSION_IMPORTADOS, P.VERSION_EXTRAIDOS
FROM    (
        SELECT    PP.E_CODIGO, PP.DES_EMPRESA, CF.CLA_FE_ID, CF.CLA_FE_DES,
                NVL(CF.CLA_ATRIBUTO6,'') DIVISION,
                NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                PP.ARSMAP, PP.AEJMAP, PP.CNCMAP, PP.CTACR1, PP.CTACR2, PP.MES, PP.MON_ORACLE MONEDA,
                PP.PPTO_OPERATIVO * TO_NUMBER (CF.CLA_ATRIBUTO5) PPTO_OPERATIVO, PP.PPTO_FLUJO * TO_NUMBER (CF.CLA_ATRIBUTO5) PPTO_FLUJO,
                PP.TC_ORIGINAL, PP.TC_FLUJO,
                PP.PRESUPUESTO_ESTATUS,
                PP.VERSION_IMPORTADOS, PP.VERSION_EXTRAIDOS
        FROM    (
                SELECT    E.E_CODIGO, E.DES_EMPRESA, PO.ARSMAP, PO.AEJMAP, PO.CNCMAP, PO.CTACR1, PO.CTACR2,
                        TO_CHAR (TO_DATE (PO.MESCOD, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') AS MES,
                        M.MON_ORACLE, PO.IMPORTE_LINEA PPTO_OPERATIVO, PC.IMPORTE_LINEA PPTO_FLUJO,
                        PO.TIPO_CAMBIO TC_ORIGINAL, M.TIPO_CAMBIO TC_FLUJO, PC.PRESUPUESTO_ESTATUS,
                        NULL AS VERSION_IMPORTADOS, PC.VERSION_FE AS VERSION_EXTRAIDOS
                FROM    FECXC.FECXC_EMPRESAS E,
                        FECXC.FECXP_PPTO_CONVERSION_SOIN PC,
                        FECXC.FECXP_PPTO_OPERATIVO_SOIN PO,
                        FECXC.FECXP_MONEDAS M
                WHERE    E.E_CODIGO = PO.E_CODIGO
                AND        PO.E_CODIGO = PC.E_CODIGO
                AND        PO.PERIODO  = PC.PERIODO
                AND     PO.MONEDA = PC.MONEDA
                AND        PO.MESCOD = PC.MESCOD
                AND        PO.ARSMAP = PC.ARSMAP
                AND        PO.AEJMAP = PC.AEJMAP
                AND        PO.CNCMAP = PC.CNCMAP
                AND        PO.CTACR1 = PC.CTACR1
                AND        PO.CTACR2 = PC.CTACR2
                AND        PO.VERSION_FE = PC.VERSION_FE
                AND        M.MON_SYBASE = PO.MONEDA
                AND        M.PERIODO = PO.PERIODO
                AND        M.MES = PO.MESCOD
                ) PP,
                FECXP_CLASIFICACION_FE CF, -- 10366
                FECXP_CTAS_SOIN_CARATULA C -- 10366
        WHERE    CF.CLA_FE_ID = C.CLA_FE_ID
        AND        PP.E_CODIGO = C.E_CODIGO
        AND        PP.E_CODIGO = C.E_CODIGO
        AND        PP.ARSMAP = C.CTAM01
        AND        PP.AEJMAP = C.CTAM02
        AND        PP.CNCMAP = C.CTAM03
        AND        PP.CTACR1 = C.CTACR1
        AND        PP.CTACR2 = C.CTACR2
        UNION ALL
        SELECT    E.E_CODIGO, E.DES_EMPRESA, C.CLA_FE_ID, C.CLA_FE_DES,
                NVL(C.CLA_ATRIBUTO6,'') DIVISION,
                NVL(C.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                NVL(C.CLA_ATRIBUTO2,'') RUBRO,
                'X' ARSMAP, 'X' AEJMAP, 'X' CNCMAP, 'X' CTACR1, H.ATRIBUTO_2 CTACR2,
                TO_CHAR (TO_DATE (H.MES, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') AS MES,
                H.MONEDA_IMP, 0 PPTO_OPERATIVO  , H.IMPORTE_LINEA * TO_NUMBER (CFU.CLA_ATRIBUTO5)  PPTO_FLUJO ,
                M.TIPO_CAMBIO TC_ORIGINAL, M.TIPO_CAMBIO TC_FLUJO, 'IMPORTADO',
                H.ATRIBUTO_3 AS VERSION_IMPORTADOS, NULL AS VERSION_EXTRAIDOS
        FROM    FECXC.FECXP_IMPORTACION_DATOS_HIST H,
                FECXC.FECXC_EMPRESAS E,
                FECXC.FECXP_CLASIFICACION_FE C,
                FECXC.FECXP_MONEDAS M,
                FECXP_CLASIFICACION_FE CFU
        WHERE    H.TIPO_IMPORTACION = 'P'
        AND        E.CUAL_ERP = 'S'
        AND        E.E_CODIGO = H.E_EMPRESA_IMP
        AND        C.CLA_FE_ID = H.CLA_FE_ID_IMP
        AND        M.MON_ORACLE = H.MONEDA_IMP
        AND        M.MES = H.MES
        AND        M.PERIODO = TO_NUMBER (TO_CHAR (H.FECHA, 'YYYY'))
        AND                         CFU.CLA_FE_ID=H.CLA_FE_ID_IMP
        ) P,
        FECXC.FECXC_EMP_X_SEGMENTO ES,
        FECXC.FECXC_SEGMENTOS_FLUJO SF
WHERE    ES.ID_SEGMENTO NOT IN (11,15, 17, 18, 20, 26, 6, 13, 25)
AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO
AND        ES.E_CODIGO = P.E_CODIGO) WHERE DIVISION  = V_DIVISION
                                  AND AGRUPAMIENTO = V_AGRUPAMIENTO
                                  AND RUBRO = V_RUBRO
                                  AND DES_EMPRESA = V_E_EMPRESA_DES
                                  AND MONEDA = V_MONEDA_IMP
                                  AND ARSMAP = V_CTA
                                  AND AEJMAP = V_SCT
                                  AND CNCMAP = V_CC
                                  AND CTACR1 = V_ICIA   ;
BEGIN
IF TIPO_IMPORTACION = 'R' THEN
 SELECT DIVISION,AGRUPAMIENTO,RUBRO,CLA_FE_ID_IMP,CLA_FE_DES,E_EMPRESA_IMP,E_EMPRESA_DES,FOLIO_SET,NO_CLIENTE,REFERENCIA,DESCRIPCION,TIPO_OPERACION,
               ID_BANCO,FORMA_PAGO,ID_CHEQUERA,ESTATUS_MOVIMIENTO,BENEFICIARIO,CONCEPTO,ORIGEN_MOVIMIENTO,NUMERO_DE_PARTIDA,CIA,NEG,CTA,SCT,CC,ICIA,
               TOP,ESTATUS,FECHA_APLICACION,MONEDA_IMP,IMPORTE_LINEA
          INTO V_DIVISION,V_AGRUPAMIENTO,V_RUBRO,V_CLA_FE_ID,V_CLA_FE_DES,V_E_CODIGO,V_E_EMPRESA_DES,V_FOLIO_SET,V_NO_CLIENTE,V_REFERENCIA,V_DESCRIPCION,V_TIPO_OPERACION,
               V_ID_BANCO,V_FORMA_PAGO,V_ID_CHEQUERA, V_ESTATUS_MOVIMIENTO,V_BENEFICIARIO,V_CONCEPTO,V_ORIGEN_MOVIMIENTO,V_NUMERO_DE_PARTIDA,V_CIA,
               V_NEG,V_CTA,V_SCT,V_CC,V_ICIA,V_TOP,V_ESTATUS,V_FECHA_APLICACION,V_MONEDA_IMP,V_IMPORTE_LINEA
               FROM  FECXP_IMPORTACION_DATOS WHERE FOLIO_SET=FOLIO_SET
                                             AND ATRIBUTO_1 = V_ID_SESION;
  FOR I IN C_FOLIOS_ORACLE_REAL(FOLIO_SET,NUMERO_DE_PARTIDA,E_CODIGO ) LOOP
             IF (V_DIVISION=I.DIVISION) OR (V_DIVISION  IS NULL AND I.DIVISION IS NULL) THEN
                IF (V_AGRUPAMIENTO = I.AGRUPAMIENTO) OR (V_AGRUPAMIENTO IS NULL AND I.AGRUPAMIENTO  IS NULL)       THEN
                   IF (V_RUBRO = I.RUBRO)  OR (V_RUBRO IS NULL AND I.RUBRO IS NULL)              THEN
                          IF (V_E_EMPRESA_DES=I.DES_EMPRESA) OR (V_E_EMPRESA_DES IS NULL AND I.DES_EMPRESA IS NULL)  THEN
                               IF (V_NO_CLIENTE=I.NO_CLIENTE) OR (V_NO_CLIENTE IS NULL AND I.NO_CLIENTE IS NULL)  THEN
                                 IF (V_REFERENCIA=I.REFERENCIA) OR (V_REFERENCIA IS NULL AND I.REFERENCIA IS NULL) THEN
                                   IF (V_DESCRIPCION=I.DESCRIPCION) OR (V_DESCRIPCION IS NULL AND I.DESCRIPCION IS NULL) THEN
                                     IF (V_TIPO_OPERACION =I.TIPO_OPERACION) OR (V_TIPO_OPERACION IS NULL AND I.TIPO_OPERACION IS NULL) THEN
                                       IF (V_ID_BANCO=I.ID_BANCO) OR (V_ID_BANCO  IS NULL AND I.ID_BANCO IS NULL) THEN
                                         IF (V_FORMA_PAGO=I.FORMA_PAGO) OR (V_FORMA_PAGO IS NULL AND I.FORMA_PAGO IS NULL) THEN
                                           IF (V_ID_CHEQUERA=I.ID_CHEQUERA) OR (V_ID_CHEQUERA IS NULL AND I.ID_CHEQUERA IS NULL) THEN
                                             IF (V_ESTATUS_MOVIMIENTO =I.ESTATUS_MOVIMIENTO) OR (V_ESTATUS_MOVIMIENTO IS NULL AND I.ESTATUS_MOVIMIENTO IS NULL) THEN
                                               IF (V_BENEFICIARIO =I.BENEFICIARIO) OR (V_BENEFICIARIO IS NULL AND I.BENEFICIARIO IS NULL) THEN
                                                 IF (V_CONCEPTO =I.CONCEPTO) OR (V_CONCEPTO IS NULL AND I.CONCEPTO IS NULL) THEN
                                                    IF (V_ORIGEN_MOVIMIENTO = I.ORIGEN_MOVIMIENTO) OR(V_ORIGEN_MOVIMIENTO IS NULL AND I.ORIGEN_MOVIMIENTO IS NULL)THEN
                                                       IF (V_NUMERO_DE_PARTIDA = I.NUMERO_DE_PARTIDA) OR (V_NUMERO_DE_PARTIDA IS NULL AND I.NUMERO_DE_PARTIDA IS NULL) THEN
                                                          IF (V_CIA=I.ORACLE_SEGMENTO1) OR (V_CIA IS NULL AND I.ORACLE_SEGMENTO1 IS NULL) THEN
                                                             IF (V_NEG = I.ORACLE_SEGMENTO2) OR (V_NEG IS NULL AND I.ORACLE_SEGMENTO2 IS NULL) THEN
                                                                IF (V_CTA= I.ORACLE_SEGMENTO3) OR (V_CTA IS NULL AND I.ORACLE_SEGMENTO3 IS NULL) THEN
                                                                   IF (V_SCT =I.ORACLE_SEGMENTO4) OR (V_SCT IS NULL AND I.ORACLE_SEGMENTO4 IS NULL) THEN
                                                                     IF (V_CC = I.ORACLE_SEGMENTO5) OR (V_CC IS NULL AND I.ORACLE_SEGMENTO5 IS NULL) THEN
                                                                        IF (V_ICIA = I.ORACLE_SEGMENTO6) OR (V_ICIA IS NULL AND I.ORACLE_SEGMENTO6 IS NULL) THEN
                                                                            IF (V_TOP = I.ORACLE_SEGMENTO7) OR (V_TOP IS NULL AND I.ORACLE_SEGMENTO7 IS NULL) THEN
                                                                               IF (V_ESTATUS = I.ESTATUS) OR (V_ESTATUS IS NULL AND I.ESTATUS IS NULL) THEN
                                                                                  IF (V_FECHA_APLICACION =I.FECHA_APLICACION) OR (V_FECHA_APLICACION IS NULL AND I.FECHA_APLICACION IS NULL) THEN
                                                                                    IF (V_MONEDA_IMP =I.MONEDA) OR (V_MONEDA_IMP IS NULL AND I.MONEDA IS NULL) THEN
                                                                                        NULL;
                                                                                    ELSE
                                                                                         V_MENSAJE := 'LA MONEDA=' ||V_MONEDA_IMP|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.MONEDA;
                                                                                    END IF;
                                                                                  ELSE
                                                                                         V_MENSAJE := 'LA FECHA='||V_FECHA_APLICACION|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.FECHA_APLICACION;
                                                                                  END IF;
                                                                               ELSE
                                                                                   V_MENSAJE := 'EL ESTATUS='||V_ESTATUS|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ESTATUS;
                                                                               END IF;
                                                                            ELSE
                                                                               V_MENSAJE := 'EL TOP='||V_TOP||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO7;
                                                                            END IF;
                                                                        ELSE
                                                                           V_MENSAJE := 'LA ICIA='||V_ICIA|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO6;
                                                                        END IF;
                                                                     ELSE
                                                                       V_MENSAJE := 'EL CC='||V_CC||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO5;
                                                                     END IF;
                                                                   ELSE
                                                                      V_MENSAJE := 'LA SCT='||V_SCT||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO4;
                                                                   END IF;
                                                                 ELSE
                                                                    V_MENSAJE := 'LA CTA='||V_CTA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO3;
                                                                 END IF;
                                                               ELSE
                                                                  V_MENSAJE := 'LA NEG='||V_NEG||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO2;
                                                               END IF;
                                                             ELSE
                                                                V_MENSAJE := 'LA CIA='||V_CIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO1;
                                                             END IF;
                                                           ELSE
                                                              V_MENSAJE := 'EL NO DE PARTIDA='||V_NUMERO_DE_PARTIDA|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.NUMERO_DE_PARTIDA;
                                                           END IF;
                                                         ELSE
                                                            V_MENSAJE := 'EL ORIGEN DEL MOVIMIENTO='||V_ORIGEN_MOVIMIENTO|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORIGEN_MOVIMIENTO;
                                                         END IF;
                                                       ELSE
                                                          V_MENSAJE := 'EL CONCEPTO='||V_CONCEPTO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CONCEPTO;
                                                       END IF;
                                                     ELSE
                                                        V_MENSAJE := 'EL BENEFICIARIO='||V_BENEFICIARIO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.BENEFICIARIO;
                                                     END IF;
                                                   ELSE
                                                      V_MENSAJE := 'EL ESTATUS='||V_ESTATUS_MOVIMIENTO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ESTATUS_MOVIMIENTO;
                                                   END IF;
                                                 ELSE
                                                     V_MENSAJE := 'EL ID_CHEQUERA='||V_ID_CHEQUERA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ID_CHEQUERA;
                                                 END IF;
                                               ELSE
                                                     V_MENSAJE := 'EL FORMA PAGO='||V_FORMA_PAGO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.FORMA_PAGO;
                                               END IF;
                                             ELSE
                                                 V_MENSAJE := 'EL ID_BANCO='||V_ID_BANCO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ID_BANCO;
                                             END IF;
                                           ELSE
                                               V_MENSAJE := 'EL TIPO DE OPERACION ='||V_TIPO_OPERACION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.TIPO_OPERACION;
                                           END IF;
                                         ELSE
                                             V_MENSAJE := 'LA DESCRIPCION='||V_DESCRIPCION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DESCRIPCION;
                                         END IF;
                                       ELSE
                                          V_MENSAJE := 'LA REFERENCIA='||V_REFERENCIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.REFERENCIA;
                                       END IF;
                                  ELSE
                                        V_MENSAJE := 'EL NO DE CLIENTE='||V_NO_CLIENTE||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.NO_CLIENTE;
                                  END IF;
                                ELSE
                                    V_MENSAJE := 'LA EMPRESA='||V_E_EMPRESA_DES||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DES_EMPRESA;
                                END IF;
                           ELSE
                              V_MENSAJE := 'EL RUBRO='||V_RUBRO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.RUBRO;
                           END IF;
                    ELSE
                       V_MENSAJE := 'EL AGRUPAMIENTO= '||V_AGRUPAMIENTO||' NO CORRESPONDE CON LA LINEA ORIGINAL= '||I.AGRUPAMIENTO;
                    END IF;
                 ELSE
                    V_MENSAJE := 'LA DIVISION='||V_DIVISION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DIVISION;
                 END IF;
  END LOOP;
  FOR I IN C_FOLIOS_SOIN_REAL(FOLIO_SET,ESTATUS_MOVIMIENTO ) LOOP
             IF (V_DIVISION=I.DIVISION) OR (V_DIVISION  IS NULL AND I.DIVISION IS NULL) THEN
                IF (V_AGRUPAMIENTO = I.AGRUPAMIENTO) OR(V_AGRUPAMIENTO  IS NULL AND I.AGRUPAMIENTO IS NULL)THEN
                   IF (V_RUBRO = I.RUBRO) OR(V_RUBRO   IS NULL AND I.RUBRO IS NULL) THEN
                          IF (V_E_CODIGO =I.E_CODIGO) OR(V_E_CODIGO  IS NULL AND I.E_CODIGO IS NULL)  THEN
                               IF (V_E_EMPRESA_DES=I.DES_EMPRESA) OR(V_E_EMPRESA_DES  IS NULL AND I.DES_EMPRESA IS NULL)  THEN
                                  IF (V_NO_CLIENTE=I.NO_CLIENTE) OR(V_NO_CLIENTE  IS NULL AND I.NO_CLIENTE IS NULL) THEN
                                     IF (V_REFERENCIA =I.REFERENCIA) OR(V_REFERENCIA  IS NULL AND I.REFERENCIA IS NULL) THEN
                                       IF (V_DESCRIPCION=I.DESCRIPCION) OR(V_DESCRIPCION  IS NULL AND I.DESCRIPCION IS NULL) THEN
                                         IF (V_TIPO_OPERACION=I.TIPO_OPERACION) OR(V_TIPO_OPERACION  IS NULL AND I.TIPO_OPERACION IS NULL) THEN
                                           IF (V_ID_BANCO=I.ID_BANCO) OR(V_ID_BANCO  IS NULL AND I.ID_BANCO IS NULL) THEN
                                             IF (V_FORMA_PAGO =I.FORMA_PAGO) OR(V_FORMA_PAGO  IS NULL AND I.FORMA_PAGO IS NULL) THEN
                                               IF (V_ID_CHEQUERA =I.ID_CHEQUERA) OR(V_ID_CHEQUERA  IS NULL AND I.ID_CHEQUERA IS NULL) THEN
                                                 IF (V_ESTATUS_MOVIMIENTO =I.ESTATUS_MOVIMIENTO) OR(V_ESTATUS_MOVIMIENTO  IS NULL AND I.ESTATUS_MOVIMIENTO IS NULL) THEN
                                                   IF (V_ORIGEN_MOVIMIENTO = I.ORIGEN_MOVIMIENTO) OR(V_ORIGEN_MOVIMIENTO IS NULL AND I.ORIGEN_MOVIMIENTO IS NULL)THEN
                                                     IF (V_BENEFICIARIO = I.BENEFICIARIO) OR(V_BENEFICIARIO  IS NULL AND I.BENEFICIARIO IS NULL) THEN
                                                        IF (V_CONCEPTO = I.CONCEPTO) OR(V_CONCEPTO  IS NULL AND I.CONCEPTO IS NULL) THEN
                                                          IF (V_NUMERO_DE_PARTIDA = I.NUMERO_DE_PARTIDA_SOIN) OR(V_NUMERO_DE_PARTIDA  IS NULL AND I.NUMERO_DE_PARTIDA_SOIN IS NULL) THEN
                                                              IF (V_CTA= I.CTAM01) OR(V_CTA  IS NULL AND I.CTAM01 IS NULL) THEN
                                                                IF (V_SCT =I.CTAM02) OR(V_SCT  IS NULL AND I.CTAM02 IS NULL) THEN
                                                                   IF (V_CC = I.CTAM03) OR(V_CC  IS NULL AND I.CTAM03 IS NULL) THEN
                                                                      IF (V_ESTATUS = I.ESTATUS) OR(V_ESTATUS  IS NULL AND I.ESTATUS IS NULL) THEN
                                                                         IF (V_FECHA_APLICACION = I.FECHA_APLICACION) OR(V_FECHA_APLICACION  IS NULL AND I.FECHA_APLICACION IS NULL) THEN
                                                                             IF (V_MONEDA_IMP = I.MONEDA) OR(V_MONEDA_IMP  IS NULL AND  I.MONEDA IS NULL) THEN
                                                                                IF (V_IMPORTE_LINEA =I.IMPORTE_LINEA_TC_O) OR(V_IMPORTE_LINEA  IS NULL AND I.IMPORTE_LINEA_TC_O IS NULL) THEN
                                                                                   NULL;
                                                                                ELSE
                                                                                         V_MENSAJE := 'EL IMPORTE='||V_IMPORTE_LINEA|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.IMPORTE_LINEA_TC_O;
                                                                                  END IF;
                                                                               ELSE
                                                                                   V_MENSAJE := 'LA MONEDA='||V_MONEDA_IMP|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.MONEDA;
                                                                               END IF;
                                                                            ELSE
                                                                               V_MENSAJE :=  'LA FECHA='||V_FECHA_APLICACION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.FECHA_APLICACION;
                                                                            END IF;
                                                                        ELSE
                                                                           V_MENSAJE :=   'EL ESTATUS='||V_ESTATUS||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ESTATUS;
                                                                        END IF;
                                                                     ELSE
                                                                       V_MENSAJE :=  'EL CC='||V_CC|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CTAM03;
                                                                     END IF;
                                                                   ELSE
                                                                      V_MENSAJE :=  'LA SCT='||V_SCT||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CTAM02;
                                                                   END IF;
                                                                 ELSE
                                                                    V_MENSAJE :=  'LA CTA='||V_CTA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CTAM01;
                                                                 END IF;
                                                               ELSE
                                                                  V_MENSAJE :=  'EL NO DE PARTIDA='||V_NUMERO_DE_PARTIDA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.NUMERO_DE_PARTIDA_SOIN;
                                                               END IF;
                                                             ELSE
                                                                V_MENSAJE :=  'EL CONCEPTO='||V_CONCEPTO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CONCEPTO;
                                                             END IF;
                                                           ELSE
                                                              V_MENSAJE :=  'EL BENEFICIARIO='||V_BENEFICIARIO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.BENEFICIARIO;
                                                           END IF;
                                                         ELSE
                                                            V_MENSAJE :=  'EL ORIGEN DEL MOVIMIENTO='||V_ORIGEN_MOVIMIENTO|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORIGEN_MOVIMIENTO;
                                                         END IF;
                                                       ELSE
                                                          V_MENSAJE :=  'EL ESTATUS DE MOVIMIENTO ='||V_ESTATUS_MOVIMIENTO|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ESTATUS_MOVIMIENTO;
                                                       END IF;
                                                     ELSE
                                                        V_MENSAJE :=  'EL ID DE CHEQUERA='||V_ID_CHEQUERA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ID_CHEQUERA;
                                                     END IF;
                                                   ELSE
                                                      V_MENSAJE := 'LA FORMA PAGO='||V_FORMA_PAGO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.FORMA_PAGO;
                                                   END IF;
                                                 ELSE
                                                     V_MENSAJE :=  'EL ID BANCO='||V_ID_BANCO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ID_BANCO;
                                                 END IF;
                                               ELSE
                                                     V_MENSAJE :=  'EL TIPO DE OPERACION='||V_TIPO_OPERACION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.TIPO_OPERACION;
                                               END IF;
                                             ELSE
                                                 V_MENSAJE := 'LA DESCRIPCION='||V_DESCRIPCION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DESCRIPCION;
                                             END IF;
                                           ELSE
                                               V_MENSAJE := 'LA REFERENCIA='||V_REFERENCIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.REFERENCIA;
                                           END IF;
                                         ELSE
                                             V_MENSAJE := 'EL NO DE CLIENTE ='||V_NO_CLIENTE||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.NO_CLIENTE;
                                         END IF;
                                       ELSE
                                        V_MENSAJE := 'LA EMPRESA='||V_E_EMPRESA_DES||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DES_EMPRESA;
                                  END IF;
                                ELSE
                                    V_MENSAJE := 'EL CODIGO='||V_E_CODIGO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.E_CODIGO;
                                END IF;
                           ELSE
                              V_MENSAJE :=  'EL RUBRO='||V_RUBRO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.RUBRO;
                           END IF;
                    ELSE
                       V_MENSAJE := 'EL AGRUPAMIENTO='||V_AGRUPAMIENTO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.AGRUPAMIENTO;
                    END IF;
                 ELSE
                    V_MENSAJE := 'LA DIVISION='||V_DIVISION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DIVISION;
                 END IF;
  END LOOP;
END IF;
IF TIPO_IMPORTACION = 'P' THEN
  FOR I IN C_FOLIOS_ORACLE_PPTO(CODE_COMBINATION,SCT ) LOOP
             IF (V_DIVISION=I.DIVISION) OR (V_DIVISION  IS NULL AND I.DIVISION IS NULL) THEN
                IF (V_AGRUPAMIENTO = I.AGRUPAMIENTO) OR(V_AGRUPAMIENTO IS NULL AND I.AGRUPAMIENTO IS NULL) THEN
                   IF (V_RUBRO = I.RUBRO)OR(V_RUBRO IS NULL AND I.RUBRO IS NULL) THEN
                          IF (V_E_EMPRESA_DES=I.DES_EMPRESA)OR(V_E_EMPRESA_DES IS NULL AND I.DES_EMPRESA IS NULL)  THEN
                               IF (V_MONEDA_IMP=I.MONEDA)OR(V_MONEDA_IMP IS NULL AND I.MONEDA IS NULL)  THEN
                                 IF (V_CODE_COMBINATION=I.CODE_COMBINATION)OR(V_CODE_COMBINATION IS NULL AND I.CODE_COMBINATION IS NULL) THEN
                                   IF (V_DESCRIPCION=I.ORACLE_SEGMENTO1)OR(V_DESCRIPCION IS NULL AND I.ORACLE_SEGMENTO1 IS NULL) THEN
                                     IF (V_TIPO_OPERACION =I.ORACLE_SEGMENTO2)OR(V_TIPO_OPERACION IS NULL AND I.ORACLE_SEGMENTO2 IS NULL) THEN
                                       IF (V_ID_BANCO=I.ORACLE_SEGMENTO3)OR(V_ID_BANCO IS NULL AND I.ORACLE_SEGMENTO3 IS NULL) THEN
                                         IF (V_FORMA_PAGO=I.ORACLE_SEGMENTO4)OR(V_FORMA_PAGO IS NULL AND I.ORACLE_SEGMENTO4 IS NULL) THEN
                                           IF (V_ID_CHEQUERA=I.ORACLE_SEGMENTO5)OR(V_ID_CHEQUERA IS NULL AND I.ORACLE_SEGMENTO5 IS NULL) THEN
                                             IF (V_ESTATUS_MOVIMIENTO =I.ORACLE_SEGMENTO6)OR(V_ESTATUS_MOVIMIENTO IS NULL AND I.ORACLE_SEGMENTO6 IS NULL) THEN
                                               IF (V_BENEFICIARIO =I.ORACLE_SEGMENTO7)OR(V_BENEFICIARIO IS NULL AND I.ORACLE_SEGMENTO7 IS NULL) THEN
                                                 IF (V_CONCEPTO =I.VERSION_IMPORTADOS)OR(V_CONCEPTO IS NULL AND I.VERSION_IMPORTADOS IS NULL) THEN
                                                       NULL;
                                                      ELSE
                                                          V_MENSAJE := 'EL ATRIBUTO 3='||V_CONCEPTO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.VERSION_IMPORTADOS;
                                                       END IF;
                                                     ELSE
                                                        V_MENSAJE := 'EL TOP='||V_TOP||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO7;
                                                     END IF;
                                                   ELSE
                                                      V_MENSAJE := 'LA ICIA='||V_ICIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO6;
                                                   END IF;
                                                 ELSE
                                                     V_MENSAJE := 'EL CC='||V_CC||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO5;
                                                 END IF;
                                               ELSE
                                                     V_MENSAJE := 'LA SCT='||V_SCT||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO4;
                                               END IF;
                                             ELSE
                                                 V_MENSAJE := 'LA CTA='||V_CTA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO3;
                                             END IF;
                                           ELSE
                                               V_MENSAJE := 'LA NEG ='||V_NEG||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO2;
                                           END IF;
                                         ELSE
                                             V_MENSAJE := 'LA CIA='||V_CIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO1;
                                         END IF;
                                       ELSE
                                          V_MENSAJE := 'EL CODIGO='||V_CODE_COMBINATION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CODE_COMBINATION;
                                       END IF;
                                  ELSE
                                        V_MENSAJE := 'LA MONEDA='||V_MONEDA_IMP||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.MONEDA;
                                  END IF;
                                ELSE
                                    V_MENSAJE := 'LA EMPRESA='||V_E_EMPRESA_DES||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DES_EMPRESA;
                                END IF;
                           ELSE
                              V_MENSAJE := 'EL RUBRO='||V_RUBRO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.RUBRO;
                           END IF;
                    ELSE
                       V_MENSAJE := 'EL AGRUPAMIENTO= '||V_AGRUPAMIENTO||' NO CORRESPONDE CON LA LINEA ORIGINAL= '||I.AGRUPAMIENTO;
                    END IF;
                 ELSE
                    V_MENSAJE := 'LA DIVISION='||V_DIVISION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DIVISION;
                 END IF;
  END LOOP;
   END IF;
  /*
  FOR I IN CC_FOLIOS_SOIN_PPTO(FOLIO_SET,NUMERO_DE_PARTIDA ) LOOP
             IF (V_DIVISION=I.DIVISION) OR (V_DIVISION  IS NULL AND I.DIVISION IS NULL) THEN
                IF V_AGRUPAMIENTO = I.AGRUPAMIENTO        THEN
                   IF V_RUBRO      = I.RUBRO               THEN
                          IF V_E_EMPRESA_DES=I.DES_EMPRESA  THEN
                               IF V_NO_CLIENTE=I.MONEDA  THEN
                                 IF V_REFERENCIA=I.AEJMAP THEN
                                   IF V_DESCRIPCION=I.CNCMAP THEN
                                     IF V_TIPO_OPERACION =I.CTACR1 THEN
                                       IF V_ID_BANCO=I.CTACR2 THEN
                                         IF V_FORMA_PAGO=I.FORMA_PAGO THEN
                                               ELSE
                                                     V_MENSAJE := 'EL FORMA PAGO='||V_FORMA_PAGO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.FORMA_PAGO;
                                               END IF;
                                             ELSE
                                                 V_MENSAJE := 'EL ID_BANCO='||V_ID_BANCO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CTACR2;
                                             END IF;
                                           ELSE
                                               V_MENSAJE := 'EL TIPO DE OPERACION ='||V_TIPO_OPERACION||'NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CTACR1;
                                           END IF;
                                         ELSE
                                             V_MENSAJE := 'LA DESCRIPCION='||V_DESCRIPCION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CNCMAP;
                                         END IF;
                                       ELSE
                                          V_MENSAJE := 'LA REFERENCIA='||V_REFERENCIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.AEJMAP;
                                       END IF;
                                  ELSE
                                        V_MENSAJE := 'EL NO DE CLIENTE='||V_NO_CLIENTE||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.NO_MONEDA;
                                  END IF;
                                ELSE
                                    V_MENSAJE := 'LA EMPRESA='||V_E_EMPRESA_DES||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DES_EMPRESA;
                                END IF;
                           ELSE
                              V_MENSAJE := 'EL RUBRO='||V_RUBRO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.RUBRO;
                           END IF;
                    ELSE
                       V_MENSAJE := 'EL AGRUPAMIENTO= '||V_AGRUPAMIENTO||' NO CORRESPONDE CON LA LINEA ORIGINAL= '||I.AGRUPAMIENTO;
                    END IF;
                 ELSE
                    V_MENSAJE := 'LA DIVISION='||V_DIVISION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DIVISION;
                 END IF;
  END LOOP;
  */
   RETURN V_MENSAJE ;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "FECXC"."FECXP_VALIDA_LINEA_IMPORTADA" (TIPO_IMPORTACION IN VARCHAR2, FOLIO_SET IN VARCHAR2,E_CODIGO IN VARCHAR2, NUMERO_DE_PARTIDA IN INTEGER, ESTATUS_MOVIMIENTO IN VARCHAR2, CODE_COMBINATION IN INTEGER, DIVISION IN VARCHAR2, AGRUPAMIENTO IN VARCHAR2, RUBRO IN VARCHAR2, DES_EMPRESA IN VARCHAR2, MONEDA IN VARCHAR2,SCT IN VARCHAR2,CTA IN VARCHAR2, CC IN VARCHAR2, ICIA IN VARCHAR2,  V_ID_SESION  in  FECXP_IMPORTACION_DATOS.ATRIBUTO_1%TYPE) RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
V_DIVISION              VARCHAR2 (50);
V_AGRUPAMIENTO          VARCHAR2 (50);
V_RUBRO                 VARCHAR2 (50);
V_CLA_FE_ID             VARCHAR2 (25);
V_CLA_FE_DES            VARCHAR2 (50);
V_E_CODIGO              VARCHAR2 (25);
V_E_EMPRESA_DES         VARCHAR2 (100);
V_FOLIO_SET             VARCHAR2 (150);
V_NO_CLIENTE            VARCHAR2 (15);
V_REFERENCIA            VARCHAR2 (30);
V_DESCRIPCION           VARCHAR2 (30);
V_TIPO_OPERACION        INTEGER;
V_ID_BANCO              INTEGER;
V_FORMA_PAGO            INTEGER;
V_ID_CHEQUERA           VARCHAR2 (20);
V_ESTATUS_MOVIMIENTO    VARCHAR2 (1);
V_BENEFICIARIO          VARCHAR2 (60);
V_CONCEPTO              VARCHAR2 (100);
V_ORIGEN_MOVIMIENTO     VARCHAR2 (3);
V_NUMERO_DE_PARTIDA     INTEGER;
V_CIA                   VARCHAR2 (25);
V_NEG                   VARCHAR2 (25);
V_CTA                   VARCHAR2 (25);
V_SCT                   VARCHAR2 (25);
V_CC                    VARCHAR2 (25);
V_ICIA                    VARCHAR2 (25);
V_TOP                    VARCHAR2 (25);
V_ESTATUS                VARCHAR2 (50);
V_FECHA_APLICACION        DATE;
V_MONEDA_IMP            VARCHAR2 (25);
V_IMPORTE_LINEA            NUMBER (20,4);
V_CONTADOR_C            INTEGER:=0;
V_MENSAJE               VARCHAR2 (4000);
V_CODE_COMBINATION INTEGER;
-- ************* CURSOR PARA REALES ORACLE ********************
CURSOR C_FOLIOS_ORACLE_REAL(V_FOLIO_SET_C VARCHAR2,V_NUMERO_DE_PARTIDA_C INTEGER, V_E_CODIGO_C VARCHAR2) IS SELECT DISTINCT
                                    E_CODIGO,DES_EMPRESA,FOLIO_SET,TIPO_OPERACION,CONCEPTO,BENEFICIARIO,
                                    ESTATUS_MOVIMIENTO,ID_CHEQUERA,ID_BANCO,NO_CLIENTE,FORMA_PAGO,FECHA_APLICACION,
                                    MONEDA,TC_ORIGINAL,TC_FLUJO,ORIGEN_MOVIMIENTO,DIVISION,AGRUPAMIENTO,
                                    RUBRO,CLA_FE_ID,CLA_FE_DES,NUMERO_DE_PARTIDA,ORACLE_SEGMENTO1,ORACLE_SEGMENTO2,
                                    ORACLE_SEGMENTO3,ORACLE_SEGMENTO4,ORACLE_SEGMENTO5,ORACLE_SEGMENTO6,ORACLE_SEGMENTO7,
                                    IMPORTE_LINEA,ESTATUS,MET_CLASIFICACION,REFERENCIA,DESCRIPCION
                                    FROM
                                    (
                                    SELECT    SF.ID_SEGMENTO, SF.DES_SEGMENTO, R.E_CODIGO, E.DES_EMPRESA, R.FOLIO_SET, TO_CHAR (R.TIPO_OPERACION) TIPO_OPERACION, R.CONCEPTO, R.BENEFICIARIO, R.ESTATUS_MOVIMIENTO, R.ID_CHEQUERA, TO_CHAR (R.ID_BANCO) ID_BANCO, NVL (R.NO_CLIENTE ,'0') NO_CLIENTE,
                                            TO_CHAR (R.FORMA_PAGO) FORMA_PAGO, R.FECHA_APLICACION, R.MONEDA, 'TC_ORIGINAL: ' || TO_CHAR (R.TC_ORIGINAL) TC_ORIGINAL, 'TC_FLUJO: ' || TO_CHAR (R.TC_FLUJO) TC_FLUJO, R.ORIGEN_MOVIMIENTO,
                                            R.DIVISION, R.AGRUPAMIENTO, R.RUBRO, R.CLA_FE_ID, R.CLA_FE_DES,
                                            TO_CHAR (R.NUMERO_DE_PARTIDA_ERP) NUMERO_DE_PARTIDA, R.ORACLE_SEGMENTO1, R.ORACLE_SEGMENTO2, R.ORACLE_SEGMENTO3, R.ORACLE_SEGMENTO4, R.ORACLE_SEGMENTO5, TRIM(R.ORACLE_SEGMENTO6) ORACLE_SEGMENTO6, R.ORACLE_SEGMENTO7,
                                            R.IMPORTE_LINEA,
                                            R.IMPORTE_LINEA * TC_ORIGINAL IMPORTE_LINEA_TC_O,
                                            R.IMPORTE_LINEA * TC_FLUJO IMPORTE_LINEA_TC_F,
                                            R.ESTATUS, R.MET_CLASIFICACION,
                                            R.REFERENCIA, R.DESCRIPCION
                                    FROM    (
                                            SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                    P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                    M.TIPO_CAMBIO TC_FLUJO,
                                                    P.ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                    NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                    NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                    NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                    CF.CLA_FE_ID,
                                                    CF.CLA_FE_DES,
                                                    P.NUMERO_DE_PARTIDA_ERP, P.ORACLE_SEGMENTO1, P.ORACLE_SEGMENTO2, P.ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5, P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7, P.IMPORTE_LINEA, 'EGRESO EXTRAIDO' ESTATUS, 'POL?TICAS' MET_CLASIFICACION,
                                                    P.REFERENCIA, P.DESCRIPCION
                                            FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                    FECXC.FECXP_PAGOS_ERP_CLASIF P,
                                                    FECXC.FECXP_CTAS_CLASIF_REAL_ERP C,
                                                    FECXC.FECXP_MONEDAS M
                                            WHERE    P.E_CODIGO = C.E_CODIGO
                                            AND        P.TIPO_OPERACION = C.TIPO_OPERACION
                                            AND        P.ID_BANCO = C.ID_BANCO
                                            AND        P.ID_CHEQUERA = C.ID_CHEQUERA
                                            AND        P.ORACLE_SEGMENTO1 = C.ORACLE_SEGMENTO1
                                            AND        P.ORACLE_SEGMENTO2 = C.ORACLE_SEGMENTO2
                                            AND        P.ORACLE_SEGMENTO3 = C.ORACLE_SEGMENTO3
                                            AND        P.ORACLE_SEGMENTO4 = C.ORACLE_SEGMENTO4
                                            AND        P.ORACLE_SEGMENTO5 = C.ORACLE_SEGMENTO5
                                            AND        P.ORACLE_SEGMENTO6 = C.ORACLE_SEGMENTO6
                                            AND        P.ORACLE_SEGMENTO7 = C.ORACLE_SEGMENTO7
                                            AND        M.MON_SET = P.MONEDA
                                            AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                            AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                            AND        CF.CLA_FE_ID = C.CLA_FE_ID
                                            UNION ALL
                                            SELECT    I.E_CODIGO, TO_CHAR (I.FOLIO_SET), I.TIPO_OPERACION, I.CONCEPTO, I.BENEFICIARIO, I.ID_STATUS_MOV, I.ID_CHEQUERA, I.ID_BANCO, I.NO_CLIENTE,
                                                    I.ID_FORMA_PAGO, I.FECHA, M.MON_ORACLE MONEDA, I.TIPO_CAMBIO, M.TIPO_CAMBIO, '',
                                                    I.IMPORTE,
                                                    NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                    NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                    NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                    CF.CLA_FE_ID, CF.CLA_FE_DES,
                                                    0, I.ORA_SOIN_SEGMENTO1, I.ORA_SOIN_SEGMENTO2, I.ORA_SOIN_SEGMENTO3, I.ORACLE_SEGMENTO4, I.ORACLE_SEGMENTO5, I.ORACLE_SEGMENTO6, I.ORACLE_SEGMENTO7, CASE I.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN I.IMPORTE ELSE I.IMPORTE_LINEA END, 'INGRESO EXTRAIDO', I.TIPO_CLASIFICACION,
                                                    I.REFERENCIA, I.DESCRIPCION
                                            FROM    FECXC.FECXP_INGRESOS_CLASIF I,
                                                    FECXC.FECXC_DEP_ESPECIALES R,
                                                    FECXC.FECXP_MONEDAS M,
                                                    FECXP_CLASIFICACION_FE CF
                                            WHERE    I.ID_STATUS_MOV NOT IN ('Q')
                                            AND        I.CLA_FE_ID = CF.CLA_FE_ID
                                            AND        M.MON_ORACLE = I.MONEDA
                                            AND        M.PERIODO = TO_NUMBER (TO_CHAR (I.FECHA, 'YYYY'))
                                            AND        M.MES = TO_NUMBER (TO_CHAR (I.FECHA, 'MM'))
                                            AND        R.NO_EMPRESA = I.E_CODIGO
                                            AND        R.NO_FOLIO_DET = I.FOLIO_SET
                                            AND        R.ID_STATUS_MOV = I.ID_STATUS_MOV
                                            UNION ALL
                                            SELECT    TO_NUMBER (H.E_EMPRESA_IMP), '0', 0, '', '', '', '', 0, '',
                                                    0, TO_DATE (TO_CHAR (H.FECHA,'YYYY') || LPAD (TO_CHAR (H.MES), 2, '0') || '01', 'YYYYMMDD') FECHA, H.MONEDA_IMP MONEDA, M.TIPO_CAMBIO, M.TIPO_CAMBIO, '', H.IMPORTE_LINEA,
                                                    NVL(C.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                    NVL(C.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                    NVL(C.CLA_ATRIBUTO2,'') RUBRO,
                                                    C.CLA_FE_ID, C.CLA_FE_DES,
                                                    0, 'X' ORACLE_SEGMENTO1, 'X' ORACLE_SEGMENTO2, 'X' ORACLE_SEGMENTO3, 'X' ORACLE_SEGMENTO4, 'X' ORACLE_SEGMENTO5, 'X' ORACLE_SEGMENTO6, 'X' ORACLE_SEGMENTO7, H.IMPORTE_LINEA, 'IMPORTADO', 'NA',
                                                    '<SIN REFERENCIA>' REFERENCIA, '<SIN DESCRIPCION>' DESCRIPCION
                                            FROM    FECXC.FECXP_IMPORTACION_DATOS_HIST H,
                                                    FECXC.FECXP_CLASIFICACION_FE C,
                                                    FECXC.FECXP_MONEDAS M
                                            WHERE    H.TIPO_IMPORTACION = 'R'
                                            AND        M.MON_ORACLE = H.MONEDA_IMP
                                            AND        M.MES = H.MES
                                            AND        M.PERIODO = TO_NUMBER (TO_CHAR (FECHA, 'YYYY'))
                                            AND        C.CLA_FE_ID = H.CLA_FE_ID_IMP
                                            ) R,
                                            FECXC.FECXC_EMP_X_SEGMENTO ES,
                                            FECXC.FECXC_SEGMENTOS_FLUJO SF,
                                            FECXC.FECXC_EMPRESAS E
                                    WHERE        ES.ID_SEGMENTO NOT IN (11,15, 17, 18, 20, 26, 6, 13, 25)
                                    AND        E.CUAL_ERP = 'O'
                                    AND        E.E_CODIGO = R.E_CODIGO
                                    AND        ES.E_CODIGO = R.E_CODIGO
                                    AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO
                                    UNION ALL
                                    SELECT    SF.ID_SEGMENTO, SF.DES_SEGMENTO, R.E_CODIGO, E.DES_EMPRESA, R.FOLIO_SET, TO_CHAR (R.TIPO_OPERACION) TIPO_OPERACION, R.CONCEPTO, R.BENEFICIARIO, R.ESTATUS_MOVIMIENTO, R.ID_CHEQUERA, TO_CHAR (R.ID_BANCO) ID_BANCO, NVL (R.NO_CLIENTE ,'0') NO_CLIENTE,
                                            TO_CHAR (R.FORMA_PAGO) FORMA_PAGO, R.FECHA_APLICACION, R.MONEDA, 'TC_ORIGINAL: ' || TO_CHAR (R.TC_ORIGINAL) TC_ORIGINAL, 'TC_FLUJO: ' || TO_CHAR (R.TC_FLUJO) TC_FLUJO, R.ORIGEN_MOVIMIENTO,
                                            R.DIVISION, R.AGRUPAMIENTO, R.RUBRO, R.CLA_FE_ID, R.CLA_FE_DES,
                                            TO_CHAR (R.NUMERO_DE_PARTIDA_ERP) NUMERO_DE_PARTIDA, R.ORACLE_SEGMENTO1, R.ORACLE_SEGMENTO2, R.ORACLE_SEGMENTO3, R.ORACLE_SEGMENTO4, R.ORACLE_SEGMENTO5, TRIM(R.ORACLE_SEGMENTO6) ORACLE_SEGMENTO6, R.ORACLE_SEGMENTO7,
                                            R.IMPORTE_LINEA,
                                            R.IMPORTE_LINEA * TC_ORIGINAL IMPORTE_LINEA_TC_O,
                                            R.IMPORTE_LINEA * TC_FLUJO IMPORTE_LINEA_TC_F,
                                            R.ESTATUS, R.MET_CLASIFICACION,
                                            R.REFERENCIA, R.DESCRIPCION
                                    FROM    (
                                                SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                        P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                        M.TIPO_CAMBIO TC_FLUJO,
                                                        'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        P.CLA_FE_ID,
                                                        CF.CLA_FE_DES,
                                                        P.NUMERO_DE_PARTIDA_ERP, P.ORA_SOIN_SEGMENTO1 AS ORACLE_SEGMENTO1, P.ORA_SOIN_SEGMENTO2 AS ORACLE_SEGMENTO2, P.ORA_SOIN_SEGMENTO3 AS ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5, P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7, P.IMPORTE_LINEA,
                                                        'COINV EGR' ESTATUS, 'COINVERSION' MET_CLASIFICACION,
                                                        P.REFERENCIA, P.DESCRIPCION
                                                FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                        FECXC.FECXP_DET_REALES_COINVERSION P,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    M.MON_SET = P.MONEDA
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                AND        P.ID_TIPO_MOVTO ='E'
                                                UNION ALL
                                                SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                        P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                        M.TIPO_CAMBIO TC_FLUJO,
                                                        'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        P.CLA_FE_ID,
                                                        CF.CLA_FE_DES,
                                                        P.NUMERO_DE_PARTIDA_ERP, P.ORA_SOIN_SEGMENTO1 AS ORACLE_SEGMENTO1, P.ORA_SOIN_SEGMENTO2 AS ORACLE_SEGMENTO2, P.ORA_SOIN_SEGMENTO3 AS ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5, P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7,
                                                        CASE P.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN P.IMPORTE ELSE P.IMPORTE_LINEA END,
                                                        'COINV ING' ESTATUS, 'COINVERSION' MET_CLASIFICACION,
                                                        P.REFERENCIA, P.DESCRIPCION
                                                FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                        FECXC.FECXP_DET_REALES_COINVERSION P,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    M.MON_SET = P.MONEDA
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                AND        P.ID_TIPO_MOVTO ='I'
                                                UNION ALL
                                                SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                        P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                        M.TIPO_CAMBIO TC_FLUJO,
                                                        'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        P.CLA_FE_ID,
                                                        CF.CLA_FE_DES,
                                                        P.NUMERO_DE_PARTIDA_ERP, P.ORA_SOIN_SEGMENTO1 AS ORACLE_SEGMENTO1, P.ORA_SOIN_SEGMENTO2 AS ORACLE_SEGMENTO2, P.ORA_SOIN_SEGMENTO3 AS ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5, P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7, P.IMPORTE_LINEA,
                                                        CASE P.ID_TIPO_MOVTO WHEN 'I' THEN 'INV INGR' ELSE 'INV EGR' END ESTATUS, 'INVERSION' MET_CLASIFICACION,
                                                        P.REFERENCIA, P.DESCRIPCION
                                                FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                        FECXC.FECXP_DET_REALES_INVERSION P,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    M.MON_SET = P.MONEDA
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                AND        P.ID_TIPO_MOVTO ='E'
                                                UNION ALL
                                                SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                        P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                        M.TIPO_CAMBIO TC_FLUJO,
                                                        'SET'AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        P.CLA_FE_ID,
                                                        CF.CLA_FE_DES,
                                                        P.NUMERO_DE_PARTIDA_ERP, P.ORA_SOIN_SEGMENTO1 AS ORACLE_SEGMENTO1, P.ORA_SOIN_SEGMENTO2 AS ORACLE_SEGMENTO2, P.ORA_SOIN_SEGMENTO3 AS ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5, P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7,
                                                        CASE P.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN P.IMPORTE ELSE P.IMPORTE_LINEA END,
                                                        CASE P.ID_TIPO_MOVTO WHEN 'I' THEN 'INV ING' ELSE 'INV EGR' END ESTATUS, 'INVERSION' MET_CLASIFICACION,
                                                        P.REFERENCIA, P.DESCRIPCION
                                                FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                        FECXC.FECXP_DET_REALES_INVERSION P,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    M.MON_SET = P.MONEDA
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                AND        P.ID_TIPO_MOVTO ='I'
                                            ) R,
                                            FECXC.FECXC_EMP_X_SEGMENTO ES,
                                            FECXC.FECXC_SEGMENTOS_FLUJO SF,
                                            FECXC.FECXC_EMPRESAS E
                                    WHERE    ES.ID_SEGMENTO NOT IN (11,15, 17, 18, 20, 26, 6, 13, 25)
                                    AND     E.CUAL_ERP = 'O'
                                    AND        E.E_CODIGO = R.E_CODIGO
                                    AND        ES.E_CODIGO = R.E_CODIGO
                                    AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO) where FOLIO_SET = V_FOLIO_SET_C
                                                                                AND   NUMERO_DE_PARTIDA=V_NUMERO_DE_PARTIDA_C
                                                                                AND E_CODIGO = V_E_CODIGO_C;
--------------++++++++CURSOR PARA REALES SOIN++++-----
CURSOR C_FOLIOS_SOIN_REAL(V_FOLIO_SET_C VARCHAR2,V_ESTATUS_MOVIMIENTO VARCHAR2) IS SELECT DISTINCT
                                                                         ID_SEGMENTO,DES_SEGMENTO,E_CODIGO,DES_EMPRESA,
                                                                      FOLIO_SET,TIPO_OPERACION,CONCEPTO,BENEFICIARIO,
                                                                      ESTATUS_MOVIMIENTO,ID_CHEQUERA,ID_BANCO,NO_CLIENTE,
                                                                      FORMA_PAGO,FECHA_APLICACION,MES,MONEDA,TC_ORIGINAL,
                                                                      TC_FLUJO,ORIGEN_MOVIMIENTO,DIVISION,AGRUPAMIENTO,RUBRO,
                                                                      CLA_FE_ID,CLA_FE_DES,NUMERO_DE_PARTIDA_SOIN,CTAM01,CTAM02,CTAM03,
                                                                      IMPORTE_LINEA,ESTATUS,MET_CLASIFICACION,IMPORTE_LINEA_TC_O,
                                                                      IMPORTE_LINEA_TC_F,REFERENCIA,DESCRIPCION
                                                                     FROM(
                                               SELECT SF.ID_SEGMENTO, SF.DES_SEGMENTO, R.E_CODIGO, E.DES_EMPRESA, R.FOLIO_SET,
                                                         TO_CHAR (R.TIPO_OPERACION) TIPO_OPERACION, R.CONCEPTO, R.BENEFICIARIO,
                                                      R.ESTATUS_MOVIMIENTO, R.ID_CHEQUERA, TO_CHAR (R.ID_BANCO) ID_BANCO, NVL (R.NO_CLIENTE ,'0') NO_CLIENTE,
                                                    TO_CHAR (R.FORMA_PAGO) FORMA_PAGO, R.FECHA_APLICACION,
                                                    TO_CHAR(TO_DATE(r.fecha_aplicacion,'DD-MM-YYYY'),'MONTH','NLS_DATE_LANGUAGE=SPANISH') mes
                                                , R.MONEDA, 'TC_ORIGINAL: ' || TO_CHAR (R.TC_ORIGINAL) TC_ORIGINAL, 'TC_FLUJO: ' || TO_CHAR (R.TC_FLUJO) TC_FLUJO, R.ORIGEN_MOVIMIENTO,
                                                R.DIVISION, R.AGRUPAMIENTO, R.RUBRO,R.CLA_FE_ID, R.CLA_FE_DES,
                                                TO_CHAR (R.NUMERO_DE_PARTIDA_SOIN) NUMERO_DE_PARTIDA_SOIN, R.CTAM01, R.CTAM02, R.CTAM03,
                                                R.IMPORTE_LINEA, R.ESTATUS, R.MET_CLASIFICACION,
                                                R.IMPORTE_LINEA * TC_ORIGINAL IMPORTE_LINEA_TC_O,
                                                R.IMPORTE_LINEA * TC_FLUJO IMPORTE_LINEA_TC_F,
                                                 R.REFERENCIA, R.DESCRIPCION
                                        FROM    (
                                                SELECT  P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                        P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL, M.TIPO_CAMBIO TC_FLUJO, P.ORIGEN_MOVIMIENTO,
                                                        P.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        CF.CLA_FE_ID,
                                                        CF.CLA_FE_DES,
                                                        P.NUMERO_DE_PARTIDA_SOIN, P.CTAM01, P.CTAM02, P.CTAM03, P.IMPORTE_LINEA, 'EGRESO EXTRAIDO' ESTATUS, 'POL?TICAS' MET_CLASIFICACION,
                                                        P.REFERENCIA, P.DESCRIPCION
                                                        FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                                FECXC.FECXP_PAGOS_SOIN_CLASIF P,
                                                                FECXC.FECXP_CTAS_CLASIF_REAL_SOIN C,
                                                                FECXC.FECXP_MONEDAS M
                                                        WHERE    P.E_CODIGO = C.E_CODIGO
                                                        AND        P.TIPO_OPERACION = C.TIPO_OPERACION
                                                        AND        P.ID_BANCO = C.ID_BANCO
                                                        AND        P.ID_CHEQUERA = C.ID_CHEQUERA
                                                        AND        P.CTAM01 = C.CTAM01
                                                        AND        P.CTAM02 = C.CTAM02
                                                        AND        P.CTAM03 = C.CTAM03
                                                        AND        CF.CLA_FE_ID = C.CLA_FE_ID
                                                        AND        M.MON_SET = P.MONEDA
                                                        AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                        AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                            UNION ALL
                                                SELECT    I.E_CODIGO, TO_CHAR (I.FOLIO_SET), I.TIPO_OPERACION, I.CONCEPTO, I.BENEFICIARIO, I.ID_STATUS_MOV, I.ID_CHEQUERA, I.ID_BANCO, I.NO_CLIENTE,
                                                        I.ID_FORMA_PAGO, I.FECHA, M.MON_ORACLE MONEDA, I.TIPO_CAMBIO, M.TIPO_CAMBIO, '',
                                                        I.IMPORTE,
                                                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                        CF.CLA_FE_ID, CF.CLA_FE_DES,
                                                        0, I.ORA_SOIN_SEGMENTO1, I.ORA_SOIN_SEGMENTO2, I.ORA_SOIN_SEGMENTO3, CASE I.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN I.IMPORTE ELSE I.IMPORTE_LINEA END, 'INGRESO EXTRAIDO', I.TIPO_CLASIFICACION,
                                                        I.REFERENCIA, I.DESCRIPCION
                                                FROM    FECXC.FECXP_INGRESOS_CLASIF I,
                                                        FECXC.FECXC_DEP_ESPECIALES R,
                                                        FECXC.FECXP_CLASIFICACION_FE CF,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    I.CLA_FE_ID = CF.CLA_FE_ID
                                                AND        M.MON_ORACLE = I.MONEDA
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (I.FECHA, 'YYYY'))
                                                AND        M.MES = TO_NUMBER (TO_CHAR (I.FECHA, 'MM'))
                                                AND        I.ID_STATUS_MOV NOT IN ('Q')
                                                AND        R.NO_EMPRESA = I.E_CODIGO
                                                AND        R.NO_FOLIO_DET = I.FOLIO_SET
                                                AND        R.ID_STATUS_MOV = I.ID_STATUS_MOV
                                                UNION ALL
                                                SELECT    TO_NUMBER (H.E_EMPRESA_IMP), '0', 0, '', '', '', '', 0, '',
                                                        0, TO_DATE (TO_CHAR (H.FECHA,'YYYY') || LPAD (TO_CHAR (H.MES), 2, '0') || '01', 'YYYYMMDD') FECHA, H.MONEDA_IMP, M.TIPO_CAMBIO, M.TIPO_CAMBIO, '',
                                                        H.IMPORTE_LINEA,
                                                        NVL(C.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                        NVL(C.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                        NVL(C.CLA_ATRIBUTO2,'') RUBRO,
                                                        C.CLA_FE_ID, C.CLA_FE_DES,
                                                        0, 'X' ARSMAP, 'X' AEJMAP, 'X' CNCMAP, H.IMPORTE_LINEA, 'IMPORTADO', 'NA',
                                                        '<SIN REFERENCIA>' REFERENCIA, '<SIN DESCRIPCION>' DESCRIPCION
                                                FROM    FECXC.FECXP_IMPORTACION_DATOS_HIST H,
                                                        FECXC.FECXP_CLASIFICACION_FE C,
                                                        FECXC.FECXP_MONEDAS M
                                                WHERE    H.TIPO_IMPORTACION = 'R'
                                                AND        C.CLA_FE_ID = H.CLA_FE_ID_IMP
                                                AND        M.MON_ORACLE = H.MONEDA_IMP
                                                AND        M.MES = H.MES
                                                AND        M.PERIODO = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'))
                                                ) R,
                                                FECXC.FECXC_EMP_X_SEGMENTO ES,
                                                FECXC.FECXC_SEGMENTOS_FLUJO SF,
                                                FECXC.FECXC_EMPRESAS E
                                        WHERE    ES.ID_SEGMENTO NOT IN (11, 15, 17, 18 , 20, 26, 6, 13, 25)
                                        AND        E.CUAL_ERP = 'S'
                                        AND        ES.E_CODIGO = R.E_CODIGO
                                        AND        E.E_CODIGO = R.E_CODIGO
                                        AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO
                                        UNION ALL
                                        SELECT    SF.ID_SEGMENTO, SF.DES_SEGMENTO, R.E_CODIGO, E.DES_EMPRESA, R.FOLIO_SET, TO_CHAR (R.TIPO_OPERACION) TIPO_OPERACION, R.CONCEPTO, R.BENEFICIARIO, R.ESTATUS_MOVIMIENTO, R.ID_CHEQUERA, TO_CHAR (R.ID_BANCO) ID_BANCO, NVL (R.NO_CLIENTE ,'0') NO_CLIENTE,
                                                TO_CHAR (R.FORMA_PAGO) FORMA_PAGO, R.FECHA_APLICACION, TO_CHAR(TO_DATE(r.fecha_aplicacion,'DD-MM-YYYY'),'MONTH','NLS_DATE_LANGUAGE=SPANISH') mes
                                        , R.MONEDA, 'TC_ORIGINAL: ' || TO_CHAR (R.TC_ORIGINAL) TC_ORIGINAL, 'TC_FLUJO: ' || TO_CHAR (R.TC_FLUJO) TC_FLUJO, R.ORIGEN_MOVIMIENTO,
                                                R.DIVISION, R.AGRUPAMIENTO, R.RUBRO,R.CLA_FE_ID, R.CLA_FE_DES,
                                                TO_CHAR (R.NUMERO_DE_PARTIDA_SOIN) NUMERO_DE_PARTIDA_SOIN, R.CTAM01, R.CTAM02, R.CTAM03,
                                                R.IMPORTE_LINEA, R.ESTATUS, R.MET_CLASIFICACION,
                                                R.IMPORTE_LINEA * TC_ORIGINAL IMPORTE_LINEA_TC_O,
                                                R.IMPORTE_LINEA * TC_FLUJO IMPORTE_LINEA_TC_F,
                                                R.REFERENCIA, R.DESCRIPCION
                                        FROM    (
                                                    SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                            P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                            M.TIPO_CAMBIO TC_FLUJO,
                                                            'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                            NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                            NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                            NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                            P.CLA_FE_ID,
                                                            CF.CLA_FE_DES,
                                                            P.NUMERO_DE_PARTIDA_ERP as NUMERO_DE_PARTIDA_SOIN, P.ORA_SOIN_SEGMENTO1 AS CTAM01, P.ORA_SOIN_SEGMENTO2 AS CTAM02, P.ORA_SOIN_SEGMENTO3 AS CTAM03,
                                                            P.IMPORTE_LINEA,
                                                            'COINV EGR' ESTATUS, 'COINVERSION' MET_CLASIFICACION,
                                                            P.REFERENCIA, P.DESCRIPCION
                                                    FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                            FECXC.FECXP_DET_REALES_COINVERSION P,
                                                            FECXC.FECXP_MONEDAS M
                                                    WHERE    M.MON_SET = P.MONEDA
                                                    AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                    AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                    AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                    AND        P.ID_TIPO_MOVTO ='E'
                                                    UNION ALL
                                                    SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                            P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                            M.TIPO_CAMBIO TC_FLUJO,
                                                            'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                            NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                            NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                            NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                            P.CLA_FE_ID,
                                                            CF.CLA_FE_DES,
                                                            P.NUMERO_DE_PARTIDA_ERP as NUMERO_DE_PARTIDA_SOIN, P.ORA_SOIN_SEGMENTO1 AS CTAM01, P.ORA_SOIN_SEGMENTO2 AS CTAM02, P.ORA_SOIN_SEGMENTO3 AS CTAM03,
                                                            CASE P.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN P.IMPORTE ELSE P.IMPORTE_LINEA END,
                                                            'COINV ING' ESTATUS, 'COINVERSION' MET_CLASIFICACION,
                                                            P.REFERENCIA, P.DESCRIPCION
                                                    FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                            FECXC.FECXP_DET_REALES_COINVERSION P,
                                                            FECXC.FECXP_MONEDAS M
                                                    WHERE    M.MON_SET = P.MONEDA
                                                    AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                    AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                    AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                    AND        P.ID_TIPO_MOVTO ='I'
                                                    UNION ALL
                                                    SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                            P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                            M.TIPO_CAMBIO TC_FLUJO,
                                                            'SET' AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                            NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                            NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                            NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                            P.CLA_FE_ID,
                                                            CF.CLA_FE_DES,
                                                            P.NUMERO_DE_PARTIDA_ERP as NUMERO_DE_PARTIDA_SOIN, P.ORA_SOIN_SEGMENTO1 AS CTAM01, P.ORA_SOIN_SEGMENTO2 AS CTAM02, P.ORA_SOIN_SEGMENTO3 AS CTAM03,
                                                            P.IMPORTE_LINEA,
                                                            CASE P.ID_TIPO_MOVTO WHEN 'I' THEN 'INV ING' ELSE 'INV EGR' END ESTATUS, 'INVERSION' MET_CLASIFICACION,
                                                            P.REFERENCIA, P.DESCRIPCION
                                                    FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                            FECXC.FECXP_DET_REALES_INVERSION P,
                                                            FECXC.FECXP_MONEDAS M
                                                    WHERE    M.MON_SET = P.MONEDA
                                                    AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                    AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                    AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                    AND        P.ID_TIPO_MOVTO ='E'
                                                    UNION ALL
                                                    SELECT    P.E_CODIGO, P.FOLIO_SET, P.TIPO_OPERACION, P.CONCEPTO, P.BENEFICIARIO, P.ESTATUS_MOVIMIENTO, P.ID_CHEQUERA, P.ID_BANCO, P.NO_CLIENTE,
                                                            P.FORMA_PAGO, P.FECHA_APLICACION, M.MON_ORACLE MONEDA, P.TIPO_CAMBIO TC_ORIGINAL,
                                                            M.TIPO_CAMBIO TC_FLUJO,
                                                            'SET'AS ORIGEN_MOVIMIENTO, P.IMPORTE,
                                                            NVL(CF.CLA_ATRIBUTO6,'') DIVISION,  --V7
                                                            NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                                                            NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                                                            P.CLA_FE_ID,
                                                            CF.CLA_FE_DES,
                                                            P.NUMERO_DE_PARTIDA_ERP as NUMERO_DE_PARTIDA_SOIN, P.ORA_SOIN_SEGMENTO1 AS CTAM01, P.ORA_SOIN_SEGMENTO2 AS CTAM02, P.ORA_SOIN_SEGMENTO3 AS CTAM03,
                                                            CASE P.ORA_SOIN_SEGMENTO1 WHEN 'X' THEN P.IMPORTE ELSE P.IMPORTE_LINEA END,
                                                            CASE P.ID_TIPO_MOVTO WHEN 'I' THEN 'INV ING' ELSE 'INV EGR' END ESTATUS, 'INVERSION' MET_CLASIFICACION,
                                                            P.REFERENCIA, P.DESCRIPCION
                                                    FROM    FECXC.FECXP_CLASIFICACION_FE CF,
                                                            FECXC.FECXP_DET_REALES_INVERSION P,
                                                            FECXC.FECXP_MONEDAS M
                                                    WHERE    M.MON_SET = P.MONEDA
                                                    AND        M.PERIODO = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'YYYY'))
                                                    AND        M.MES = TO_NUMBER (TO_CHAR (P.FECHA_APLICACION, 'MM'))
                                                    AND        CF.CLA_FE_ID = P.CLA_FE_ID
                                                    AND        P.ID_TIPO_MOVTO ='I'
                                                ) R,
                                                FECXC.FECXC_EMP_X_SEGMENTO ES,
                                                FECXC.FECXC_SEGMENTOS_FLUJO SF,
                                                FECXC.FECXC_EMPRESAS E
                                        WHERE    ES.ID_SEGMENTO NOT IN (11, 15, 17, 18 , 20, 26, 6, 13, 25)
                                        AND        E.CUAL_ERP = 'S'
                                        AND        ES.E_CODIGO = R.E_CODIGO
                                        AND        E.E_CODIGO = R.E_CODIGO
                                        AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO) WHERE FOLIO_SET = V_FOLIO_SET AND ESTATUS_MOVIMIENTO = V_ESTATUS_MOVIMIENTO;
    --Termina
 --*******************CURSOR PARA PRESUPUESTO ORACLE *****************
CURSOR C_FOLIOS_ORACLE_PPTO(V_CODE_COMBINATION INTEGER, V_SCT VARCHAR2) IS SELECT DISTINCT
                           ID_SEGMENTO,DES_SEGMENTO,E_CODIGO,DES_EMPRESA,CLA_FE_ID,CLA_FE_DES,
                        DIVISION,AGRUPAMIENTO,RUBRO,LIBRO_ID,VERSION_ID,MONEDA,MES,MES_NUM,
                        CODE_COMBINATION,ORACLE_SEGMENTO1,ORACLE_SEGMENTO2,ORACLE_SEGMENTO3,
                        ORACLE_SEGMENTO4,ORACLE_SEGMENTO5,ORACLE_SEGMENTO6,ORACLE_SEGMENTO7,
                        TC_ORIGINAL_STR,TC_FLUJO_STR,PPTO_OPERATIVO_MO,PPTO_OPERATIVO_MF_ORIGINAL,
                        PPTO_OPERATIVO_MF_FLUJO,PPTO_FLUJO_MO,PPTO_FLUJO_MF_ORIGINAL,PPTO_FLUJO_MF_FLUJO,
                        PRESUPUESTO_ESTATUS,VERSION_EXTRAIDOS,VERSION_IMPORTADOS
    FROM(
       SELECT    SF.ID_SEGMENTO, SF.DES_SEGMENTO, P.E_CODIGO, P.DES_EMPRESA, P.CLA_FE_ID, P.CLA_FE_DES,
                P.DIVISION, P.AGRUPAMIENTO, P.RUBRO,TO_CHAR (P.LIBRO_ID) LIBRO_ID, TO_CHAR (P.VERSION_ID) VERSION_ID,
                P.MONEDA, P.MES, P.MES_NUM,    TO_CHAR (P.CODE_COMBINATION) CODE_COMBINATION,
                P.ORACLE_SEGMENTO1, P.ORACLE_SEGMENTO2, P.ORACLE_SEGMENTO3, P.ORACLE_SEGMENTO4, P.ORACLE_SEGMENTO5,
                P.ORACLE_SEGMENTO6, P.ORACLE_SEGMENTO7,
                'TC ORIGINAL ' || P.MONEDA || ': ' || TO_CHAR (P.TC_ORIGINAL) TC_ORIGINAL_STR,
                'TC FLUJO ' || P.MONEDA || ': ' || TO_CHAR (P.TC_FLUJO) TC_FLUJO_STR,
                P.PPTO_OPERATIVO PPTO_OPERATIVO_MO,
                P.PPTO_OPERATIVO * P.TC_ORIGINAL PPTO_OPERATIVO_MF_ORIGINAL,
                P.PPTO_OPERATIVO * P.TC_FLUJO PPTO_OPERATIVO_MF_FLUJO,
                P.PPTO_FLUJO PPTO_FLUJO_MO,
                P.PPTO_FLUJO * P.TC_ORIGINAL PPTO_FLUJO_MF_ORIGINAL,
                P.PPTO_FLUJO * P.TC_FLUJO PPTO_FLUJO_MF_FLUJO,
                P.PRESUPUESTO_ESTATUS,
                P.VERSION_EXTRAIDOS, P.VERSION_IMPORTADOS
        FROM    (
                SELECT    PP.E_CODIGO, PP.VERSION_FE, PP.DES_EMPRESA, CF.CLA_FE_ID, CF.CLA_FE_DES,
                        NVL(CF.CLA_ATRIBUTO6,'') DIVISION,
                        NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                        NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                        PP.LIBRO_ID, PP.VERSION_ID, PP.MONEDA,
                        PP.MES,
                        PP.MES_NUM,
                        PP.CODE_COMBINATION,
                        PP.ORACLE_SEGMENTO1, PP.ORACLE_SEGMENTO2, PP.ORACLE_SEGMENTO3, PP.ORACLE_SEGMENTO4, PP.ORACLE_SEGMENTO5, PP.ORACLE_SEGMENTO6, PP.ORACLE_SEGMENTO7,
                        PP.PPTO_OPERATIVO * TO_NUMBER (CF.CLA_ATRIBUTO5) PPTO_OPERATIVO, PP.PPTO_FLUJO * TO_NUMBER (CF.CLA_ATRIBUTO5) PPTO_FLUJO, PP.TC_ORIGINAL, PP.TC_FLUJO, PP.PRESUPUESTO_ESTATUS,
                        PP.VERSION_EXTRAIDOS, NULL AS VERSION_IMPORTADOS
                FROM    (
                        SELECT    E.E_CODIGO, PO.VERSION_FE, E.DES_EMPRESA,
                                PC.LIBRO_ID, PC.VERSION_ID,
                                PC.MONEDA, TO_CHAR (TO_DATE (PO.MES, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') AS MES,
                                PO.MES MES_NUM,
                                PC.CODE_COMBINATION,
                                PC.ORACLE_SEGMENTO1, PC.ORACLE_SEGMENTO2, PC.ORACLE_SEGMENTO3, PC.ORACLE_SEGMENTO4, PC.ORACLE_SEGMENTO5, PC.ORACLE_SEGMENTO6, PC.ORACLE_SEGMENTO7,
                                PO.PPTO PPTO_OPERATIVO, PC.IMPORTE_LINEA PPTO_FLUJO, PC.TIPO_CAMBIO TC_ORIGINAL, M.TIPO_CAMBIO TC_FLUJO, PC.PRESUPUESTO_ESTATUS,
                                PO.VERSION_FE  AS VERSION_EXTRAIDOS
                        FROM    (
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 1 MES, PPTO_01 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 2 MES, PPTO_02 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 3 MES, PPTO_03 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 4 MES, PPTO_04 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 5 MES, PPTO_05 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 6 MES, PPTO_06 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 7 MES, PPTO_07 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 8 MES, PPTO_08 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 9 MES, PPTO_09 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 10 MES, PPTO_10 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 11 MES, PPTO_11 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                    UNION ALL
                                    SELECT    E_CODIGO, VERSION_FE, PERIODO_PPTO, LIBRO_ID, VERSION_ID, MONEDA, CODE_COMBINATION_ID, 12 MES, PPTO_12 PPTO
                                    FROM    FECXC.FECXP_PPTO_OPERA_ERP
                                ) PO,
                                FECXC.FECXP_PPTO_CONVERSION_ERP PC,
                                FECXC_EMPRESAS E,
                                FECXC.FECXP_MONEDAS M
                        WHERE    PO.E_CODIGO = PC.E_CODIGO
                        AND        PO.VERSION_FE = PC.VERSION_FE
                        AND        PO.PERIODO_PPTO = PC.PERIODO
                        AND        PO.LIBRO_ID = PC.LIBRO_ID
                        AND        PO.VERSION_ID = PC.VERSION_ID
                        AND        PO.MONEDA = PC.MONEDA
                        AND        PO.CODE_COMBINATION_ID = PC.CODE_COMBINATION
                        AND        PO.MES = PC.MES
                        AND        E.E_CODIGO = PO.E_CODIGO
                        AND        M.MON_ORACLE = PO.MONEDA
                        AND        M.PERIODO = PO.PERIODO_PPTO
                        AND        M.MES = PO.MES
                        ) PP,
                        FECXC.FECXP_REP_PPTO_COM_CTA_ERP C,
                        FECXC.FECXP_CLASIFICACION_FE CF
                WHERE    C.CLA_FE_ID = CF.CLA_FE_ID
                AND        C.CODE_COMBINATION_ID = PP.CODE_COMBINATION
                AND                    C.E_CODIGO=PP.E_CODIGO
                -- AND        P.CODE_COMBINATION = 580865
                UNION ALL
                SELECT    E.E_CODIGO, TO_NUMBER (ATRIBUTO_3), E.DES_EMPRESA, C.CLA_FE_ID, C.CLA_FE_DES,
                        NVL(C.CLA_ATRIBUTO6,'') DIVISION,
                        NVL(C.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                        NVL(C.CLA_ATRIBUTO2,'') RUBRO,
                        0 LIBRO_ID, 0 VERSION_ID, H.MONEDA_IMP MONEDA,
                        TO_CHAR (TO_DATE (H.MES, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') AS MES,
                        H.MES MES_NUM,
                        0,
                        E.E_CODIGO_SOIN ORACLE_SEGMENTO1, 'X' ORACLE_SEGMENTO2, 'X' ORACLE_SEGMENTO3, 'X' ORACLE_SEGMENTO4, 'X' ORACLE_SEGMENTO5, H.ATRIBUTO_2 ORACLE_SEGMENTO6, 'X' ORACLE_SEGMENTO7,
                        0 PPTO_OPERATIVO, SUM (H.IMPORTE_LINEA * TO_NUMBER (C.CLA_ATRIBUTO5)) PPTO_FLUJO,
                        M.TIPO_CAMBIO, M.TIPO_CAMBIO, 'IMPORTADO',
                        NULL AS VERSION_EXTRAIDOS, H.ATRIBUTO_3 AS VERSION_IMPORTADOS
                FROM    FECXC.FECXP_IMPORTACION_DATOS_HIST H,
                        FECXC_EMPRESAS E,
                        FECXC.FECXP_CLASIFICACION_FE C,
                        FECXC.FECXP_MONEDAS M
                WHERE    H.TIPO_IMPORTACION = 'P'
                AND        E.E_CODIGO = H.E_EMPRESA_IMP
                AND        E.CUAL_ERP = 'O'
                AND        M.MON_ORACLE = H.MONEDA_IMP
                AND        M.MES = H.MES
                AND        M.PERIODO = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'))
                AND        C.CLA_FE_ID = H.CLA_FE_ID_IMP
                -- AND        E.E_CODIGO = 19
                -- AND        C.CLA_FE_ID = 'A6'
                GROUP BY E.E_CODIGO, TO_NUMBER (ATRIBUTO_3), E.DES_EMPRESA, C.CLA_FE_ID, C.CLA_FE_DES,
                        NVL(C.CLA_ATRIBUTO6,''),
                        NVL(C.CLA_ATRIBUTO4,''),
                        NVL(C.CLA_ATRIBUTO2,''),
                        TO_CHAR (TO_DATE (H.MES, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH'),
                        H.MES,
                        E.E_CODIGO_SOIN,
                        H.ATRIBUTO_2,
                        H.MONEDA_IMP, M.TIPO_CAMBIO, H.ATRIBUTO_3
                ) P,
                FECXC.FECXC_EMP_X_SEGMENTO ES,
                FECXC.FECXC_SEGMENTOS_FLUJO SF
        WHERE    ES.ID_SEGMENTO NOT IN (11, 15,  17, 18, 20,  26, 6, 13, 25)
        AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO
        AND        ES.E_CODIGO = P.E_CODIGO) WHERE CODE_COMBINATION = V_CODE_COMBINATION AND SCT = V_SCT ;
    --Termina
    --********* CURSOR PARA PPTO SOIN ********
    CURSOR C_FOLIOS_SOIN_PPTO(V_DIVISION VARCHAR2,V_AGRUPAMIENTO VARCHAR2,V_RUBRO VARCHAR2,V_E_EMPRESA_DES VARCHAR2,V_MONEDA_IMP VARCHAR2,V_CIA VARCHAR2,V_NEG VARCHAR2,V_CTA VARCHAR2, V_SCT VARCHAR2)
    IS SELECT DISTINCT
                                        ID_SEGMENTO,DES_SEGMENTO,E_CODIGO,DES_EMPRESA,
                                        CLA_FE_ID,CLA_FE_DES,DIVISION,AGRUPAMIENTO,RUBRO,
                                        ARSMAP,AEJMAP,CNCMAP,CTACR1,CTACR2,MES,MONEDA,
                                        TC_ORIGINAL_STR,TC_FLUJO_STR,PPTO_OPERATIVO_MO,
                                        PPTO_OPERATIVO_MF_ORIGINAL,PPTO_OPERATIVO_MF_FLUJO,
                                        PPTO_FLUJO_MO,PPTO_FLUJO_MF_ORIGINAL,PPTO_FLUJO_MF_FLUJO,
                                        PRESUPUESTO_ESTATUS,VERSION_IMPORTADOS,VERSION_EXTRAIDOS
    FROM(
    SELECT    SF.ID_SEGMENTO, SF.DES_SEGMENTO, P.E_CODIGO, P.DES_EMPRESA, P.CLA_FE_ID, P.CLA_FE_DES,
        P.DIVISION, P.AGRUPAMIENTO, P.RUBRO,
        P.ARSMAP, P.AEJMAP, P.CNCMAP, P.CTACR1, P.CTACR2, P.MES, P.MONEDA, 'TC ORIGINAL ' || P.MONEDA || ':' || TO_CHAR (P.TC_ORIGINAL) TC_ORIGINAL_STR, 'TC FLUJO ' || P.MONEDA || ':' || TO_CHAR (P.TC_FLUJO) TC_FLUJO_STR,
        P.PPTO_OPERATIVO * 1.0 PPTO_OPERATIVO_MO,
        P.PPTO_OPERATIVO * P.TC_ORIGINAL PPTO_OPERATIVO_MF_ORIGINAL,
        P.PPTO_OPERATIVO * P.TC_FLUJO PPTO_OPERATIVO_MF_FLUJO,
        P.PPTO_FLUJO * 1.0 PPTO_FLUJO_MO,
        P.PPTO_FLUJO * P.TC_ORIGINAL PPTO_FLUJO_MF_ORIGINAL,
        P.PPTO_FLUJO * P.TC_FLUJO PPTO_FLUJO_MF_FLUJO,
        P.PRESUPUESTO_ESTATUS,
        P.VERSION_IMPORTADOS, P.VERSION_EXTRAIDOS
FROM    (
        SELECT    PP.E_CODIGO, PP.DES_EMPRESA, CF.CLA_FE_ID, CF.CLA_FE_DES,
                NVL(CF.CLA_ATRIBUTO6,'') DIVISION,
                NVL(CF.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                NVL(CF.CLA_ATRIBUTO2,'') RUBRO,
                PP.ARSMAP, PP.AEJMAP, PP.CNCMAP, PP.CTACR1, PP.CTACR2, PP.MES, PP.MON_ORACLE MONEDA,
                PP.PPTO_OPERATIVO * TO_NUMBER (CF.CLA_ATRIBUTO5) PPTO_OPERATIVO, PP.PPTO_FLUJO * TO_NUMBER (CF.CLA_ATRIBUTO5) PPTO_FLUJO,
                PP.TC_ORIGINAL, PP.TC_FLUJO,
                PP.PRESUPUESTO_ESTATUS,
                PP.VERSION_IMPORTADOS, PP.VERSION_EXTRAIDOS
        FROM    (
                SELECT    E.E_CODIGO, E.DES_EMPRESA, PO.ARSMAP, PO.AEJMAP, PO.CNCMAP, PO.CTACR1, PO.CTACR2,
                        TO_CHAR (TO_DATE (PO.MESCOD, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') AS MES,
                        M.MON_ORACLE, PO.IMPORTE_LINEA PPTO_OPERATIVO, PC.IMPORTE_LINEA PPTO_FLUJO,
                        PO.TIPO_CAMBIO TC_ORIGINAL, M.TIPO_CAMBIO TC_FLUJO, PC.PRESUPUESTO_ESTATUS,
                        NULL AS VERSION_IMPORTADOS, PC.VERSION_FE AS VERSION_EXTRAIDOS
                FROM    FECXC.FECXC_EMPRESAS E,
                        FECXC.FECXP_PPTO_CONVERSION_SOIN PC,
                        FECXC.FECXP_PPTO_OPERATIVO_SOIN PO,
                        FECXC.FECXP_MONEDAS M
                WHERE    E.E_CODIGO = PO.E_CODIGO
                AND        PO.E_CODIGO = PC.E_CODIGO
                AND        PO.PERIODO  = PC.PERIODO
                AND     PO.MONEDA = PC.MONEDA
                AND        PO.MESCOD = PC.MESCOD
                AND        PO.ARSMAP = PC.ARSMAP
                AND        PO.AEJMAP = PC.AEJMAP
                AND        PO.CNCMAP = PC.CNCMAP
                AND        PO.CTACR1 = PC.CTACR1
                AND        PO.CTACR2 = PC.CTACR2
                AND        PO.VERSION_FE = PC.VERSION_FE
                AND        M.MON_SYBASE = PO.MONEDA
                AND        M.PERIODO = PO.PERIODO
                AND        M.MES = PO.MESCOD
                ) PP,
                FECXP_CLASIFICACION_FE CF, -- 10366
                FECXP_CTAS_SOIN_CARATULA C -- 10366
        WHERE    CF.CLA_FE_ID = C.CLA_FE_ID
        AND        PP.E_CODIGO = C.E_CODIGO
        AND        PP.E_CODIGO = C.E_CODIGO
        AND        PP.ARSMAP = C.CTAM01
        AND        PP.AEJMAP = C.CTAM02
        AND        PP.CNCMAP = C.CTAM03
        AND        PP.CTACR1 = C.CTACR1
        AND        PP.CTACR2 = C.CTACR2
        UNION ALL
        SELECT    E.E_CODIGO, E.DES_EMPRESA, C.CLA_FE_ID, C.CLA_FE_DES,
                NVL(C.CLA_ATRIBUTO6,'') DIVISION,
                NVL(C.CLA_ATRIBUTO4,'') AGRUPAMIENTO,
                NVL(C.CLA_ATRIBUTO2,'') RUBRO,
                'X' ARSMAP, 'X' AEJMAP, 'X' CNCMAP, 'X' CTACR1, H.ATRIBUTO_2 CTACR2,
                TO_CHAR (TO_DATE (H.MES, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') AS MES,
                H.MONEDA_IMP, 0 PPTO_OPERATIVO  , H.IMPORTE_LINEA * TO_NUMBER (CFU.CLA_ATRIBUTO5)  PPTO_FLUJO ,
                M.TIPO_CAMBIO TC_ORIGINAL, M.TIPO_CAMBIO TC_FLUJO, 'IMPORTADO',
                H.ATRIBUTO_3 AS VERSION_IMPORTADOS, NULL AS VERSION_EXTRAIDOS
        FROM    FECXC.FECXP_IMPORTACION_DATOS_HIST H,
                FECXC.FECXC_EMPRESAS E,
                FECXC.FECXP_CLASIFICACION_FE C,
                FECXC.FECXP_MONEDAS M,
                FECXP_CLASIFICACION_FE CFU
        WHERE    H.TIPO_IMPORTACION = 'P'
        AND        E.CUAL_ERP = 'S'
        AND        E.E_CODIGO = H.E_EMPRESA_IMP
        AND        C.CLA_FE_ID = H.CLA_FE_ID_IMP
        AND        M.MON_ORACLE = H.MONEDA_IMP
        AND        M.MES = H.MES
        AND        M.PERIODO = TO_NUMBER (TO_CHAR (H.FECHA, 'YYYY'))
        AND                         CFU.CLA_FE_ID=H.CLA_FE_ID_IMP
        ) P,
        FECXC.FECXC_EMP_X_SEGMENTO ES,
        FECXC.FECXC_SEGMENTOS_FLUJO SF
WHERE    ES.ID_SEGMENTO NOT IN (11,15, 17, 18, 20, 26, 6, 13, 25)
AND        ES.ID_SEGMENTO = SF.ID_SEGMENTO
AND        ES.E_CODIGO = P.E_CODIGO) WHERE DIVISION  = V_DIVISION
                                  AND AGRUPAMIENTO = V_AGRUPAMIENTO
                                  AND RUBRO = V_RUBRO
                                  AND DES_EMPRESA = V_E_EMPRESA_DES
                                  AND MONEDA = V_MONEDA_IMP
                                  AND ARSMAP = V_CTA
                                  AND AEJMAP = V_SCT
                                  AND CNCMAP = V_CC
                                  AND CTACR1 = V_ICIA   ;
BEGIN
IF TIPO_IMPORTACION = 'R' THEN
 SELECT DIVISION,AGRUPAMIENTO,RUBRO,CLA_FE_ID_IMP,CLA_FE_DES,E_EMPRESA_IMP,E_EMPRESA_DES,FOLIO_SET,NO_CLIENTE,REFERENCIA,DESCRIPCION,TIPO_OPERACION,
               ID_BANCO,FORMA_PAGO,ID_CHEQUERA,ESTATUS_MOVIMIENTO,BENEFICIARIO,CONCEPTO,ORIGEN_MOVIMIENTO,NUMERO_DE_PARTIDA,CIA,NEG,CTA,SCT,CC,ICIA,
               TOP,ESTATUS,FECHA_APLICACION,MONEDA_IMP,IMPORTE_LINEA
          INTO V_DIVISION,V_AGRUPAMIENTO,V_RUBRO,V_CLA_FE_ID,V_CLA_FE_DES,V_E_CODIGO,V_E_EMPRESA_DES,V_FOLIO_SET,V_NO_CLIENTE,V_REFERENCIA,V_DESCRIPCION,V_TIPO_OPERACION,
               V_ID_BANCO,V_FORMA_PAGO,V_ID_CHEQUERA, V_ESTATUS_MOVIMIENTO,V_BENEFICIARIO,V_CONCEPTO,V_ORIGEN_MOVIMIENTO,V_NUMERO_DE_PARTIDA,V_CIA,
               V_NEG,V_CTA,V_SCT,V_CC,V_ICIA,V_TOP,V_ESTATUS,V_FECHA_APLICACION,V_MONEDA_IMP,V_IMPORTE_LINEA
               FROM  FECXP_IMPORTACION_DATOS WHERE FOLIO_SET=FOLIO_SET
                                             AND ATRIBUTO_1 = V_ID_SESION;
  FOR I IN C_FOLIOS_ORACLE_REAL(FOLIO_SET,NUMERO_DE_PARTIDA,E_CODIGO ) LOOP
             IF (V_DIVISION=I.DIVISION) OR (V_DIVISION  IS NULL AND I.DIVISION IS NULL) THEN
                IF (V_AGRUPAMIENTO = I.AGRUPAMIENTO) OR (V_AGRUPAMIENTO IS NULL AND I.AGRUPAMIENTO  IS NULL)       THEN
                   IF (V_RUBRO = I.RUBRO)  OR (V_RUBRO IS NULL AND I.RUBRO IS NULL)              THEN
                          IF (V_E_EMPRESA_DES=I.DES_EMPRESA) OR (V_E_EMPRESA_DES IS NULL AND I.DES_EMPRESA IS NULL)  THEN
                               IF (V_NO_CLIENTE=I.NO_CLIENTE) OR (V_NO_CLIENTE IS NULL AND I.NO_CLIENTE IS NULL)  THEN
                                 IF (V_REFERENCIA=I.REFERENCIA) OR (V_REFERENCIA IS NULL AND I.REFERENCIA IS NULL) THEN
                                   IF (V_DESCRIPCION=I.DESCRIPCION) OR (V_DESCRIPCION IS NULL AND I.DESCRIPCION IS NULL) THEN
                                     IF (V_TIPO_OPERACION =I.TIPO_OPERACION) OR (V_TIPO_OPERACION IS NULL AND I.TIPO_OPERACION IS NULL) THEN
                                       IF (V_ID_BANCO=I.ID_BANCO) OR (V_ID_BANCO  IS NULL AND I.ID_BANCO IS NULL) THEN
                                         IF (V_FORMA_PAGO=I.FORMA_PAGO) OR (V_FORMA_PAGO IS NULL AND I.FORMA_PAGO IS NULL) THEN
                                           IF (V_ID_CHEQUERA=I.ID_CHEQUERA) OR (V_ID_CHEQUERA IS NULL AND I.ID_CHEQUERA IS NULL) THEN
                                             IF (V_ESTATUS_MOVIMIENTO =I.ESTATUS_MOVIMIENTO) OR (V_ESTATUS_MOVIMIENTO IS NULL AND I.ESTATUS_MOVIMIENTO IS NULL) THEN
                                               IF (V_BENEFICIARIO =I.BENEFICIARIO) OR (V_BENEFICIARIO IS NULL AND I.BENEFICIARIO IS NULL) THEN
                                                 IF (V_CONCEPTO =I.CONCEPTO) OR (V_CONCEPTO IS NULL AND I.CONCEPTO IS NULL) THEN
                                                    IF (V_ORIGEN_MOVIMIENTO = I.ORIGEN_MOVIMIENTO) OR(V_ORIGEN_MOVIMIENTO IS NULL AND I.ORIGEN_MOVIMIENTO IS NULL)THEN
                                                       IF (V_NUMERO_DE_PARTIDA = I.NUMERO_DE_PARTIDA) OR (V_NUMERO_DE_PARTIDA IS NULL AND I.NUMERO_DE_PARTIDA IS NULL) THEN
                                                          IF (V_CIA=I.ORACLE_SEGMENTO1) OR (V_CIA IS NULL AND I.ORACLE_SEGMENTO1 IS NULL) THEN
                                                             IF (V_NEG = I.ORACLE_SEGMENTO2) OR (V_NEG IS NULL AND I.ORACLE_SEGMENTO2 IS NULL) THEN
                                                                IF (V_CTA= I.ORACLE_SEGMENTO3) OR (V_CTA IS NULL AND I.ORACLE_SEGMENTO3 IS NULL) THEN
                                                                   IF (V_SCT =I.ORACLE_SEGMENTO4) OR (V_SCT IS NULL AND I.ORACLE_SEGMENTO4 IS NULL) THEN
                                                                     IF (V_CC = I.ORACLE_SEGMENTO5) OR (V_CC IS NULL AND I.ORACLE_SEGMENTO5 IS NULL) THEN
                                                                        IF (V_ICIA = I.ORACLE_SEGMENTO6) OR (V_ICIA IS NULL AND I.ORACLE_SEGMENTO6 IS NULL) THEN
                                                                            IF (V_TOP = I.ORACLE_SEGMENTO7) OR (V_TOP IS NULL AND I.ORACLE_SEGMENTO7 IS NULL) THEN
                                                                               IF (V_ESTATUS = I.ESTATUS) OR (V_ESTATUS IS NULL AND I.ESTATUS IS NULL) THEN
                                                                                  IF (V_FECHA_APLICACION =I.FECHA_APLICACION) OR (V_FECHA_APLICACION IS NULL AND I.FECHA_APLICACION IS NULL) THEN
                                                                                    IF (V_MONEDA_IMP =I.MONEDA) OR (V_MONEDA_IMP IS NULL AND I.MONEDA IS NULL) THEN
                                                                                        NULL;
                                                                                    ELSE
                                                                                         V_MENSAJE := 'LA MONEDA=' ||V_MONEDA_IMP|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.MONEDA;
                                                                                    END IF;
                                                                                  ELSE
                                                                                         V_MENSAJE := 'LA FECHA='||V_FECHA_APLICACION|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.FECHA_APLICACION;
                                                                                  END IF;
                                                                               ELSE
                                                                                   V_MENSAJE := 'EL ESTATUS='||V_ESTATUS|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ESTATUS;
                                                                               END IF;
                                                                            ELSE
                                                                               V_MENSAJE := 'EL TOP='||V_TOP||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO7;
                                                                            END IF;
                                                                        ELSE
                                                                           V_MENSAJE := 'LA ICIA='||V_ICIA|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO6;
                                                                        END IF;
                                                                     ELSE
                                                                       V_MENSAJE := 'EL CC='||V_CC||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO5;
                                                                     END IF;
                                                                   ELSE
                                                                      V_MENSAJE := 'LA SCT='||V_SCT||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO4;
                                                                   END IF;
                                                                 ELSE
                                                                    V_MENSAJE := 'LA CTA='||V_CTA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO3;
                                                                 END IF;
                                                               ELSE
                                                                  V_MENSAJE := 'LA NEG='||V_NEG||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO2;
                                                               END IF;
                                                             ELSE
                                                                V_MENSAJE := 'LA CIA='||V_CIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO1;
                                                             END IF;
                                                           ELSE
                                                              V_MENSAJE := 'EL NO DE PARTIDA='||V_NUMERO_DE_PARTIDA|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.NUMERO_DE_PARTIDA;
                                                           END IF;
                                                         ELSE
                                                            V_MENSAJE := 'EL ORIGEN DEL MOVIMIENTO='||V_ORIGEN_MOVIMIENTO|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORIGEN_MOVIMIENTO;
                                                         END IF;
                                                       ELSE
                                                          V_MENSAJE := 'EL CONCEPTO='||V_CONCEPTO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CONCEPTO;
                                                       END IF;
                                                     ELSE
                                                        V_MENSAJE := 'EL BENEFICIARIO='||V_BENEFICIARIO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.BENEFICIARIO;
                                                     END IF;
                                                   ELSE
                                                      V_MENSAJE := 'EL ESTATUS='||V_ESTATUS_MOVIMIENTO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ESTATUS_MOVIMIENTO;
                                                   END IF;
                                                 ELSE
                                                     V_MENSAJE := 'EL ID_CHEQUERA='||V_ID_CHEQUERA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ID_CHEQUERA;
                                                 END IF;
                                               ELSE
                                                     V_MENSAJE := 'EL FORMA PAGO='||V_FORMA_PAGO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.FORMA_PAGO;
                                               END IF;
                                             ELSE
                                                 V_MENSAJE := 'EL ID_BANCO='||V_ID_BANCO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ID_BANCO;
                                             END IF;
                                           ELSE
                                               V_MENSAJE := 'EL TIPO DE OPERACION ='||V_TIPO_OPERACION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.TIPO_OPERACION;
                                           END IF;
                                         ELSE
                                             V_MENSAJE := 'LA DESCRIPCION='||V_DESCRIPCION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DESCRIPCION;
                                         END IF;
                                       ELSE
                                          V_MENSAJE := 'LA REFERENCIA='||V_REFERENCIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.REFERENCIA;
                                       END IF;
                                  ELSE
                                        V_MENSAJE := 'EL NO DE CLIENTE='||V_NO_CLIENTE||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.NO_CLIENTE;
                                  END IF;
                                ELSE
                                    V_MENSAJE := 'LA EMPRESA='||V_E_EMPRESA_DES||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DES_EMPRESA;
                                END IF;
                           ELSE
                              V_MENSAJE := 'EL RUBRO='||V_RUBRO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.RUBRO;
                           END IF;
                    ELSE
                       V_MENSAJE := 'EL AGRUPAMIENTO= '||V_AGRUPAMIENTO||' NO CORRESPONDE CON LA LINEA ORIGINAL= '||I.AGRUPAMIENTO;
                    END IF;
                 ELSE
                    V_MENSAJE := 'LA DIVISION='||V_DIVISION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DIVISION;
                 END IF;
  END LOOP;
  FOR I IN C_FOLIOS_SOIN_REAL(FOLIO_SET,ESTATUS_MOVIMIENTO ) LOOP
             IF (V_DIVISION=I.DIVISION) OR (V_DIVISION  IS NULL AND I.DIVISION IS NULL) THEN
                IF (V_AGRUPAMIENTO = I.AGRUPAMIENTO) OR(V_AGRUPAMIENTO  IS NULL AND I.AGRUPAMIENTO IS NULL)THEN
                   IF (V_RUBRO = I.RUBRO) OR(V_RUBRO   IS NULL AND I.RUBRO IS NULL) THEN
                          IF (V_E_CODIGO =I.E_CODIGO) OR(V_E_CODIGO  IS NULL AND I.E_CODIGO IS NULL)  THEN
                               IF (V_E_EMPRESA_DES=I.DES_EMPRESA) OR(V_E_EMPRESA_DES  IS NULL AND I.DES_EMPRESA IS NULL)  THEN
                                  IF (V_NO_CLIENTE=I.NO_CLIENTE) OR(V_NO_CLIENTE  IS NULL AND I.NO_CLIENTE IS NULL) THEN
                                     IF (V_REFERENCIA =I.REFERENCIA) OR(V_REFERENCIA  IS NULL AND I.REFERENCIA IS NULL) THEN
                                       IF (V_DESCRIPCION=I.DESCRIPCION) OR(V_DESCRIPCION  IS NULL AND I.DESCRIPCION IS NULL) THEN
                                         IF (V_TIPO_OPERACION=I.TIPO_OPERACION) OR(V_TIPO_OPERACION  IS NULL AND I.TIPO_OPERACION IS NULL) THEN
                                           IF (V_ID_BANCO=I.ID_BANCO) OR(V_ID_BANCO  IS NULL AND I.ID_BANCO IS NULL) THEN
                                             IF (V_FORMA_PAGO =I.FORMA_PAGO) OR(V_FORMA_PAGO  IS NULL AND I.FORMA_PAGO IS NULL) THEN
                                               IF (V_ID_CHEQUERA =I.ID_CHEQUERA) OR(V_ID_CHEQUERA  IS NULL AND I.ID_CHEQUERA IS NULL) THEN
                                                 IF (V_ESTATUS_MOVIMIENTO =I.ESTATUS_MOVIMIENTO) OR(V_ESTATUS_MOVIMIENTO  IS NULL AND I.ESTATUS_MOVIMIENTO IS NULL) THEN
                                                   IF (V_ORIGEN_MOVIMIENTO = I.ORIGEN_MOVIMIENTO) OR(V_ORIGEN_MOVIMIENTO IS NULL AND I.ORIGEN_MOVIMIENTO IS NULL)THEN
                                                     IF (V_BENEFICIARIO = I.BENEFICIARIO) OR(V_BENEFICIARIO  IS NULL AND I.BENEFICIARIO IS NULL) THEN
                                                        IF (V_CONCEPTO = I.CONCEPTO) OR(V_CONCEPTO  IS NULL AND I.CONCEPTO IS NULL) THEN
                                                          IF (V_NUMERO_DE_PARTIDA = I.NUMERO_DE_PARTIDA_SOIN) OR(V_NUMERO_DE_PARTIDA  IS NULL AND I.NUMERO_DE_PARTIDA_SOIN IS NULL) THEN
                                                              IF (V_CTA= I.CTAM01) OR(V_CTA  IS NULL AND I.CTAM01 IS NULL) THEN
                                                                IF (V_SCT =I.CTAM02) OR(V_SCT  IS NULL AND I.CTAM02 IS NULL) THEN
                                                                   IF (V_CC = I.CTAM03) OR(V_CC  IS NULL AND I.CTAM03 IS NULL) THEN
                                                                      IF (V_ESTATUS = I.ESTATUS) OR(V_ESTATUS  IS NULL AND I.ESTATUS IS NULL) THEN
                                                                         IF (V_FECHA_APLICACION = I.FECHA_APLICACION) OR(V_FECHA_APLICACION  IS NULL AND I.FECHA_APLICACION IS NULL) THEN
                                                                             IF (V_MONEDA_IMP = I.MONEDA) OR(V_MONEDA_IMP  IS NULL AND  I.MONEDA IS NULL) THEN
                                                                                IF (V_IMPORTE_LINEA =I.IMPORTE_LINEA_TC_O) OR(V_IMPORTE_LINEA  IS NULL AND I.IMPORTE_LINEA_TC_O IS NULL) THEN
                                                                                   NULL;
                                                                                ELSE
                                                                                         V_MENSAJE := 'EL IMPORTE='||V_IMPORTE_LINEA|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.IMPORTE_LINEA_TC_O;
                                                                                  END IF;
                                                                               ELSE
                                                                                   V_MENSAJE := 'LA MONEDA='||V_MONEDA_IMP|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.MONEDA;
                                                                               END IF;
                                                                            ELSE
                                                                               V_MENSAJE :=  'LA FECHA='||V_FECHA_APLICACION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.FECHA_APLICACION;
                                                                            END IF;
                                                                        ELSE
                                                                           V_MENSAJE :=   'EL ESTATUS='||V_ESTATUS||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ESTATUS;
                                                                        END IF;
                                                                     ELSE
                                                                       V_MENSAJE :=  'EL CC='||V_CC|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CTAM03;
                                                                     END IF;
                                                                   ELSE
                                                                      V_MENSAJE :=  'LA SCT='||V_SCT||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CTAM02;
                                                                   END IF;
                                                                 ELSE
                                                                    V_MENSAJE :=  'LA CTA='||V_CTA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CTAM01;
                                                                 END IF;
                                                               ELSE
                                                                  V_MENSAJE :=  'EL NO DE PARTIDA='||V_NUMERO_DE_PARTIDA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.NUMERO_DE_PARTIDA_SOIN;
                                                               END IF;
                                                             ELSE
                                                                V_MENSAJE :=  'EL CONCEPTO='||V_CONCEPTO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CONCEPTO;
                                                             END IF;
                                                           ELSE
                                                              V_MENSAJE :=  'EL BENEFICIARIO='||V_BENEFICIARIO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.BENEFICIARIO;
                                                           END IF;
                                                         ELSE
                                                            V_MENSAJE :=  'EL ORIGEN DEL MOVIMIENTO='||V_ORIGEN_MOVIMIENTO|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORIGEN_MOVIMIENTO;
                                                         END IF;
                                                       ELSE
                                                          V_MENSAJE :=  'EL ESTATUS DE MOVIMIENTO ='||V_ESTATUS_MOVIMIENTO|| ' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ESTATUS_MOVIMIENTO;
                                                       END IF;
                                                     ELSE
                                                        V_MENSAJE :=  'EL ID DE CHEQUERA='||V_ID_CHEQUERA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ID_CHEQUERA;
                                                     END IF;
                                                   ELSE
                                                      V_MENSAJE := 'LA FORMA PAGO='||V_FORMA_PAGO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.FORMA_PAGO;
                                                   END IF;
                                                 ELSE
                                                     V_MENSAJE :=  'EL ID BANCO='||V_ID_BANCO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ID_BANCO;
                                                 END IF;
                                               ELSE
                                                     V_MENSAJE :=  'EL TIPO DE OPERACION='||V_TIPO_OPERACION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.TIPO_OPERACION;
                                               END IF;
                                             ELSE
                                                 V_MENSAJE := 'LA DESCRIPCION='||V_DESCRIPCION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DESCRIPCION;
                                             END IF;
                                           ELSE
                                               V_MENSAJE := 'LA REFERENCIA='||V_REFERENCIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.REFERENCIA;
                                           END IF;
                                         ELSE
                                             V_MENSAJE := 'EL NO DE CLIENTE ='||V_NO_CLIENTE||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.NO_CLIENTE;
                                         END IF;
                                       ELSE
                                        V_MENSAJE := 'LA EMPRESA='||V_E_EMPRESA_DES||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DES_EMPRESA;
                                  END IF;
                                ELSE
                                    V_MENSAJE := 'EL CODIGO='||V_E_CODIGO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.E_CODIGO;
                                END IF;
                           ELSE
                              V_MENSAJE :=  'EL RUBRO='||V_RUBRO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.RUBRO;
                           END IF;
                    ELSE
                       V_MENSAJE := 'EL AGRUPAMIENTO='||V_AGRUPAMIENTO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.AGRUPAMIENTO;
                    END IF;
                 ELSE
                    V_MENSAJE := 'LA DIVISION='||V_DIVISION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DIVISION;
                 END IF;
  END LOOP;
END IF;
IF TIPO_IMPORTACION = 'P' THEN
  FOR I IN C_FOLIOS_ORACLE_PPTO(CODE_COMBINATION,SCT ) LOOP
             IF (V_DIVISION=I.DIVISION) OR (V_DIVISION  IS NULL AND I.DIVISION IS NULL) THEN
                IF (V_AGRUPAMIENTO = I.AGRUPAMIENTO) OR(V_AGRUPAMIENTO IS NULL AND I.AGRUPAMIENTO IS NULL) THEN
                   IF (V_RUBRO = I.RUBRO)OR(V_RUBRO IS NULL AND I.RUBRO IS NULL) THEN
                          IF (V_E_EMPRESA_DES=I.DES_EMPRESA)OR(V_E_EMPRESA_DES IS NULL AND I.DES_EMPRESA IS NULL)  THEN
                               IF (V_MONEDA_IMP=I.MONEDA)OR(V_MONEDA_IMP IS NULL AND I.MONEDA IS NULL)  THEN
                                 IF (V_CODE_COMBINATION=I.CODE_COMBINATION)OR(V_CODE_COMBINATION IS NULL AND I.CODE_COMBINATION IS NULL) THEN
                                   IF (V_DESCRIPCION=I.ORACLE_SEGMENTO1)OR(V_DESCRIPCION IS NULL AND I.ORACLE_SEGMENTO1 IS NULL) THEN
                                     IF (V_TIPO_OPERACION =I.ORACLE_SEGMENTO2)OR(V_TIPO_OPERACION IS NULL AND I.ORACLE_SEGMENTO2 IS NULL) THEN
                                       IF (V_ID_BANCO=I.ORACLE_SEGMENTO3)OR(V_ID_BANCO IS NULL AND I.ORACLE_SEGMENTO3 IS NULL) THEN
                                         IF (V_FORMA_PAGO=I.ORACLE_SEGMENTO4)OR(V_FORMA_PAGO IS NULL AND I.ORACLE_SEGMENTO4 IS NULL) THEN
                                           IF (V_ID_CHEQUERA=I.ORACLE_SEGMENTO5)OR(V_ID_CHEQUERA IS NULL AND I.ORACLE_SEGMENTO5 IS NULL) THEN
                                             IF (V_ESTATUS_MOVIMIENTO =I.ORACLE_SEGMENTO6)OR(V_ESTATUS_MOVIMIENTO IS NULL AND I.ORACLE_SEGMENTO6 IS NULL) THEN
                                               IF (V_BENEFICIARIO =I.ORACLE_SEGMENTO7)OR(V_BENEFICIARIO IS NULL AND I.ORACLE_SEGMENTO7 IS NULL) THEN
                                                 IF (V_CONCEPTO =I.VERSION_IMPORTADOS)OR(V_CONCEPTO IS NULL AND I.VERSION_IMPORTADOS IS NULL) THEN
                                                       NULL;
                                                      ELSE
                                                          V_MENSAJE := 'EL ATRIBUTO 3='||V_CONCEPTO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.VERSION_IMPORTADOS;
                                                       END IF;
                                                     ELSE
                                                        V_MENSAJE := 'EL TOP='||V_TOP||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO7;
                                                     END IF;
                                                   ELSE
                                                      V_MENSAJE := 'LA ICIA='||V_ICIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO6;
                                                   END IF;
                                                 ELSE
                                                     V_MENSAJE := 'EL CC='||V_CC||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO5;
                                                 END IF;
                                               ELSE
                                                     V_MENSAJE := 'LA SCT='||V_SCT||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO4;
                                               END IF;
                                             ELSE
                                                 V_MENSAJE := 'LA CTA='||V_CTA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO3;
                                             END IF;
                                           ELSE
                                               V_MENSAJE := 'LA NEG ='||V_NEG||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO2;
                                           END IF;
                                         ELSE
                                             V_MENSAJE := 'LA CIA='||V_CIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.ORACLE_SEGMENTO1;
                                         END IF;
                                       ELSE
                                          V_MENSAJE := 'EL CODIGO='||V_CODE_COMBINATION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CODE_COMBINATION;
                                       END IF;
                                  ELSE
                                        V_MENSAJE := 'LA MONEDA='||V_MONEDA_IMP||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.MONEDA;
                                  END IF;
                                ELSE
                                    V_MENSAJE := 'LA EMPRESA='||V_E_EMPRESA_DES||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DES_EMPRESA;
                                END IF;
                           ELSE
                              V_MENSAJE := 'EL RUBRO='||V_RUBRO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.RUBRO;
                           END IF;
                    ELSE
                       V_MENSAJE := 'EL AGRUPAMIENTO= '||V_AGRUPAMIENTO||' NO CORRESPONDE CON LA LINEA ORIGINAL= '||I.AGRUPAMIENTO;
                    END IF;
                 ELSE
                    V_MENSAJE := 'LA DIVISION='||V_DIVISION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DIVISION;
                 END IF;
  END LOOP;
   END IF;
  /*
  FOR I IN CC_FOLIOS_SOIN_PPTO(FOLIO_SET,NUMERO_DE_PARTIDA ) LOOP
             IF (V_DIVISION=I.DIVISION) OR (V_DIVISION  IS NULL AND I.DIVISION IS NULL) THEN
                IF V_AGRUPAMIENTO = I.AGRUPAMIENTO        THEN
                   IF V_RUBRO      = I.RUBRO               THEN
                          IF V_E_EMPRESA_DES=I.DES_EMPRESA  THEN
                               IF V_NO_CLIENTE=I.MONEDA  THEN
                                 IF V_REFERENCIA=I.AEJMAP THEN
                                   IF V_DESCRIPCION=I.CNCMAP THEN
                                     IF V_TIPO_OPERACION =I.CTACR1 THEN
                                       IF V_ID_BANCO=I.CTACR2 THEN
                                         IF V_FORMA_PAGO=I.FORMA_PAGO THEN
                                               ELSE
                                                     V_MENSAJE := 'EL FORMA PAGO='||V_FORMA_PAGO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.FORMA_PAGO;
                                               END IF;
                                             ELSE
                                                 V_MENSAJE := 'EL ID_BANCO='||V_ID_BANCO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CTACR2;
                                             END IF;
                                           ELSE
                                               V_MENSAJE := 'EL TIPO DE OPERACION ='||V_TIPO_OPERACION||'NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CTACR1;
                                           END IF;
                                         ELSE
                                             V_MENSAJE := 'LA DESCRIPCION='||V_DESCRIPCION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.CNCMAP;
                                         END IF;
                                       ELSE
                                          V_MENSAJE := 'LA REFERENCIA='||V_REFERENCIA||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.AEJMAP;
                                       END IF;
                                  ELSE
                                        V_MENSAJE := 'EL NO DE CLIENTE='||V_NO_CLIENTE||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.NO_MONEDA;
                                  END IF;
                                ELSE
                                    V_MENSAJE := 'LA EMPRESA='||V_E_EMPRESA_DES||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DES_EMPRESA;
                                END IF;
                           ELSE
                              V_MENSAJE := 'EL RUBRO='||V_RUBRO||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.RUBRO;
                           END IF;
                    ELSE
                       V_MENSAJE := 'EL AGRUPAMIENTO= '||V_AGRUPAMIENTO||' NO CORRESPONDE CON LA LINEA ORIGINAL= '||I.AGRUPAMIENTO;
                    END IF;
                 ELSE
                    V_MENSAJE := 'LA DIVISION='||V_DIVISION||' NO CORRESPONDE CON LA LINEA ORIGINAL='||I.DIVISION;
                 END IF;
  END LOOP;
  */
   RETURN V_MENSAJE ;
END;
/
