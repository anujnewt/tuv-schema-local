CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_PANTALLA_EST_VW" ("ID_SOLICITUD", "ID_FZA_VENTAS", "INF_ORDEN", "ID_PRDG", "ID_ONAIR", "NOM_ARCHIVO_SOL", "ID_ARCHIVO_SOL", "ORDEN_ESTATUS", "NOMBRE_FZA_VENTAS", "ERROR_LINEA", "ERROR_PARA", "CREATE_DATE", "FECHA_CREACION", "CREATED_BY", 
	 CONSTRAINT "XXMOR_PANTALLA_EST_PK" PRIMARY KEY ("ID_SOLICITUD") RELY DISABLE) AS 
  SELECT SE.ID_SOLICITUD,
       SE.ID_FZA_VENTAS,
       NULL                                            INF_ORDEN,
       (SELECT ER.ESTAT_ID_FORANEO
        FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
        WHERE  ER.ID_SOLICITUD = SE.ID_SOLICITUD
        AND    ER.LINEA        = 0
        AND    ER.ID_SIST      = 1
       )                                               ID_PRDG,
       NULL                                            ID_ONAIR,
       SA.NOM_ARCHIVO_SOL,
       SA.ID_ARCHIVO_SOL,
       XXMOR_FUNCIONAL_PKG.XXMOR_ORDEN_ESTATUS_FUN
                          (
                               SE.ID_SOLICITUD,
                               NULL,
                               'ESTATUS_ORDEN'
                          )                            ORDEN_ESTATUS,
       FV.NOMBRE_FZA_VENTAS,
       1,
       NVL((SELECT NVL(SER.ESTAT_ERROR_MSG, '0')
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB SER
            WHERE  SER.ID_SOLICITUD = SE.ID_SOLICITUD
            AND    SER.LINEA        = 0
            AND    SER.ID_SIST      = 1
           ), '0')                                     ERROR_PARA,
       TO_CHAR(SE.CREATED_DATE, 'YYYY-MM-DD HH24:MI')  CREATE_DATE,
       TRUNC(SE.CREATED_DATE)                          FECHA_CREACION,
       SE.CREATED_BY
FROM   XXMOR_SOLICITUDES_ENC_TAB      SE,
       XXMOR_SOLICITUDES_ORIG_ENC_TAB SO,
       XXMOR_SOLICITUDES_ARCH_TAB     SA,
       XXMOR_FZAS_VTAS_TAB            FV
WHERE  SE.ID_REQUEST     = SO.ID_REQUEST
AND    SO.ID_SEG_NEG     = SA.ID_SEG_NEG
AND    SO.ID_ARCHIVO_SOL = SA.ID_ARCHIVO_SOL
AND    SE.ID_SEG_NEG     = FV.ID_SEG_NEG
AND    SE.ID_FZA_VENTAS  = FV.ID_FZA_VENTAS
ORDER BY SE.ID_SOLICITUD DESC;
