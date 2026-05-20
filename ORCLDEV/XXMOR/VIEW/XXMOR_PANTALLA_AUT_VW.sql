CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_PANTALLA_AUT_VW" ("CRED_CORP", "SOBRECARGO", "MC_TOPADO", "SALDO_CPS", "OPENLOG", "URGENTE", "TARIFA_MANUAL", "REPROCESAR", "ID_SOLICITUD", "ID_FZA_VENTAS", "NOMBRE_FZA_VENTAS", "NOM_ARCHIVO_SOL", "CREATE_DATE", "FECHA_CREACION", "ADVID", "CLAVE_AGENCIA", "PRDID_DESC", "REFERENCIA_FOLIO", "RTCRD", "MCONTID", "PL", "TOTAL_CON_DESC", "CREATED_BY", "ID_PRDG", "ID_ONAIR", "ID_ARCHIVO_SOL", "EXISTEN_ERRORES", "ID_REQUEST", "SPOT_CHR") AS 
  SELECT TO_CHAR(CRED_CORP)         CRED_CORP,
       TO_CHAR(SOBRECARGO)        SOBRECARGO,
       TO_CHAR(MC_TOPADO)         MC_TOPADO,
       TO_CHAR(SALDO_CPS)         SALDO_CPS,
       TO_CHAR(OPENLOG)           OPENLOG,
       TO_CHAR(URGENTE)           URGENTE,
       TO_CHAR(TARIFA_MANUAL)     TARIFA_MANUAL,
       TO_CHAR(REPROCESAR)        REPROCESAR,
       TO_CHAR(ID_SOLICITUD)      ID_SOLICITUD,
       TO_CHAR(ID_FZA_VENTAS)     ID_FZA_VENTAS,
       TO_CHAR(NOMBRE_FZA_VENTAS) NOMBRE_FZA_VENTAS,
       TO_CHAR(NOM_ARCHIVO_SOL)   NOM_ARCHIVO_SOL,
       TO_CHAR(CREATE_DATE)       CREATE_DATE,
       FECHA_CREACION,
       ADVID,
       CLAVE_AGENCIA,
       PRDID_DESC,
       REFERENCIA_FOLIO,
       RTCRD,
       MCONTID,
       PL,
       TOTAL_CON_DESC,
       CREATED_BY,
       ID_PRDG,
       ID_ONAIR,
       TO_CHAR(ID_ARCHIVO_SOL)    ID_ARCHIVO_SOL,
       TO_CHAR(EXISTEN_ERRORES)   EXISTEN_ERRORES,
       TO_CHAR(ID_REQUEST)        ID_REQUEST,
       TO_CHAR(SPOT_CHR)          SPOT_CHR
FROM   (SELECT (CASE
                    WHEN (SELECT COUNT(1)
                          FROM   XXMOR_CONCOM_RPTA_TAB RC
                          WHERE  UPPER(RC.CAMPO_CONCOM)      = 'CRED_CORP'
                          AND    UPPER(RC.ACCION_CONCOM)     = 'AUTORIZACION'
                          AND    NVL(RC.ESTATUS_ORDUNI,'10') = '10'
                          AND    RC.ID_SOLICITUD             = SE.ID_SOLICITUD
                         ) > 0 THEN
                        1
                    ELSE
                        0
                END
               )                  CRED_CORP,
               (CASE
                    WHEN (SELECT COUNT(1)
                          FROM   XXMOR_CONCOM_RPTA_TAB RC
                          WHERE  UPPER(RC.CAMPO_CONCOM)      = 'SOBRECARGO'
                          AND    UPPER(RC.ACCION_CONCOM)     = 'AUTORIZACION'
                          AND    NVL(RC.ESTATUS_ORDUNI,'10') = '10'
                          AND    RC.ID_SOLICITUD             = SE.ID_SOLICITUD
                         ) > 0 THEN
                        1
                    ELSE
                        0
                END
               )                  SOBRECARGO,
               (CASE
                    WHEN (SELECT COUNT(1)
                          FROM   XXMOR_CONCOM_RPTA_TAB RC
                          WHERE  UPPER(RC.ACCION_CONCOM)     = 'AUTORIZACION'
                          AND    UPPER(RC.POSICION_CONCOM)   = 'ENCABEZADO'
                          AND    INSTR(UPPER(RC.DESC_CONCOM),'MASTER TOPADO')
                                                             > 0
                          AND    NVL(RC.ESTATUS_ORDUNI,'10') = '10'
                          AND    RC.ID_SOLICITUD             = SE.ID_SOLICITUD
                         ) > 0 THEN
                        1
                    ELSE
                        0
                END
               )                  MC_TOPADO,
               (CASE
                    WHEN (SELECT COUNT(1)
                          FROM   XXMOR_CONCOM_RPTA_TAB RC
                          WHERE  UPPER(RC.CAMPO_CONCOM)      = 'CPS'
                          AND    UPPER(RC.ACCION_CONCOM)     = 'AUTORIZACION'
                          AND    NVL(RC.ESTATUS_ORDUNI,'10') = '10'
                          AND    RC.ID_SOLICITUD             = SE.ID_SOLICITUD
                         ) > 0 THEN
                        1
                    ELSE
                        0
                END
               )                  SALDO_CPS,
               (CASE
                    WHEN (SELECT COUNT(1)
                          FROM   XXMOR_CONCOM_RPTA_TAB RC
                          WHERE  UPPER(RC.CAMPO_CONCOM)      = 'OPENLOG'
                          AND    UPPER(RC.ACCION_CONCOM)     = 'AUTORIZACION'
                          AND    NVL(RC.ESTATUS_ORDUNI,'10') = '10'
                          AND    RC.ID_SOLICITUD             = SE.ID_SOLICITUD
                         ) > 0 THEN
                        1
                    ELSE
                        0
                END
               )                                             OPENLOG,
               (CASE
                    WHEN (SELECT COUNT (1)
                          FROM   XXMOR_CONCOM_RPTA_TAB RC
                          WHERE  UPPER (RC.CAMPO_CONCOM)     = 'URGENTE'
                          AND    UPPER (RC.ACCION_CONCOM)    = 'AUTORIZACION'
                          AND    NVL(RC.ESTATUS_ORDUNI,'10') = '10'
                          AND    RC.ID_SOLICITUD = SE.ID_SOLICITUD
                         ) > 0 THEN
                        1
                    ELSE
                        0
                END
               )                                             URGENTE,
               (CASE
                    WHEN (SELECT COUNT(1)
                          FROM   XXMOR_CONCOM_RPTA_TAB RC
                          WHERE  UPPER (RC.CAMPO_CONCOM)     = 'TARIFA_MANUAL'
                          AND    UPPER (RC.ACCION_CONCOM)    = 'AUTORIZACION'
                          AND    NVL(RC.ESTATUS_ORDUNI,'10') = '10'
                          AND    RC.ID_SOLICITUD             = SE.ID_SOLICITUD
                         ) > 0 THEN
                        1
                    ELSE
                        0
                END
               )                                             TARIFA_MANUAL,
               (SELECT DECODE(COUNT(1), 0, 0, 1)
                FROM   (SELECT DISTINCT ID_SOLICITUD
                        FROM   (SELECT DISTINCT
                                       CRT.ID_SOLICITUD,
                                       CRT.NUMLINEA_CONCOM
                                FROM   XXMOR_CONCOM_RPTA_TAB CRT
                                WHERE  CRT.ESTATUS_ORDUNI       = '10'
                                AND    UPPER(CRT.ACCION_CONCOM) IN ('REPROCESO', 'REENVIO')
                                MINUS
                                SELECT DISTINCT
                                       CRT.ID_SOLICITUD,
                                       CRT.NUMLINEA_CONCOM
                                FROM   XXMOR_CONCOM_RPTA_TAB CRT
                                WHERE  CRT.ESTATUS_ORDUNI = '10'
                                AND    UPPER(CRT.ACCION_CONCOM) IN ('RECHAZO', 'RETENCION')
                               )
                       ) RE
                WHERE  RE.ID_SOLICITUD = SE.ID_SOLICITUD
               )                                             REPROCESAR,
               SE.ID_SOLICITUD,
               SE.ID_FZA_VENTAS,
               FZ.NOMBRE_FZA_VENTAS,
               SOL.NOM_ARCHIVO_SOL,
               TO_CHAR(SE.CREATED_DATE,'YYYY-MM-DD HH24:MI') CREATE_DATE,
               TRUNC(SE.CREATED_DATE)                        FECHA_CREACION,
               SE.ADVID,
               EO.ACCTHDRID                                  CLAVE_AGENCIA,
               SE.PRDID_DESC,
               EO.AGYESTNUM                                  REFERENCIA_FOLIO,
               SE.RTCRD,
               SE.MCONTID,
               SE.PROC_POR_LINEA                             PL,
               SE.TOTAL_CON_DESC,
               SE.CREATED_BY,
               R.ESTAT_ID_FORANEO                            ID_PRDG,
               RO.ESTAT_ID_FORANEO                           ID_ONAIR,
               SOL.ID_ARCHIVO_SOL,
               (CASE
                    WHEN (SELECT COUNT(1)
                          FROM   XXMOR_CONCOM_RPTA_TAB RC
                          WHERE  UPPER(RC.POSICION_CONCOM)   = 'LINEA'
                          AND    NVL(RC.ESTATUS_ORDUNI,'10') = '10'
                          AND    RC.ID_SOLICITUD             = SE.ID_SOLICITUD
                         ) > 0 THEN
                        1
                    ELSE
                       0
                END
               )                                             EXISTEN_ERRORES,
               SE.ID_REQUEST,
               (SELECT COUNT(1)
                FROM   XXMOR_SOLICITUDES_DET_TAB
                WHERE  ID_SOLICITUD = SE.ID_SOLICITUD
                AND    SPOT_CHR     IN (1,5)
               )                                             SPOT_CHR
        FROM   XXMOR_SOLICITUDES_ENC_TAB      SE,
               XXMOR_SOLICITUDES_ORIG_ENC_TAB EO,
               XXMOR_SOLICITUDES_ARCH_TAB     SOL,
               XXMOR_FZAS_VTAS_TAB            FZ,
               XXMOR_SOLICITUDES_EST_REP_TAB  R,
               XXMOR_SOLICITUDES_EST_REP_TAB  RO,
               (SELECT DISTINCT CRT.ID_SOLICITUD
                FROM   (SELECT DISTINCT
                               CRT.ID_SOLICITUD,
                               CRT.NUMLINEA_CONCOM
                        FROM   XXMOR_CONCOM_RPTA_TAB CRT
                        WHERE  CRT.ESTATUS_ORDUNI       = '10'
                        AND    UPPER(CRT.ACCION_CONCOM) IN ('REPROCESO',
                                                            'REENVIO',
                                                            'AUTORIZACION'
                                                           )
                        GROUP BY CRT.ID_SOLICITUD,
                                 CRT.NUMLINEA_CONCOM
                        MINUS
                        SELECT DISTINCT
                               CRT.ID_SOLICITUD,
                               CRT.NUMLINEA_CONCOM
                        FROM   XXMOR_CONCOM_RPTA_TAB CRT
                        WHERE  CRT.ESTATUS_ORDUNI = '10'
                        AND    UPPER(CRT.ACCION_CONCOM) IN ('RETENCION', 'RECHAZO')
                        GROUP BY CRT.ID_SOLICITUD,
                                 NUMLINEA_CONCOM
                       ) CRT
               )                              CR
        WHERE  SE.ORDEN_ESTATUS != 46
        AND    SE.ID_REQUEST     = EO.ID_REQUEST
        AND    EO.ID_ARCHIVO_SOL = SOL.ID_ARCHIVO_SOL
        AND    SE.ID_FZA_VENTAS  = FZ.ID_FZA_VENTAS
        AND    SE.ID_SOLICITUD   = R.ID_SOLICITUD(+)
        AND    R.LINEA(+)        = 0
        AND    R.ID_SIST(+)      = 1
        AND    SE.ID_SOLICITUD   = RO.ID_SOLICITUD(+)
        AND    RO.LINEA(+)       = 0
        AND    RO.ID_SIST(+)     = 2
        AND    SE.ID_SOLICITUD   = CR.ID_SOLICITUD
       );
