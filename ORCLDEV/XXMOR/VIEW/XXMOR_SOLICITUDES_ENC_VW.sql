CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_SOLICITUDES_ENC_VW" ("ID_SOLICITUD", "ID_REQUEST", "ID_FZA_VENTAS", "ERR_ID_FZA_VENTAS", "NOMBRE_FZA_VENTAS", "ERR_NOMBRE_FZA_VENTAS", "ID_SOLICITUD_HNA", "PROC_POR_LINEA", "ERR_PROC_POR_LINEA", "GARANTIZADO", "ERR_GARANTIZADO", "ADVID", "ERR_ADVID", "MCONTID", "ERR_MCONTID", "MCONTID_CUTIN", "ERR_MCONTID_CUTIN", "EMAIL", "ERR_EMAIL", "AGYESTNUM", "ERR_AGYESTNUM", "ACCTHDRID", "ERR_ACCTHDRID", "RTCRDDSCR", "ERR_RTCRDDSCR", "RTCRD", "ERR_RTCRD", "RTCRDDSCR_CUTIN", "ERR_RTCRDDSCR_CUTIN", "COMENTARIOS", "ERR_COMENTARIOS", "SECNUM", "ERR_SECNUM", "PLATAFORMA_CANAL", "ERR_PLATAFORMA_CANAL", "AGRUPADOR", "ERR_AGRUPADOR", "PRDID_DESC", "ERR_PRDID_DESC", "PRDID", "ERR_PRDID", "TOTAL_SPOTS", "ERR_TOTAL_SPOTS", "TOTAL_CON_DESC", "ERR_TOTAL_CON_DESC", "TOTAL_SIN_DESC", "ERR_TOTAL_SIN_DESC", "TIPO_FACTURACION", "ERR_TIPO_FACTURACION", "DESCUENTO", "ERR_DESCUENTO", "TARGET", "ERR_TARGET", "ORDEN_ESTATUS", "DESC_NOTIFICACION", "ERR_DESC_NOTIFICACION", "TOTAL_EFECTIVO", "CRED_CORP", "SALDO_CPS", "SALDO_MASTER_CONTRACT", "AUT_CRED_CORP", "AUT_SALDO_CPS", "AUT_MC_TOPADO") AS 
  SELECT SE.ID_SOLICITUD,
       SE.ID_REQUEST,
       SE.ID_FZA_VENTAS,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'FZA_VENTAS'
                                    )
           ,0)                             AS ERR_ID_FZA_VENTAS,
       FZ.NOMBRE_FZA_VENTAS,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'FZA_VENTAS'
                                    )
           ,0)                             AS ERR_NOMBRE_FZA_VENTAS,
       SE.ID_SOLICITUD_HNA,
       NVL2(SE.PROC_POR_LINEA, 'SI', 'NO') PROC_POR_LINEA,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'PROC_POR_LINEA'
                                     )
           ,0)                             AS ERR_PROC_POR_LINEA,
       SE.GARANTIZADO,
       NVL (XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                     (    SE.ID_SOLICITUD,
                                          NULL,
                                          'GARANTIZADO'
                                     )
            ,0)                            AS ERR_GARANTIZADO,
       SE.ADVID,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'ADVID'
                                    )
           ,0)                             AS ERR_ADVID,
       SE.MCONTID,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'MCONTID'
                                    )
           ,0)                             AS ERR_MCONTID,
       SE.MCONTID_CUTIN,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'MCONTID'
                                    )
           ,0)                             AS ERR_MCONTID_CUTIN,
       SE.EMAIL,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'EMAIL'
                                    )
           ,0)                             AS ERR_EMAIL,
       SE.AGYESTNUM,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'AGYESTNUM'
                                    )
           ,0)                             AS ERR_AGYESTNUM,
       SE.ACCTHDRID,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'ACCTHDRID'
                                    )
           ,0)                             AS ERR_ACCTHDRID,
       SE.RTCRDDSCR,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'RTCRD'
                                    )
           ,0)                             AS ERR_RTCRDDSCR,
       SE.RTCRD,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'RTCRDSCR'
                                    )
           ,0)                             AS ERR_RTCRD,
       SE.RTCRDDSCR_CUTIN,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (   SE.ID_SOLICITUD,
                                        NULL,
                                        'MCONTID'
                                    )
           ,0)                             AS ERR_RTCRDDSCR_CUTIN,
       SE.COMENTARIOS,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'COMENTARIOS'
                                    )
           ,0)                             AS ERR_COMENTARIOS,
       SE.SECNUM,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'SECNUM'
                                    )
           ,0)                             AS ERR_SECNUM,
       SE.PLATAFORMA_CANAL,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'PLATAFORMA_CANAL'
                                    )
           ,0)                             AS ERR_PLATAFORMA_CANAL,
       SE.AGRUPADOR,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'AGRUPADOR'
                                    )
           ,0)                             AS ERR_AGRUPADOR,
       SE.PRDID_DESC,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'PRDID_DESC'
                                    )
           ,0)                             AS ERR_PRDID_DESC,
       SE.PRDID,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'PRDID'
                                    )
           ,0)                             AS ERR_PRDID,
       NVL(SE.TOTAL_SPOTS, XXMOR_FUNCIONAL_PKG.XXMOR_SOL_TOTALES_FUN
                                              (    SE.ID_SOLICITUD,
                                                   NULL,
                                                   'SP_X_O'
                                              )
          )                                AS TOTAL_SPOTS,
       XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                (    SE.ID_SOLICITUD,
                                     NULL,
                                     'TOTAL_SPOTS_PAQUETES'
                                )          ERR_TOTAL_SPOTS,
       XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_SOL_TOTALES_FUN
                                (    SE.ID_SOLICITUD,
                                     NULL,
                                     'TCD_X_O'
                                )          TOTAL_CON_DESC,
       XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                (    SE.ID_SOLICITUD,
                                     NULL,
                                     'TOT_LINEA_CON_DESC'
                                )          ERR_TOTAL_CON_DESC,
       XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_SOL_TOTALES_FUN
                                (    SE.ID_SOLICITUD,
                                     NULL,
                                     'TSD_X_O'
                                ),
       XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                (    SE.ID_SOLICITUD,
                                     NULL,
                                     'TOT_LINEA_SIN_DESC'
                                )          ERR_TOTAL_SIN_DESC,
       SE.TIPO_FACTURACION,
       NVL(XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                    (    SE.ID_SOLICITUD,
                                         NULL,
                                         'TIPO_FACTURACION'
                                    )
           ,0)                             AS ERR_TIPO_FACTURACION,
       SE.DESCUENTO,
       XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                (    SE.ID_SOLICITUD,
                                     NULL,
                                     'DESCUENTO'
                                )          ERR_DESCUENTO,
       SE.TARGET,
       XXMOR.XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN
                                (    SE.ID_SOLICITUD,
                                     NULL,
                                     'TARGET'
                                )          ERR_TARGET,
       XXMOR_FUNCIONAL_PKG.XXMOR_ORDEN_ESTATUS_FUN
                          (    SE.ID_SOLICITUD,
                               NULL,
                               'ESTATUS_ORD_N'
                          )                AS ORDEN_ESTATUS,
       (SELECT DESC_NOTIFICACION
        FROM   XXMOR_ORDENES_ESTATUS_TAB
        WHERE  ID_NOTIFICACION = XXMOR_FUNCIONAL_PKG.XXMOR_ORDEN_ESTATUS_FUN
                                                    (    SE.ID_SOLICITUD,
                                                         NULL,
                                                         'ESTATUS_ORD_N'
                                                    )
       )                                   AS DESC_NOTIFICACION,
       '0'                                 ERR_DESC_NOTIFICACION,
       (SELECT SUM (TOT_LINEA_SIN_DESC)
        FROM   XXMOR_SOLICITUDES_DET_TAB D,
               XXMOR_SOLICITUDES_EST_REP_TAB ER
        WHERE  D.ID_SOLICITUD = SE.ID_SOLICITUD
        AND    D.ID_SOLICITUD = ER.ID_SOLICITUD
        AND    D.LINEA        = ER.LINEA
        AND    ER.ESTAT_REP  != 2
       )                                   AS TOTAL_EFECTIVO,
       (CASE
            WHEN (SELECT COUNT(1)
                  FROM   XXMOR_CONCOM_RPTA_TAB XCR
                  WHERE  UPPER(XCR.CAMPO_CONCOM)      = 'CRED_CORP'
                  AND    UPPER(XCR.POSICION_CONCOM)   = 'ENCABEZADO'
                  AND    UPPER(XCR.ACCION_CONCOM)     = 'AUTORIZACION'
                  AND    NVL(XCR.ESTATUS_ORDUNI,'10') = '10'
                  AND    XCR.ID_SOLICITUD             = SE.ID_SOLICITUD
                 ) > 0 THEN
                1
            ELSE
                0
        END
       )                                   CRED_CORP,
       (CASE
            WHEN (SELECT COUNT(1)
                  FROM   XXMOR_CONCOM_RPTA_TAB XCR
                  WHERE  UPPER(XCR.CAMPO_CONCOM)      = 'CPS'
                  AND    UPPER(XCR.POSICION_CONCOM)   = 'ENCABEZADO'
                  AND    UPPER(XCR.ACCION_CONCOM)     = 'AUTORIZACION'
                  AND    NVL(XCR.ESTATUS_ORDUNI,'10') = '10'
                  AND    XCR.ID_SOLICITUD             = SE.ID_SOLICITUD
                 ) > 0 THEN
                1
            ELSE
                0
        END
       )                                   SALDO_CPS,
       (CASE
            WHEN (SELECT COUNT(1)
                  FROM   XXMOR_CONCOM_RPTA_TAB XCR
                  WHERE  UPPER(XCR.CAMPO_CONCOM)      = 'REQUEST/ORDEN/ENCABEZADO/CPSMASTERCONTRACT'
                  AND    UPPER(XCR.POSICION_CONCOM)   = 'ENCABEZADO'
                  AND    UPPER(XCR.ACCION_CONCOM)     = 'AUTORIZACION'
                  AND    NVL(XCR.ESTATUS_ORDUNI,'10') = '10'
                  AND    XCR.ID_SOLICITUD             = SE.ID_SOLICITUD
                 ) > 0 THEN
                1
            ELSE
                0
        END
       )                                   SALDO_MASTER_CONTRACT,
       NVL((SELECT XCR.DESC_CONCOM||'/'||XCR.DETALLE_CONCOM
            FROM   XXMOR_CONCOM_RPTA_TAB XCR
            WHERE  UPPER(XCR.CAMPO_CONCOM)      = 'CRED_CORP'
            AND    UPPER(XCR.POSICION_CONCOM)   = 'ENCABEZADO'
            AND    UPPER(XCR.ACCION_CONCOM)     = 'AUTORIZACION'
            AND    NVL(XCR.ESTATUS_ORDUNI,'10') = '10'
            AND    XCR.ID_SOLICITUD             = SE.ID_SOLICITUD
           ),'0'
          )                                AUT_CRED_CORP,
       NVL((SELECT XCR.DESC_CONCOM||'/'||XCR.DETALLE_CONCOM
            FROM   XXMOR_CONCOM_RPTA_TAB XCR
            WHERE  UPPER(XCR.CAMPO_CONCOM)      = 'CPS'
            AND    UPPER(XCR.POSICION_CONCOM)   = 'ENCABEZADO'
            AND    UPPER(XCR.ACCION_CONCOM)     = 'AUTORIZACION'
            AND    NVL(XCR.ESTATUS_ORDUNI,'10') = '10'
            AND    XCR.ID_SOLICITUD             = SE.ID_SOLICITUD
           ),'0'
          )                                AUT_SALDO_CPS,
       NVL((SELECT XCR.DESC_CONCOM||'/'||XCR.DETALLE_CONCOM
            FROM   XXMOR_CONCOM_RPTA_TAB XCR
            WHERE  UPPER(XCR.CAMPO_CONCOM)      = 'REQUEST/ORDEN/ENCABEZADO/CPSMASTERCONTRACT'
            AND    UPPER(XCR.POSICION_CONCOM)   = 'ENCABEZADO'
            AND    UPPER(XCR.ACCION_CONCOM)     = 'AUTORIZACION'
            AND    NVL(XCR.ESTATUS_ORDUNI,'10') = '10'
            AND    XCR.ID_SOLICITUD             = SE.ID_SOLICITUD
            AND    XCR.ID_RPTA_CONCOM           = (SELECT MAX(RC.ID_RPTA_CONCOM)
                                                   FROM   XXMOR_CONCOM_RPTA_TAB RC
                                                   WHERE  UPPER(RC.CAMPO_CONCOM)       = 'REQUEST/ORDEN/ENCABEZADO/CPSMASTERCONTRACT'
                                                   AND    UPPER(RC.POSICION_CONCOM)    = 'ENCABEZADO'
                                                   AND    UPPER(RC.ACCION_CONCOM)      = 'AUTORIZACION'
                                                   AND    NVL(XCR.ESTATUS_ORDUNI,'10') = '10'
                                                   AND    RC.ID_SOLICITUD              = XCR.ID_SOLICITUD
                                                  )
           ),'0'
          )                                AUT_MC_TOPADO
FROM   XXMOR_SOLICITUDES_ENC_TAB SE,
       XXMOR_FZAS_VTAS_TAB       FZ
WHERE  SE.ID_SEG_NEG    = 1
AND    SE.ID_FZA_VENTAS = FZ.ID_FZA_VENTAS;
