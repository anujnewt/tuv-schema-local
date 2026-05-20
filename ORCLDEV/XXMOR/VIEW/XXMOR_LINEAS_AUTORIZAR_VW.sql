CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_LINEAS_AUTORIZAR_VW" ("ID_SOLICITUD", "LINEA") AS 
  SELECT ID_SOLICITUD,
       LINEA
FROM   (SELECT DISTINCT
               ID_SOLICITUD,
               TO_NUMBER(NUMLINEA_CONCOM) LINEA
        FROM   XXMOR_CONCOM_RPTA_TAB R
        WHERE  R.ID_SEG_NEG     = 1
        AND    R.ESTATUS_ORDUNI = '20'
        AND    NOT EXISTS         (SELECT 1 -- EL ENCABEZADO NO TENGA ERRORES (REPROCESOS)
                                   FROM   XXMOR_CONCOM_RPTA_TAB CR
                                   WHERE  CR.ID_SEG_NEG           = 1
                                   AND    UPPER(CR.ACCION_CONCOM) = 'REPROCESO'
                                   AND    CR.ESTATUS_ORDUNI       = '10'
                                   AND    CR.ID_SOLICITUD         = R.ID_SOLICITUD
                                   AND    CR.NUMLINEA_CONCOM      IS NULL
                                  )
        AND    NOT EXISTS         (SELECT 1 -- LAS LINEAS NO TENGAN ERRORES (REPROCESOS)
                                   FROM   XXMOR_CONCOM_RPTA_TAB CR
                                   WHERE  CR.ID_SEG_NEG           = 1
                                   AND    UPPER(CR.ACCION_CONCOM) = 'REPROCESO'
                                   AND    CR.ESTATUS_ORDUNI       = '10'
                                   AND    CR.ID_SOLICITUD         = R.ID_SOLICITUD
                                   AND    CR.NUMLINEA_CONCOM      IS NOT NULL
                                   AND    CR.NUMLINEA_CONCOM      = R.NUMLINEA_CONCOM
                                  )
        AND    NOT EXISTS         (SELECT 1 -- LAS LINEAS DE DETALLE QUE NO HAN SIDO RECHAZADAS
                                   FROM   XXMOR_CONCOM_RPTA_TAB CR
                                   WHERE  CR.ID_SEG_NEG      = 1
                                   AND    CR.NUMLINEA_CONCOM IS NOT NULL
                                   AND    CR.ACCION_CONCOM   = 'RECHAZO'
                                   AND    CR.ESTATUS_ORDUNI  = '10'
                                   AND    CR.ID_SOLICITUD    = R.ID_SOLICITUD
                                   AND    CR.NUMLINEA_CONCOM = R.NUMLINEA_CONCOM
                                  )
        AND NOT EXISTS            (SELECT 1 -- LAS LINEAS DE DETALLE QUE NO HAN SIDO INSERTADAS
                                   FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                                   WHERE  ER.ID_SIST          = 1
                                   AND    ER.ESTAT_ID_FORANEO IS NOT NULL
                                   AND    ER.LINEA            != 0
                                   AND    ER.ID_SOLICITUD     = R.ID_SOLICITUD
                                   AND    ER.LINEA            = TO_NUMBER (R.NUMLINEA_CONCOM)
                                  )
          )
WHERE LINEA IS NOT NULL
ORDER BY LINEA;
