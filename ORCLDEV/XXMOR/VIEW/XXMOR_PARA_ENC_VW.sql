CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_PARA_ENC_VW" ("ID_SOLICITUD", "P_ORDID", "P_ADVID", "P_ACCTHDRID", "P_STNID", "P_ORDTYP", "P_STRDT", "P_EDT", "P_MCONTID", "P_AGYESTNUM", "P_PRDID1", "P_RTCRD", "P_USRFLD1", "P_USRFL10", "P_TOTSPTORD", "P_CMT", "P_TARGET", "P_CREATED_BY", "P_TOTVALORD", "PROC_POR_LINEA", "P_ID_SOL_HNA", "P_ID_HNA_PDGM", "P_FZA_VTAS", "P_AUX1", "P_AUX2", "P_EMAIL") AS 
  SELECT --Las ordenes (solicitudes) PROCESAR POR LINEA
       ENC.ID_SOLICITUD,
       (SELECT TO_NUMBER(ER.AUX2)
        FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
        WHERE  ER.ID_SOLICITUD = ENC.ID_SOLICITUD
        AND    ER.LINEA        = 0
       )                                  AS P_ORDID,
       SUBSTR(ENC.ADVID, 1, 6)            AS P_ADVID,
       ENC.ACCTHDRID                      AS P_ACCTHDRID,
       DECODE(NVL(FV.RESPETA_CANAL,'0'), '0'
                                       , ENC.AGRUPADOR
                                       , ENC.PLATAFORMA_CANAL
             )                            AS P_STNID,
       0                                  AS P_ORDTYP,
       XXMOR_FUNCIONAL_PKG.XXMOR_SOL_FECHAS_FUN
                          (    ENC.ID_SOLICITUD,
                               NULL,
                               'FI_ENC'
                          )               AS P_STRDT,
       XXMOR_FUNCIONAL_PKG.XXMOR_SOL_FECHAS_FUN
                          (    ENC.ID_SOLICITUD,
                               NULL,
                               'FF_ENC'
                          )               AS P_EDT,
       ENC.MCONTID                        AS P_MCONTID,
       ENC.AGYESTNUM                      AS P_AGYESTNUM,
       (SELECT SUBSTR(PRDID_DESC, 0, 4)
        FROM   XXMOR_SOLICITUDES_ENC_TAB DET
        WHERE  DET.ID_SOLICITUD = ENC.ID_SOLICITUD
       )                                  AS P_PRDID1,
       ENC.RTCRD                          AS P_RTCRD,
       (SELECT SUBSTR(TIPO_FACTURACION, 0, 6)
        FROM   XXMOR_SOLICITUDES_ENC_TAB
        WHERE ID_SOLICITUD = ENC.ID_SOLICITUD
       )                                  AS P_USRFLD1,
       0                                  AS P_USRFL10,
       XXMOR_FUNCIONAL_PKG.XXMOR_SOL_TOTALES_FUN
                          (    ENC.ID_SOLICITUD,
                               NULL,
                               'TOT_SPOTS_BIEN'
                          )               AS P_TOTSPTORD,
       ENC.COMENTARIOS                    AS P_CMT,
       UPPER(TRIM(TARGET))                AS P_TARGET,
       ENC.CREATED_BY                     AS P_CREATED_BY,
       XXMOR_FUNCIONAL_PKG.XXMOR_SOL_TOTALES_FUN
                          (    ENC.ID_SOLICITUD,
                               NULL,
                               'TOT_X_O'
                          )               AS P_TOTVALORD,
       NVL2(ENC.PROC_POR_LINEA, '1', '0') AS PROC_POR_LINEA,
       NVL(ENC.ID_SOLICITUD_HNA,0)        AS P_ID_SOL_HNA,
       (SELECT NVL(TO_NUMBER(ER.ESTAT_ID_FORANEO),0)
        FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
        WHERE  ER.ID_SOLICITUD = ENC.ID_SOLICITUD_HNA
        AND    ER.LINEA        = 0
       )                                  AS P_ID_HNA_PDGM,
       (SELECT FV.IDENT_FZA_VENTAS
        FROM   XXMOR_FZAS_VTAS_TAB FV
        WHERE  FV.ID_FZA_VENTAS = ENC.ID_FZA_VENTAS
       )                                  AS P_FZA_VTAS,
       (SELECT COUNT(1)
        FROM   XXMOR_SOLICITUDES_DET_TAB D
        WHERE  ID_SOLICITUD = ENC.ID_SOLICITUD
        AND    EXISTS         (SELECT 1
                               FROM   XXMOR_SOLICITUDES_EST_REP_TAB R
                               WHERE  R.ID_SOLICITUD = D.ID_SOLICITUD
                               AND    R.LINEA        = D.LINEA
                               AND    R.AUX2         IS NULL
                              )
        AND EXISTS            (            --LINEAS QUE YA HAYAN ENTRADO A PARADIGM
                               SELECT 1
                               FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                               WHERE  ER.ID_SOLICITUD     = D.ID_SOLICITUD
                               AND    ER.LINEA            = D.LINEA
                               AND    ER.ESTAT_ID_FORANEO IS NULL
                              )
        AND NOT EXISTS        (                    -- QUE LAS LINEAS ESTEN BIEN
                               SELECT 1
                               FROM   XXMOR_CONCOM_RPTA_TAB CR
                               WHERE  CR.ESTATUS_ORDUNI             = '10'
                               AND    CR.ID_SOLICITUD               = D.ID_SOLICITUD
                               AND    TO_NUMBER(CR.NUMLINEA_CONCOM) = D.LINEA
                              )
       )                                  AS P_AUX1,
       '  '                               AS P_AUX2,
       ENC.EMAIL                          AS P_EMAIL
FROM   XXMOR_SOLICITUDES_ENC_TAB ENC,
       XXMOR_FZAS_VTAS_TAB       FV,
       XXMOR_CONCOM_RPTA_TAB     CR
WHERE  ENC.ID_FZA_VENTAS                     = FV.ID_FZA_VENTAS
AND    ENC.ID_SOLICITUD                      = CR.ID_SOLICITUD
AND    CR.NUMLINEA_CONCOM                    IS NULL
AND    CR.ESTATUS_ORDUNI                     = 20
AND    XXMOR_FUNCIONAL_PKG.XXMOR_FECHA_ENC_VAL_FUN
                          (ENC.ID_SOLICITUD) > 0
AND    XXMOR_FUNCIONAL_PKG.XXMOR_ORDEN_ESTATUS_FUN
                          (ENC.ID_SOLICITUD,
                           NULL,
                           'BANDERA_INSERT'
                          )                  = 1
AND    XXMOR_FUNCIONAL_PKG.XXMOR_SOL_AGR_MULT_VAL_FUN
                          (ENC.ID_SOLICITUD) = 1
AND    NOT EXISTS                              (SELECT 1
                                                FROM   XXMOR_CONCOM_RPTA_TAB C
                                                WHERE  C.ID_SOLICITUD    = ENC.ID_SOLICITUD
                                                AND    C.NUMLINEA_CONCOM IS NULL
                                                AND    C.ESTATUS_ORDUNI  = '10'
                                               )
UNION
SELECT --Las ordenes PROCESAR POR ORDEN
       ENC.ID_SOLICITUD,
       (SELECT TO_NUMBER(AUX2)
        FROM   XXMOR_SOLICITUDES_EST_REP_TAB
        WHERE  ID_SOLICITUD = ENC.ID_SOLICITUD
        AND    LINEA        = 0
       )                                  AS P_ORDID,
       SUBSTR(ENC.ADVID, 1, 6)            AS P_ADVID,
       ENC.ACCTHDRID                      AS P_ACCTHDRID,
       DECODE(NVL(FV.RESPETA_CANAL,'0'), '0'
                                       , ENC.AGRUPADOR
                                       , ENC.PLATAFORMA_CANAL
             )                            AS P_STNID,
       0                                  AS P_ORDTYP,
       XXMOR_FUNCIONAL_PKG.XXMOR_SOL_FECHAS_FUN
                          (ENC.ID_SOLICITUD,
                           NULL,
                           'FI_ENC'
                          )               AS P_STRDT,
       XXMOR_FUNCIONAL_PKG.XXMOR_SOL_FECHAS_FUN
                          (ENC.ID_SOLICITUD,
                           NULL,
                           'FF_ENC'
                          )               AS P_EDT,
       ENC.MCONTID                        AS P_MCONTID,
       ENC.AGYESTNUM                      AS P_AGYESTNUM,
       (SELECT SUBSTR(PRDID_DESC, 0, 4)
        FROM   XXMOR_SOLICITUDES_ENC_TAB DET
        WHERE DET.ID_SOLICITUD = ENC.ID_SOLICITUD
       )                                  AS P_PRDID1,
       ENC.RTCRD                          AS P_RTCRD,
       (SELECT SUBSTR(TIPO_FACTURACION, 0, 6)
        FROM   XXMOR_SOLICITUDES_ENC_TAB
        WHERE  ID_SOLICITUD = ENC.ID_SOLICITUD
       )                                  AS P_USRFLD1,
       0                                  AS P_USRFL10,
       XXMOR_FUNCIONAL_PKG.XXMOR_SOL_TOTALES_FUN
                          (ENC.ID_SOLICITUD,
                           NULL,
                           'TOT_SPOTS_BIEN'
                          )               AS P_TOTSPTORD,
       ENC.COMENTARIOS                    AS P_CMT,
       UPPER(TRIM(TARGET))                AS P_TARGET,
       ENC.CREATED_BY                     AS P_CREATED_BY,
       XXMOR_FUNCIONAL_PKG.XXMOR_SOL_TOTALES_FUN
                          (ENC.ID_SOLICITUD,
                           NULL,
                           'TOT_X_O'
                          )               AS P_TOTVALORD,
       NVL2(ENC.PROC_POR_LINEA, '1', '0') AS PROC_POR_LINEA,
       NVL(ENC.ID_SOLICITUD_HNA,0)        AS P_ID_SOL_HNA,
       (SELECT NVL(TO_NUMBER(ER.ESTAT_ID_FORANEO),0)
        FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
        WHERE  ER.ID_SOLICITUD = ENC.ID_SOLICITUD_HNA
        AND    ER.LINEA        = 0
       )                                  AS P_ID_HNA_PDGM,
       (SELECT FV.IDENT_FZA_VENTAS
        FROM   XXMOR_FZAS_VTAS_TAB FV
        WHERE  FV.ID_FZA_VENTAS = ENC.ID_FZA_VENTAS
       )                                  AS P_FZA_VTAS,
       (SELECT COUNT(1)
        FROM   XXMOR_SOLICITUDES_DET_TAB D
        WHERE  ID_SOLICITUD = ENC.ID_SOLICITUD
        AND    EXISTS         (SELECT 1
                               FROM   XXMOR_SOLICITUDES_EST_REP_TAB R
                               WHERE  R.ID_SOLICITUD = D.ID_SOLICITUD
                               AND    R.LINEA        = D.LINEA
                               AND    R.AUX2         IS NULL
                              )
        AND    EXISTS         (            --LINEAS QUE YA HAYAN ENTRADO A PARADIGM
                               SELECT 1
                               FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                               WHERE  ER.ID_SOLICITUD     = D.ID_SOLICITUD
                               AND    ER.LINEA            = D.LINEA
                               AND    ER.ESTAT_ID_FORANEO IS NULL
                              )
        AND    NOT EXISTS     (                    -- QUE LAS LINEAS ESTEN BIEN
                               SELECT 1
                               FROM   XXMOR_CONCOM_RPTA_TAB CR
                               WHERE  CR.ESTATUS_ORDUNI = '10'
                               AND    CR.ID_SOLICITUD = D.ID_SOLICITUD
                               AND    TO_NUMBER(CR.NUMLINEA_CONCOM) = D.LINEA
                              )
       )                                  AS P_AUX1,
       '  '                               AS P_AUX2,
       ENC.EMAIL                          AS P_EMAIL
FROM   XXMOR_SOLICITUDES_ENC_TAB ENC,
       XXMOR_FZAS_VTAS_TAB       FV,
       XXMOR_CONCOM_RPTA_TAB     CR
WHERE  ENC.ID_FZA_VENTAS                     = FV.ID_FZA_VENTAS
AND    ENC.ID_SOLICITUD                      = CR.ID_SOLICITUD
AND    CR.NUMLINEA_CONCOM                    IS NULL
AND    PROC_POR_LINEA                        IS NOT NULL
AND    CR.ESTATUS_ORDUNI                     = 20
AND    NOT EXISTS                              (SELECT 1
                                                FROM   XXMOR_CONCOM_RPTA_TAB C
                                                WHERE  C.ID_SOLICITUD    = ENC.ID_SOLICITUD
                                                AND    C.NUMLINEA_CONCOM IS NULL
                                                AND    C.ESTATUS_ORDUNI  = '10'
                                               )
AND    XXMOR_FUNCIONAL_PKG.XXMOR_FECHA_ENC_VAL_FUN
                          (ENC.ID_SOLICITUD) > 0
AND    CR.ID_SOLICITUD                       NOT IN (SELECT DISTINCT ID_SOLICITUD
                                                     FROM   XXMOR_CONCOM_RPTA_TAB
                                                     WHERE  ID_SEG_NEG     = 1
                                                     AND    ESTATUS_ORDUNI = 10
                                                     --AND NVL(NUMLINEA_CONCOM,0) = 0
                                                     MINUS
                                                     --SE RESTAN LAS ORDENES QUE SON PROCESAR POR LINEA Y QUE EL ENCABEZADO ESTA BIEN
                                                     SELECT ID_SOLICITUD
                                                     FROM   XXMOR_CONCOM_RPTA_TAB
                                                     WHERE  ID_SEG_NEG     = 1
                                                     AND    ESTATUS_ORDUNI = 20
                                                     AND    NUMLINEA_CONCOM IS NULL
                                                    )
AND    XXMOR_FUNCIONAL_PKG.XXMOR_SOL_AGR_MULT_VAL_FUN
                          (ENC.ID_SOLICITUD) = 1
;
