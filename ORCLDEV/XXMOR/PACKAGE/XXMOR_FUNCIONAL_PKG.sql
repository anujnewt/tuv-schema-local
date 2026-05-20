CREATE OR REPLACE EDITIONABLE PACKAGE "XXMOR"."XXMOR_FUNCIONAL_PKG" AS
    /*===============================================================
     FILE NAME :
     NOMBRE DEL MODULO :   XXMOR
     CREATED DATE :        01-DIC-2010
     AUTHOR(S) :           MIGUEL ANGEL RODRIGUEZ
     SHORT DESCRIPTION :   ESTE PROCESO GENERA LAS ORDENES DE SERVICIO.
     PROCEDURES CONTAINS :
     RELATED DOCUMENTS :   ANALISIS Y DISEO FUNCIONAL
     ===============================================================
     MODIFICATION DATE :    N/A
     MODIFICATION MADE BY : N/A
     CHANGE MADE :          N/A
     RELATED DOCUMENTS :    N/A
    V_AGRUPADOR  VARCHAR(10);
    V_REGION     VARCHAR2(2);
    V_SUFIJO     VARCHAR2(2);
    V_CLIENTE    VARCHAR2(15);
    V_FZA_VENTAS NUMBER(5);
    V_ACCTHDRID  VARCHAR2(15);
    ===============================================================*/
    glo_document            LONG;
    g_conexion              utl_smtp.connection;
    TYPE MOR_ENC_REC_TYPE IS RECORD
               (
                       ID_SOLICITUD       XXMOR_SOLICITUDES_ENC_TAB.ID_SOLICITUD%TYPE := NULL,
                       ID_REQUEST         XXMOR_SOLICITUDES_ENC_TAB.ID_REQUEST%TYPE := NULL,
                       ID_SEG_NEG         XXMOR_SOLICITUDES_ENC_TAB.ID_SEG_NEG%TYPE := NULL,
                       ID_FZA_VENTAS      XXMOR_SOLICITUDES_ENC_TAB.ID_FZA_VENTAS%TYPE := NULL,
                       ID_SOLICITUD_HNA   XXMOR_SOLICITUDES_ENC_TAB.ID_SOLICITUD_HNA%TYPE := NULL,
                       PROC_POR_LINEA     XXMOR_SOLICITUDES_ENC_TAB.PROC_POR_LINEA%TYPE := NULL,
                       GARANTIZADO        XXMOR_SOLICITUDES_ENC_TAB.GARANTIZADO%TYPE := NULL,
                       ADVID              XXMOR_SOLICITUDES_ENC_TAB.ADVID%TYPE := NULL,
                       MCONTID            XXMOR_SOLICITUDES_ENC_TAB.MCONTID%TYPE := NULL,
                       MCONTID_CUTIN      XXMOR_SOLICITUDES_ENC_TAB.MCONTID_CUTIN%TYPE := NULL,
                       EMAIL              XXMOR_SOLICITUDES_ENC_TAB.EMAIL%TYPE := NULL,
                       AGYESTNUM          XXMOR_SOLICITUDES_ENC_TAB.AGYESTNUM%TYPE := NULL,
                       ACCTHDRID          XXMOR_SOLICITUDES_ENC_TAB.ACCTHDRID%TYPE := NULL,
                       RTCRDDSCR          XXMOR_SOLICITUDES_ENC_TAB.RTCRDDSCR%TYPE := NULL,
                       RTCRD              XXMOR_SOLICITUDES_ENC_TAB.RTCRD%TYPE := NULL,
                       RTCRDDSCR_CUTIN    XXMOR_SOLICITUDES_ENC_TAB.RTCRDDSCR_CUTIN%TYPE := NULL,
                       RTCRD_CUTIN        XXMOR_SOLICITUDES_ENC_TAB.RTCRD_CUTIN%TYPE := NULL,
                       COMENTARIOS        XXMOR_SOLICITUDES_ENC_TAB.COMENTARIOS%TYPE := NULL,
                       SECNUM             XXMOR_SOLICITUDES_ENC_TAB.SECNUM%TYPE := NULL,
                       PLATAFORMA_CANAL   XXMOR_SOLICITUDES_ENC_TAB.PLATAFORMA_CANAL%TYPE := NULL,
                       AGRUPADOR          XXMOR_SOLICITUDES_ENC_TAB.AGRUPADOR%TYPE := NULL,
                       PRDID_DESC         XXMOR_SOLICITUDES_ENC_TAB.PRDID_DESC%TYPE := NULL,
                       PRDID              XXMOR_SOLICITUDES_ENC_TAB.PRDID%TYPE := NULL,
                       TOTAL_SPOTS        XXMOR_SOLICITUDES_ENC_TAB.TOTAL_SPOTS%TYPE := NULL,
                       TOTAL_SIN_DESC     XXMOR_SOLICITUDES_ENC_TAB.TOTAL_SIN_DESC%TYPE := NULL,
                       TOTAL_CON_DESC     XXMOR_SOLICITUDES_ENC_TAB.TOTAL_CON_DESC%TYPE := NULL,
                       TIPO_FACTURACION   XXMOR_SOLICITUDES_ENC_TAB.TIPO_FACTURACION%TYPE := NULL,
                       DESCUENTO          XXMOR_SOLICITUDES_ENC_TAB.DESCUENTO%TYPE := NULL,
                       TARGET             XXMOR_SOLICITUDES_ENC_TAB.TARGET%TYPE := NULL,
                       ORDEN_ESTATUS      XXMOR_SOLICITUDES_ENC_TAB.ORDEN_ESTATUS%TYPE := NULL,
                       FECHA_CONCOM       XXMOR_SOLICITUDES_ENC_TAB.FECHA_CONCOM%TYPE := NULL,
                       TRACKING_ID_CONCOM XXMOR_SOLICITUDES_ENC_TAB.TRACKING_ID_CONCOM%TYPE := NULL,
                       CREATED_DATE       XXMOR_SOLICITUDES_ENC_TAB.CREATED_DATE%TYPE := NULL,
                       CREATED_BY         XXMOR_SOLICITUDES_ENC_TAB.CREATED_BY%TYPE := NULL,
                       UPDATED_DATE       XXMOR_SOLICITUDES_ENC_TAB.UPDATED_DATE%TYPE := NULL,
                       UPDATED_BY         XXMOR_SOLICITUDES_ENC_TAB.UPDATED_BY%TYPE := NULL
               );
    TYPE MOR_RPTA_CONCOM_TYPE IS RECORD
               (
                       ID_SOLICITUD       XXMOR_CONCOM_RPTA_TAB.ID_SOLICITUD%TYPE := NULL,
                       ID_RPTA_CONCOM     XXMOR_CONCOM_RPTA_TAB.ID_RPTA_CONCOM%TYPE := NULL ,
                       RESULTADOGENERAL   XXMOR_CONCOM_RPTA_TAB.RESULTADOGENERAL%TYPE := NULL ,
                       TRACKINGID         XXMOR_CONCOM_RPTA_TAB.TRACKINGID%TYPE := NULL ,
                       DESC_CONCOM        XXMOR_CONCOM_RPTA_TAB.DESC_CONCOM%TYPE := NULL ,
                       POSICION_CONCOM    XXMOR_CONCOM_RPTA_TAB.POSICION_CONCOM%TYPE := NULL ,
                       ID_CONCOM          XXMOR_CONCOM_RPTA_TAB.ID_CONCOM%TYPE := NULL ,
                       NUMLINEA_CONCOM    XXMOR_CONCOM_RPTA_TAB.NUMLINEA_CONCOM%TYPE := NULL ,
                       ESTATUS_CONCOM     XXMOR_CONCOM_RPTA_TAB.ESTATUS_CONCOM%TYPE := NULL ,
                       CAMPO_CONCOM       XXMOR_CONCOM_RPTA_TAB.CAMPO_CONCOM%TYPE := NULL ,
                       DETALLE_CONCOM     XXMOR_CONCOM_RPTA_TAB.DETALLE_CONCOM%TYPE := NULL ,
                       ACCION_CONCOM      XXMOR_CONCOM_RPTA_TAB.ACCION_CONCOM%TYPE := NULL ,
                       TIPOREGLA_CONCOM   XXMOR_CONCOM_RPTA_TAB.TIPOREGLA_CONCOM%TYPE := NULL ,
                       ESTATUS_ORDUNI     XXMOR_CONCOM_RPTA_TAB.ESTATUS_ORDUNI%TYPE := NULL
               );
    FUNCTION XXMOR_IDENT_FZA_VTAS
                        (
                                P_ID_SOLICITUD IN NUMBER,
                                P_USRCHR       IN VARCHAR2,
                                P_SPTCHR       IN VARCHAR2
                        ) RETURN NUMBER;
    FUNCTION XXMOR_IDENT_ERRORES_FUN
                        (
                                P_ID_SOLICITUD IN NUMBER,
                                P_LINEA        IN NUMBER,
                                P_CAMPO_OU     IN VARCHAR2
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_ORDEN_ESTATUS_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO         IN VARCHAR2
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_NOTIFICACION_FUN
                        (
                                P_ID_SOLICITUD  IN NUMBER,
                                P_LINEAS        IN VARCHAR2,
                                P_ADVID         IN VARCHAR2,
                                P_ACCTHDRID     IN VARCHAR2,
                                P_MCONTID       IN VARCHAR2,
                                P_RTCRDDSCR     IN VARCHAR2,
                                P_EMAIL         IN VARCHAR2,
                                P_COMENTARIOS   IN VARCHAR2,
                                P_ORDEN_ESTATUS IN NUMBER,
                                P_EMAIL_TO      IN VARCHAR2
                        ) RETURN INTEGER;
    FUNCTION XXMOR_SOL_TOTALES_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO         IN VARCHAR2
                        ) RETURN NUMBER;
    FUNCTION XXMOR_SOL_FECHAS_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO         IN VARCHAR2
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_EN_SEMANA_CONF_FUN
                        (
                                P_DIA_INICIO  IN VARCHAR2,
                                P_HORA_INICIO IN VARCHAR2,
                                P_DIA_FIN     IN VARCHAR2,
                                P_HORA_FIN    IN VARCHAR2
                        ) RETURN NUMBER;
    FUNCTION XXMOR_FECHA_SIN_ER_FUN
                        (
                                P_FECHA IN VARCHAR2,
                                P_TIPO  IN VARCHAR2
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_FECHA_VALIDA_FUN
                        (
                                P_FECHA IN VARCHAR2
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_DURACION_VALIDA_FUN
                        (
                                P_DURACION IN VARCHAR2
                        ) RETURN INTEGER;
    FUNCTION XXMOR_MARCAS_ORDEN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_HTML_MAIL
                        (
                                P_ID_SOLICITUD  IN INTEGER,
                                P_LINEAS        IN VARCHAR2,
                                P_ORDEN_ESTATUS IN INTEGER
                        ) RETURN CLOB;
    FUNCTION XXMOR_VERSION_VIRTUAL
                        (
                                P_AGRUPADOR IN INTEGER
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_ENV_SOL_CONCOM_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_FECHA_ENC_VAL_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN INTEGER;
    FUNCTION XXMOR_RTCRD_CA_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN INTEGER;
    FUNCTION XXMOR_MATLOC_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_NUMLINE_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_GETRATE_CA_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO         IN VARCHAR2
                        ) RETURN NUMBER;
    FUNCTION XXMOR_ENV_MAIL_OR_MC_FUN
                        (
                                P_ID_REQUEST IN INTEGER
                        ) RETURN INTEGER;
    FUNCTION XXMOR_SOL_AGR_MULT_VAL_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN INTEGER;
    FUNCTION XXMOR_ES_SOL_AGR_MULT_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN INTEGER;
    FUNCTION XXMOR_GET_RTCRD_AGR_MULT_FN
                        (
                                P_ID_SOLICITUD IN NUMBER
                        ) RETURN  VARCHAR2;
    FUNCTION XXMOR_COPYS_POR_ORDEN_FN
                        (
                                piin_id_fza_ventas  IN INTEGER,
                                piin_id_solicitud   IN INTEGER
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_COPYS_VERHORARIO_FN
                        (
                                piin_id_solicitud   IN INTEGER,
                                piin_num_linea      IN INTEGER
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_DESC_MCONTID_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN NUMBER;
    FUNCTION XXMOR_DESC_TI_SERVICIO_FUN
                        (
                                P_ID_REQUEST IN  INTEGER,
                                P_LINEA      IN  INTEGER
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_GET_MAILS_FACTUR_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN VARCHAR2;
    FUNCTION XXMOR_ES_ORDEN_FACTURABLE_FN
                        (
                                piinIdSolicitud IN INTEGER
                        ) RETURN INTEGER;
    FUNCTION XXMOR_GET_AGRUPADOR_FN
                        (
                                pistCanal       IN VARCHAR2,
                                piinIdSolicitud IN INTEGER
                        ) RETURN VARCHAR2;
    -- INCIO OMW - Cambio manejo de Paquetes, 23-ABR-2015
    FUNCTION XXMOR_VALOR_PAQUETES_FN
                        (
                                pistUsrfl          IN  VARCHAR2,
                                pistDescPaquete    IN  VARCHAR2
                        ) RETURN INTEGER;
    -- FIN OMW - Cambio manejo de Paquetes, 23-ABR-2015
    PROCEDURE XXMOR_GUARDA_ARCHIVO_ORD_PR
                        (
                                P_NOM_ARCHIVO     IN VARCHAR2,
                                P_ARCHIVO         IN BLOB,
                                P_CREATED_BY      IN VARCHAR2,
                                O_ID_ARCHIVO_SOL  OUT INTEGER,
                                O_NOM_ARCH_EXISTE OUT INTEGER
                        );
    PROCEDURE XXMOR_SOL_HNA_AM_PR
                        (
                                P_ID_SOLICITUD IN  INTEGER,
                                O_ID_SOL_HNA   OUT INTEGER
                        );
    PROCEDURE XXMOR_AUT_OPENLOG_FUN
                        (
                                P_ID_SOLICITUD IN  NUMBER,
                                P_TIPO         IN  NUMBER,
                                O_RES          OUT VARCHAR2
                        );
    PROCEDURE XXMOR_AUT_URGENTE_FUN
                        (
                                P_ID_SOLICITUD IN NUMBER,
                                P_TIPO         IN NUMBER
                        );
    PROCEDURE XXMOR_UPD_MONTOS_AGR_MUL_PR
                        (
                                P_ID_SOLICITUD IN NUMBER,
                                P_LINEA        IN INTEGER,
                                P_MONTO        IN NUMBER,
                                P_ID_SOL_REF   IN INTEGER
                        );
    PROCEDURE XXMOR_AUT_TM_SOBREP_PR
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO_AUT     IN VARCHAR2,
                                P_RATE         IN NUMBER,
                                P_AUX          IN VARCHAR2,
                                P_DET_CONCOM   IN VARCHAR2
                        );
    PROCEDURE XXMOR_AUT_ENV_CORREO_PR
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_MAIL_ADDRESS IN VARCHAR,
                                P_AUT_RECH     IN VARCHAR
                        );
    PROCEDURE XXMOR_SEMANA_CONF_PR
                        (
                                P_IDENT_FZA_VENTAS IN  VARCHAR2,
                                P_DIA_INICIO       IN  VARCHAR2,
                                P_HORA_INICIO      IN  VARCHAR2,
                                P_DIA_FIN          IN  VARCHAR2,
                                P_HORA_FIN         IN  VARCHAR2,
                                O_ACTUALIZA        OUT INTEGER
                        );
    PROCEDURE XXMOR_GENERAORDENES_PR
                        (
                                P_ID_REQUEST_AUX IN NUMBER
                        );
    PROCEDURE XXMOR_REVISAR_BUYUNITMKT_PR
                        (
                                P_ID_SOLICITUD IN XXMOR_SOLICITUDES_ENC_TAB.ID_SOLICITUD%TYPE
                        );
    PROCEDURE XXMOR_ASIGNA_FZAVTAS_PR
                        (
                                P_ID_REQUEST_AUX IN INTEGER
                        );
    PROCEDURE XXMOR_GENERA_INF_REP_PR
                        (
                                P_ID_SOLICITUD  IN INTEGER,
                                P_ID_FZA_VENTAS IN INTEGER
                        );
    PROCEDURE XXMOR_SOL_ESTATUS_PR
                        (
                                P_RESPUESTA IN XXMOR_FUNCIONAL_PKG.MOR_RPTA_CONCOM_TYPE
                        );
    PROCEDURE XXMOR_PROC_RPTA_CC_PR
                        (
                                P_ID_SOLICITUD IN INTEGER
                        );
    PROCEDURE XXMOR_COPY_UPDATE_PR
                        (
                                P_ID_SOLICITUD IN INTEGER
                        );
    PROCEDURE XXMOR_HTML_EMAIL_PR
                        (
                                P_MAILS_NOTIFICAR IN VARCHAR2,
                                P_SUBJECT         IN VARCHAR2,
                                P_TEXT            IN VARCHAR2 DEFAULT NULL,
                                P_HTML            IN CLOB DEFAULT NULL
                        );
    PROCEDURE XXMOR_REVISAR_SEMANA_CONF_PR;
    PROCEDURE XXMOR_ENV_SOL_REZAGADAS;
    PROCEDURE XXMOR_CALL_WS_SP
                        (
                                P_SOAP_REQUEST IN VARCHAR2,
                                P_REQ          IN VARCHAR2
                        );
    PROCEDURE XXMOR_SOL_NOTIFICACION_PR
                        (
                                P_SOLICITUD IN XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE
                        );
    PROCEDURE XXMOR_ENV_NOTIFICACION_PR
                        (
                                P_SOLICITUD IN XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE
                        );
    PROCEDURE XXMOR_ENV_NOTIFICACION_ST_PR
                        (
                                P_ID_SOLICITUD    IN INTEGER,
                                P_LINEAS          IN VARCHAR2,
                                P_ID_NOTIFICACION IN INTEGER
                        );
    PROCEDURE XXMOR_ENV_NOTIFICACION_PR
                        (
                                P_ID_SOLICITUD    IN INTEGER,
                                P_LINEAS          IN VARCHAR2,
                                P_ID_NOTIFICACION IN VARCHAR2
                        );
    PROCEDURE XXMOR_ENV_NOTIF_OCPGM_PR
                        (
                                P_ID_SOLICITUD IN INTEGER
                        );
    PROCEDURE XXMOR_ENV_MAIL_OR_MC_PR
                        (
                                P_ID_REQUEST IN INTEGER,
                                P_ID_ESTATUS IN INTEGER
                        );
    PROCEDURE XXMOR_SET_DB2_IDS_PR
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_ORDLNID      IN INTEGER
                        );
    PROCEDURE XXMOR_AM_SEND_SOL_PEND_PR
                        (
                                P_ID_SOLICITUD IN INTEGER
                        );
    PROCEDURE XXMOR_EJECUTA_AUTH_CREDCORP_PR
                        (
                                piinIdSolicitud IN  NUMBER,
                                poinAutorizar   OUT NUMBER
                        );
    PROCEDURE XXMOR_REVISA_ERROR_ARCHIVO_PR
                        (
                                piinIdArchivoSol IN  NUMBER
                        );
    PROCEDURE XXCC_CREA_HTML_FVTAS_MERCA_PR
                      (
                              piinLine           IN      VARCHAR2
                      );
    PROCEDURE XXMOR_NOTIFICA_FVTAS_MERCA_PR
                      (
                              pistTipoNotif      IN      VARCHAR2,
                              piinValor          IN      NUMBER,
                              piinIdSolRequest   IN      NUMBER
                      );
END XXMOR_FUNCIONAL_PKG;
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXMOR"."XXMOR_FUNCIONAL_PKG" IS
    FUNCTION XXMOR_IDENT_FZA_VTAS
                        (
                                P_ID_SOLICITUD IN NUMBER,
                                P_USRCHR       IN VARCHAR2,
                                P_SPTCHR       IN VARCHAR2
                        ) RETURN NUMBER IS
        V_AGRUPADOR   VARCHAR(10);
        V_REGION      VARCHAR2(2);
        V_SUFIJO      VARCHAR2(2);
        V_CLIENTE     VARCHAR2(15);
        V_FZA_VENTAS  NUMBER(5) := NULL;
        V_ACCTHDRID   VARCHAR2(15);
        V_MCONTID     VARCHAR2(20);
        V_RTCRDDSCR   VARCHAR2(50);
        V_EMAIL       VARCHAR2(50);
        V_COMENTARIOS VARCHAR2(150);
        P_SOLICITUD   XXMOR.XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE;
    BEGIN
        --Identificamos la Fza de ventas
        --Obtenemos el master contract, Agrupador, cliente, prefijo, sufijo
        SELECT TRIM(AGRUPADOR)                                    AGRUPADOR,
               TRIM(ADVID)                                        CLIENTE,
               SUBSTR(TRIM(MCONTID),1,2)                          REGION,
               SUBSTR(TRIM(MCONTID),INSTR(TRIM(MCONTID),'.')-2,2) SUFIJO,
               ACCTHDRID,
               MCONTID,
               RTCRDDSCR,
               EMAIL
        INTO   V_AGRUPADOR,
               V_CLIENTE,
               V_REGION,
               V_SUFIJO,
               V_ACCTHDRID,
               V_MCONTID,
               V_RTCRDDSCR,
               V_EMAIL
        FROM   XXMOR_SOLICITUDES_ENC_TAB
        WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
        --dbms_output.put_line('-> '||V_FZA_VENTAS || ' -> '|| V_REGION ||' -> '|| V_AGRUPADOR  ||' -> '|| P_Sptchr ||' -> '|| P_Usrchr );   --DECODE(NVL(v.SUFIJO,'*'),'*','*',v.SUFIJO)
        BEGIN
            SELECT ID_FZA_VENTAS
            INTO   V_FZA_VENTAS
            FROM   (SELECT DISTINCT
                           V.ID_FZA_VENTAS
                    FROM   XXMOR_FZAS_VENTAS_IDS_VW V
                    WHERE  V.REGION                                            = V_REGION
                    AND    V.AGRUPADOR                                         = V_AGRUPADOR
                    AND    DECODE(V.SPTCHR,'*','*',V.SPTCHR)                   = DECODE(V.SPTCHR,'*','*',P_SPTCHR)
                    AND    DECODE(NVL(V.USRCHR,' '),'*','*',NVL(V.USRCHR,' ')) = DECODE(NVL(V.USRCHR,' '),'*','*',NVL(P_USRCHR,' '))
                    AND    DECODE(NVL(V.CLIENTE,'*'),'*','*',V.CLIENTE)        = NVL((SELECT ACCTHDRID
                                                                                      FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                                                      WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                                                                      AND    ACCTHDRID    IN (SELECT CLIENTE
                                                                                                              FROM   XXMOR_FZAS_VENTAS_IDS_VW
                                                                                                             )
                                                                                     ),'*')
                    AND    NVL(V.SUFIJO,'*')                                   = NVL((SELECT SUBSTR(MCONTID,INSTR(MCONTID,'.')-2,2)
                                                                                      FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                                                      WHERE  ID_SOLICITUD                           = P_ID_SOLICITUD
                                                                                      AND    SUBSTR(MCONTID,INSTR(MCONTID,'.')-2,2) IN (SELECT SUFIJO
                                                                                                                                        FROM   XXMOR_FZAS_VENTAS_IDS_VW
                                                                                                                                        WHERE  REGION    = V_REGION
                                                                                                                                        AND    AGRUPADOR = V_AGRUPADOR
                                                                                                                                       )
                                                                                     ),'*')
                    AND    V.INCLUSION                                         = 1
                    UNION
                    SELECT DISTINCT
                           V.ID_FZA_VENTAS
                    FROM   XXMOR_FZAS_VENTAS_IDS_VW V
                    WHERE  V.REGION    = V_REGION
                    AND    V.AGRUPADOR = V_AGRUPADOR
                    AND    DECODE(NVL(v.CLIENTE,'*'),'*','*',v.CLIENTE) = NVL((SELECT ACCTHDRID
                                                                               FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                                               WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                                                               AND    ACCTHDRID    IN (SELECT CLIENTE
                                                                                                       FROM XXMOR_FZAS_VENTAS_IDS_VW
                                                                                                      )
                                                                              ),'*')
                    AND    V.INCLUSION                                  = 0
                    AND    NOT EXISTS                                     (SELECT 1
                                                                           FROM   XXMOR.XXMOR_CONF_TIPO_SRV_TAB TS
                                                                           WHERE  V.ID_SEG_NEG                         = TS.ID_SEG_NEG
                                                                           AND    V.ID_FZA_VENTAS                      = TS.ID_FZA_VENTAS
                                                                           AND    V.INCLUSION                          = TS.INCLUSION
                                                                           AND    TS.SPTCHR                            = P_SPTCHR
                                                                           AND    (DECODE(TS.USRCHR,'*','*',TS.USRCHR) = DECODE(TS.USRCHR,'*','*',P_USRCHR)
                                                                                   OR TS.USRCHR IS NULL)
                                                                          )
                    AND    (SELECT COUNT(1)
                            FROM   XXMOR_FZAS_VENTAS_IDS_VW V
                            WHERE  V.REGION    = V_REGION
                            AND    V.AGRUPADOR = V_AGRUPADOR
                            AND    V.INCLUSION = 0
                           )                                            = (SELECT COUNT(1)
                                                                           FROM   XXMOR_FZAS_VENTAS_IDS_VW V
                                                                           WHERE  V.REGION    = V_REGION
                                                                           AND    V.AGRUPADOR = V_AGRUPADOR
                                                                           AND    V.INCLUSION = 0
                                                                           AND    NOT EXISTS    (SELECT 1
                                                                                                 FROM   XXMOR.XXMOR_CONF_TIPO_SRV_TAB TS
                                                                                                 WHERE  V.ID_SEG_NEG                        = TS.ID_SEG_NEG
                                                                                                 AND    V.ID_FZA_VENTAS                     = TS.ID_FZA_VENTAS
                                                                                                 AND    V.INCLUSION                         = TS.INCLUSION
                                                                                                 AND    V.SPTCHR                            = TS.SPTCHR
                                                                                                 AND    V.USRCHR                            = TS.USRCHR
                                                                                                 AND    TS.SPTCHR                           = P_SPTCHR
                                                                                                 AND    DECODE(TS.USRCHR,'*','*',TS.USRCHR) = DECODE(TS.USRCHR,'*','*',P_USRCHR)
                                                                                                )
                                                                          )
                   );
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_FZA_VENTAS := 0;
            WHEN TOO_MANY_ROWS THEN
                V_FZA_VENTAS := 1;
        END;
        BEGIN
            --SE REVISA QUE LA FZA DE VENTAS ESTE ACTIVA
            SELECT ID_FZA_VENTAS
            INTO   V_FZA_VENTAS
            FROM   XXMOR_FZAS_VTAS_TAB
            WHERE  ID_FZA_VENTAS = V_FZA_VENTAS
            AND    ACTIVA        = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_FZA_VENTAS := (V_FZA_VENTAS * -1);
        END;
        RETURN NVL(V_FZA_VENTAS,0);
    END XXMOR_IDENT_FZA_VTAS;
    FUNCTION XXMOR_IDENT_ERRORES_FUN
                        (
                                P_ID_SOLICITUD IN NUMBER,
                                P_LINEA        IN NUMBER,
                                P_CAMPO_OU     IN VARCHAR2
                        ) RETURN VARCHAR2 IS
    V_ERR_MSG     VARCHAR(32765) := NULL;
    V_AUX         VARCHAR(2500) := NULL;
    V_COUNT       INTEGER := 0;
    CURSOR c1  IS
    SELECT DISTINCT DESC_CONCOM || '/' ||DETALLE_CONCOM AS ERR_MSG
    FROM   XXMOR_CONCOM_RPTA_TAB       R,
           XXMOR_MAP_CONCOM_ORDUNI_TAB M
    WHERE  INSTR(R.CAMPO_CONCOM,CAMPO_POSICION_CONCOM) > 0
    AND    M.CAMPO_ORDUNI = P_CAMPO_OU -- 'ACCTHDR'
    AND    R.ID_SOLICITUD = P_ID_SOLICITUD
    AND    R.TRACKINGID   = NVL2(P_LINEA, (SELECT TRACKINGID
                                           FROM   XXMOR_SOLICITUDES_DET_TAB
                                           WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                           AND    LINEA        = P_LINEA
                                          ),
                                          (SELECT TRACKINGID
                                           FROM   XXMOR_SOLICITUDES_ENC_TAB
                                           WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                          )
                                )
    AND    NVL(TO_NUMBER(R.NUMLINEA_CONCOM),0) = NVL(P_LINEA,0)
    AND    R.ESTATUS_ORDUNI = '10';
    --AND R.ACCION_CONCOM != 'RECHAZO'
    CURSOR c2  IS
    SELECT DISTINCT DESC_CONCOM || '/' ||DETALLE_CONCOM AS ERR_MSG
    FROM   XXMOR_CONCOM_RPTA_TAB R,
           XXMOR_MAP_CONCOM_ORDUNI_TAB M
    WHERE  INSTR(R.CAMPO_CONCOM,CAMPO_POSICION_CONCOM) > 0
    AND    R.ID_SOLICITUD = P_ID_SOLICITUD
    AND    R.TRACKINGID   = NVL2(P_LINEA, (SELECT TRACKINGID
                                           FROM   XXMOR_SOLICITUDES_DET_TAB
                                           WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                           AND    LINEA        = P_LINEA
                                          ),
                                          (SELECT TRACKINGID
                                           FROM   XXMOR_SOLICITUDES_ENC_TAB
                                           WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                          )
                                )
    AND    NVL(TO_NUMBER(R.NUMLINEA_CONCOM),0) = NVL(P_LINEA,0)
    AND    R.ESTATUS_ORDUNI = '10';
    --AND R.ACCION_CONCOM != 'RECHAZO'
    CURSOR c3  IS
    SELECT DISTINCT DETALLE_CONCOM AS ERR_MSG
    FROM   XXMOR_CONCOM_RPTA_TAB R
    WHERE  R.ID_SOLICITUD                      = P_ID_SOLICITUD
    AND    NVL(TO_NUMBER(R.NUMLINEA_CONCOM),0) = NVL(P_LINEA,0)
    AND    R.ESTATUS_ORDUNI                    = '10';
    BEGIN
        IF P_CAMPO_OU = 'lineaMail' THEN
            SELECT COUNT(1)
            INTO V_COUNT
            FROM  xxmor_concom_rpta_tab
            WHERE ID_SOLICITUD = P_ID_SOLICITUD;
            IF V_COUNT > 0 THEN
               OPEN c3;
                LOOP
                    FETCH c3 INTO V_AUX;
                    EXIT WHEN c3%NOTFOUND;
                    --V_ERR_MSG := SUBSTR(V_ERR_MSG,1,32665) || V_AUX ||', ';
                    V_ERR_MSG := V_ERR_MSG||V_AUX||', ';
                END LOOP;
                CLOSE c3;
                V_ERR_MSG := SUBSTR(V_ERR_MSG,1,LENGTH(V_ERR_MSG)-2);
                RETURN NVL(V_ERR_MSG,'Sin_Error');
            ELSE
                RETURN NVL(V_ERR_MSG,'Estatus Inicial');
            END IF;
        END IF;
        IF P_CAMPO_OU != 'linea' THEN
            OPEN c1;
            LOOP
                FETCH c1 INTO V_AUX;
                EXIT WHEN c1%NOTFOUND;
                V_ERR_MSG := V_ERR_MSG||V_AUX||', ';
            END LOOP;
            CLOSE c1;
        ELSE
            OPEN c2;
            LOOP
                FETCH c2 INTO V_AUX;
                EXIT WHEN c2%NOTFOUND;
                V_ERR_MSG := V_ERR_MSG||V_AUX||', ';
            END LOOP;
            CLOSE c2;
        END IF;
        V_ERR_MSG := SUBSTR(V_ERR_MSG,1,LENGTH(V_ERR_MSG)-2);
        RETURN NVL(V_ERR_MSG,'0');
    END XXMOR_IDENT_ERRORES_FUN;
    FUNCTION XXMOR_ORDEN_ESTATUS_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO         IN VARCHAR2
                        ) RETURN VARCHAR2 IS
    V_ORDEN_ESTATUS         INTEGER;
    V_ESTATUS_LINEA         INTEGER;
    V_ESTATUS_ENC           INTEGER;
    V_RECHAZO_ENC           INTEGER;
    V_TOT_LINEAS            INTEGER;
    V_RPTA_CC_SIN_E         INTEGER;
    V_RPTA_CC               INTEGER;
    V_RPTA_CC_CON_E         INTEGER;
    V_TOT_EST_REP           INTEGER;
    V_TOT_EST_REP_E0        INTEGER;
    V_TOT_EST_REP_E2        INTEGER;
    V_TOT_REPROCESOS        INTEGER;
    V_TOT_RECHAZOS          INTEGER;
    V_TOT_RETENCION         INTEGER;
    V_TOT_AUTORIZACION      INTEGER;
    V_TOT_LIN_EN_REP        INTEGER;
    V_SIN_FZA_VTAS          INTEGER;
    V_AGRU_MULTIPLE         INTEGER;
    CURSOR ESTATUS_CONCOM_CUR IS
        SELECT 'Linea(s) con '|| LOWER(ACCION_CONCOM) AS ACCION_CONCOM
        FROM   (SELECT DISTINCT LOWER(ACCION_CONCOM) ACCION_CONCOM
                FROM  XXMOR_CONCOM_RPTA_TAB CR
                WHERE ID_SOLICITUD = P_ID_SOLICITUD
                AND ESTATUS_ORDUNI = '10'
                /*AND NOT EXISTS       ( SELECT DISTINCT ID_SOLICITUD, NUMLINEA_CONCOM
                                       FROM  XXMOR_CONCOM_RPTA_TAB CRR
                                       WHERE ESTATUS_ORDUNI            = '10'
                                       AND UPPER(ACCION_CONCOM)        ='RECHAZO'
                                       AND CR.ID_SOLICITUD = CRR.ID_SOLICITUD
                                       AND CR.NUMLINEA_CONCOM = CRR.NUMLINEA_CONCOM
                                     )*/
               )
        ORDER BY 1 ASC;
     CURSOR ESTATUS_REPLICA_CUR IS
         SELECT DISTINCT
                CASE ESTAT_REP WHEN '1' THEN 'Insertando en Paradigm'
                               WHEN '2' THEN 'Linea(s) en Paradigm'
                               WHEN '3' THEN 'Error al insertar linea(s) a Paradigm'
                ELSE ESTAT_REP
                END            AS ESTAT_REP
         FROM   XXMOR_SOLICITUDES_EST_REP_TAB E
         WHERE  ESTAT_REP   != 0
         AND    ID_SOLICITUD = P_ID_SOLICITUD
         ORDER BY 1 ASC;
    V_OUTPUT   VARCHAR2(3000);
    BEGIN
        --Estatus para insercion
        IF P_TIPO = 'BANDERA_INSERT' THEN
            /*  SELECT COUNT(1)
                INTO   V_TOT_LINEAS
                FROM   XXMOR_SOLICITUDES_DET_TAB
                WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
                dbms_output.put_line('V_TOT_LINEAS '|| V_TOT_LINEAS );
            */
            --errores en el encabezado
            SELECT COUNT(1)
            INTO   V_RPTA_CC_CON_E
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD           = P_ID_SOLICITUD
            AND    UPPER(POSICION_CONCOM) = 'ENCABEZADO'
            AND    ESTATUS_ORDUNI         = '10';
            --errores en las lineas
            SELECT COUNT(1)
            INTO   V_TOT_LINEAS
            FROM   (SELECT TO_CHAR(LINEA)
                    FROM   XXMOR_SOLICITUDES_DET_TAB
                    WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                    MINUS
                    SELECT DISTINCT(NUMLINEA_CONCOM)
                    FROM   XXMOR_CONCOM_RPTA_TAB
                    WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                    AND    NUMLINEA_CONCOM IS NOT NULL
                    AND    ESTATUS_ORDUNI  = '10'
                   );
            -- SELECT COUNT(1) +V_TOT_LINEAS
            -- INTO   V_TOT_LINEAS
            -- FROM   XXMOR_SOLICITUDES_EST_REP_TAB
            -- WHERE  aux3 = 1
            -- AND    LINEA = 0
            -- AND    ID_SOLICITUD =  P_ID_SOLICITUD;
            --si el encabezado no tiene errores y al menos hay una linea para insertar entonces dejar insertar (1) si no pues no (0)
            IF V_TOT_LINEAS > 0 AND V_RPTA_CC_CON_E = 0 THEN
                V_OUTPUT := '1';
            ELSE
                V_OUTPUT := '0';
            END IF;
            --Si la orden es de agrupador multiple entonces se revisa si se retiene o si continua
            IF V_OUTPUT = '1' THEN
                V_OUTPUT := XXMOR_FUNCIONAL_PKG.XXMOR_SOL_AGR_MULT_VAL_FUN(P_ID_SOLICITUD);
            END IF;
            RETURN V_OUTPUT;
        END IF;
        --SABER EL ESTATUS DE LA ORDEN DE ACUERDO A LOS RESULTADOS DE CONCOM
        IF P_TIPO = 'ESTATUS_CONCOM' THEN
            FOR C_ESTATUS IN ESTATUS_CONCOM_CUR LOOP
                V_OUTPUT := V_OUTPUT || C_ESTATUS.ACCION_CONCOM||', ';
            END LOOP;
            V_OUTPUT := SUBSTR(V_OUTPUT,1,LENGTH(V_OUTPUT)-2);
            RETURN V_OUTPUT;
        END IF;
        --SABER EL ESTATUS DE LA ORDEN CUANDO ESTA ES ENVIADA A PARADIGM
        IF P_TIPO = 'ESTATUS_REPLICA' THEN
            FOR C_ESTATUS IN ESTATUS_REPLICA_CUR LOOP
                V_OUTPUT := V_OUTPUT || C_ESTATUS.ESTAT_REP||', ';
            END LOOP;
            V_OUTPUT := SUBSTR(V_OUTPUT,1,LENGTH(V_OUTPUT)-2);
            RETURN V_OUTPUT;
        END IF;
        IF P_TIPO = 'ESTATUS_ORDEN' THEN
            --sIN FUERZA DE VENTAS
            SELECT COUNT(1)
            INTO   V_SIN_FZA_VTAS
            FROM   XXMOR_SOLICITUDES_ENC_TAB
            WHERE  ID_SOLICITUD  = P_ID_SOLICITUD
            AND    ID_FZA_VENTAS = 0;
            IF V_SIN_FZA_VTAS = 1 THEN
                SELECT DESC_NOTIFICACION
                INTO   V_OUTPUT
                FROM   XXMOR_ORDENES_ESTATUS_TAB
                WHERE  ID_NOTIFICACION = 25;
                RETURN V_OUTPUT;
            END IF;
            --AUN NO HA RESPONDIDO CONCOM 1 VEZ ESTATUS INICIAL
            SELECT COUNT(1)
            INTO   V_RPTA_CC
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD = P_ID_Solicitud;
            IF V_RPTA_CC=0 THEN
                --REVISAR SI YA SE ENVIO A CC
                SELECT ORDEN_ESTATUS
                INTO   V_ORDEN_ESTATUS
                FROM   XXMOR_SOLICITUDES_ENC_TAB
                WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
                IF V_ORDEN_ESTATUS = 30 THEN
                    SELECT DESC_NOTIFICACION
                    INTO   V_OUTPUT
                    FROM   XXMOR_ORDENES_ESTATUS_TAB
                    WHERE  ID_NOTIFICACION = 30;
                    RETURN V_OUTPUT;
                END IF;
                --Estatus inicial
                SELECT DESC_NOTIFICACION
                INTO   V_OUTPUT
                FROM   XXMOR_ORDENES_ESTATUS_TAB
                WHERE  ID_NOTIFICACION = 11;
                RETURN V_OUTPUT;
            END IF;
            SELECT COUNT(DISTINCT NUMLINEA_CONCOM )
            INTO   V_TOT_RECHAZOS
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD                          = P_ID_SOLICITUD
            AND    ESTATUS_ORDUNI                        = '10'
            AND    NUMLINEA_CONCOM                       IS NOT NULL
            AND    INSTR(UPPER(ACCION_CONCOM),'RECHAZO') > 0;
            SELECT COUNT(1)
            INTO   V_RECHAZO_ENC
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD                          = P_ID_SOLICITUD
            AND    ESTATUS_ORDUNI                        = '10'
            AND    NUMLINEA_CONCOM                       IS NULL
            AND    INSTR(UPPER(ACCION_CONCOM),'RECHAZO') > 0;
            --DBMS_OUTPUT.PUT_LINE('RECHAZOS: '||V_TOT_RECHAZOS);
            SELECT COUNT(DISTINCT NUMLINEA_CONCOM )
            INTO   V_TOT_REPROCESOS
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD         = P_ID_SOLICITUD
            AND    ESTATUS_ORDUNI       = '10'
            AND    UPPER(ACCION_CONCOM) IN ('REENVIO','REPROCESO');
            SELECT COUNT(1)
            INTO   V_TOT_AUTORIZACION
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD                               = P_ID_SOLICITUD
            AND    ESTATUS_ORDUNI                             = '10'
            AND    INSTR(UPPER(ACCION_CONCOM),'AUTORIZACION') > 0;
            SELECT COUNT(1)
            INTO   V_TOT_RETENCION
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD                            = P_ID_SOLICITUD
            AND    ESTATUS_ORDUNI                          = '10'
            AND    INSTR(UPPER(ACCION_CONCOM),'RETENCION') > 0;
            SELECT ORDEN_ESTATUS
            INTO   V_ORDEN_ESTATUS
            FROM   XXMOR_SOLICITUDES_ENC_TAB
            WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
            SELECT COUNT(1)
            INTO   V_TOT_LINEAS
            FROM   XXMOR_SOLICITUDES_DET_TAB
            WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
            dbms_output.put_line('V_TOT_LINEAS '|| V_TOT_LINEAS );
            --TOTAL DE LINEAS EN REPROCESO
            SELECT COUNT(1)
            INTO   V_TOT_LIN_EN_REP
            FROM   XXMOR_SOLICITUDES_DET_TAB
            WHERE  ID_SOLICITUD  = P_ID_SOLICITUD
            AND    LINEA_ESTATUS = 30;
            dbms_output.put_line('V_TOT_LINEAS_REP (en reproceso )'|| V_TOT_LIN_EN_REP );
            -- TOTAL DE ERRORES CORREGIDOS DE LA ORDEN
            SELECT COUNT(DISTINCT NVL(NUMLINEA_CONCOM,'0'))
            INTO   V_RPTA_CC_CON_E
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
            AND    ESTATUS_ORDUNI != '20';
            dbms_output.put_line('V_RPTA_CC_CON_E '|| V_RPTA_CC_CON_E );
            -- TOTAL DE ERRORES SIN SER CORREGIDOS DE LA ORDEN
            SELECT COUNT(DISTINCT NVL(NUMLINEA_CONCOM,'0'))
            INTO   V_RPTA_CC_SIN_E
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD   = P_ID_SOLICITUD
            AND    ESTATUS_ORDUNI = '20';
            dbms_output.put_line('V_RPTA_CC_SIN_E '|| V_RPTA_CC_SIN_E );
            --- TOTAL DE LINEAS SIN INSTERTAR EN SISTEMA FINAL
            SELECT COUNT(1)
            INTO   V_TOT_EST_REP_E0
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB E
            WHERE  ESTAT_REP   != '2'
            AND    ID_SOLICITUD = P_ID_SOLICITUD;
            dbms_output.put_line('V_TOT_EST_REP_E0 '|| V_TOT_EST_REP_E0 );
            --- TOTAL DE LINEAS INSTERTADAS EN SISTEMA FINAL
            SELECT COUNT(1)
            INTO   V_TOT_EST_REP_E2
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB E
            WHERE  ESTAT_REP    = '2'
            AND    ID_SOLICITUD = P_ID_SOLICITUD;
            dbms_output.put_line('V_TOT_EST_REP_E2 '|| V_TOT_EST_REP_E2 );
            --TOTAL DE LINEAS TRATADAS DE INSERTAR
            SELECT COUNT(1)
            INTO   V_TOT_EST_REP
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB E
            WHERE  ESTAT_REP   != '0'
            AND    ID_SOLICITUD = P_ID_SOLICITUD;
            dbms_output.put_line('V_TOT_EST_REP_E0 '|| V_TOT_EST_REP_E0 );
            --TODA LA ORDEN ESTA EN SISTEMA FINAL
            IF V_TOT_EST_REP_E2 = V_TOT_LINEAS+1 THEN
                SELECT DESC_NOTIFICACION
                INTO   V_OUTPUT
                FROM   XXMOR_ORDENES_ESTATUS_TAB
                WHERE  ID_NOTIFICACION = 60;
                RETURN V_OUTPUT;
            --TODAS LAS LINEAS ESTAN RECHAZADAS
            ELSIF V_TOT_RECHAZOS = V_TOT_LINEAS THEN
                SELECT DESC_NOTIFICACION
                INTO   V_OUTPUT
                FROM   XXMOR_ORDENES_ESTATUS_TAB
                WHERE  ID_NOTIFICACION = 46;
                RETURN V_OUTPUT;
            --EL ENCABEZADO FUE RECHAZADO
            ELSIF V_RECHAZO_ENC > 0 THEN
                SELECT DESC_NOTIFICACION
                INTO   V_OUTPUT
                FROM   XXMOR_ORDENES_ESTATUS_TAB
                WHERE  ID_NOTIFICACION = 46;
                RETURN V_OUTPUT;
            --TODA LA ORDEN ESTA RETENIDA
            ELSIF V_TOT_RETENCION = V_TOT_LINEAS THEN
                SELECT DESC_NOTIFICACION
                INTO   V_OUTPUT
                FROM   XXMOR_ORDENES_ESTATUS_TAB
                WHERE  ID_NOTIFICACION = 36;
                RETURN V_OUTPUT;
            --LA ORDEN ESTA LISTA PARA SER ENVIADA
            ELSIF V_TOT_EST_REP_E2 = 0 AND V_RPTA_CC_SIN_E = V_TOT_LINEAS +1 AND V_RPTA_CC_CON_E = 0 THEN --Se suma mas 1 por el encabezado
                SELECT DESC_NOTIFICACION
                INTO   V_OUTPUT
                FROM   XXMOR_ORDENES_ESTATUS_TAB
                WHERE  ID_NOTIFICACION = 47;
                RETURN V_OUTPUT;
            ELSIF (V_TOT_REPROCESOS + V_TOT_RECHAZOS + V_TOT_RETENCION + V_TOT_AUTORIZACION + V_TOT_LIN_EN_REP ) > 0 AND V_TOT_EST_REP >0 THEN
                dbms_output.put_line('ESTATUS REP > 0 '|| V_TOT_EST_REP_E0 || ' TOT_RPTA_CC >0' );
                FOR C_ESTATUS IN ESTATUS_REPLICA_CUR LOOP
                    V_OUTPUT := V_OUTPUT || C_ESTATUS.ESTAT_REP||', ';
                END LOOP;
                FOR C_ESTATUS IN ESTATUS_CONCOM_CUR LOOP
                    V_OUTPUT := V_OUTPUT || C_ESTATUS.ACCION_CONCOM||', ';
                END LOOP;
                IF V_TOT_LIN_EN_REP > 0 THEN
                    SELECT V_OUTPUT||DESC_NOTIFICACION||', '
                    INTO   V_OUTPUT
                    FROM   XXMOR_ORDENES_ESTATUS_TAB
                    WHERE  ID_NOTIFICACION = 30;
                END IF;
                V_OUTPUT := SUBSTR(V_OUTPUT,1,LENGTH(V_OUTPUT)-2);
                RETURN V_OUTPUT;
            ELSIF (V_TOT_REPROCESOS + V_TOT_RECHAZOS + V_TOT_RETENCION + V_TOT_AUTORIZACION) > 0 AND V_TOT_EST_REP =0 THEN
                dbms_output.put_line('ESTATUS REP = 0 '|| V_TOT_EST_REP_E0 || ' TOT_RPTA_CC >0' );
                FOR C_ESTATUS IN ESTATUS_CONCOM_CUR LOOP
                    V_OUTPUT := V_OUTPUT || C_ESTATUS.ACCION_CONCOM||', ';
                END LOOP;
                V_OUTPUT := SUBSTR(V_OUTPUT,1,LENGTH(V_OUTPUT)-2);
                RETURN V_OUTPUT;
            ELSIF (V_TOT_REPROCESOS + V_TOT_RECHAZOS + V_TOT_RETENCION + V_TOT_AUTORIZACION) = 0 AND V_TOT_EST_REP >0 THEN
                dbms_output.put_line('ESTATUS REP > 0 '|| V_TOT_EST_REP_E0 || ' TOT_RPTA_CC = 0' );
                FOR C_ESTATUS IN ESTATUS_REPLICA_CUR LOOP
                    V_OUTPUT := V_OUTPUT || C_ESTATUS.ESTAT_REP||', ';
                END LOOP;
                V_OUTPUT := SUBSTR(V_OUTPUT,1,LENGTH(V_OUTPUT)-2);
                dbms_output.put_line('V_OUTPUT ' || V_OUTPUT );
                RETURN V_OUTPUT;
            ELSIF V_TOT_EST_REP_E2 > 0 THEN
                FOR C_ESTATUS IN ESTATUS_REPLICA_CUR LOOP
                    V_OUTPUT := V_OUTPUT || C_ESTATUS.ESTAT_REP||', ';
                END LOOP;
                V_OUTPUT := SUBSTR(V_OUTPUT,1,LENGTH(V_OUTPUT)-2);
                FOR C_ESTATUS IN ESTATUS_REPLICA_CUR LOOP
                    V_OUTPUT := V_OUTPUT || C_ESTATUS.ESTAT_REP||', ';
                END LOOP;
                V_OUTPUT := SUBSTR(V_OUTPUT,1,LENGTH(V_OUTPUT)-2);
                RETURN V_OUTPUT;
            --            ELSIF V_ORDEN_ESTATUS IN (10,20,25,30,33)  THEN
            --
            --                SELECT DESC_NOTIFICACION
            --                INTO V_OUTPUT
            --                FROM XXMOR_ORDENES_ESTATUS_TAB
            --                WHERE ID_NOTIFICACION = V_ORDEN_ESTATUS;
            --
            --                RETURN V_OUTPUT;
            ELSE
                FOR C_ESTATUS IN ESTATUS_REPLICA_CUR LOOP
                    V_OUTPUT := V_OUTPUT || C_ESTATUS.ESTAT_REP||', ';
                END LOOP;
                FOR C_ESTATUS IN ESTATUS_CONCOM_CUR LOOP
                    V_OUTPUT := V_OUTPUT || C_ESTATUS.ACCION_CONCOM||', ';
                END LOOP;
                V_OUTPUT := SUBSTR(V_OUTPUT,1,LENGTH(V_OUTPUT)-2);
                RETURN V_OUTPUT;
            END IF;
            RETURN 'Procesando';
        END IF;
        IF P_TIPO = 'ESTATUS_LINEA' THEN
            SELECT COUNT(1)
            INTO   V_RPTA_CC
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
            AND    NUMLINEA_CONCOM = P_LINEA;
            IF V_RPTA_CC = 0 THEN
                RETURN '11';
            END IF;
            SELECT COUNT(1)
            INTO   V_TOT_RETENCION
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD                            = P_ID_SOLICITUD
            AND    NUMLINEA_CONCOM                         = P_LINEA
            AND    ESTATUS_ORDUNI                          = '10'
            AND    INSTR(UPPER(ACCION_CONCOM),'RETENCION') > 0;
            IF V_TOT_RETENCION > 0 THEN
                RETURN '36';
            END IF;
            SELECT COUNT(1)
            INTO   V_TOT_RECHAZOS
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD                          = P_ID_SOLICITUD
            AND    NUMLINEA_CONCOM                       = P_LINEA
            AND    ESTATUS_ORDUNI                        = '10'
            AND    INSTR(UPPER(ACCION_CONCOM),'RECHAZO') > 0;
            IF V_TOT_RECHAZOS > 0 THEN
                RETURN '46';
            END IF;
            SELECT COUNT(1)
            INTO   V_TOT_REPROCESOS
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD         = P_ID_SOLICITUD
            AND    NUMLINEA_CONCOM      = P_LINEA
            AND    ESTATUS_ORDUNI       = '10'
            AND    UPPER(ACCION_CONCOM) IN ('REENVIO','REPROCESO');
            SELECT COUNT(1)
            INTO   V_TOT_AUTORIZACION
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD                               = P_ID_SOLICITUD
            AND    NUMLINEA_CONCOM                            = P_LINEA
            AND    ESTATUS_ORDUNI                             = '10'
            AND    INSTR(UPPER(ACCION_CONCOM),'AUTORIZACION') > 0;
            IF V_TOT_AUTORIZACION > 0 OR V_TOT_REPROCESOS > 0 THEN
                RETURN '45';
            END IF;
            SELECT TO_NUMBER(LINEA_ESTATUS)
            INTO   V_ESTATUS_lINEA
            FROM   XXMOR_SOLICITUDES_DET_TAB
            WHERE  ID_SOLICITUD = P_ID_SOLICITUD
            AND    LINEA        = P_LINEA;
            IF V_ESTATUS_lINEA IN (30, 33) THEN
                RETURN TO_CHAR(V_ESTATUS_lINEA);
            END IF;
            SELECT CASE ESTAT_REP WHEN '1' THEN 50
                                  WHEN '2' THEN 60
                                  WHEN '3' THEN 55
                   ELSE NULL
                   END
            INTO   V_ESTATUS_lINEA
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB E
            WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
            AND    E.LINEA        = P_LINEA;
            IF V_ESTATUS_lINEA IN (50,60,55) THEN
                RETURN V_ESTATUS_lINEA;
            END IF;
            IF V_TOT_REPROCESOS = 0 THEN
                RETURN 47;
            END IF;
            IF V_ESTATUS_LINEA IS NOT NULL THEN
                RETURN TO_CHAR(V_ESTATUS_LINEA);
            END IF;
            RETURN '0';
        END IF;
        IF P_TIPO = 'ESTATUS_ORD_N' THEN
            --reproceso
            SELECT COUNT(1)
            INTO   V_RPTA_CC_SIN_E
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD   = P_ID_SOLICITUD
            AND    ESTATUS_ORDUNI = '20';
            SELECT COUNT(1)
            INTO   V_RPTA_CC
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD   = P_ID_SOLICITUD
            AND    ESTATUS_ORDUNI = '10';
            IF V_RPTA_CC = 0 AND V_RPTA_CC_SIN_E > 0 THEN
                RETURN TO_CHAR('30');
            END IF;
            dbms_output.put_line('V_RPTA_CC_SIN_E '|| V_RPTA_CC_SIN_E );
            dbms_output.put_line('V_RPTA_CC_coN_E '|| V_RPTA_CC_CON_E );
            /*--
            SELECT TO_NUMBER(ORDEN_ESTATUS)
            INTO   V_ORDEN_ESTATUS
            FROM   XXMOR_SOLICITUDES_ENC_TAB
            WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
            dbms_output.put_line('V_ORDEN_ESTATUS estatus fisico'|| V_ORDEN_ESTATUS );
            dbms_output.put_line('--------------------------------------' );
            IF V_ORDEN_ESTATUS IN (30, 33, 42) THEN
                RETURN TO_CHAR(V_ESTATUS_lINEA);
            END IF;
            dbms_output.put_line('V_ORDEN_ESTATUS estatus fisico'|| V_ORDEN_ESTATUS );
            dbms_output.put_line('--------------------------------------' );
            */
            SELECT COUNT(1)
            INTO   V_TOT_REPROCESOS
            FROM   (SELECT DISTINCT
                           NUMLINEA_CONCOM
                    FROM   XXMOR_CONCOM_RPTA_TAB
                    WHERE  ID_SOLICITUD   = P_ID_SOLICITUD
                    AND    ESTATUS_ORDUNI = '10'
                   );
                   --AND    UPPER(ACCION_CONCOM) IN ('RECHAZO', 'AUTORIZACION');
            IF  V_TOT_REPROCESOS > 0 THEN
                RETURN '45';
            END IF;
            dbms_output.put_line('V_TOT_REPROCESOS '|| V_TOT_REPROCESOS );
            SELECT COUNT(1)
            INTO   V_TOT_EST_REP
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB E
            WHERE  ESTAT_REP    = '1'
            AND    ID_SOLICITUD = P_ID_SOLICITUD;
            dbms_output.put_line('V_TOT_EST_REP '|| V_TOT_EST_REP );
            IF V_TOT_EST_REP > 0 THEN
                RETURN 50;
            END IF;
            SELECT COUNT(1)
            INTO   V_TOT_LINEAS
            FROM   XXMOR_SOLICITUDES_DET_TAB
            WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
            SELECT COUNT(1)
            INTO   V_TOT_EST_REP_E2
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB E
            WHERE  ESTAT_REP    = '2'
            AND    ID_SOLICITUD = P_ID_SOLICITUD;
            IF V_TOT_LINEAS = V_TOT_EST_REP_E2 THEN
                RETURN '60';
            END IF;
            SELECT COUNT(1)
            INTO   V_TOT_EST_REP
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB E
            WHERE  ESTAT_REP    = '3'
            AND    ID_SOLICITUD = P_ID_SOLICITUD;
            IF V_TOT_EST_REP >0 THEN
                RETURN '55';
            END IF;
            SELECT COUNT(1)
            INTO   V_TOT_RETENCION
            FROM   (SELECT DISTINCT
                           NUMLINEA_CONCOM
                    FROM   XXMOR_CONCOM_RPTA_TAB
                    WHERE  ID_SOLICITUD                            = P_ID_SOLICITUD
                    AND    ESTATUS_ORDUNI                          = '10'
                    AND    NUMLINEA_CONCOM                         IS NOT NULL
                    AND    INSTR(UPPER(ACCION_CONCOM),'RETENCION') > 0
                   );
            IF V_TOT_LINEAS = V_TOT_RETENCION THEN
                RETURN '36';
            END IF;
            SELECT COUNT(1)
            INTO   V_TOT_RECHAZOS
            FROM   (SELECT DISTINCT
                           NUMLINEA_CONCOM
                    FROM   XXMOR_CONCOM_RPTA_TAB
                    WHERE  ID_SOLICITUD                          = P_ID_SOLICITUD
                    AND    ESTATUS_ORDUNI                        = '10'
                    AND    NUMLINEA_CONCOM                       IS NOT NULL
                    AND    INSTR(UPPER(ACCION_CONCOM),'RECHAZO') > 0
                   );
            IF V_TOT_LINEAS = V_TOT_RECHAZOS THEN
                RETURN '46';
            END IF;
            RETURN '0';
        END IF;
        IF P_TIPO = 'LINEA_BIEN' THEN
           --SI 1 ->LINEA BIEN
           --SI 0 PUES MAL
           SELECT COUNT(1)
           INTO   V_OUTPUT
           FROM  (SELECT DISTINCT
                         ID_SOLICITUD,
                         NUMLINEA_CONCOM
                  FROM   XXMOR_CONCOM_RPTA_TAB
                  WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                  AND    NUMLINEA_CONCOM IS NOT NULL
                  AND    ID_SEG_NEG      = 1
                  AND    NUMLINEA_CONCOM = P_LINEA
                  MINUS
                  SELECT DISTINCT
                         ID_SOLICITUD,
                         NUMLINEA_CONCOM
                  FROM   XXMOR_CONCOM_RPTA_TAB R
                  WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                  AND    NUMLINEA_CONCOM IS NOT NULL
                  AND    ESTATUS_ORDUNI  = '10'
                  AND    ID_SEG_NEG      = 1
                  AND    NUMLINEA_CONCOM = P_LINEA
                 );
            RETURN V_OUTPUT;
        END IF;
        RETURN 'x';
    END XXMOR_ORDEN_ESTATUS_FUN;
    FUNCTION XXMOR_NOTIFICACION_FUN
                        (
                                P_ID_SOLICITUD  IN NUMBER,
                                P_LINEAS        IN VARCHAR2,
                                P_ADVID         IN VARCHAR2,
                                P_ACCTHDRID     IN VARCHAR2,
                                P_MCONTID       IN VARCHAR2,
                                P_RTCRDDSCR     IN VARCHAR2,
                                P_EMAIL         IN VARCHAR2,
                                P_COMENTARIOS   IN VARCHAR2,
                                P_ORDEN_ESTATUS IN NUMBER,
                                P_EMAIL_TO      IN VARCHAR2
                        ) RETURN INTEGER IS
    P_Solicitud xxmor_Funcional_pkg.Mor_Enc_Rec_Type;
    BEGIN
        P_SOLICITUD.ID_SOLICITUD  := P_ID_SOLICITUD;
        P_SOLICITUD.ADVID         := P_ADVID;
        P_SOLICITUD.ACCTHDRID     := P_ACCTHDRID;
        P_SOLICITUD.MCONTID       := P_MCONTID;
        P_SOLICITUD.RTCRDDSCR     := P_RTCRDDSCR;
        P_SOLICITUD.EMAIL         := P_EMAIL;
        P_SOLICITUD.COMENTARIOS   := P_COMENTARIOS;
        P_SOLICITUD.ORDEN_ESTATUS := P_ORDEN_ESTATUS;
        --P_SOLICITUD.EMAIL_TO      := P_EMAIL_TO;
    XXMOR_SOL_NOTIFICACION_PR ( P_SOLICITUD );
    RETURN 0;
    /*EXCEPTION
            WHEN others THEN
                INSERT INTO XXMOR_LOG_ERRORES_TAB(ID_ERROR, DESC_ERROR, ARCHIVO_ERROR, METODO_ERROR)
                VALUES(XXMOR_LOG_ERROR_SQ.NEXTVAL, 'No pudo enviarse la notificacion', NULL, 'procedure XXMOR_HTML_EMAIL_PR(to:'||P_email||', subject:  ,...') );*/
    END XXMOR_NOTIFICACION_FUN;
    FUNCTION XXMOR_SOL_TOTALES_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO         IN VARCHAR2
                        ) RETURN NUMBER AS
    V_TOTAL     NUMBER;
    BEGIN
        --total spots por orden
        CASE WHEN P_TIPO = 'SP_X_O' THEN
            BEGIN
                --dbms_output.put_line(p_tipo);
                SELECT SUM(CEIL(TO_NUMBER((((TO_DATE(FECHA_FIN,'YYYYMMDD') - TO_DATE(FECHA_INICIO,'YYYYMMDD'))+1)/7)))
                           * (LUNES+MARTES+MIERCOLES+JUEVES+VIERNES+SABADO+DOMINGO)
                          )
                INTO   V_TOTAL
                FROM   XXMOR_SOLICITUDES_DET_TAB
                WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
            EXCEPTION
                WHEN OTHERS THEN
                    V_TOTAL := NULL;
            END;
        --total spots por linea
        WHEN P_TIPO = 'SP_X_L' THEN
            BEGIN
                SELECT  CEIL(TO_NUMBER((((TO_DATE(FECHA_FIN,'YYYYMMDD') - TO_DATE(FECHA_INICIO,'YYYYMMDD'))+1)/7)))
                        * (LUNES+MARTES+MIERCOLES+JUEVES+VIERNES+SABADO+DOMINGO) AS TOT_SPOTS
                INTO    V_TOTAL
                FROM    XXMOR_SOLICITUDES_DET_TAB
                WHERE   ID_SOLICITUD = P_ID_SOLICITUD
                AND     LINEA        = P_LINEA;
            EXCEPTION
                WHEN OTHERS THEN
                    V_TOTAL := NULL;
            END;
        -- total con descuento Master Contract por orden
        WHEN P_TIPO = 'TCD_X_O' THEN
            BEGIN
                SELECT SUM(TARIFASP_SIN_DESC * XXMOR_DESC_MCONTID_FUN(ID_SOLICITUD)
                           * CEIL(TO_NUMBER((((TO_DATE(FECHA_FIN,'YYYYMMDD') - TO_DATE(FECHA_INICIO,'YYYYMMDD'))+1)/7)))
                           * (LUNES+MARTES+MIERCOLES+JUEVES+VIERNES+SABADO+DOMINGO)
                          )
                INTO   V_TOTAL
                FROM   XXMOR_SOLICITUDES_DET_TAB
                WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
            EXCEPTION
                WHEN OTHERS THEN
                    V_TOTAL := NULL;
            END;
        -- total con descuento Master Contract mas Sobrecargo por orden
        WHEN P_TIPO = 'TCDSC_X_O' THEN
            BEGIN
                SELECT SUM(CASE
                               WHEN SOBRECARGO IS NOT NULL THEN
                                   (TARIFASP_SIN_DESC * XXMOR_FUNCIONAL_PKG.XXMOR_DESC_MCONTID_FUN(ID_SOLICITUD)
                                    * CEIL(TO_NUMBER((((TO_DATE(FECHA_FIN,'YYYYMMDD') - TO_DATE(FECHA_INICIO,'YYYYMMDD'))+1)/7)))
                                    * (LUNES+MARTES+MIERCOLES+JUEVES+VIERNES+SABADO+DOMINGO)
                                   ) *
                                   (CASE
                                        WHEN ABS(TO_NUMBER(TRIM(REPLACE(REPLACE(UPPER(NVL(SOBRECARGO,'0')), 'DESC. ', '-'), '%', '')))) < 1 THEN
                                            (1 + TO_NUMBER(TRIM(REPLACE(REPLACE(UPPER(NVL(SOBRECARGO,'0')), 'DESC. ', '-'), '%', ''))))
                                        ELSE
                                           (1 + (TO_NUMBER(TRIM(REPLACE(REPLACE(UPPER(NVL(SOBRECARGO,'0')), 'DESC. ', '-'), '%', '')))/100))
                                   END)
                               ELSE
                                   (TARIFASP_SIN_DESC * XXMOR_FUNCIONAL_PKG.XXMOR_DESC_MCONTID_FUN(ID_SOLICITUD)
                                    * CEIL(TO_NUMBER((((TO_DATE(FECHA_FIN,'YYYYMMDD') - TO_DATE(FECHA_INICIO,'YYYYMMDD'))+1)/7)))
                                    * (LUNES+MARTES+MIERCOLES+JUEVES+VIERNES+SABADO+DOMINGO)
                                   )
                           END) MONTO_LIN_DESC_SOB
                INTO   V_TOTAL
                FROM   XXMOR_SOLICITUDES_DET_TAB
                WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
            EXCEPTION
                WHEN OTHERS THEN
                    V_TOTAL := NULL;
            END;
        --total sin descuento por orden
        WHEN P_TIPO = 'TSD_X_O' THEN
            BEGIN
                SELECT SUM(TARIFASP_SIN_DESC * CEIL(TO_NUMBER((((TO_DATE(FECHA_FIN,'YYYYMMDD') - TO_DATE(FECHA_INICIO,'YYYYMMDD'))+1)/7)))
                           *(LUNES+MARTES+MIERCOLES+JUEVES+VIERNES+SABADO+DOMINGO)
                          )
                INTO   V_TOTAL
                FROM   XXMOR_SOLICITUDES_DET_TAB
                WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
            EXCEPTION
                WHEN OTHERS THEN
                    V_TOTAL := NULL;
            END;
        --total por orden
        WHEN P_TIPO = 'TOT_X_O' THEN
                SELECT TRUNC(100 * SUM(TARIFASP_SIN_DESC * CEIL(TO_NUMBER((((TO_DATE(FECHA_FIN,'YYYYMMDD') - TO_DATE(FECHA_INICIO,'YYYYMMDD'))+1)/7)))
                                       *(LUNES+MARTES+MIERCOLES+JUEVES+VIERNES+SABADO+DOMINGO)
                                      ),2)
                INTO   V_TOTAL
                FROM   XXMOR_SOLICITUDES_DET_TAB D,
                       (SELECT DISTINCT
                               ID_SOLICITUD,
                               NUMLINEA_CONCOM
                        FROM   XXMOR_CONCOM_RPTA_TAB
                        WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                        AND    NUMLINEA_CONCOM IS NOT NULL
                        AND    ID_SEG_NEG      = 1
                        MINUS
                        SELECT DISTINCT
                               ID_SOLICITUD,
                               NUMLINEA_CONCOM
                        FROM   XXMOR_CONCOM_RPTA_TAB
                        WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                        AND    NUMLINEA_CONCOM IS NOT NULL
                        AND    ESTATUS_ORDUNI  = '10'
                        AND    ID_SEG_NEG      = 1
                       )                         CR
                WHERE  D.ID_SOLICITUD = CR.ID_SOLICITUD
                AND    D.LINEA        = CR.NUMLINEA_CONCOM
                AND    D.ID_SOLICITUD = P_ID_SOLICITUD;
        --total spots x semana de una linea
        WHEN P_TIPO = 'SS_X_L' THEN
            BEGIN
                SELECT LUNES+MARTES+MIERCOLES+JUEVES+VIERNES+SABADO+DOMINGO AS TOT_SPOTS
                INTO   V_TOTAL
                FROM   XXMOR_SOLICITUDES_DET_TAB
                WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                AND    LINEA        = P_LINEA;
            EXCEPTION
            WHEN OTHERS THEN
                V_TOTAL := NULL;
            END;
        --ENCABEZADO TOTAL DE SPOTS PARA INSERTAR EN SISTEMA FINAL
        WHEN P_TIPO = 'TOT_SPOTS_BIEN' THEN
                SELECT SUM(CEIL(TO_NUMBER((((TO_DATE(FECHA_FIN,'YYYYMMDD') - TO_DATE(FECHA_INICIO,'YYYYMMDD'))+1)/7)))
                           *(LUNES+MARTES+MIERCOLES+JUEVES+VIERNES+SABADO+DOMINGO)
                          )
                INTO   V_TOTAL
                FROM   XXMOR_SOLICITUDES_DET_TAB D,
                       (SELECT DISTINCT
                               ID_SOLICITUD,
                               NUMLINEA_CONCOM
                        FROM   XXMOR_CONCOM_RPTA_TAB
                        WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                        AND    NUMLINEA_CONCOM IS NOT NULL
                        AND    ID_SEG_NEG      = 1
                        MINUS
                        SELECT DISTINCT
                               ID_SOLICITUD,
                               NUMLINEA_CONCOM
                        FROM   XXMOR_CONCOM_RPTA_TAB
                        WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                        AND    NUMLINEA_CONCOM IS NOT NULL
                        AND    ESTATUS_ORDUNI  = '10'
                        AND    ID_SEG_NEG      = 1
                       )                         CR
                WHERE  D.ID_SOLICITUD = CR.ID_SOLICITUD
                AND    D.LINEA        = CR.NUMLINEA_CONCOM
                AND    D.ID_SOLICITUD = P_ID_SOLICITUD;
        WHEN P_TIPO = 'TOT_PARA_' THEN
            BEGIN
                SELECT LUNES+MARTES+MIERCOLES+JUEVES+VIERNES+SABADO+DOMINGO AS TOT_SPOTS
                INTO   V_TOTAL
                FROM   XXMOR_SOLICITUDES_DET_TAB D
                WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                AND    LINEA        = P_LINEA;
            EXCEPTION
                WHEN OTHERS THEN
                    V_TOTAL := NULL;
            END;
        END CASE;
        RETURN TRUNC(V_TOTAL,2);
    END XXMOR_SOL_TOTALES_FUN;
    FUNCTION XXMOR_SOL_FECHAS_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO         IN VARCHAR2
                        ) RETURN VARCHAR2 AS
    V_Total     varchar2(100);
    BEGIN
        IF P_TIPO = 'F_1A_T' THEN
            BEGIN
                SELECT TO_CHAR(TO_DATE(fecha_inicio, 'yyyymmdd')
                                          +  CASE
                                          WHEN LUNES != 0 THEN 0
                                          WHEN MARTES != 0 THEN 1
                                          WHEN MIERCOLES != 0 THEN 2
                                          WHEN JUEVES != 0 THEN 3
                                          WHEN VIERNES != 0 THEN 4
                                          WHEN SABADO!= 0 THEN 5
                                          WHEN DOMINGO != 0 THEN 6
                                          ELSE NULL
                                       END,'YYYYMMDD')
                INTO V_Total
                FROM XXMOR_SOLICITUDES_det_TAB
                WHERE id_solicitud = P_ID_SOLICITUD
                AND linea = P_Linea;
            EXCEPTION
                WHEN OTHERS THEN
                    V_Total := '00010101';
            END;
        ELSIF P_TIPO = 'F_U_T' THEN
            BEGIN
                SELECT TO_CHAR(TO_DATE(fecha_fin, 'yyyymmdd')
                                          -  CASE
                                          WHEN DOMINGO != 0 THEN 0
                                          WHEN SABADO != 0 THEN 1
                                          WHEN VIERNES != 0 THEN 2
                                          WHEN JUEVES  != 0 THEN 3
                                          WHEN MIERCOLES != 0 THEN 4
                                          WHEN MARTES != 0 THEN 5
                                          WHEN LUNES != 0 THEN 6
                                          ELSE NULL
                                       END,'YYYYMMDD')
                INTO V_Total
                FROM XXMOR_SOLICITUDES_det_TAB
                WHERE id_solicitud = P_ID_SOLICITUD
                AND linea = P_Linea;
            EXCEPTION
                WHEN OTHERS THEN
                    V_Total := '00010101';
            END;
        /*
        --FECHA EXACTA PRIMERA TRANSMISION PARA COPYS POR ORDEN
        ELSIF P_TIPO = 'FECOPY_PT_XO' THEN
        BEGIN
            SELECT TO_CHAR(TO_DATE(FECHA_INICIO, 'yyyymmdd')
                                      -  CASE
                                      WHEN DOMINGO != 0 THEN 0
                                      WHEN SABADO != 0 THEN 1
                                      WHEN VIERNES != 0 THEN 2
                                      WHEN JUEVES  != 0 THEN 3
                                      WHEN MIERCOLES != 0 THEN 4
                                      WHEN MARTES != 0 THEN 5
                                      WHEN LUNES != 0 THEN 6
                                      ELSE NULL
                                   END,'YYYYMMDD')
            INTO V_TOTAL
            FROM XXMOR_SOLICITUDES_DET_TAB
            WHERE ID_SOLICITUD = P_ID_SOLICITUD
            AND LINEA = (SELECT MIN(TO_DATE(FECHA_INICIO,'YYYYMMDD')
                         FROM XXMOR_SOLICITUDES_DET_TAB
                         WHERE ID_SOLICITUD = P_ID_SOLICITUD);
        EXCEPTION
        WHEN OTHERS THEN
            V_Total := '00010101';
        END;
        --FECHA EXACTA ULTIMA TRANSMISION PARA COPYS POR ORDEN
        ELSIF P_TIPO = 'FECOPY_UT_XO' THEN
        BEGIN
            SELECT TO_CHAR(TO_DATE(fecha_fin, 'yyyymmdd')
                                      -  CASE
                                      WHEN DOMINGO != 0 THEN 0
                                      WHEN SABADO != 0 THEN 1
                                      WHEN VIERNES != 0 THEN 2
                                      WHEN JUEVES  != 0 THEN 3
                                      WHEN MIERCOLES != 0 THEN 4
                                      WHEN MARTES != 0 THEN 5
                                      WHEN LUNES != 0 THEN 6
                                      ELSE NULL
                                   END,'YYYYMMDD')
            INTO V_Total
            FROM XXMOR_SOLICITUDES_det_TAB
            WHERE id_solicitud = P_ID_SOLICITUD
            AND LINEA = (SELECT MAX(TO_DATE(FECHA_INICIO,'YYYYMMDD')
                         FROM XXMOR_SOLICITUDES_DET_TAB
                         WHERE ID_SOLICITUD = P_ID_SOLICITUD);
        EXCEPTION
        WHEN OTHERS THEN
            V_Total := '00010101';
        END;
        */
        --Regresa la fecha inicio a nivel de encabezado (debe ser la fecha menor de las lineas que estan listas para ser enviadas a paradigm o que ya se enviaron)
        ELSIF  P_TIPO = 'FI_ENC' THEN
            SELECT  TO_CHAR(MIN(TO_DATE(FECHA_INICIO,'YYYYMMDD')),'YYYY-MM-DD')
            INTO V_TOTAL
            FROM XXMOR_SOLICITUDES_DET_TAB D,
                      (SELECT DISTINCT ID_SOLICITUD, NUMLINEA_CONCOM
                           FROM XXMOR_CONCOM_RPTA_TAB
                          WHERE NUMLINEA_CONCOM IS NOT NULL
                          AND     ID_SEG_NEG = 1
                         MINUS
                         SELECT DISTINCT ID_SOLICITUD, NUMLINEA_CONCOM
                           FROM XXMOR_CONCOM_RPTA_TAB
                          WHERE ESTATUS_ORDUNI = '10'
                          AND     ID_SEG_NEG = 1) CR
            WHERE  D.ID_SOLICITUD = CR.ID_SOLICITUD
            AND D.LINEA = CR.NUMLINEA_CONCOM
            AND D.ID_SOLICITUD = P_ID_SOLICITUD
            AND EXISTS (SELECT 1
                             FROM  XXMOR_SOLICITUDES_ENC_TAB E
                             WHERE E.ID_SOLICITUD = D.ID_SOLICITUD
                             AND     E.ID_SEG_NEG = 1
                             );
        --Regresa la fecha final a nivel de encabezado (debe ser la fecha mayor de las lineas que estan listas para ser enviadas a paradigm o que ya se enviaron)
        ELSIF  P_TIPO = 'FF_ENC' THEN
            SELECT  TO_CHAR(MAX(TO_DATE(FECHA_FIN,'YYYYMMDD')),'YYYY-MM-DD')
            INTO V_TOTAL
            FROM XXMOR_SOLICITUDES_DET_TAB D,
                      (SELECT DISTINCT ID_SOLICITUD, NUMLINEA_CONCOM
                           FROM XXMOR_CONCOM_RPTA_TAB
                          WHERE NUMLINEA_CONCOM IS NOT NULL
                          AND     ID_SEG_NEG = 1
                         MINUS
                         SELECT DISTINCT ID_SOLICITUD, NUMLINEA_CONCOM
                           FROM XXMOR_CONCOM_RPTA_TAB
                          WHERE ESTATUS_ORDUNI = '10'
                          AND     ID_SEG_NEG = 1) CR
            WHERE  D.ID_SOLICITUD = CR.ID_SOLICITUD
            AND D.LINEA = CR.NUMLINEA_CONCOM
            AND D.ID_SOLICITUD = P_ID_SOLICITUD
            AND EXISTS (SELECT 1
                             FROM  XXMOR_SOLICITUDES_ENC_TAB E
                             WHERE E.ID_SOLICITUD = D.ID_SOLICITUD
                             AND     E.ID_SEG_NEG = 1
                             );
        -- Regresa la fecha para calcular RTCRD_CA
        --ELSIF  P_TIPO = 'FF_RTCRD_CA' THEN
        --Regresa la fecha inicial para los Copys(debe ser la fecha menor de las lineas de la orden) 06JUN2013
        ELSIF  P_TIPO = 'FI_COPY' THEN
            SELECT TO_CHAR(MIN(TO_DATE(FECHA_INICIO,'YYYYMMDD')),'YYYY-MM-DD')
            INTO   V_TOTAL
            FROM   XXMOR_SOLICITUDES_DET_TAB D,
                   (SELECT DISTINCT ID_SOLICITUD, NUMLINEA_CONCOM
                    FROM   XXMOR_CONCOM_RPTA_TAB
                    WHERE  NUMLINEA_CONCOM IS NOT NULL
                    AND    ID_SEG_NEG      = 1
                   ) CR
            WHERE  D.ID_SOLICITUD = CR.ID_SOLICITUD
            AND    D.LINEA        = CR.NUMLINEA_CONCOM
            AND    D.ID_SOLICITUD = P_ID_SOLICITUD
            AND    EXISTS           (SELECT 1
                                     FROM   XXMOR_SOLICITUDES_ENC_TAB E
                                     WHERE  E.ID_SOLICITUD = D.ID_SOLICITUD
                                     AND    E.ID_SEG_NEG   = 1
                                    );
        --Regresa la fecha final para los Copys(debe ser la fecha mayor de las lineas de la orden) 06JUN2013
        ELSIF  P_TIPO = 'FF_COPY' THEN
            SELECT TO_CHAR(MAX(TO_DATE(FECHA_FIN,'YYYYMMDD')),'YYYY-MM-DD')
            INTO   V_TOTAL
            FROM   XXMOR_SOLICITUDES_DET_TAB D,
                   (SELECT DISTINCT ID_SOLICITUD, NUMLINEA_CONCOM
                    FROM   XXMOR_CONCOM_RPTA_TAB
                    WHERE  NUMLINEA_CONCOM IS NOT NULL
                   ) CR
            WHERE  D.ID_SOLICITUD = CR.ID_SOLICITUD
            AND    D.LINEA        = CR.NUMLINEA_CONCOM
            AND    D.ID_SOLICITUD = P_ID_SOLICITUD
            AND    EXISTS           (SELECT 1
                                     FROM   XXMOR_SOLICITUDES_ENC_TAB E
                                     WHERE  E.ID_SOLICITUD = D.ID_SOLICITUD
                                     AND    E.ID_SEG_NEG   = 1
                                    );
        END IF;
        RETURN V_Total;
    END XXMOR_SOL_FECHAS_FUN;
    FUNCTION XXMOR_EN_SEMANA_CONF_FUN
                        (
                                P_DIA_INICIO  IN VARCHAR2,
                                P_HORA_INICIO IN VARCHAR2,
                                P_DIA_FIN     IN VARCHAR2,
                                P_HORA_FIN    IN VARCHAR2
                        ) RETURN NUMBER IS
    D_AUX_FIN           INTEGER;
    D_AUX_INI           INTEGER;
    D_AUX_HOY           INTEGER;
    D_AUX_HOY_NOMBRE    VARCHAR2(23);
    V_RESULTADO         INTEGER;
    V_FEC_INI           DATE;
    V_FEC_FIN           DATE;
    V_FEC_HOY           DATE;
    BEGIN
        BEGIN
            EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_TERRITORY=MEXICO';
        END;
        SELECT TRIM(TO_CHAR(SYSDATE,'DAY','nls_date_language=spanish'))
        INTO D_AUX_HOY_NOMBRE
        FROM DUAL;
        dbms_output.put_line(' dia hoy: '||d_aux_hoy_nombre );
        IF P_DIA_INICIO = 'LUNES' THEN
            SELECT
                CASE UPPER(P_DIA_inicio)
                    WHEN 'LUNES'        THEN 1
                    WHEN 'MARTES'       THEN 2
                    WHEN 'MIERCOLES'    THEN 3
                    WHEN 'JUEVES'       THEN 4
                    WHEN 'VIERNES'      THEN 5
                    WHEN 'SABADO'       THEN 6
                    WHEN 'DOMINGO'      THEN 7
                ELSE 0 END
            INTO  d_aux_ini
            FROM dual;
            SELECT
                CASE UPPER(P_DIA_FIN)
                    WHEN 'LUNES'        THEN 1
                    WHEN 'MARTES'       THEN 2
                    WHEN 'MIERCOLES'    THEN 3
                    WHEN 'JUEVES'       THEN 4
                    WHEN 'VIERNES'      THEN 5
                    WHEN 'SABADO'       THEN 6
                    WHEN 'DOMINGO'      THEN 7
                ELSE 0 END
            INTO  d_aux_fin
            FROM dual;
            SELECT
                CASE UPPER(d_aux_hoy_nombre)
                    WHEN 'LUNES'        THEN 1
                    WHEN 'MARTES'       THEN 2
                    WHEN 'MIERCOLES'    THEN 3
                    WHEN 'JUEVES'       THEN 4
                    WHEN 'VIERNES'      THEN 5
                    WHEN 'SABADO'       THEN 6
                    WHEN 'DOMINGO'      THEN 7
                ELSE 0 END
            INTO  d_aux_hoy
            FROM dual;
        ELSIF P_DIA_INICIO = 'MARTES' THEN
            SELECT
                CASE UPPER(P_DIA_inicio)
                    WHEN 'LUNES'        THEN 7
                    WHEN 'MARTES'       THEN 1
                    WHEN 'MIERCOLES'    THEN 2
                    WHEN 'JUEVES'       THEN 3
                    WHEN 'VIERNES'      THEN 4
                    WHEN 'SABADO'       THEN 5
                    WHEN 'DOMINGO'      THEN 6
                ELSE 0 END
            INTO  d_aux_ini
            FROM dual;
            SELECT
                CASE UPPER(P_DIA_FIN)
                    WHEN 'LUNES'        THEN 7
                    WHEN 'MARTES'       THEN 1
                    WHEN 'MIERCOLES'    THEN 2
                    WHEN 'JUEVES'       THEN 3
                    WHEN 'VIERNES'      THEN 4
                    WHEN 'SABADO'       THEN 5
                    WHEN 'DOMINGO'      THEN 6
                ELSE 0 END
            INTO  d_aux_fin
            FROM dual;
            SELECT
                CASE UPPER(d_aux_hoy_nombre)
                    WHEN 'LUNES'        THEN 7
                    WHEN 'MARTES'       THEN 1
                    WHEN 'MIERCOLES'    THEN 2
                    WHEN 'JUEVES'       THEN 3
                    WHEN 'VIERNES'      THEN 4
                    WHEN 'SABADO'       THEN 5
                    WHEN 'DOMINGO'      THEN 6
                ELSE 0 END
            INTO  d_aux_hoy
            FROM dual;
        ELSIF P_DIA_INICIO =   'MIERCOLES' THEN
            SELECT
                CASE UPPER(P_DIA_inicio)
                    WHEN 'LUNES'        THEN 6
                    WHEN 'MARTES'       THEN 7
                    WHEN 'MIERCOLES'    THEN 1
                    WHEN 'JUEVES'       THEN 2
                    WHEN 'VIERNES'      THEN 3
                    WHEN 'SABADO'       THEN 4
                    WHEN 'DOMINGO'      THEN 5
                ELSE 0 END
            INTO  d_aux_ini
            FROM dual;
            SELECT
                CASE UPPER(P_DIA_FIN)
                    WHEN 'LUNES'        THEN 6
                    WHEN 'MARTES'       THEN 7
                    WHEN 'MIERCOLES'    THEN 1
                    WHEN 'JUEVES'       THEN 2
                    WHEN 'VIERNES'      THEN 3
                    WHEN 'SABADO'       THEN 4
                    WHEN 'DOMINGO'      THEN 5
                ELSE 0 END
            INTO  d_aux_fin
            FROM dual;
            SELECT
                CASE UPPER(d_aux_hoy_nombre)
                    WHEN 'LUNES'        THEN 6
                    WHEN 'MARTES'       THEN 7
                    WHEN 'MIERCOLES'    THEN 1
                    WHEN 'JUEVES'       THEN 2
                    WHEN 'VIERNES'      THEN 3
                    WHEN 'SABADO'       THEN 4
                    WHEN 'DOMINGO'      THEN 5
                ELSE 0 END
            INTO  d_aux_hoy
            FROM dual;
        ELSIF P_DIA_INICIO =  'JUEVES' THEN
            SELECT
                CASE UPPER(P_DIA_inicio)
                    WHEN 'LUNES'        THEN 5
                    WHEN 'MARTES'       THEN 6
                    WHEN 'MIERCOLES'    THEN 7
                    WHEN 'JUEVES'       THEN 1
                    WHEN 'VIERNES'      THEN 2
                    WHEN 'SABADO'       THEN 3
                    WHEN 'DOMINGO'      THEN 4
                ELSE 0 END
            INTO  d_aux_ini
            FROM dual;
            SELECT
                CASE UPPER(P_DIA_FIN)
                    WHEN 'LUNES'        THEN 5
                    WHEN 'MARTES'       THEN 6
                    WHEN 'MIERCOLES'    THEN 7
                    WHEN 'JUEVES'       THEN 1
                    WHEN 'VIERNES'      THEN 2
                    WHEN 'SABADO'       THEN 3
                    WHEN 'DOMINGO'      THEN 4
                ELSE 0 END
            INTO  d_aux_fin
            FROM dual;
            SELECT
                CASE UPPER(d_aux_hoy_nombre)
                    WHEN 'LUNES'        THEN 5
                    WHEN 'MARTES'       THEN 6
                    WHEN 'MIERCOLES'    THEN 7
                    WHEN 'JUEVES'       THEN 1
                    WHEN 'VIERNES'      THEN 2
                    WHEN 'SABADO'       THEN 3
                    WHEN 'DOMINGO'      THEN 4
                ELSE 0 END
            INTO  d_aux_hoy
            FROM dual;
        ELSIF P_DIA_INICIO =  'VIERNES' THEN
            SELECT
                CASE UPPER(P_DIA_inicio)
                    WHEN 'LUNES'        THEN 4
                    WHEN 'MARTES'       THEN 5
                    WHEN 'MIERCOLES'    THEN 6
                    WHEN 'JUEVES'       THEN 7
                    WHEN 'VIERNES'      THEN 1
                    WHEN 'SABADO'       THEN 2
                    WHEN 'DOMINGO'      THEN 3
                ELSE 0 END
            INTO  d_aux_ini
            FROM dual;
            SELECT
                CASE UPPER(P_DIA_FIN)
                    WHEN 'LUNES'        THEN 4
                    WHEN 'MARTES'       THEN 5
                    WHEN 'MIERCOLES'    THEN 6
                    WHEN 'JUEVES'       THEN 7
                    WHEN 'VIERNES'      THEN 1
                    WHEN 'SABADO'       THEN 2
                    WHEN 'DOMINGO'      THEN 3
                ELSE 0 END
            INTO  d_aux_fin
            FROM dual;
            SELECT
                CASE UPPER(d_aux_hoy_nombre)
                    WHEN 'LUNES'        THEN 4
                    WHEN 'MARTES'       THEN 5
                    WHEN 'MIERCOLES'    THEN 6
                    WHEN 'JUEVES'       THEN 7
                    WHEN 'VIERNES'      THEN 1
                    WHEN 'SABADO'       THEN 2
                    WHEN 'DOMINGO'      THEN 3
                ELSE 0 END
            INTO  d_aux_hoy
            FROM dual;
        ELSIF P_DIA_INICIO = 'SABADO' THEN
            SELECT
                CASE UPPER(P_DIA_inicio)
                    WHEN 'LUNES'        THEN 3
                    WHEN 'MARTES'       THEN 4
                    WHEN 'MIERCOLES'    THEN 5
                    WHEN 'JUEVES'       THEN 6
                    WHEN 'VIERNES'      THEN 7
                    WHEN 'SABADO'       THEN 1
                    WHEN 'DOMINGO'      THEN 2
                ELSE 0 END
            INTO  d_aux_ini
            FROM dual;
            SELECT
                CASE UPPER(P_DIA_FIN)
                    WHEN 'LUNES'        THEN 3
                    WHEN 'MARTES'       THEN 4
                    WHEN 'MIERCOLES'    THEN 5
                    WHEN 'JUEVES'       THEN 6
                    WHEN 'VIERNES'      THEN 7
                    WHEN 'SABADO'       THEN 1
                    WHEN 'DOMINGO'      THEN 2
                ELSE 0 END
            INTO  d_aux_fin
            FROM dual;
            SELECT
                CASE UPPER(d_aux_hoy_nombre)
                    WHEN 'LUNES'        THEN 3
                    WHEN 'MARTES'       THEN 4
                    WHEN 'MIERCOLES'    THEN 5
                    WHEN 'JUEVES'       THEN 6
                    WHEN 'VIERNES'      THEN 7
                    WHEN 'SABADO'       THEN 1
                    WHEN 'DOMINGO'      THEN 2
                ELSE 0 END
            INTO  d_aux_hoy
            FROM dual;
        ELSIF P_DIA_INICIO = 'DOMINGO' THEN
            SELECT
                CASE UPPER(P_DIA_inicio)
                    WHEN 'LUNES'        THEN 2
                    WHEN 'MARTES'       THEN 3
                    WHEN 'MIERCOLES'    THEN 4
                    WHEN 'JUEVES'       THEN 5
                    WHEN 'VIERNES'      THEN 6
                    WHEN 'SABADO'       THEN 7
                    WHEN 'DOMINGO'      THEN 1
                ELSE 0 END
            INTO  d_aux_ini
            FROM dual;
            SELECT
                CASE UPPER(P_DIA_FIN)
                    WHEN 'LUNES'        THEN 2
                    WHEN 'MARTES'       THEN 3
                    WHEN 'MIERCOLES'    THEN 4
                    WHEN 'JUEVES'       THEN 5
                    WHEN 'VIERNES'      THEN 6
                    WHEN 'SABADO'       THEN 7
                    WHEN 'DOMINGO'      THEN 1
                ELSE 0 END
            INTO  d_aux_fin
            FROM dual;
            SELECT
                CASE UPPER(d_aux_hoy_nombre)
                    WHEN 'LUNES'        THEN 2
                    WHEN 'MARTES'       THEN 3
                    WHEN 'MIERCOLES'    THEN 4
                    WHEN 'JUEVES'       THEN 5
                    WHEN 'VIERNES'      THEN 6
                    WHEN 'SABADO'       THEN 7
                    WHEN 'DOMINGO'      THEN 1
                ELSE 0 END
            INTO  d_aux_hoy
            FROM dual;
        END IF;
        dbms_output.put_line('dia_ini: '||d_aux_ini|| '  dia fin'||d_aux_fin||' dia hoy: '||d_aux_hoy);
        SELECT TO_DATE('2001010'||TO_CHAR(D_AUX_INI)||' '||P_HORA_INICIO,'YYYYMMDD HH24MI') AS FEC_INI,
               TO_DATE('2001010'||TO_CHAR(D_AUX_FIN)||' '||P_HORA_FIN,'YYYYMMDD HH24MI') AS FEC_FIN,
               TO_DATE('2001010'||TO_CHAR(D_AUX_HOY)||' '||TO_CHAR(SYSDATE,'HH24MI'),'YYYYMMDD HH24MI') AS FEC_HOY
        INTO   V_FEC_INI,
               V_FEC_FIN,
               V_FEC_HOY
        FROM DUAL;
        IF V_FEC_HOY BETWEEN  V_FEC_INI AND V_FEC_FIN THEN
            V_RESULTADO:= 0;
        ELSE
            V_RESULTADO:= 1;
        END IF;
        RETURN V_RESULTADO;
    END XXMOR_EN_SEMANA_CONF_FUN;
    FUNCTION XXMOR_FECHA_SIN_ER_FUN
                        (
                                P_FECHA IN VARCHAR2,
                                P_TIPO  IN VARCHAR2
                        ) RETURN VARCHAR2 IS
    V_FECHA_OUT VARCHAR2(50);
    BEGIN
        IF P_TIPO = 'AUT_TM' THEN
            BEGIN
                SELECT TO_CHAR (TO_DATE (P_FECHA, 'YYYYMMDD'), 'YYYY-MM-DD')
                INTO V_FECHA_OUT
                FROM DUAL;
            EXCEPTION
                WHEN OTHERS THEN
                    V_FECHA_OUT := '0001-01-01';
            END;
        END IF;
        RETURN V_FECHA_OUT;
    END XXMOR_FECHA_SIN_ER_FUN;
    FUNCTION XXMOR_FECHA_VALIDA_FUN
                        (
                                P_FECHA IN VARCHAR2
                        ) RETURN VARCHAR2 IS
    V_ES_VALIDA VARCHAR2(2) := '0';
    BEGIN
        IF P_FECHA IS NOT NULL THEN
            BEGIN
                SELECT NVL2(TO_DATE (P_FECHA, 'YYYYMMDD'),'1','0')
                INTO V_ES_VALIDA
                FROM DUAL;
            EXCEPTION
                WHEN OTHERS THEN
                    V_ES_VALIDA := '0';
            END;
        END IF;
        RETURN V_ES_VALIDA;
    END XXMOR_FECHA_VALIDA_FUN;
    FUNCTION XXMOR_DURACION_VALIDA_FUN
                        (
                                P_DURACION IN VARCHAR2
                        ) RETURN INTEGER IS
    V_ES_VALIDA INTEGER := 0;
    BEGIN
        IF P_DURACION IS NOT NULL THEN
            BEGIN
                SELECT NVL2(TO_NUMBER(P_DURACION),1,0)
                INTO V_ES_VALIDA
                FROM DUAL;
            EXCEPTION
                WHEN OTHERS THEN
                    V_ES_VALIDA := 0;
            END;
        END IF;
        RETURN V_ES_VALIDA;
    END XXMOR_DURACION_VALIDA_FUN;
    --pARA MAILS DE FACTUR
    FUNCTION XXMOR_MARCAS_ORDEN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN VARCHAR2 IS
    V_MARCAS          VARCHAR2(1000);
    V_OUTPUT          VARCHAR2(1000);
    V_ADVID           VARCHAR2(50);
    V_COUNT_MARCAS    INTEGER := 0;
    V_CORREO_FACTUR   INTEGER := 0;
    V_ID_FZA_VENTAS   PLS_INTEGER;
    V_ESQ_FACTUR      VARCHAR2(20);
    CURSOR LINEAS_ORD_CUR IS
        SELECT DISTINCT MARCA
        FROM   XXMOR_SOLICITUDES_DET_TAB
        WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
    BEGIN
        SELECT ID_FZA_VENTAS
        INTO V_ID_FZA_VENTAS
        FROM XXMOR_SOLICITUDES_ENC_TAB
        WHERE ID_SOLICITUD = P_ID_SOLICITUD;
        SELECT ''''''||ESQUEMA_FACTUR||''''''
        INTO V_ESQ_FACTUR
        FROM XXMOR_FZAS_VTAS_TAB
        WHERE ID_FZA_VENTAS = V_ID_FZA_VENTAS;
        BEGIN
            SELECT ''''''''||ADVID||''''''''
            INTO V_ADVID
            FROM XXMOR_SOLICITUDES_ENC_TAB
            WHERE ID_SOLICITUD = P_ID_SOLICITUD;
        EXCEPTION
            WHEN OTHERS THEN
                RETURN 'NO SE ENCONTRO SOLICITUD';
        END;
        BEGIN
            SELECT COUNT(1)
            INTO   V_CORREO_FACTUR
            FROM   XXMOR_CONF_NOTIFIC_TAB
            WHERE  USUARIO_FACTUR = 1
            AND    ID_SEG_NEG     = 1
            AND    ID_FZA_VENTAS  = V_ID_FZA_VENTAS;
        EXCEPTION
            WHEN OTHERS THEN
                RETURN 'NO SE ECNONTRO FZA';
        END;
        V_MARCAS := '''';
        FOR MARCAS IN LINEAS_ORD_CUR LOOP
            V_MARCAS := V_MARCAS || ''''''||MARCAS.MARCA||''''',';
            V_COUNT_MARCAS := V_COUNT_MARCAS + 1;
            DBMS_OUTPUT.PUT_LINE('V_MARCAS: '||V_MARCAS);
        END LOOP;
        V_MARCAS := SUBSTR(V_MARCAS,1,LENGTH(V_MARCAS) - 1) || '''';
        DBMS_OUTPUT.PUT_LINE('V_MARCAS: '||V_MARCAS);
        IF V_COUNT_MARCAS > 0 AND V_CORREO_FACTUR > 0 THEN
            V_OUTPUT := 'CALL MOR.XXMOR_MAILS_FACTUR_PR('||P_ID_SOLICITUD ||','||V_ADVID||','|| V_MARCAS||','||V_ESQ_FACTUR||')';
            DBMS_OUTPUT.PUT_LINE('V_MARCAS: '||V_MARCAS);
        END IF;
        DBMS_OUTPUT.PUT_LINE('4 V_OUTPUT: '||V_OUTPUT);
        RETURN NVL(V_OUTPUT,'SELECT '' '' AS HOLA FROM SYSIBM.SYSDUMMY1');
    END XXMOR_MARCAS_ORDEN;
    FUNCTION XXMOR_HTML_MAIL
                        (
                                P_ID_SOLICITUD  IN INTEGER,
                                P_LINEAS        IN VARCHAR2,
                                P_ORDEN_ESTATUS IN INTEGER
                        ) RETURN CLOB IS
    V_ORDEN_HTML          CLOB;
    V_IP_SMTP_SRV         VARCHAR2(30);
    V_ESTATUS_DESC        VARCHAR2(100);
    V_ERRORES_LINEA       VARCHAR2(32000);
    V_FUERZA_VENTAS       VARCHAR2(100);
    V_FECHA               VARCHAR2(150);
    V_ID_PARADIGM         VARCHAR2(25);
    V_ID_ONAIR            VARCHAR2(25);
    V_COLOR               VARCHAR2(10);
    V_EST_LINEA           VARCHAR2(5);
    V_AUX                 INTEGER;
    V_NOMBRE_ARCHIVO      VARCHAR2(150);
    V_DIR_LOGO            VARCHAR2(200);
    lstTxtFooter          VARCHAR2(3001);
    CURSOR CUR_HDR_SOL IS
    SELECT ID_SOLICITUD,
           ID_REQUEST,
           ID_SEG_NEG,
           ID_FZA_VENTAS,
           ID_SOLICITUD_HNA,
           NVL2(PROC_POR_LINEA,'SI','NO') PROC_POR_LINEA,
           DECODE(GARANTIZADO, '1', 'SI', 'NO') GARANTIZADO,
           ADVID,
           MCONTID,
           MCONTID_CUTIN,
           EMAIL,
           AGYESTNUM,
           ACCTHDRID,
           RTCRDDSCR,
           RTCRD,
           RTCRDDSCR_CUTIN,
           RTCRD_CUTIN,
           COMENTARIOS,
           SECNUM,
           PLATAFORMA_CANAL,
           AGRUPADOR,
           PRDID_DESC,
           PRDID,
           TOTAL_SPOTS,
           TOTAL_SIN_DESC,
           TOTAL_CON_DESC,
           TIPO_FACTURACION,
           DESCUENTO,
           TARGET,
           CREATED_DATE,
           CREATED_BY,
           UPDATED_DATE,
           UPDATED_BY,
           ORDEN_ESTATUS,
           FECHA_CONCOM,
           TRACKING_ID_CONCOM,
           AUX1,
           AUX2,
           AUX3
    FROM   XXMOR_SOLICITUDES_ENC_TAB
    WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
    V_HDR_SOL CUR_HDR_SOL%ROWTYPE;
    CURSOR CUR_DET_SOL IS
    SELECT ID_SOLICITUD,
           LINEA,
           LINEA_HNA,
           STNID,
           FECHA_INICIO,
           FECHA_FIN,
           DURACION,
           BUYUNTID,
           HORA_INICIO,
           HORA_FIN,
           SPOTS,
           LUNES,
           MARTES,
           MIERCOLES,
           JUEVES,
           VIERNES,
           SABADO,
           DOMINGO,
           SPOTS_X_SEMANA,
           TIPO_SERVICIO,
           USR_CHR,
           SPOT_CHR,
           BN,
           P,
           MARCA,
           VERSION,
           TARIFASP_SIN_DESC,
           TARIFASP_CON_DESC,
           TOT_LINEA_SIN_DESC,
           TOT_LINEA_CON_DESC,
           SOBRECARGO,
           OBSERVACIONES,
           CREATED_BY,
           CREATED_DATE,
           UPDATED_DATE,
           UPDATED_BY,
           DES_PLATAFORMA
    FROM   XXMOR_SOLICITUDES_DET_TAB
    WHERE  ID_SOLICITUD = P_ID_SOLICITUD
    AND    INSTR(NVL(P_LINEAS,LINEA),LINEA) > 0
    ORDER BY LINEA ASC;
    V_DET_SOL CUR_DET_SOL%ROWTYPE;
    CURSOR AUTORIZACIONES_CUR IS
    SELECT CR.UPDATED_BY||' autorizo por '||CR.CAMPO_CONCOM AS AUTORIZACION_MSG
    FROM   XXMOR_CONCOM_RPTA_TAB CR
    WHERE  CR.ID_SOLICITUD         = P_ID_SOLICITUD
    AND    CR.NUMLINEA_CONCOM      = V_DET_SOL.LINEA
    AND    CR.ESTATUS_ORDUNI       = '20'
    AND    UPPER(CR.ACCION_CONCOM) = 'AUTORIZACION'
    AND    NOT EXISTS                (SELECT 1
                                      FROM   XXMOR_CONCOM_RPTA_TAB CR2
                                      WHERE  CR2.ID_SOLICITUD         = CR.ID_SOLICITUD
                                      AND    CR2.NUMLINEA_CONCOM      = CR.NUMLINEA_CONCOM
                                      AND    UPPER(CR2.ACCION_CONCOM) = 'RECHAZO'
                                     );
    BEGIN
        --TRAEMOS EL ESTATUS DE LA ORDEN
        SELECT DESC_NOTIFICACION
        INTO   V_ESTATUS_DESC
        FROM   XXMOR_ORDENES_ESTATUS_TAB
        WHERE  ID_NOTIFICACION = DECODE(P_ORDEN_ESTATUS,20,10,P_ORDEN_ESTATUS);
        --NOMBRE DEL ARCHIVO RELACIONADO A LA ORDEN
        SELECT A.NOM_ARCHIVO_SOL
        INTO   V_NOMBRE_ARCHIVO
        FROM   XXMOR_SOLICITUDES_ARCH_TAB     A,
               XXMOR_SOLICITUDES_ENC_TAB      E,
               XXMOR_SOLICITUDES_ORIG_ENC_TAB EO
        WHERE  E.ID_SOLICITUD    = P_ID_SOLICITUD
        AND    E.ID_REQUEST      = EO.ID_REQUEST
        AND    EO.ID_ARCHIVO_SOL = A.ID_ARCHIVO_SOL
        AND    E.ID_SEG_NEG      = 1
        AND    E.ID_SEG_NEG      = A.ID_SEG_NEG;
        --PARAMETRO IP DE LA IMAGEN DEL CORREO
        SELECT VALOR_PARAMETRO
        INTO   V_DIR_LOGO
        FROM   XXMOR_CONF_PARAMS_GRLS_TAB
        WHERE  NOMBRE_PARAMETRO = 'LogoMail';
        OPEN CUR_HDR_SOL;
            FETCH CUR_HDR_SOL
            INTO  V_HDR_SOL;
        CLOSE CUR_HDR_SOL;
        SELECT TO_CHAR(SYSDATE,'Daydd Monthyyyy HH24:MI','NLS_LANGUAGE=SPANISH')
        INTO   V_FECHA
        FROM   DUAL;
        SELECT XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN(P_ID_SOLICITUD,V_DET_SOL.LINEA,'lineaMail')
        INTO   V_ERRORES_LINEA
        FROM   DUAL;
        BEGIN
            SELECT NOMBRE_FZA_VENTAS
            INTO   V_FUERZA_VENTAS
            FROM   XXMOR_FZAS_VTAS_TAB
            WHERE  ID_FZA_VENTAS = V_HDR_SOL.ID_FZA_VENTAS
            AND    ID_SEG_NEG    = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_FUERZA_VENTAS := 'SIN FUERZA DE VENTAS';
        END;
        BEGIN
            SELECT ESTAT_ID_FORANEO
            INTO   V_ID_PARADIGM
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB
            WHERE  ID_SIST      = 1
            AND    ID_SOLICITUD = P_ID_SOLICITUD
            AND    LINEA        = 0;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_ID_PARADIGM := ' ';
        END;
        BEGIN
            SELECT ESTAT_ID_FORANEO
            INTO   V_ID_ONAIR
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB
            WHERE  ID_SIST      = 2
            AND    ID_SOLICITUD = P_ID_SOLICITUD
            AND    LINEA        = 0;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_ID_ONAIR := ' ';
        END;
        V_ORDEN_HTML :='<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Televisa - Orduni</title>
        </head>
        <body>
        <table  width="1330" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td align="left" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#252671">
        <tr>
        <td width="180" rowspan="3" align="center" valign="middle"><!--img src="'||V_DIR_LOGO||'" width="150" height="50"/--></td>
        <td height="20" align="left">;</td>
        </tr>
        <tr>
        <td height="20" align="left" valign="bottom" style="font-family:Verdana, Geneva, sans-serif; font-size:20px; font-weight:bold; color:#FFF;">Correo de Notificacion</td>
        </tr>
        <tr>
        <td height="30" align="left" valign="middle" style="font-family:Verdana, Geneva, sans-serif; font-size:14px; color:#FFF;">De la orden no: ' || P_ID_SOLICITUD|| '</td>
        </tr>
        </table></td>
        </tr>
        <tr>
        <td>;</td>
        </tr>
        <tr>
            <td bgcolor="#FF801A" height="1"></td>
        </tr>
        <tr>
        <td bgcolor="#FBE194" height="1"></td>
        </tr>
        <tr>
        <td>;</td>
        </tr>
        <tr>
        <td bgcolor="#666666"><table width="100%" border="0" cellspacing="1" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:#000;">
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Clave Cliente</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.ADVID|| '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Clave Encabezado de<br/>Cliente - Agencia</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.ACCTHDRID|| '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Fuerza de<br/>Ventas</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_FUERZA_VENTAS|| '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">CPS - Master Contract</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.MCONTID|| '</td>
        </tr>
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Nombre Tarifa</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.rtcrddscr || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Categoria de<br/>Producto</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.PRDID_DESC || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Plataforma<br/>Canal</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.PLATAFORMA_CANAL || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Ref folio</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.AGYESTNUM || '</td>
        </tr>
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Nombre / email<br/>Responsable(s)</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.EMAIL || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Target</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || REPLACE(V_HDR_SOL.TARGET,'?',';') || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Garantizado</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.GARANTIZADO || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Proc x linea</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.PROC_POR_LINEA || '</td>
        </tr>
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Total Spots</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.TOTAL_SPOTS || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Total Tarifa Referencia</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.TOTAL_SIN_DESC || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Total Tarifa Definitiva</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.TOTAL_con_DESC || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4"></td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Tipo facturacion</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.TIPO_FACTURACION || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Ajuste Variable Contrato</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.Descuento || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Comentarios de la<br/>Orden de Servicio</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF" colspan="3" >' || V_HDR_SOL.comentarios || '</td>
        </tr>
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">ID PARADIGM</td>
        <td style="padding: 3px;" align="left" valign="middle"  bgcolor="#FFFFFF">'||V_ID_PARADIGM||'</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">ID ONAIR</td>
        <td style="padding: 3px;" align="left" valign="middle"  bgcolor="#FFFFFF">'||V_ID_ONAIR||'</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Estatus Encabezado</td>
        <td style="padding: 3px;" align="left" valign="middle" colspan="3" bgcolor="#FFFFFF">' || xxmor_funcional_pkg.xxmor_Ident_Errores_FUN(P_ID_SOLICITUD, NULL, 'lineaMail') || '</td>
        </tr>
        </table></td>
        </tr>
        <tr>
        <td>;</td>
        </tr>
        <tr>
        <td bgcolor="#FF801A" height="1"></td>
        </tr>
        <tr>
        <td bgcolor="#FBE194" height="1"></td>
        </tr>
        <tr>
        <td>;</td>
        </tr>
        <tr>
        <td bgcolor="#666666">
          <table width="100%" border="0" cellspacing="1" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
        <!--tr>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF" width="70">;</td>
        <td colspan="2" align="center" valign="middle" bgcolor="#E4E4E4">Fecha</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF" width="100">;</td>
        <td bgcolor="#FFFFFF" width="50">;</td>
        <td bgcolor="#FFFFFF" width="50">;</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td colspan="7" align="center" valign="middle" bgcolor="#E4E4E4" style="font-weight:bold">Cantidad de<br/>Transmisiones</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        </tr-->
        <tr>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
                <tr>
                <td align="center" valign="middle">L</td>
                </tr>
                <tr>
                <td align="center" valign="middle">?</td>
                </tr>
                <tr>
                <td align="center" valign="middle">n</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Estatus</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
                <tr>
                <td align="center" valign="middle">ID</td>
                </tr>
                <tr>
                <td align="center" valign="middle">PGM</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
                <tr>
                <td align="center" valign="middle">ID</td>
                </tr>
                <tr>
                <td align="center" valign="middle">ONAIR</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">C</td>
        </tr>
        <tr>
        <td align="center" valign="middle">a</td>
        </tr>
        <tr>
        <td align="center" valign="middle">n</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
        <tr>
        <td align="center" valign="middle">Fecha</td>
        </tr>
        <tr>
        <td align="center" valign="middle">inicio</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
        <tr>
        <td align="center" valign="middle">Fecha</td>
        </tr>
        <tr>
        <td align="center" valign="middle">fin</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">D</td>
        </tr>
        <tr>
        <td align="center" valign="middle">u</td>
        </tr>
        <tr>
        <td align="center" valign="middle">r</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Programa /<br/>Paquete /<br/>Bloque Horario</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">H</td>
        <td align="center" valign="middle"> </td>
        </tr>
        <tr>
        <td align="center" valign="middle">o</td>
        <td align="center" valign="middle">I</td>
        </tr>
        <tr>
        <td align="center" valign="middle">r</td>
        <td align="center" valign="middle">n</td>
        </tr>
        <tr>
        <td align="center" valign="middle">a</td>
        <td align="center" valign="middle">i</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">H</td>
        <td align="center" valign="middle">;</td>
        </tr>
        <tr>
        <td align="center" valign="middle">o</td>
        <td align="center" valign="middle">F</td>
        </tr>
        <tr>
        <td align="center" valign="middle">r</td>
        <td align="center" valign="middle">i</td>
        </tr>
        <tr>
        <td align="center" valign="middle">a</td>
        <td align="center" valign="middle">n</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">S</td>
        <td align="center" valign="middle">X</td>
        </tr>
        <tr>
        <td align="center" valign="middle">p</td>
        <td align="center" valign="middle">;</td>
        </tr>
        <tr>
        <td align="center" valign="middle">o</td>
        <td align="center" valign="middle">S</td>
        </tr>
        <tr>
        <td align="center" valign="middle">t</td>
        <td align="center" valign="middle">e</td>
        </tr>
        <tr>
        <td align="center" valign="middle">s</td>
        <td align="center" valign="middle">m</td>
        </tr>
        </table>
        </td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr><td align="center">L</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">M</td>
        </tr>
        <tr>
        <td align="center">a</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">M</td>
        </tr>
        <tr>
        <td align="center">i</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">J</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">V</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">S</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">D</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">T</td>
        <td align="center" valign="middle">;</td>
        </tr>
        <tr>
        <td align="center" valign="middle">o</td>
        <td align="center" valign="middle">;</td>
        </tr>
        <tr>
        <td align="center" valign="middle">t</td>
        <td align="center" valign="middle">;</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Tipo de Servicio</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">BN</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">P</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Marca</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Version</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
                <tr>
                <td align="center" valign="middle">Tarifa Referencia</td>
                </tr>
                <tr>
                <td align="center" valign="middle">Por Spot</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
                <tr>
                <td align="center" valign="middle">Tarifa Definitiva</td>
                </tr>
                <tr>
                <td align="center" valign="middle">Por Spot</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
                <tr>
                <td align="center" valign="middle">Tot Linea</td>
                </tr>
                <tr>
                <td align="center" valign="middle">Tarifa Ref</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
                <tr>
                <td align="center" valign="middle">Tot Linea</td>
                </tr>
                <tr>
                <td align="center" valign="middle">Tarifa Def</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Ajuste</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Observaciones</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Plataforma</td>
        </tr>';
        BEGIN
            OPEN CUR_DET_SOL;
            LOOP
                FETCH CUR_DET_SOL
                INTO  V_DET_SOL;
                EXIT WHEN CUR_DET_SOL%NOTFOUND;
                IF P_LINEAS IS NULL OR NVL(SUBSTR(P_LINEAS,(INSTR(P_LINEAS,V_DET_SOL.LINEA) + LENGTH(V_DET_SOL.LINEA)),1),',') = ',' THEN
                    SELECT XXMOR_ORDEN_ESTATUS_FUN(P_ID_SOLICITUD, V_DET_SOL.LINEA,'ESTATUS_LINEA')
                    INTO   V_EST_LINEA
                    FROM   DUAL;
                    BEGIN
                        SELECT ESTAT_ID_FORANEO
                        INTO   V_ID_PARADIGM
                        FROM   XXMOR_SOLICITUDES_EST_REP_TAB
                        WHERE  ID_SIST      = 1
                        AND    ID_SOLICITUD = P_ID_SOLICITUD
                        AND    LINEA        = V_DET_SOL.LINEA;
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            V_ID_PARADIGM := ' ';
                    END;
                    BEGIN
                        SELECT ESTAT_ID_FORANEO
                        INTO   V_ID_ONAIR
                        FROM   XXMOR_SOLICITUDES_EST_REP_TAB
                        WHERE  ID_SIST      = 2
                        AND    ID_SOLICITUD = P_ID_SOLICITUD
                        AND    LINEA        = V_DET_SOL.LINEA;
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            V_ID_ONAIR:= ' ';
                    END;
                    IF V_EST_LINEA = '36' THEN
                        V_COLOR := 'FFFFFF'; --BLANCO
                        SELECT DESC_NOTIFICACION
                        INTO   V_ERRORES_LINEA
                        FROM   XXMOR_ORDENES_ESTATUS_TAB
                        WHERE  ID_NOTIFICACION = 36;
                    ELSIF V_EST_LINEA = '46' THEN
                        /*SELECT REPLACE(DESC_NOTIFICACION,'Orden', 'Linea') || (SELECT ' por: ' || REPLACE(CREATED_BY,'ConComWsResponse','Condiciones Comerciales')
                                                     FROM XXMOR_CONCOM_RPTA_TAB C
                                                     WHERE ID_SOLICITUD = P_ID_SOLICITUD
                                                       AND NUMLINEA_CONCOM = V_DET_SOL.LINEA
                                                       AND UPPER(ACCION_CONCOM) = 'RECHAZO'
                                                       AND ROWNUM = 1 )
                        INTO V_ERRORES_LINEA
                        FROM XXMOR_ORDENES_ESTATUS_TAB
                        WHERE ID_NOTIFICACION = 46;
                        */
                        SELECT CASE CREATED_BY WHEN 'ConComWsResponse' THEN 'Linea rechazada por: Condiciones Comerciales'
                               ELSE 'Linea rechazada por: ' || REPLACE(CREATED_BY,'ConComWsResponse','Condiciones Comerciales') || ' (' || CAMPO_CONCOM|| ')'
                               END
                        INTO   V_ERRORES_LINEA
                        FROM   XXMOR_CONCOM_RPTA_TAB C
                        WHERE  ID_SOLICITUD         = P_ID_SOLICITUD
                        AND    NUMLINEA_CONCOM      = V_DET_SOL.LINEA
                        AND    UPPER(ACCION_CONCOM) = 'RECHAZO'
                        AND    ROWNUM               = 1;
                        SELECT XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN(P_ID_SOLICITUD,V_DET_SOL.linea,'lineaMail')||'
                        '||V_errores_linea
                        INTO V_errores_linea
                        FROM DUAL;
                    ELSIF V_EST_LINEA = '45' THEN
                        SELECT XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN(P_ID_SOLICITUD,V_DET_SOL.linea,'lineaMail')
                        INTO   V_errores_linea
                        FROM   DUAL;
                    ELSE
                        SELECT REPLACE(DESC_NOTIFICACION,'Orden completa', 'Linea')
                        INTO   V_ERRORES_LINEA
                        FROM   XXMOR_ORDENES_ESTATUS_TAB
                        WHERE  ID_NOTIFICACION = TO_NUMBER(V_EST_LINEA);
                    END IF;
                    FOR AUTORIZACION IN AUTORIZACIONES_CUR LOOP
                        V_ERRORES_LINEA := V_ERRORES_LINEA || '<br>' ||AUTORIZACION.AUTORIZACION_MSG;
                    END LOOP;
                    SELECT COUNT(1)
                    INTO V_AUX
                    FROM XXMOR_SOLICITUDES_DET_TAB
                    WHERE TRACKING_ID_CONCOM = (SELECT TRACKING_ID_CONCOM
                                                FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                               )
                    AND ID_SOLICITUD         = P_ID_SOLICITUD
                    AND LINEA                = V_DET_SOL.LINEA;
                    IF V_AUX > 0 THEN
                        V_COLOR := 'F7DCC3';
                    ELSE
                        V_COLOR := 'FFFFFF';
                    END IF;
                    V_ORDEN_HTML := V_ORDEN_HTML || '<tr>
                                    <td align="center" width="10" valign="middle" bgcolor="#'||V_COLOR||'">' || TO_CHAR(V_DET_SOL.LINEA) || '</td>
                                    <td align="center" width="300" bgcolor="#'||V_COLOR||'">' || V_ERRORES_LINEA || '</td>
                                    <td align="center" width="40" bgcolor="#'||V_COLOR||'">' || V_ID_PARADIGM || '</td>
                                    <td align="center" width="40" bgcolor="#'||V_COLOR||'">' || V_ID_ONAIR || '</td>
                                    <td align="center" width="60" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.STNID|| '</td>
                                    <td align="center" width="60" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.FECHA_INICIO|| '</td>
                                    <td align="center" width="60" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.FECHA_FIN|| '</td>
                                    <td align="center" width="20" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.DURACION|| '</td>
                                    <td align="center" width="70" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.BUYUNTID|| '</td>
                                    <td align="center" width="30" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.HORA_INICIO|| '</td>
                                    <td align="center" width="30" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.HORA_FIN|| '</td>
                                    <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.SPOTS|| '</td>
                                    <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.LUNES|| '</td>
                                    <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.MARTES|| '</td>
                                    <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.MIERCOLES|| '</td>
                                    <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.JUEVES|| '</td>
                                    <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.VIERNES|| '</td>
                                    <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.SABADO|| '</td>
                                    <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.DOMINGO|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.SPOTS_X_SEMANA|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.TIPO_SERVICIO|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.BN|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.P|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.MARCA|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.VERSION|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.TARIFASP_SIN_DESC|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.TARIFASP_CON_DESC|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.TOT_LINEA_SIN_DESC|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.TOT_LINEA_CON_DESC|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.SOBRECARGO|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.OBSERVACIONES|| '</td>
                                    <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.DES_PLATAFORMA|| '</td>
                              </tr>';
                END IF;
            END LOOP;
            CLOSE CUR_DET_SOL;
            BEGIN
                SELECT VALOR_PARAMETRO
                INTO   lstTxtFooter
                FROM   XXMOR_CONF_PARAMS_GRLS_TAB
                WHERE  NOMBRE_PARAMETRO = 'EMAIL_TXT_ORD_ST_FOOTER';
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    lstTxtFooter := '';
            END;
            V_ORDEN_HTML := V_ORDEN_HTML ||'</table></td>
                  </tr>
                      <tr><td>;</td></tr>
                      <tr style="font-size:small; font-weight:bold; font-family:sans-serif;">
                        <td>'||lstTxtFooter||'</td>
                      </tr>
                      <tr><td>;</td></tr>
                      <tr><td bgcolor="#FCE49F" height="3"></td></tr>
                      <tr><td bgcolor="#FF801A" height="3"></td></tr>
                      <tr><td bgcolor="#D50000" height="3"></td></tr>
                  <tr><td style="font-family:Verdana, Geneva, sans-serif; font-size:12px; font-weight:bold color:#000;">'|| v_fecha ||'</td></tr>
                </table>
                </body>';
        END;
        RETURN V_ORDEN_HTML;
    END XXMOR_HTML_MAIL;
    FUNCTION XXMOR_VERSION_VIRTUAL
                        (
                                P_AGRUPADOR IN INTEGER
                        ) RETURN VARCHAR2 IS
    lstwsCall                   VARCHAR(2500);
    V_WS_URL                    VARCHAR(100);
    V_AUX                       VARCHAR(100);
    --Cursor para llenar los parametros del WS que genera/revisa las versiones virtuales
    /*CURSOR CUR_LINEAS_ORDEN IS
    SELECT *
    FROM    XXMOR_VERS_VIRT_AUX_VW
    WHERE ID_SOLICITUD = P_ID_SOLICITUD;*/
    CURSOR CUR_LINEAS_ORDEN IS
    SELECT *
    FROM   XXMOR_VERS_VIRT_AUX_VW
    WHERE  ID_SOLICITUD IN (SELECT ET.ID_SOLICITUD
                            FROM   XXMOR.XXMOR_SOLICITUDES_ORIG_ENC_TAB OE,
                                   XXMOR.XXMOR_SOLICITUDES_ENC_TAB      ET
                            WHERE  OE.ID_REQUEST = ET.ID_REQUEST
                            AND    OE.AUX1       = P_AGRUPADOR
                           );
    BEGIN
        SELECT VALOR_PARAMETRO
        INTO   V_WS_URL
        FROM   XXMOR_CONF_PARAMS_GRLS_TAB
        WHERE  NOMBRE_PARAMETRO = 'WS_Version_Virtual';
        FOR lrowVerVirtual IN CUR_LINEAS_ORDEN LOOP
            lstwsCall := '
            <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
               <soapenv:Header/>
               <soapenv:Body>
                  <tem:S_InsertarVersionVirtual>
                     <tem:sAdvid>'|| lrowVerVirtual.ADVID ||'</tem:sAdvid>
                     <tem:sExtcpynum>'|| lrowVerVirtual.EXTCPYNUM ||'</tem:sExtcpynum>
                     <tem:iNomanclen>'|| lrowVerVirtual.NOMANCLEN ||'</tem:iNomanclen>
                     <tem:dtAncstrdt>'|| lrowVerVirtual.ANCSTRDT ||'</tem:dtAncstrdt>
                     <tem:dtAncedt>'|| lrowVerVirtual.ANCEDT ||'</tem:dtAncedt>
                     <tem:sUsrchr>'|| lrowVerVirtual.USRCHR ||'</tem:sUsrchr>
                     <tem:sSptchr>'|| lrowVerVirtual.SPTCHR ||'</tem:sSptchr>
                     <tem:sPrdid1>'|| lrowVerVirtual.PRDID1 ||'</tem:sPrdid1>
                     <tem:sVidsrc>'|| lrowVerVirtual.VIDSRC ||'</tem:sVidsrc>
                     <tem:sAudsrc>'|| lrowVerVirtual.AUDSRC ||'</tem:sAudsrc>
                     <tem:sBrnd>'|| lrowVerVirtual.BRND ||'</tem:sBrnd>
                     <tem:sAutoid>'|| lrowVerVirtual.AUTOID ||'</tem:sAutoid>
                     <tem:sProactday>'|| lrowVerVirtual.PROACTDAY ||'</tem:sProactday>
                     <tem:sActday>'|| lrowVerVirtual.ACTDAY ||'</tem:sActday>
                     <tem:sPropgmid>'|| lrowVerVirtual.PROPGMID ||'</tem:sPropgmid>
                     <tem:sProstn>'|| lrowVerVirtual.PROSTN ||'</tem:sProstn>
                  </tem:S_InsertarVersionVirtual>
               </soapenv:Body>
            </soapenv:Envelope>';
            --DBMS_OUTPUT.PUT_LINE(lstwsCall);
            XXMOR_CALL_WS_SP (lstwsCall, V_WS_URL);
        END LOOP;
        RETURN V_AUX;
    END XXMOR_VERSION_VIRTUAL;
    FUNCTION XXMOR_ENV_SOL_CONCOM_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN VARCHAR2 IS
    CURSOR LINEAS_CUR IS
    SELECT LINEA
    FROM   XXMOR_SOLICITUDES_DET_TAB d,
           (SELECT DISTINCT ID_SOLICITUD, NUMLINEA_CONCOM
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
            AND    NUMLINEA_CONCOM IS NOT NULL
            AND    ID_SEG_NEG      = 1
            MINUS
            SELECT DISTINCT ID_SOLICITUD, NUMLINEA_CONCOM
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
            AND    NUMLINEA_CONCOM IS NOT NULL
            AND    ESTATUS_ORDUNI  = '10'
            AND    ID_SEG_NEG      = 1
           )                      CR
    WHERE  D.ID_SOLICITUD = CR.ID_SOLICITUD(+)
    AND    D.LINEA        = CR.NUMLINEA_CONCOM(+)
    AND    D.ID_SOLICITUD = P_ID_SOLICITUD
    AND    EXISTS           (SELECT 1
                             FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                             WHERE  ER.ID_SOLICITUD     = D.ID_SOLICITUD
                             AND    ER.LINEA            = D.LINEA
                             AND    ER.ESTAT_ID_FORANEO IS NULL
                            );
    V_DIR_WS          VARCHAR2(250);
    V_LINEAS_ENV      VARCHAR2(2250);
    V_SOAP_CALL       VARCHAR2(1500);
    BEGIN
        FOR C_LINEAS IN LINEAS_CUR LOOP
            V_LINEAS_ENV := V_LINEAS_ENV ||C_LINEAS.LINEA||',';
        END LOOP;
        dbms_output.put_line('-> '||V_LINEAS_ENV);
        SELECT SUBSTR(V_LINEAS_ENV,1,LENGTH(V_LINEAS_ENV)-1)
        INTO V_LINEAS_ENV
        FROM DUAL;
        dbms_output.put_line('-> '||V_LINEAS_ENV);
        SELECT '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:mor="http://xmlns.oracle.com/MOR_jws/MORBsRecibirSolicitudes/MORBsEnviarLineaAConCom">
           <soapenv:Header/>
           <soapenv:Body>
              <mor:process>
                 <mor:idSolicitud>'||P_ID_SOLICITUD||'</mor:idSolicitud>
                 <mor:lineas>'||V_LINEAS_ENV||'</mor:lineas>
              </mor:process>
           </soapenv:Body>
        </soapenv:Envelope>'
        INTO V_SOAP_CALL
        FROM DUAL;
        SELECT VALOR_PARAMETRO
        INTO   V_DIR_WS
        FROM   XXMOR_CONF_PARAMS_GRLS_TAB
        WHERE  NOMBRE_PARAMETRO = 'ServicioEnvSolConcom';
        XXMOR_CALL_WS_SP(V_SOAP_CALL,V_DIR_WS);
        RETURN '1';
    END XXMOR_ENV_SOL_CONCOM_FUN;
    FUNCTION XXMOR_FECHA_ENC_VAL_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN INTEGER IS
    V_LINEAS_BIEN       PLS_INTEGER;
    BEGIN
        SELECT COUNT(1)
        INTO   V_LINEAS_BIEN
        FROM   (SELECT numlinea_concom
                FROM   XXMOR_CONCOM_RPTA_TAB
                WHERE  id_solicitud         = P_ID_SOLICITUD
                AND    UPPER(ACCION_CONCOM) = 'LINEABIEN'
                MINUS
                SELECT numlinea_concom
                FROM   XXMOR_CONCOM_RPTA_TAB
                WHERE  id_solicitud         = P_ID_SOLICITUD
                AND    UPPER(ACCION_CONCOM) IN ( 'AUTORIZACION', 'RECHAZO', 'REPROCESO')
                AND    ESTATUS_ORDUNI       = '10'
               );
        RETURN V_LINEAS_BIEN;
    END XXMOR_FECHA_ENC_VAL_FUN;
    --Indica si un RTCRD debe buscarse en CA
    FUNCTION XXMOR_RTCRD_CA_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN INTEGER IS
    V_RESULTADO    PLS_INTEGER;
    V_FEC_INICIO   VARCHAR2(12);
    V_RTCRDDSCR    VARCHAR2(50);
    BEGIN
        BEGIN
            SELECT TO_CHAR(MIN(TO_DATE(FECHA_INICIO,'YYYYMMDD')),'YYYY-MM-DD')
            INTO   V_FEC_INICIO
            FROM   XXMOR_SOLICITUDES_DET_TAB D
            WHERE  D.ID_SOLICITUD = P_ID_SOLICITUD
            AND    EXISTS           (SELECT 1
                                     FROM   XXMOR_SOLICITUDES_ENC_TAB E
                                     WHERE  E.ID_SOLICITUD = D.ID_SOLICITUD
                                     AND    E.ID_SEG_NEG   = 1
                                    )
            AND    NOT EXISTS       (-- SE AGREGO PARA NO CONSIDERAR LINEAS RECHAZADAS 14-08-2013
                                     SELECT 1
                                     FROM   XXMOR_CONCOM_RPTA_TAB CRT
                                     WHERE  CRT.NUMLINEA_CONCOM            IS NOT NULL
                                     AND    CRT.ESTATUS_ORDUNI             = '10'
                                     AND    UPPER(CRT.ACCION_CONCOM)       = 'RECHAZO'
                                     AND    CRT.ID_SOLICITUD               = D.ID_SOLICITUD
                                     AND    TO_NUMBER(CRT.NUMLINEA_CONCOM) = D.LINEA
                                    );
        EXCEPTION
            WHEN OTHERS THEN
                V_FEC_INICIO := '1900-01-01';
        END;
        IF V_FEC_INICIO IS NULL THEN
            V_FEC_INICIO := '1900-01-01';
        END IF;
        BEGIN
            SELECT RTCRDDSCR
            INTO   V_RTCRDDSCR
            FROM   XXMOR_SOLICITUDES_ENC_TAB
            WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
        EXCEPTION
            WHEN OTHERS THEN
                V_RTCRDDSCR :='NO_RT';
        END;
        --dbms_output.put_line('-> '||V_RTCRDDSCR);
        --dbms_output.put_line('-> '||V_FEC_INICIO);
        IF V_RTCRDDSCR = NULL OR V_RTCRDDSCR IS NULL  THEN
            V_RESULTADO := 0;
        ELSIF V_RTCRDDSCR != 'NO_RT' THEN
            SELECT COUNT(1) AS CA_RTCRD
            INTO   V_RESULTADO
            FROM   EVENTAS.CA_RATECARDS@ORDUNIDB2
            WHERE  RTCRDDSCR = V_RTCRDDSCR
            AND    V_FEC_INICIO BETWEEN STRDT AND EDT;
        ELSE
            V_RESULTADO := 0;
        END IF;
        RETURN V_RESULTADO;
    END XXMOR_RTCRD_CA_FUN;
    FUNCTION XXMOR_MATLOC_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER
                        ) RETURN VARCHAR2 IS
    V_MATLOC         VARCHAR2(3);
    V_MAT_FROM       VARCHAR2(3);
    V_MAT_CANAL      VARCHAR2(3);
    V_MAT_DEFAULT    VARCHAR2(3);
    V_MAT_COUNT      INTEGER;
    V_MAT_NULL       VARCHAR2(3);
    V_FZA_VENTAS     VARCHAR2(10);
    V_ADVID          VARCHAR2(15);
    V_VERSION        VARCHAR2(30);
    BEGIN
        SELECT IDENT_FZA_VENTAS,
               NVL(MATLOC_NULL,'0'),
               MATLOC_BUSQUEDA,
               CASE MATLOC_BUSQUEDA
                   WHEN 'FV' THEN MATLOC
                   ELSE SUBSTR(D.STNID,1,2)
               END,
               MATLOC,
               E.ADVID,
               D.VERSION
        INTO   V_FZA_VENTAS,
               V_MAT_NULL,
               V_MAT_FROM,
               V_MAT_CANAL,
               V_MAT_DEFAULT,
               V_ADVID,
               V_VERSION
        FROM   XXMOR_SOLICITUDES_ENC_TAB E,
               XXMOR_SOLICITUDES_DET_TAB D,
               XXMOR_FZAS_VTAS_TAB       F
        WHERE  E.ID_SOLICITUD  = P_ID_SOLICITUD
        AND    D.LINEA         = P_LINEA
        AND    E.ID_SOLICITUD  = D.ID_SOLICITUD
        AND    E.ID_FZA_VENTAS = F.ID_FZA_VENTAS;
        IF V_FZA_VENTAS IN ('PNAL', 'JC', 'NL') THEN
            dbms_output.put_line(' --V_FZA_VENTAS: '||V_FZA_VENTAS );
            --REVISAMOS QUE EL MATLOC POR CANAL EXISTA
            SELECT COUNT(1)
            INTO   V_MAT_COUNT
            FROM   PARADB.MATASN@ORDUNIDB2
            WHERE  ADVID     = V_ADVID
            AND    EXTCPYNUM = V_VERSION
            AND    MATLOC    = V_MAT_CANAL;
            --SI EL MATLOC POR CANAL NO EXISTE entonces matloc = DEFAULT
            -- IF V_MAT_COUNT = 0 AND V_MAT_CANAL != 'JC' AND V_MAT_CANAL != 'NL' THEN CAMBIO 28MAY2013 MANEJO MATLOC NULL PNAL
            IF V_MAT_COUNT = 0 THEN
                dbms_output.put_line(' --mat_count=0: '||V_FZA_VENTAS );
                IF V_MAT_CANAL NOT IN ('JC','NL') THEN
                    SELECT COUNT(1)
                    INTO   V_MAT_COUNT
                    FROM   PARADB.MATASN@ORDUNIDB2
                    WHERE  ADVID     = V_ADVID
                    AND    EXTCPYNUM = V_VERSION
                    AND    MATLOC    = V_MAT_DEFAULT;
                    IF V_MAT_COUNT = 0 THEN
                        V_MATLOC := NULL;
                    ELSE
                        V_MATLOC := V_MAT_DEFAULT;
                    END IF;
                ELSE -- ES JC o NL
                    IF V_MAT_NULL = '1' THEN
                        V_MATLOC := NULL;
                    ELSE
                        --  Este -1 debe interpretarse como un error
                        V_MATLOC := '-1';
                    END IF;
                END IF;
            --Si MATLOC POR CANAL EXISTE, se pone EL MATLOC_CANAL
            ELSE
                V_MATLOC := V_MAT_CANAL;
            END IF;
        --No es de provincia y matloc canal y default son iguales
        ELSIF V_MAT_CANAL = V_MAT_DEFAULT THEN
            dbms_output.put_line(' --Matloc default y canal iguales: '||V_MAT_CANAL ||' - ' || V_MAT_DEFAULT );
            V_MATLOC := V_MAT_DEFAULT;
            --SOLO PARA VER SI EXISTE
            SELECT COUNT(1)
            INTO   V_MAT_COUNT
            FROM   PARADB.MATASN@ORDUNIDB2
            WHERE  ADVID     = V_ADVID
            AND    EXTCPYNUM = V_VERSION
            AND    MATLOC    = V_MAT_DEFAULT;
        ELSE
            dbms_output.put_line(' --Matloc default  canal diferentes: '||V_MAT_CANAL ||' - ' || V_MAT_DEFAULT );
            --REVISAMOS QUE EL MATLOC POR CANAL EXISTA
            SELECT COUNT(1)
            INTO   V_MAT_COUNT
            FROM   PARADB.MATASN@ORDUNIDB2
            WHERE  ADVID     = V_ADVID      -- DEL ENCABEZADO DE LA ORDEN
            AND    EXTCPYNUM = V_VERSION    -- DE LA LINEA
            AND    MATLOC    = V_MAT_CANAL; -- DE LA CONFIGURACION DE FV
            --SI EL MATLOC POR CANAL NO EXISTE TOMAMOS EL MATLOC DEFAULT
            IF V_MAT_COUNT = 0 THEN
                dbms_output.put_line(' --Matloc count (matloc por canal no existe): '||V_MAT_COUNT );
                SELECT COUNT(1)
                INTO   V_MAT_COUNT
                FROM   PARADB.MATASN@ORDUNIDB2
                WHERE  ADVID     = V_ADVID        -- DEL ENCABEZADO DE LA ORDEN
                AND    EXTCPYNUM = V_VERSION      -- DE LA LINEA
                AND    MATLOC    = V_MAT_DEFAULT; -- DE LA CONFIGURACION DE FV
                IF V_MAT_COUNT > 0 THEN
                    dbms_output.put_line(' --Matloc count (matloc por default  existe): '||V_MAT_COUNT );
                    V_MATLOC := V_MAT_DEFAULT;
                ELSE
                    dbms_output.put_line(' --Matloc count (matloc por default  NO existe): '||V_MAT_COUNT );
                    dbms_output.put_line(' --fv permite matloc null): '||V_MAT_NULL );
                    IF V_MAT_NULL = '1' THEN
                        V_MATLOC := NULL;
                    ELSE
                        --  Este -1 debe interpretarse como un error
                        V_MATLOC := '-1';
                    END IF;
                END IF;
            ELSE
                --Si MATLOC POR CANAL EXISTE, se pone el mismo
                dbms_output.put_line(' --Matloc canal si existe: '||V_MAT_COUNT );
                V_MATLOC := V_MAT_CANAL;
            END IF;
        END IF;
        RETURN V_MATLOC;
    END XXMOR_MATLOC_FUN;
    FUNCTION XXMOR_NUMLINE_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER
                        ) RETURN VARCHAR2 IS
    V_COUNT            PLS_INTEGER;
    V_NUMLINE          VARCHAR2(4);
    BEGIN
        SELECT COUNT(1)
        INTO   V_COUNT
        FROM   (SELECT VERSION,
                       STNID,
                       COUNT(VERSION),
                       CASE
                           WHEN COUNT(VERSION) = 1 THEN
                              MIN (LINEA)
                       ELSE 0 END
                       AS NUMLINE
                FROM   XXMOR_SOLICITUDES_DET_TAB
                WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                --AND LINEA = 1
                GROUP BY VERSION, STNID
               )
        WHERE  NUMLINE = P_LINEA;
        IF V_COUNT = 0 THEN
            V_NUMLINE := '000';
        ELSE
            SELECT LPAD((SELECT estat_id_foraneo
                         FROM   XXMOR_SOLICITUDES_EST_REP_TAB
                         WHERE  id_solicitud =  P_ID_SOLICITUD
                         AND    linea        = numline
                        ),3,'0') AS numline
            INTO   V_NUMLINE
            FROM   (SELECT VERSION,
                           STNID,
                           COUNT(VERSION),
                           CASE
                               WHEN COUNT(VERSION) = 1 THEN
                                   MIN (LINEA)
                            ELSE 0 END
                            AS NUMLINE
                    FROM XXMOR_SOLICITUDES_DET_TAB
                    WHERE ID_SOLICITUD = P_ID_SOLICITUD
                    --AND LINEA = 1
                    GROUP BY VERSION, STNID
                   )
            WHERE NUMLINE = P_LINEA;
            /*SELECT LPAD(TO_CHAR(NUMLINE),3,'0')
            INTO V_NUMLINE
            FROM (
                    SELECT VERSION,STNID, COUNT(VERSION),
                    CASE WHEN COUNT(VERSION) = 1
                            THEN MIN (LINEA) ELSE 0 END
                    AS NUMLINE
                    FROM XXMOR_SOLICITUDES_DET_TAB
                    WHERE ID_SOLICITUD = P_ID_SOLICITUD
                    --AND LINEA = 1
                    GROUP BY VERSION, STNID)
            WHERE NUMLINE = P_LINEA;*/
        END IF;
        RETURN V_NUMLINE;
    END XXMOR_NUMLINE_FUN;
    --Funcion para saber la tarifa
    FUNCTION XXMOR_GETRATE_CA_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO         IN VARCHAR2
                        ) RETURN NUMBER IS
    V_RTCRDDSCR   VARCHAR2(50);
    V_DIASEMANA   VARCHAR2(10);
    V_STNID       VARCHAR2(15);
    V_DURACION    INTEGER(15);
    V_HORA_INI    VARCHAR2(10);
    V_HORA_FIN    VARCHAR2(10);
    V_FECHA_INI   VARCHAR2(10);
    V_TARIFA      NUMBER;
    BEGIN
        SELECT XXMOR_SOL_FECHAS_FUN(p_ID_SOLICITUD,P_LINEA,'F_1A_T')
        INTO   V_FECHA_INI
        FROM   DUAL;
        SELECT RTCRDDSCR,
               CASE WHEN TO_NUMBER(SABADO) > 1 THEN 'S'
                    WHEN TO_NUMBER(DOMINGO) > 1 THEN 'D'
               ELSE 'L-V' END,
               D.STNID,
               D.DURACION,
               SUBSTR(HORA_INICIO,1,2)||':'||SUBSTR(HORA_INICIO,3,2),
               SUBSTR(HORA_FIN,1,2)||':'||SUBSTR(HORA_FIN,3,2),
               SUBSTR(V_FECHA_INI,1,4)||'-'||SUBSTR(V_FECHA_INI,5,2)||'-'||SUBSTR(V_FECHA_INI,7,2)
        INTO   V_RTCRDDSCR, V_DIASEMANA, V_STNID, V_DURACION, V_HORA_INI,  V_HORA_FIN, V_FECHA_INI
        FROM   XXMOR_SOLICITUDES_DET_TAB D,
               XXMOR_SOLICITUDES_ENC_TAB E
        WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
        AND    D.LINEA        = P_LINEA
        AND    E.ID_SOLICITUD = D.ID_SOLICITUD;
        -- P_TIPO  SI ES CBSKY, CV O SK
        IF P_TIPO != 'CBSKY' THEN
            SELECT REPLACE(E.RTCRDDSCR, AM.CA_RTCRD_SUBSTR, AM.CA_RTCRD_AUX) AS RTCRD_TMP
            INTO   V_RTCRDDSCR
            FROM   XXMOR_SOLICITUDES_ENC_TAB E,
                   XXMOR_CAT_AGRUPADOR_MULT_TAB AM
            WHERE  ID_SOLICITUD     = P_ID_SOLICITUD
            AND    E.AGRUPADOR      = AM.AGRUPADOR_MULTIPLE
            AND    AM.PREFIJO_CANAL = (SELECT SUBSTR(STNID,0,2)
                                       FROM   XXMOR_SOLICITUDES_DET_TAB D
                                       WHERE  D.ID_SOLICITUD = E.ID_SOLICITUD
                                       AND    ROWNUM = 1
                                      );
        END IF;
        SELECT MAX(CST.TARIFA) TARIFA
        INTO   V_TARIFA
        FROM   EVENTAS.CA_COSTOS@ORDUNIDB2 CST
               LEFT JOIN EVENTAS.CA_FRANJA_DIA@ORDUNIDB2 FRD
                ON (CST.IDFRANJADIA = FRD.IDFRANJADIA)
               LEFT JOIN EVENTAS.CA_RATECARDS@ORDUNIDB2 RTS
                ON FRD.FRNAME = RTS.FRNAME
               LEFT JOIN EVENTAS.CA_CANALES@ORDUNIDB2 CNL
                ON CST.IDCANAL = CNL.IDCANAL
        WHERE  RTS.RTCRDDSCR  =  V_RTCRDDSCR                  -- EL RATECARD DE LA ORDEN
        AND    CST.IDTARGET   =  RTS.IDTARGET
        AND    CST.IDTIPOTARI =  RTS.IDTIPOTARI
        AND    CST.DIASEMANA  =  V_DIASEMANA                   -- DEPENDIENDO DEL PRIMER DIA DE TRANSMISION (L-V, S, D)
        AND    CNL.CANAL      =  V_STNID                       -- CANAL DE LA LINEA
        AND    CST.DURACION   =  V_DURACION                    -- DE LA DURACION DE LA LINEA
        AND    FRD.IDCANAL    =  CST.IDCANAL
        AND    FRD.HORAINI    >= V_HORA_INI                   -- HORA INICIO DE LA LINEA
        AND    FRD.HORAFIN    <= V_HORA_FIN                   -- HORA FIN DE LA LINEA
        AND    FRD.DIASEMANA  =  CST.DIASEMANA
        AND    V_FECHA_INI BETWEEN FRD.FECINI AND FRD.FECFIN; -- LA FECHA DE LA PRIMER TRANSMISION
        RETURN V_TARIFA;
    END XXMOR_GETRATE_CA_FUN;
    --VERIFICA QUE LA ORDEN DE AGRUPADOR MULTIPLE YA ESTA LISTA PARA SER INSERTADA
    --SI NO LA RETIENE
    FUNCTION XXMOR_SOL_AGR_MULT_VAL_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN INTEGER IS
    V_CONF_AGR_MULT         PLS_INTEGER;
    V_ORD_NUM_ORD_HNAS      PLS_INTEGER;
    V_ORD_CON_GR_CA         PLS_INTEGER;
    V_ORD_SIN_GR_CA         PLS_INTEGER;
    V_ORD_SIN_GR_CA_AUX     PLS_INTEGER := 0;
    V_RETURN                INTEGER;
    CURSOR SOLICITUDES_CUR IS
    SELECT ID_SOLICITUD
    FROM   XXMOR_SOLICITUDES_ENC_TAB
    WHERE  ID_SOLICITUD IN (SELECT ID_SOLICITUD
                            FROM   XXMOR_SOLICITUDES_ENC_TAB
                            WHERE  ID_REQUEST = (SELECT ID_REQUEST
                                                 FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                 WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                                )
                           );
    BEGIN
        SELECT COUNT(AGRUPADOR_MULTIPLE) AS AGRUPADORMULTIPLE
        INTO V_CONF_AGR_MULT
        FROM XXMOR_CAT_AGRUPADOR_MULT_TAB
        WHERE AGRUPADOR_MULTIPLE = (SELECT AGRUPADOR
                                    FROM   XXMOR.XXMOR_SOLICITUDES_ENC_TAB
                                    WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                   );
         IF V_CONF_AGR_MULT > 1 THEN
            FOR C_SOLICITUD IN SOLICITUDES_CUR LOOP
                SELECT COUNT(1)
                INTO   V_ORD_CON_GR_CA
                FROM   XXMOR_SOLICITUDES_ENC_TAB E,
                       XXMOR_SOLICITUDES_DET_TAB D
                       --,XXMOR_SOLICITUDES_EST_REP_TAB R
                WHERE E.ID_SOLICITUD = D.ID_SOLICITUD
                AND   E.ID_SOLICITUD = C_SOLICITUD.ID_SOLICITUD
                AND   NOT EXISTS       (SELECT 1 -- LAS LINEAS DE DETALLE QUE NO HAN SIDO RECHAZADAS
                                        FROM   XXMOR_CONCOM_RPTA_TAB CR
                                        WHERE  CR.ID_SEG_NEG                 = 1
                                        AND    CR.NUMLINEA_CONCOM            IS NOT NULL
                                        AND    CR.ACCION_CONCOM              = 'RECHAZO'
                                        AND    CR.ESTATUS_ORDUNI             = '10'
                                        AND    CR.ID_SOLICITUD               = D.ID_SOLICITUD
                                        AND    TO_NUMBER(CR.NUMLINEA_CONCOM) = D.LINEA
                                       )
                AND   NVL(D.GETRATE_CON_AJUSTE,0) > 0
                ;
                --AND   R.ID_SOLICITUD = D.ID_SOLICITUD
                --AND   R.LINEA = D.LINEA
                --AND   R.ESTAT_ID_FORANEO IS NULL
                --AND   D.GETRATE_CON_AJUSTE IS NOT NULL; -- SE QUITO ESTA CONDICION PUES HAY LINEAS QUE EL WS RETORNA 0
                DBMS_OUTPUT.PUT_LINE('V_ORD_CON_GR_CA: '||V_ORD_CON_GR_CA );
                IF V_ORD_SIN_GR_CA_AUX = V_ORD_CON_GR_CA AND  V_ORD_CON_GR_CA != 0 THEN
                    V_RETURN := 1;
                ELSE
                    V_RETURN := 0;
                END IF;
                V_ORD_SIN_GR_CA_AUX := V_ORD_CON_GR_CA;
            END LOOP;
        ELSE
            V_RETURN := 1;
        END IF;
        RETURN V_RETURN;
    END XXMOR_SOL_AGR_MULT_VAL_FUN;
    FUNCTION XXMOR_ES_SOL_AGR_MULT_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN INTEGER IS
    V_CONF_AGR_MULT    PLS_INTEGER;
    V_RETURN           INTEGER;
    BEGIN
        SELECT COUNT(AGRUPADOR_MULTIPLE) AS AGRUPADORMULTIPLE
        INTO   V_CONF_AGR_MULT
        FROM   XXMOR_CAT_AGRUPADOR_MULT_TAB
        WHERE  AGRUPADOR_MULTIPLE = (SELECT AGRUPADOR
                                     FROM   XXMOR.XXMOR_SOLICITUDES_ENC_TAB
                                     WHERE ID_SOLICITUD = P_ID_SOLICITUD
                                    );
        IF V_CONF_AGR_MULT > 1 THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END XXMOR_ES_SOL_AGR_MULT_FUN;
    --Devuelve la informacion del ratecard para calcular la tarifa del canal (caso cabsky)
    FUNCTION XXMOR_GET_RTCRD_AGR_MULT_FN
                        (
                                P_ID_SOLICITUD IN NUMBER
                        ) RETURN  VARCHAR2 AS
    V_RTCRDDSCR     VARCHAR2(50);
    V_ES_DE_CA      PLS_INTEGER;
    V_RTCRD         VARCHAR2(50);
    BEGIN
        V_ES_DE_CA :=  XXMOR_RTCRD_CA_FUN(P_ID_SOLICITUD);
        IF V_ES_dE_CA = 1 THEN
            SELECT REPLACE(E.RTCRDDSCR, AM.CA_RTCRD_SUBSTR, AM.CA_RTCRD_AUX)
            INTO   V_RTCRDDSCR
            FROM   XXMOR_SOLICITUDES_ENC_TAB    E,
                   XXMOR_CAT_AGRUPADOR_MULT_TAB AM
            WHERE  E.ID_SOLICITUD   = P_ID_SOLICITUD
            AND    E.AGRUPADOR      = AM.AGRUPADOR_MULTIPLE
            AND    AM.PREFIJO_CANAL = (SELECT SUBSTR(D.STNID,0,2)
                                       FROM   XXMOR_SOLICITUDES_DET_TAB D
                                       WHERE  D.ID_SOLICITUD = E.ID_SOLICITUD
                                       AND    ROWNUM         = 1
                                      );
            SELECT TRIM(RTCRD)
            INTO   V_RTCRD
            FROM   EVENTAS.CA_RATECARDS@ORDUNIDB2
            WHERE  RTCRDDSCR = V_RTCRDDSCR;
        ELSE
            --Obtiene el rtcard del canal de cable o sky
            SELECT REPLACE(E.RTCRDDSCR, AM.RTCRD_SUBSTR, PREFIJO_CANAL)
            INTO   V_RTCRDDSCR
            FROM   XXMOR_SOLICITUDES_ENC_TAB    E,
                   XXMOR_CAT_AGRUPADOR_MULT_TAB AM
            WHERE  E.ID_SOLICITUD   = P_ID_SOLICITUD
            AND    E.AGRUPADOR      = AM.AGRUPADOR_MULTIPLE
            AND    AM.PREFIJO_CANAL = (SELECT SUBSTR(STNID,0,2)
                                       FROM   XXMOR_SOLICITUDES_DET_TAB D
                                       WHERE  D.ID_SOLICITUD = E.ID_SOLICITUD
                                       AND    ROWNUM = 1
                                      );
            SELECT TRIM(RTCRD)
            INTO   V_RTCRD
            FROM   PARADB.RTHDR@ORDUNIDB2
            WHERE  RTCRDDSCR = V_RTCRDDSCR;
        END IF;
        RETURN V_RTCRD;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
        WHEN TOO_MANY_ROWS THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END XXMOR_GET_RTCRD_AGR_MULT_FN;
    FUNCTION XXMOR_COPYS_POR_ORDEN_FN
                        (
                                piin_id_fza_ventas  IN INTEGER,
                                piin_id_solicitud   IN INTEGER
                        ) RETURN VARCHAR2 AS
        lst_conf_copys_fv  VARCHAR2(1);
        lst_copys_orden    VARCHAR2(1);
        lin_regs_canal     NUMBER;
        lin_regs_version   NUMBER;
        lin_regs_can_ver   NUMBER;
    BEGIN
        lst_conf_copys_fv := NULL;
        lst_copys_orden   := NULL;
        SELECT NVL(COPYS_X_ORDEN,'0')
        INTO   lst_conf_copys_fv
        FROM   XXMOR_FZAS_VTAS_TAB
        WHERE  ID_FZA_VENTAS = piin_id_fza_ventas;
        IF lst_conf_copys_fv = '1' THEN
            -- Se trata de Copys por Orden, por lo tanto hay que revisar
            -- si en realidad deben ser por orden o por linea.
            SELECT COUNT(DISTINCT D.STNID)            CANAL,
                   COUNT(DISTINCT D.VERSION)          VERSION,
                   COUNT(DISTINCT D.STNID||D.VERSION) CAN_VER
            INTO   lin_regs_canal,
                   lin_regs_version,
                   lin_regs_can_ver
            FROM   XXMOR_SOLICITUDES_DET_TAB D
            WHERE  D.ID_SOLICITUD = piin_id_solicitud
            AND    NOT EXISTS       (   --LINEAS EN LAS QUE CONCOM RESPONDIO QUE SU VERSION NO EXISTE NO SE GENERAN COPYS
                                     SELECT 1
                                     FROM   XXMOR_CONCOM_RPTA_TAB CR
                                     WHERE  CR.ID_SOLICITUD               = D.ID_SOLICITUD
                                     AND    TO_NUMBER(CR.NUMLINEA_CONCOM) = D.LINEA
                                     AND    INSTR(CR.DETALLE_CONCOM, 'VersionHorario') > 0
                                    )
            AND    NOT EXISTS       (   --LINEAS que sigan teniendo error no se generan copys
                                     SELECT 1
                                     FROM   XXMOR_CONCOM_RPTA_TAB CR
                                     WHERE  CR.ID_SOLICITUD               = D.ID_SOLICITUD
                                     AND    TO_NUMBER(CR.NUMLINEA_CONCOM) = D.LINEA
                                     AND    CR.ESTATUS_ORDUNI             = '10'
                                    );
            -- Caso 1, 1 canal - 1 version
            IF lin_regs_canal = 1 AND lin_regs_version = 1 THEN
                lst_copys_orden := 'Y';
            -- Caso 2, N canales - 1 version
            ELSIF lin_regs_canal > 1 AND lin_regs_version = 1 THEN
                lst_copys_orden := 'Y';
            -- Caso 3, N canales - N versiones
            ELSIF lin_regs_canal = lin_regs_version THEN
                IF lin_regs_canal = lin_regs_can_ver THEN
                    lst_copys_orden := 'Y';
                ELSE
                    lst_copys_orden := 'N';
                END IF;
            -- Caso 4, 1 canal - N versiones
            ELSIF lin_regs_canal = 1 AND lin_regs_version > 1 THEN
                lst_copys_orden := 'N';
            -- Caso 5, N canales - N versiones
            ELSIF lin_regs_canal != lin_regs_version THEN
                lst_copys_orden := 'N';
            END IF;
        ELSE
            -- Se trata de Copys por Linea, por lo tanto se envia el valor de
            -- la configuracion de la fuerza de ventas, es decir, por linea.
            lst_copys_orden := 'N';
        END IF;
        RETURN (lst_copys_orden);
    END XXMOR_COPYS_POR_ORDEN_FN;
    -- INICIO - OMW Copys VersionHorario 09-MAY-2016.
    -- Funcion para saber si se generan copy para la linea, cuando existen
    -- registros con VersionHorario.
    FUNCTION XXMOR_COPYS_VERHORARIO_FN
                        (
                                piin_id_solicitud   IN INTEGER,
                                piin_num_linea      IN INTEGER
                        ) RETURN VARCHAR2 AS
        lin_regs             NUMBER;
        lst_copys_verhorario VARCHAR2(1);
    BEGIN
        lst_copys_verhorario := 'Y';
        lin_regs             := 0;
        SELECT COUNT(1)
        INTO   lin_regs
        FROM   XXMOR_CONCOM_RPTA_TAB
        WHERE  INSTR(DETALLE_CONCOM,'VersionHorario') > 0
        AND    ESTATUS_ORDUNI            != '30'
        AND    ID_SOLICITUD               = piin_id_solicitud
        AND    TO_NUMBER(NUMLINEA_CONCOM) = piin_num_linea;
        IF lin_regs > 0 THEN
            -- Existen registros con VersionHorario que se generaron por
            -- ORDEN URGENTE.
            lin_regs := 0;
            -- Existen registros con VersionHorario que se generaron por
            -- ORDEN URGENTE y que aun no han sido autorizados, estatus '10'.
            SELECT COUNT(1)
            INTO   lin_regs
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  INSTR(DETALLE_CONCOM,'VersionHorario') > 0
            AND    ESTATUS_ORDUNI             = '10'
            AND    ID_SOLICITUD               = piin_id_solicitud
            AND    TO_NUMBER(NUMLINEA_CONCOM) = piin_num_linea;
            IF lin_regs > 0 THEN
                lst_copys_verhorario := 'N';
            ELSE
                -- Se valida si existen registros con VersionHorario que se generaron por
                -- ORDEN URGENTE y que ya fueron autorizados, estatus '20'.
                lin_regs := 0;
                SELECT COUNT(1)
                INTO   lin_regs
                FROM   XXMOR_CONCOM_RPTA_TAB
                WHERE  INSTR(DETALLE_CONCOM,'VersionHorario') > 0
                AND    ESTATUS_ORDUNI             = '20'
                AND    ID_SOLICITUD               = piin_id_solicitud
                AND    TO_NUMBER(NUMLINEA_CONCOM) = piin_num_linea;
                IF lin_regs > 0 THEN
                    lst_copys_verhorario := 'Y';
                END IF;
            END IF;
        ELSE
            -- Se valida si existen registros con VersionHorario que se autorizaron
            -- en automatico, estatus '30'.
            lin_regs := 0;
            SELECT COUNT(1)
            INTO   lin_regs
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  INSTR(DETALLE_CONCOM,'VersionHorario') > 0
            AND    ESTATUS_ORDUNI             = '30'
            AND    ID_SOLICITUD               = piin_id_solicitud
            AND    TO_NUMBER(NUMLINEA_CONCOM) = piin_num_linea;
            IF lin_regs > 0 THEN
                    lst_copys_verhorario := 'N';
            END IF;
        END IF;
        RETURN (lst_copys_verhorario);
    END XXMOR_COPYS_VERHORARIO_FN;
    -- FIN - OMW Copys VersionHorario 09-MAY-2016.
    --ENVIA MAILS DE LAS ORDENES CON MASTER CONTRACT QUE ESTA MAL
    FUNCTION XXMOR_ENV_MAIL_OR_MC_FUN
                        (
                                P_ID_REQUEST IN INTEGER
                        ) RETURN INTEGER IS
    CURSOR SOL_MCONTID_MAL_CUR  IS
    SELECT ID_SOLICITUD
    FROM   XXMOR_SOLICITUDES_ENC_TAB
    WHERE  ID_REQUEST         = P_ID_REQUEST
    AND    ID_SEG_NEG         = 1
    AND    INSTR(MCONTID,'.') = 0;
    V_SOLICITUD       XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE;
    V_CREATED_BY      VARCHAR2(100);
    V_EMAIL           VARCHAR2(100);
    V_ID_FZA_VENTAS   INTEGER;
    V_TRACKING_ID     INTEGER;
    V_RETURN          INTEGER;
    BEGIN
        dbms_output.put_line('hola_rec_type');
        FOR C_ORD_MAL IN SOL_MCONTID_MAL_CUR LOOP
            SELECT CREATED_BY,
                   EMAIL,
                   ID_FZA_VENTAS
            INTO   V_CREATED_BY,
                   V_EMAIL,
                   V_ID_FZA_VENTAS
            FROM   XXMOR_SOLICITUDES_ENC_TAB
            WHERE  ID_SOLICITUD = C_ORD_MAL.ID_SOLICITUD;
            V_SOLICITUD.ID_SOLICITUD   := C_ORD_MAL.ID_SOLICITUD;
            V_SOLICITUD.ORDEN_ESTATUS  := 46;
            V_SOLICITUD.CREATED_BY     := V_CREATED_BY;
            V_SOLICITUD.EMAIL          := V_EMAIL;
            V_SOLICITUD.ID_FZA_VENTAS  := V_ID_FZA_VENTAS;
            XXMOR_ENV_NOTIFICACION_PR ( V_SOLICITUD );
            dbms_output.put_line(V_SOLICITUD.EMAIL);
            --XXMOR_ENV_NOTIFICACION_PR(C_ORD_MAL.ID_SOLICITUD, NULL, 46);
            --XXMOR_ENV_NOTIFICACION_PR(C_ORD_MAL.ID_SOLICITUD);
            V_RETURN := V_RETURN + 1;
        END LOOP;
        RETURN V_RETURN;
        dbms_output.put_line('bye bye');
    END XXMOR_ENV_MAIL_OR_MC_FUN;
    FUNCTION XXMOR_DESC_MCONTID_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN NUMBER IS
    V_MCONTID       VARCHAR2(50);
    V_DESCUENTO     NUMBER;
    BEGIN
        SELECT MCONTID
        INTO   V_MCONTID
        FROM   XXMOR_SOLICITUDES_ENC_TAB
        WHERE  ID_SOLICITUD =  P_ID_SOLICITUD;
        BEGIN
            SELECT TRUNC((1-DISCVAL/10000),2) --1-DISCVAL/10000 con este valor no regresaba el valor correcto
            INTO   V_DESCUENTO
            FROM   PARADB.MCONT@ORDUNIDB2
            WHERE  MCONTID = V_MCONTID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_DESCUENTO := 1;
        END;
        RETURN V_DESCUENTO;
    END XXMOR_DESC_MCONTID_FUN;
    FUNCTION XXMOR_DESC_TI_SERVICIO_FUN
                        (
                                P_ID_REQUEST IN  INTEGER,
                                P_LINEA      IN  INTEGER
                        ) RETURN VARCHAR2 IS
    --V_Tipo_SERVICIO
    BEGIN
        RETURN '0';
        /*BEGIN
            --Para identificar la fza de ventas, solo se utiliza el tipo de servicio de la primera orden
            SELECT TRIM(TIPO_SERVICIO)
            INTO   V_TIPO_SERVICIO
            FROM   XXMOR.XXMOR_SOLICITUDES_ORIG_DET_TAB
            WHERE  ID_REQUEST = P_ID_REQUEST
            AND    LINEA_REQUEST = 1;
            EXCEPTION
                WHEN others THEN
                V_TIPO_SERVICIO :=  'NA';
        END;
        IF LENGTH(V_TIPO_SERVICIO) = 2 THEN
            V_usrchr := SUBSTR(V_TIPO_SERVICIO,1,1);
            V_sptchr := SUBSTR(V_TIPO_SERVICIO,2,1);
            SELECT USR_CHR, spt_chr, DESC_TIPO_SERVICIO
            INTO V_usrchr, V_sptchr, V_TIPO_SERVICIO
            FROM XXMOR.XXMOR_CAT_TIPO_SERV_TAB
            WHERE NVL(usr_chr,' ') = SUBSTR(V_TIPO_SERVICIO,1,1)
            AND   SPT_CHR = SUBSTR(V_TIPO_SERVICIO,2,1);
            dbms_output.put_line(' -> USR_CHR' ||' ->'|| V_USRCHR||'<-'  );
            dbms_output.put_line(' ->V_SPTCHR ' ||' ->'|| V_SPTCHR||'<-'  );
            --pONEMOS LA DESCRIPCION DEL SERVICIO QUE REPRESENTAN SPOT-USR CHR
            SELECT DESC_TIPO_SERVICIO
            INTO V_DESC_T_SERV
            FROM XXMOR_CAT_TIPO_SERV_TAB
            WHERE NVL(USR_CHR,' ') = NVL(V_USRCHR,' ')
            AND NVL(SPT_CHR,' ') = V_SPTCHR;
        --end if;
        ELSIF LENGTH(V_TIPO_SERVICIO) > 0 THEN
        --if V_sptchr is null and V_usrchr is null then
            SELECT SPT_CHR, usr_chr
            INTO V_sptchr, V_usrchr
            FROM XXMOR.XXMOR_CAT_TIPO_SERV_TAB
            WHERE UPPER(DESC_TIPO_SERVICIO) = UPPER(V_TIPO_SERVICIO);
        END IF;*/
    END;
    FUNCTION XXMOR_GET_MAILS_FACTUR_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) RETURN VARCHAR2 IS
    V_ESQUEMA_FACTUR        VARCHAR2(20);
    V_ID_FZA_VENTAS         PLS_INTEGER;
    V_MAILS                 VARCHAR(300);
    CURSOR MAILS_FAC_CUR IS
    SELECT DISTINCT TRIM(VDA.EMAIL) EMAIL
    FROM   FACTUR.VENDEDORA_VTAS@ORDUNIDB2 VDA
           LEFT JOIN FACTUR.CONTROL_VTAS@ORDUNIDB2 CT ON VDA.ID_VD = CT.ID_VD
    WHERE  TRIM(CT.ADVID)     =  (SELECT TRIM(ADVID)
                                  FROM   XXMOR_SOLICITUDES_ENC_TAB
                                  WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                 ) -- CLIENTE DE LA ORDEN
    AND    TRIM(CT.ACCTHDRID) IN (SELECT DISTINCT TRIM(MARCA)
                                  FROM   XXMOR_SOLICITUDES_DET_TAB
                                  WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                 ); -- MARCAS DE LAS LINEAS;
    CURSOR MAILS_FAC4_CUR IS
    SELECT DISTINCT TRIM(VDA.EMAIL) EMAIL
    FROM   FACTUR4.VENDEDORA_VTAS@ORDUNIDB2 VDA
           LEFT JOIN FACTUR4.CONTROL_VTAS@ORDUNIDB2 CT ON VDA.ID_VD = CT.ID_VD
    WHERE  TRIM(CT.ADVID)     =  (SELECT TRIM(ADVID)
                                  FROM   XXMOR_SOLICITUDES_ENC_TAB
                                  WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                 ) -- CLIENTE DE LA ORDEN
    AND    TRIM(CT.ACCTHDRID) IN (SELECT DISTINCT TRIM(MARCA)
                                  FROM   XXMOR_SOLICITUDES_DET_TAB
                                  WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                 ); -- MARCAS DE LAS LINEAS;
    CURSOR MAILS_TVP_CUR IS
    SELECT DISTINCT TRIM(VDA.EMAIL) EMAIL
    FROM   FACTURTVP.VENDEDORA_VTAS@ORDUNIDB2 VDA
           LEFT JOIN FACTURTVP.CONTROL_VTAS@ORDUNIDB2 CT ON VDA.ID_VD = CT.ID_VD
    WHERE  TRIM(CT.ADVID)     =  (SELECT TRIM(ADVID)
                                  FROM   XXMOR_SOLICITUDES_ENC_TAB
                                  WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                 ) -- CLIENTE DE LA ORDEN
    AND    TRIM(CT.ACCTHDRID) IN (SELECT DISTINCT TRIM(MARCA)
                                  FROM   XXMOR_SOLICITUDES_DET_TAB
                                  WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                 ); -- MARCAS DE LAS LINEAS;
    BEGIN
        V_ESQUEMA_FACTUR := NULL;
        V_ID_FZA_VENTAS  := NULL;
        V_MAILS          := NULL;
        SELECT ID_FZA_VENTAS
        INTO   V_ID_FZA_VENTAS
        FROM   XXMOR_SOLICITUDES_ENC_TAB
        WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
        SELECT ESQUEMA_FACTUR
        INTO   V_ESQUEMA_FACTUR
        FROM   XXMOR_FZAS_VTAS_TAB
        WHERE  ID_FZA_VENTAS = V_ID_FZA_VENTAS;
        IF V_ESQUEMA_FACTUR = 'FACTUR' THEN
            FOR CORREO_C IN MAILS_FAC_CUR LOOP
                V_MAILS := V_MAILS||CORREO_C.EMAIL||', ';
                DBMS_OUTPUT.PUT_LINE('FAC CORREO_C.EMAIL: '||CORREO_C.EMAIL);
            END LOOP;
        ELSIF V_ESQUEMA_FACTUR = 'FACTUR4' THEN
            FOR CORREO_C IN MAILS_FAC4_CUR LOOP
                V_MAILS := V_MAILS||CORREO_C.EMAIL||', ';
                DBMS_OUTPUT.PUT_LINE('FAC4 CORREO_C.EMAIL: '||CORREO_C.EMAIL);
            END LOOP;
        ELSIF V_ESQUEMA_FACTUR = 'FACTURTVP' THEN
            FOR CORREO_C IN MAILS_TVP_CUR LOOP
                V_MAILS := V_MAILS||TRIM(CORREO_C.EMAIL)||', ';
                DBMS_OUTPUT.PUT_LINE('TVP CORREO_C.EMAIL: '||CORREO_C.EMAIL);
            END LOOP;
        END IF;
        IF LENGTH(V_MAILS) > 5 THEN
            SELECT SUBSTR(V_MAILS, 0, LENGTH(V_MAILS) -2)
            INTO V_MAILS
            FROM DUAL;
        END IF;
        RETURN V_MAILS;
    END XXMOR_GET_MAILS_FACTUR_FUN;
    -- Funcion para saber si una orden es FACTURABLE (1) o NO (0)
    -- dependiendo del master contract. En caso de haber error
    -- retornara 2.
    FUNCTION XXMOR_ES_ORDEN_FACTURABLE_FN
                        (
                                piinIdSolicitud IN INTEGER
                        ) RETURN INTEGER IS
    lst_sufijo         VARCHAR2(2);
    lin_facturable     INTEGER;
    BEGIN
        lst_sufijo := NULL;
        BEGIN
            SELECT SUBSTR(TRIM(MCONTID),INSTR(TRIM(MCONTID),'.')-2,2) SUFIJO
            INTO   lst_sufijo
            FROM   XXMOR_SOLICITUDES_ENC_TAB E
            WHERE  ID_SEG_NEG   = 1
            AND    ID_SOLICITUD = piinIdSolicitud;
        EXCEPTION
            WHEN OTHERS THEN
                lst_sufijo := NULL;
        END;
        IF lst_sufijo IS NOT NULL THEN
            BEGIN
                SELECT CASE WHEN COUNT(IDPREFIX) = 0 THEN 1 ELSE 0 END FACTURABLE
                INTO   lin_facturable
                FROM   SAYCO_304.SM_ORDERSPREFIX@ORDUNIDB2
                WHERE  UPPER(IDPREFIX) = UPPER(lst_sufijo);
            EXCEPTION
                WHEN OTHERS THEN
                    lin_facturable := 2;
            END;
        ELSE
            lin_facturable := 2;
        END IF;
        RETURN lin_facturable;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 2;
        WHEN OTHERS THEN
            RETURN 2;
    END XXMOR_ES_ORDEN_FACTURABLE_FN;
    -- Funcion para obtener el AGRUPADOR a usar para la identificacion
    -- de la Fuerza de Ventas dependiendo de la PLATAFORMA_CANAL y el
    -- ID_SOLICITUD.
    FUNCTION XXMOR_GET_AGRUPADOR_FN
                        (
                                pistCanal       IN VARCHAR2,
                                piinIdSolicitud IN INTEGER
                        ) RETURN VARCHAR2 IS
    lst_agrupador      VARCHAR2(15);
    lin_agrup_mult     INTEGER;
    BEGIN
        SELECT COUNT(1)
        INTO   lin_agrup_mult
        FROM   XXMOR_CAT_AGRUPADOR_MULT_TAB
        WHERE  AGRUPADOR_MULTIPLE = pistCanal;
        lst_agrupador := NULL;
        IF lin_agrup_mult > 1 THEN
            lst_agrupador := pistCanal;
        ELSE
            SELECT AGRUPADOR
            INTO   lst_agrupador
            FROM   XXMOR_AGRUPADOR_SOLICITUD_TAB
            WHERE  ID_SOLICITUD = piinIdSolicitud
            AND    NOT EXISTS     (SELECT 1
                                   FROM   XXMOR_CAT_AGRUPADOR_MULT_TAB
                                   WHERE  AGRUPADOR_MULTIPLE = AGRUPADOR
                                   HAVING COUNT(AGRUPADOR_MULTIPLE) > 1
                                  );
        END IF;
        RETURN lst_agrupador;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END XXMOR_GET_AGRUPADOR_FN;
    -- INCIO OMW - Cambio manejo de Paquetes, 23-ABR-2015
    -- Funcion que valida si para la linea indicada, se manejan paquetes
    -- de acuerdo al campo OBSERVACIONES, el cual se pasa el campo DES_PAQUETE,
    -- SIN DIG, USRFL19 = 1 y USRFL20 = 0, SIN TVP, USRFL19 = 0 y USRFL20 = 1,
    -- TVABIERTA, USRFL19 = 1 y USRFL20 = 1,
    -- NULL o diferente a los mencionados, USRFL19 = 0 y USRFL20 = 0.
    FUNCTION XXMOR_VALOR_PAQUETES_FN
                        (
                                pistUsrfl          IN  VARCHAR2,
                                pistDescPaquete    IN  VARCHAR2
                        ) RETURN INTEGER IS
    lst_parametro    VARCHAR2(30);
    lin_Valor_Usrfl  INTEGER;
    BEGIN
        lst_parametro := NULL;
        IF pistDescPaquete = 'SIN VALOR' THEN
            lin_Valor_Usrfl := 0;
        ELSE
            BEGIN
                SELECT NOMBRE_PARAMETRO
                INTO   lst_parametro
                FROM   XXMOR_CONF_PARAMS_GRLS_TAB
                WHERE  TIPO_PARAMETRO  = 'PLATAFORMA'
                AND    VALOR_PARAMETRO = pistDescPaquete;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    lst_parametro := 'SIN PAQUETE';
                WHEN OTHERS THEN
                    lst_parametro := 'SIN PAQUETE';
            END;
            IF lst_parametro = 'SIN PAQUETE' THEN
                lin_Valor_Usrfl := 0;
            ELSIF lst_parametro = 'SIN_TV_DIGITAL' THEN
                IF pistUsrfl = 'USRFL19' THEN
                    lin_Valor_Usrfl := 1;
                ELSE
                    lin_Valor_Usrfl := 0;
                END IF;
            ELSIF lst_parametro = 'SIN_TV_PAGA' THEN
                IF pistUsrfl = 'USRFL19' THEN
                    lin_Valor_Usrfl := 0;
                ELSE
                    lin_Valor_Usrfl := 1;
                END IF;
            ELSIF lst_parametro = 'TV_ABIERTA' THEN
                IF pistUsrfl = 'USRFL19' THEN
                    lin_Valor_Usrfl := 1;
                ELSE
                    lin_Valor_Usrfl := 1;
                END IF;
            END IF;
        END IF;
        RETURN lin_Valor_Usrfl;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
        WHEN OTHERS THEN
            RETURN 0;
    END XXMOR_VALOR_PAQUETES_FN;
    -- FIN OMW - Cambio manejo de Paquetes, 23-ABR-2015
    PROCEDURE XXMOR_GUARDA_ARCHIVO_ORD_PR
                        (
                                P_NOM_ARCHIVO     IN VARCHAR2,
                                P_ARCHIVO         IN BLOB,
                                P_CREATED_BY      IN VARCHAR2,
                                O_ID_ARCHIVO_SOL  OUT INTEGER,
                                O_NOM_ARCH_EXISTE OUT INTEGER
                        ) IS
    V_ID_ARCHIVO_SOL        PLS_INTEGER;
    V_ARCHIVO_PROCESADO     PLS_INTEGER;
    V_FROM                  VARCHAR2(80) := 'servicio_orduni@televisa.com.mx';
    V_RECIPIENT             VARCHAR2(80);
    V_SUBJECT               VARCHAR2(80) := 'El nombre del archivo ya existe';
    lst_mail_host           VARCHAR2(30) := '10.7.4.218';
    lin_mail_puerto         NUMBER       := 25;
    V_BODY                  VARCHAR2(2000);
    crlf                    VARCHAR2(2)  := CHR(13)||CHR(10);
    V_MAIL_CONN             UTL_SMTP.CONNECTION;
    lst_error               VARCHAR2(2000);
    BEGIN
        SELECT COUNT(1)
        INTO   O_NOM_ARCH_EXISTE
        FROM   XXMOR_SOLICITUDES_ARCH_TAB
        WHERE  NOM_ARCHIVO_SOL = P_NOM_ARCHIVO
        AND    ID_SEG_NEG      = 1;
        IF O_NOM_ARCH_EXISTE > 0 THEN
            V_ARCHIVO_PROCESADO := 0;
            --sacamos el mail del administrador del sistemas
            SELECT VALOR_PARAMETRO
            INTO   V_RECIPIENT
            FROM   XXMOR_CONF_PARAMS_GRLS_TAB
            WHERE  NOMBRE_PARAMETRO = 'SysAdmin';
            -- Se obtien la direccion IP del smtp server
            -- asi como el puerto.
            SELECT SUBSTR(VALOR_PARAMETRO,1,(INSTR(VALOR_PARAMETRO,':')-1)) SERVIDOR,
                   SUBSTR(VALOR_PARAMETRO,(INSTR(VALOR_PARAMETRO,':')+1))   PUERTO
            INTO   lst_mail_host,
                   lin_mail_puerto
            FROM   XXMOR_CONF_PARAMS_GRLS_TAB
            WHERE  UPPER(NOMBRE_PARAMETRO) = 'SMTP_SERVER';
            V_SUBJECT:= V_SUBJECT|| ' ('||P_NOM_ARCHIVO ||')';
            V_BODY :='El archivo del servidor FTP: '||P_NOM_ARCHIVO|| ' ya existe en la base de datos de orduni2 ('||O_NOM_ARCH_EXISTE || ' veces) ';
            --V_BODY := V_BODY || 'el archivo se ha guardado con el id: '||V_ID_ARCHIVO_SOL||' en la tabla XXMOR_SOLICITUDES_ARCH_TAB ';
            BEGIN
             v_Mail_Conn := utl_smtp.Open_Connection(lst_mail_host, lin_mail_puerto);
             utl_smtp.Helo(v_Mail_Conn, lst_mail_host);
             utl_smtp.Mail(v_Mail_Conn, v_From);
             utl_smtp.Rcpt(v_Mail_Conn, v_Recipient);
             utl_smtp.DATA(v_Mail_Conn,
               'Date: '   || TO_CHAR(SYSDATE, 'Dy, DD Mon YYYY hh24:mi:ss') || crlf ||
               'From: '   || v_From || crlf ||
               'Subject: '|| v_Subject || crlf ||
               'To: '     || v_Recipient || crlf ||
               crlf ||
               V_BODY || crlf ||' '    -- Message body
               --'more message text'|| crlf
             );
             utl_smtp.Quit(v_mail_conn);
            EXCEPTION
                -- WHEN utl_smtp.Transient_Error OR utl_smtp.Permanent_Error then
                -- raise_application_error(-20000, 'Unable to send mail: '||sqlerrm);
                WHEN OTHERS THEN
                    NULL;
            END;
        ELSE
            SELECT XXMOR_ARCH_SOL_ID_SQ.NEXTVAL
            INTO   V_ID_ARCHIVO_SOL
            FROM   DUAL;
            V_ARCHIVO_PROCESADO := 1;
            INSERT INTO XXMOR_SOLICITUDES_ARCH_TAB
                   (
                           ID_SEG_NEG,
                           ID_ARCHIVO_SOL,
                           ARCHIVO_SOL,
                           NOM_ARCHIVO_SOL,
                           ARCHIVO_PROCESADO,
                           ENVIO_WS,
                           CREATED_DATE,
                           CREATED_BY
                   )
            VALUES (
                           1,
                           V_ID_ARCHIVO_SOL,
                           P_ARCHIVO,
                           P_NOM_ARCHIVO,
                           V_ARCHIVO_PROCESADO,
                           1,
                           SYSDATE,
                           P_CREATED_BY
                   );
        END IF;
        O_ID_ARCHIVO_SOL := V_ID_ARCHIVO_SOL;
    EXCEPTION
        WHEN OTHERS THEN
            lst_error := SQLERRM;
            -- Se inserta en la tabla de errores el error encontrado
            INSERT INTO XXMOR_LOG_ERRORES_TAB
                        (
                                ID_ERROR,
                                DESC_ERROR,
                                ARCHIVO_ERROR,
                                METODO_ERROR,
                                HORA_ERROR
                        )
            VALUES      (       XXMOR.XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                lst_error,
                                'XXMOR_FUNCIONAL_PKG',
                                'XXMOR_GUARDA_ARCHIVO_ORD_PR',
                                SYSDATE
                        );
    END XXMOR_GUARDA_ARCHIVO_ORD_PR;
    PROCEDURE XXMOR_SOL_HNA_AM_PR
                        (
                                P_ID_SOLICITUD IN  INTEGER,
                                O_ID_SOL_HNA   OUT INTEGER
                        ) IS
    V_VALIDO        PLS_INTEGER;
    V_COPYS         PLS_INTEGER;
    V_LINEAS        PLS_INTEGER;
    V_ENC           PLS_INTEGER;
    V_INTENTOS      PLS_INTEGER;
    V_ID_SOL_HNA    INTEGER;
    BEGIN
        BEGIN
            SELECT ID_SOLICITUD
            INTO V_ID_SOL_HNA
            FROM  XXMOR_SOLICITUDES_ENC_TAB
            WHERE ID_REQUEST = (SELECT ID_REQUEST
                                FROM   XXMOR_SOLICITUDES_ENC_TAB
                                WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                               )
            AND ID_SOLICITUD != P_ID_SOLICITUD
            AND ROWNUM = 1
            AND (SELECT COUNT(1)
                 FROM   XXMOR_SOLICITUDES_EST_REP_TAB
                 WHERE  ESTAT_REINTENTO <= 5
                 AND    ID_SOLICITUD    =  P_ID_SOLICITUD
                 AND    LINEA           =  0
                )      > 0;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                O_ID_SOL_HNA := 0;
        END;
        --        SELECT ESTAT_REINTENTO
        --        INTO V_INTENTOS
        --        FROM XXMOR_SOLICITUDES_EST_REP_TAB
        --        WHERE ID_SOLICITUD = V_ID_SOL_HNA
        --        AND LINEA = 0;
        IF V_ID_SOL_HNA IS NOT NULL THEN
            UPDATE XXMOR_SOLICITUDES_EST_REP_TAB
            SET ESTAT_REINTENTO =  ESTAT_REINTENTO + 1
            WHERE ID_SOLICITUD = V_ID_SOL_HNA
            AND LINEA = 0;
            SELECT COUNT(1)
            INTO V_COPYS
            FROM XXMOR_PARA_COPY_VW
            WHERE ID_SOLICITUD = V_ID_SOL_HNA;
            SELECT COUNT(1)
            INTO V_LINEAS
            FROM XXMOR_PARA_LIN_VW
            WHERE ID_SOLICITUD = V_ID_SOL_HNA;
            SELECT COUNT(1)
            INTO V_ENC
            FROM XXMOR_PARA_ENC_VW
            WHERE ID_SOLICITUD = V_ID_SOL_HNA;
            --DBMS_OUTPUT.PUT_LINE('V_LINEAS: '||V_LINEAS);
            --DBMS_OUTPUT.PUT_LINE('V_COPYS: '||V_COPYS);
            IF V_ENC > 0 OR V_COPYS > 0 OR V_LINEAS > 0 THEN
                O_ID_SOL_HNA := V_ID_SOL_HNA;
            ELSE
                O_ID_SOL_HNA := 0;
            END IF;
        ELSE
            O_ID_SOL_HNA := 0;
        END IF;
    END XXMOR_SOL_HNA_AM_PR;
    PROCEDURE XXMOR_AUT_OPENLOG_FUN
                        (
                                P_ID_SOLICITUD IN  NUMBER,
                                P_TIPO         IN  NUMBER,
                                O_RES          OUT VARCHAR2
                        ) IS
        V_TRACKINGID        VARCHAR2(100);
    BEGIN
        BEGIN
            SELECT XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL
            INTO   V_TRACKINGID
            FROM   DUAL;
            --Se le quito la hora 11-07-2012 por que causa q algunas ordenes no generen autorizacion por openlog
            INSERT INTO XXMOR_CONCOM_RPTA_TAB
                   (ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM,
                    RESULTADOGENERAL, TRACKINGID, DESC_CONCOM,
                    POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM,
                    ESTATUS_CONCOM, CAMPO_CONCOM, DETALLE_CONCOM,
                    ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI,
                    CREATED_DATE, CREATED_BY
                   )
            SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                   P_TIPO, V_TRACKINGID, NULL,
                   'LINEA', NULL, D.LINEA,
                   'ERROR', 'OPENLOG', 'AUTORIZACION - Openlog.- La primera transmision tiene una fecha menor a la actual',
                   'AUTORIZACION', NULL, '10',
                   SYSDATE, 'ORDUNI2'
            FROM   XXMOR_SOLICITUDES_ENC_TAB E,
                   XXMOR_SOLICITUDES_DET_TAB D
            WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
            AND    E.ID_SOLICITUD = D.ID_SOLICITUD
            AND    TRUNC(SYSDATE) >= (SELECT TO_DATE(det.fecha_inicio,'yyyymmdd')
                                                      +  CASE WHEN LUNES     != 0 THEN 0
                                                              WHEN MARTES    != 0 THEN 1
                                                              WHEN MIERCOLES != 0 THEN 2
                                                              WHEN JUEVES    != 0 THEN 3
                                                              WHEN VIERNES   != 0 THEN 4
                                                              WHEN SABADO    != 0 THEN 5
                                                              WHEN DOMINGO   != 0 THEN 6
                                                         ELSE 999 END
                                      FROM   XXMOR_SOLICITUDES_DET_TAB det
                                      WHERE  DET.ID_SOLICITUD = D.ID_SOLICITUD
                                      AND    DET.LINEA        = D.LINEA
                                      AND    NOT EXISTS       ( SELECT 1
                                                                FROM   XXMOR_CONCOM_RPTA_TAB C
                                                                WHERE  DET.ID_SOLICITUD             = C.ID_SOLICITUD
                                                                AND    C.NUMLINEA_CONCOM            IS NOT NULL
                                                                AND    UPPER(C.ACCION_CONCOM)       = 'RECHAZO'
                                                                AND    TO_NUMBER(C.NUMLINEA_CONCOM) = DET.LINEA
                                                              )
                                      AND NOT EXISTS          ( SELECT 1
                                                                FROM   XXMOR_CONCOM_RPTA_TAB C
                                                                WHERE  DET.ID_SOLICITUD             = C.ID_SOLICITUD
                                                                AND    C.NUMLINEA_CONCOM            IS NOT NULL
                                                                AND    UPPER(C.ACCION_CONCOM)       = 'REENVIO'
                                                                AND    C.ESTATUS_ORDUNI             = '10'
                                                                AND    TO_NUMBER(C.NUMLINEA_CONCOM) = DET.LINEA
                                                              )
                                     )
            AND    NOT EXISTS     (SELECT 1
                                   FROM   XXMOR_CONCOM_RPTA_TAB C
                                   WHERE  C.ID_SOLICITUD               = E.ID_SOLICITUD
                                   AND    C.NUMLINEA_CONCOM            IS NOT NULL
                                   AND    (C.CAMPO_CONCOM              = 'OPENLOG'
                                           OR UPPER(C.ACCION_CONCOM)   = 'RECHAZO'
                                          )
                                   AND    TO_NUMBER(C.NUMLINEA_CONCOM) = D.LINEA
                                  )
            AND    NOT EXISTS     (SELECT 1
                                   FROM   XXMOR_CONCOM_RPTA_TAB C
                                   WHERE  C.ID_SOLICITUD               = E.ID_SOLICITUD
                                   AND    C.NUMLINEA_CONCOM            IS NOT NULL
                                   AND    UPPER(C.ACCION_CONCOM)       = 'REENVIO'
                                   AND    C.ESTATUS_ORDUNI             = '10'
                                   AND    TO_NUMBER(C.NUMLINEA_CONCOM) = D.LINEA
                                  )
            AND    EXISTS         (SELECT 1
                                   FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                                   WHERE  ER.ID_SOLICITUD  = D.ID_SOLICITUD
                                   AND    ER.LINEA         = D.LINEA
                                   AND    ESTAT_ID_FORANEO IS NULL
                                  );
        END;
        SELECT 'OK'
        INTO   O_Res
        FROM dual;
    END XXMOR_AUT_OPENLOG_FUN;
    PROCEDURE XXMOR_AUT_URGENTE_FUN
                        (
                                P_ID_SOLICITUD IN NUMBER,
                                P_TIPO         IN NUMBER
                        ) IS
    BEGIN
        BEGIN
            EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_TERRITORY=MEXICO';
        END;
        INSERT INTO XXMOR_CONCOM_RPTA_TAB
               (ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM,
                RESULTADOGENERAL, TRACKINGID, DESC_CONCOM,
                POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM,
                ESTATUS_CONCOM, CAMPO_CONCOM, DETALLE_CONCOM,
                ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI,
                CREATED_DATE, CREATED_BY
               )
         SELECT ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                P_TIPO, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                'LINEA', NULL, LINEA,
                'ERROR', 'URGENTE', 'Autorizacion - Linea URGENTE: La linea tiene transmisiones que estan fuera de la hora de cierre ('||TO_CHAR(c.dia_cierre_ini,'DD/MM/YYYY hh24:mi')||')',
                'AUTORIZACION', NULL, '10',
                SYSDATE, 'ORDUNI2'
         FROM   XXMOR_SOLICITUDES_DET_TAB D,
                (SELECT ID_SEG_NEG,
                        ID_FZA_VENTAS,
                        DIA,
                        DIA_CIERRE,
                        TO_CHAR(HORA_CIERRE,'hh24:mi') AS HORA_CIERRE,
                        TO_CHAR(SYSDATE,'D') HOY,
                        CASE WHEN DIA = TO_NUMBER(TO_CHAR(SYSDATE,'D')) THEN
                            TO_DATE(TO_CHAR(SYSDATE, 'yyyymmdd')
                            ||' '||TO_CHAR(HORA_CIERRE, 'HH24:MI'),'YYYYMMDD HH24:MI')
                        END AS Dia_Cierre_INI,
                        NEXT_DAY(TO_DATE(TO_CHAR(SYSDATE, 'yyyymmdd')||'23:59:59','YYYYMMDDHH24:MI:SS'),
                        DECODE(DIA_CIERRE, 1, 'MON',
                                           2, 'TUE',
                                           3, 'WED',
                                           4, 'THU',
                                           5, 'FRI',
                                           6, 'SAT',
                                           7, 'SUN')
                              ) AS Dia_cierre_Fin
                 FROM   XXMOR_CONF_ORDS_URGENTES_TAB
                ) C
         WHERE  ID_SOLICITUD = P_ID_SOLICITUD
         AND    C.DIA_CIERRE_INI IS NOT NULL
         --        AND TO_CHAR(TO_DATE(xxmor_funcional_pkg.XXMOR_SOL_FECHAS_FUN (id_solicitud,LINEA, 'F_1A_T'),'YYYYMMDd'),'D') = C.DIA_CIERRE
         --        AND TO_DATE(XXMOR_FUNCIONAL_PKG.XXMOR_SOL_FECHAS_FUN (ID_SOLICITUD,1, 'F_1A_T')||LPAD(HORA_INICIO,4,'0'),'yyyymmddhh24mi')
         --              BETWEEN c.dia_cierre_ini AND c.dia_cierre_fin
         AND    TO_CHAR(TO_DATE(XXMOR_FUNCIONAL_PKG.XXMOR_SOL_FECHAS_FUN (ID_SOLICITUD,LINEA, 'F_1A_T'),'YYYYMMDd'),'D') = C.DIA_CIERRE
         AND    TO_DATE(XXMOR_FUNCIONAL_PKG.XXMOR_SOL_FECHAS_FUN (ID_SOLICITUD,LINEA, 'F_1A_T'),'yyyymmdd')
                BETWEEN TRUNC(C.DIA_CIERRE_INI+1) AND TRUNC(C.DIA_CIERRE_FIN)
         AND    SYSDATE > C.DIA_CIERRE_INI
         AND    C.ID_FZA_VENTAS = (SELECT ID_FZA_VENTAS
                                   FROM   XXMOR_SOLICITUDES_ENC_TAB
                                   WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                  )
         AND    NOT EXISTS        (SELECT 1
                                   FROM   XXMOR_CONCOM_RPTA_TAB C
                                   WHERE  C.ID_SOLICITUD     = D.ID_SOLICITUD
                                   AND    C.NUMLINEA_CONCOM  = D.LINEA
                                   AND    C.NUMLINEA_CONCOM  IS NOT NULL
                                   AND    C.CAMPO_CONCOM     = 'URGENTE'
                                   AND    TO_NUMBER(D.LINEA) = TO_NUMBER(C.NUMLINEA_CONCOM)
                                  )
         AND NOT EXISTS           (SELECT 1
                                   FROM   XXMOR_CONCOM_RPTA_TAB C
                                   WHERE  C.ID_SOLICITUD         = D.ID_SOLICITUD
                                   AND    C.NUMLINEA_CONCOM      = D.LINEA
                                   AND    C.NUMLINEA_CONCOM      IS NOT NULL
                                   AND    UPPER(C.ACCION_CONCOM) = 'RECHAZO'
                                   AND    TO_NUMBER(D.LINEA)     = TO_NUMBER(C.NUMLINEA_CONCOM)
                                  )
         AND EXISTS               (SELECT 1
                                   FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                                   WHERE  ER.ID_SOLICITUD     = D.ID_SOLICITUD
                                   AND    ER.LINEA            = D.LINEA
                                   AND    ER.ESTAT_ID_FORANEO IS NULL
                                  );
    END XXMOR_AUT_URGENTE_FUN;
    PROCEDURE XXMOR_UPD_MONTOS_AGR_MUL_PR
                        (
                                P_ID_SOLICITUD IN NUMBER,
                                P_LINEA        IN INTEGER,
                                P_MONTO        IN NUMBER,
                                P_ID_SOL_REF   IN INTEGER
                        ) IS
    V_TOT_SPOTS              NUMBER;
    V_LINEAS_CON_GET_RATE    INTEGER;
    V_ORDENES_HERMANAS       INTEGER;
    V_ID_REQUEST             INTEGER;
    V_SUMA_GET_RATE          NUMBER;
    V_GETRATE_SIN_AJUSTE     NUMBER;
    V_RT_ORIGINAL            NUMBER;
    V_MONTO_UPDATED          INTEGER :=0;
    V_GET_RATE_FROM          VARCHAR2(4);
    V_MONTO_ORIG             NUMBER;
    V_SUMA_LINEAS            NUMBER;
    V_CA_RTCRD               PLS_INTEGER;
    V_MONTO                  NUMBER;
    V_AUT_TM                 PLS_INTEGER;
    BEGIN
        IF P_MONTO = 0 THEN
            INSERT INTO XXMOR_CONCOM_RPTA_TAB
                   ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM,
                     RESULTADOGENERAL, TRACKINGID, DESC_CONCOM,
                     POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM,
                     ESTATUS_CONCOM, CAMPO_CONCOM, DETALLE_CONCOM,
                     ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI,
                     CREATED_DATE, CREATED_BY
                   )
            SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                   NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                   'LINEA', NULL, LINEA,
                   'ERROR', 'TARIFA_MANUAL', 'RECHAZO - La tarifa para la linea de la orden '||P_ID_SOLICITUD||' es igual a '||P_MONTO ,
                   'RECHAZO', NULL, '10',
                   SYSDATE, 'ORDUNI2'
            FROM   XXMOR_SOLICITUDES_DET_TAB D,
                   XXMOR_SOLICITUDES_ENC_TAB E
            WHERE  E.ID_SOLICITUD IN (SELECT ID_SOLICITUD
                                      FROM   XXMOR_SOLICITUDES_ENC_TAB
                                      WHERE  ID_REQUEST = (SELECT ID_REQUEST
                                                           FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                           WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                                          )
                                     )
            AND    E.ID_SOLICITUD = D.ID_SOLICITUD
            AND    D.LINEA        = P_LINEA
            AND    NOT EXISTS       (SELECT 1
                                     FROM   XXMOR_CONCOM_RPTA_TAB C
                                     WHERE  C.ID_SOLICITUD             = E.ID_SOLICITUD
                                     AND    C.NUMLINEA_CONCOM          IS NOT NULL
                                     AND    ACCION_CONCOM              = 'RECHAZO'
                                     AND    TO_NUMBER(NUMLINEA_CONCOM) = D.LINEA
                                    );
        END IF;
        --VERIFICAMOS SI PROVIENE DE CA_RATECARDS
        SELECT XXMOR_RTCRD_CA_FUN(P_ID_SOLICITUD)
        INTO   V_CA_RTCRD
        FROM   DUAL;
        --Verificamos si se genero tarifa manual
        SELECT COUNT(1)
        INTO   V_AUT_TM
        FROM   XXMOR_CONCOM_RPTA_TAB
        WHERE  id_solicitud               = P_ID_SOLICITUD
        AND    NUMLINEA_CONCOM            IS NOT NULL
        AND    CAMPO_CONCOM               = 'TARIFA_MANUAL'
        AND    TO_NUMBER(NUMLINEA_CONCOM) = P_LINEA;
        IF V_CA_RTCRD = 1 THEN
            V_MONTO := P_MONTO;
        ELSE
            V_MONTO := P_MONTO/100;
        END IF;
        --OBTENEMOS LA FUENTE DE DONDE PROVIENEN LAS COTIZACIONES (WS O SP)
        SELECT GET_RATE
        INTO   V_GET_RATE_FROM
        FROM   XXMOR_FZAS_VTAS_TAB
        WHERE  ID_FZA_VENTAS  = (SELECT ID_FZA_VENTAS
                                 FROM   XXMOR_SOLICITUDES_ENC_TAB
                                 WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                );
        --Obtenemos la tarifa "original" de la orden de referencia (debe ser igual al GetRate la 1a vez)
        --EL GETRATE_SIN_AJUSTE ES EL VALOR ORIGINAL DEL VALOR DEL PRECIO POR SPOT SIN DESCUENTO
        SELECT GETRATE_SIN_AJUSTE,
               TARIFASP_SIN_DESC
        INTO   V_GETRATE_SIN_AJUSTE,
               V_RT_ORIGINAL
        FROM   XXMOR_SOLICITUDES_DET_TAB
        WHERE  ID_SOLICITUD = P_ID_SOLICITUD
        AND    LINEA        = P_LINEA;
        --Obtenemos el monto original de la linea
        SELECT TRUNC(NVL(TARIFASP_SIN_DESC,0))
        INTO   V_MONTO_ORIG
        FROM   XXMOR_SOLICITUDES_DET_TAB
        WHERE  ID_SOLICITUD = P_ID_SOLICITUD
        AND    LINEA        = P_LINEA;
        --OBTENEMOS EL MONTO DE LA SUMA DE LAS LINEAS
        SELECT ROUND(SUM( TARIFASP_SIN_DESC ))
        INTO   V_SUMA_LINEAS
        FROM   XXMOR_SOLICITUDES_DET_TAB
        WHERE  ID_SOLICITUD IN ( SELECT ID_SOLICITUD
                                 FROM   XXMOR_SOLICITUDES_ENC_TAB
                                 WHERE  ID_REQUEST = (SELECT ID_REQUEST
                                                      FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                      WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                                     )
                               )
        AND    LINEA        = P_LINEA;
        --Revisamos si el monto ya fue actualizado, si si, entonces evitar volver a actualizar
        SELECT NVL2(GETRATE_CON_AJUSTE,1,0)
        INTO   V_MONTO_UPDATED
        FROM   XXMOR_SOLICITUDES_DET_TAB
        WHERE  ID_SOLICITUD = P_ID_SOLICITUD
        AND    LINEA        = P_LINEA;
        dbms_output.put_line(' V_SUMA_LINEAS:  '||V_SUMA_LINEAS);
        dbms_output.put_line(' V_MONTO_ORIG:  '||V_MONTO_ORIG);
        UPDATE XXMOR_SOLICITUDES_DET_TAB
        SET    GETRATE_CON_AJUSTE = V_MONTO
        WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
        AND    LINEA           = P_LINEA
        AND    DIVISION_MONTOS IS NULL;
       -- IF V_SUMA_LINEAS != V_MONTO_ORIG THEN
            --actualizamos el campo GETRATE_CON_AJUSTE (dado que para este tipo de ordenes DEBE venir vacio)
            --            UPDATE XXMOR_SOLICITUDES_DET_TAB
            --            set GETRATE_CON_AJUSTE = V_MONTO
            --            WHERE ID_SOLICITUD = P_ID_SOLICITUD
            --            AND LINEA = P_LINEA;
            --obtenemos el identificador de  las ordenes "hermanas"
            SELECT ID_REQUEST
            INTO   V_ID_REQUEST
            FROM   XXMOR_SOLICITUDES_ENC_TAB
            WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
            --contamos las lineas "hermanas"
            SELECT COUNT(1)
            INTO   V_ORDENES_HERMANAS
            FROM   XXMOR_SOLICITUDES_ENC_TAB
            WHERE  ID_REQUEST = V_ID_REQUEST;
            --Contamos todas las lineas hermanas que ya tienen ese campo calculado
            SELECT COUNT(1)
            INTO   V_LINEAS_CON_GET_RATE
            FROM   XXMOR_SOLICITUDES_ENC_TAB E,
                   XXMOR_SOLICITUDES_DET_TAB D
            WHERE  E.ID_REQUEST         = V_ID_REQUEST
            AND    E.ID_SOLICITUD       = D.ID_SOLICITUD
            AND    D.LINEA              = P_LINEA
            AND    D.GETRATE_CON_AJUSTE IS NOT NULL;
            --Si todas las lineas/ordenes hermanas ya tienen ese campo != de null entonces aplicamos la formula
            IF V_ORDENES_HERMANAS = V_LINEAS_CON_GET_RATE THEN
                --Sacamos la suma de las "parciales" o getrates con ratecard especifico
                SELECT SUM(GETRATE_CON_AJUSTE)
                INTO   V_SUMA_GET_RATE
                FROM   XXMOR_SOLICITUDES_ENC_TAB E,
                       XXMOR_SOLICITUDES_DET_TAB D
                WHERE  E.ID_REQUEST         = V_ID_REQUEST
                AND    E.ID_SOLICITUD       = D.ID_SOLICITUD
                AND    D.LINEA              = P_LINEA
                AND    D.GETRATE_CON_AJUSTE IS NOT NULL;
                --Total de spots de la linea
                V_TOT_SPOTS := XXMOR_SOL_TOTALES_FUN (P_ID_SOLICITUD, P_LINEA, 'SP_X_L');
                --IF V_GET_RATE_FROM = 'SP' AND V_SUMA_GET_RATE <> 0 THEN
                IF V_SUMA_GET_RATE <> 0 THEN
                    --Actualizamos los valores para cuando la orden es de CA
                    IF V_CA_RTCRD = 1 THEN
                        dbms_output.put_line(' rtcrd de CA  ');
                        IF V_AUT_TM > 0 THEN
                            dbms_output.put_line(' y con TM');
                            UPDATE XXMOR_SOLICITUDES_DET_TAB
                            SET    TARIFASP_SIN_DESC  = ROUND(TARIFASP_SIN_DESC * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE,2),
                                   TARIFASP_CON_DESC  = 777, --ROUND(NVL(TARIFASP_CON_DESC,0) * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE,2),
                                   TOT_LINEA_SIN_DESC = ROUND(V_TOT_SPOTS * (TARIFASP_SIN_DESC * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE),2),
                                   TOT_LINEA_CON_DESC = ROUND(V_TOT_SPOTS * (NVL(TARIFASP_CON_DESC,0) * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE),2),
                                   DIVISION_MONTOS    = 1
                            WHERE ID_SOLICITUD IN (SELECT ID_SOLICITUD
                                                   FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                   WHERE  ID_REQUEST = (SELECT ID_REQUEST
                                                                        FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                                        WHERE  ID_SOLICITUD = P_ID_SOL_REF
                                                                       )
                                                  )
                            AND DIVISION_MONTOS IS NULL
                            AND LINEA           = P_LINEA;
                        ELSE
                            dbms_output.put_line(' sin TM  ');
                            --si la tarifa de la linea = 0 o no traia
                            IF V_MONTO_ORIG = 0 THEN
                                dbms_output.put_line(' y monto = 0 o null ');
                                UPDATE XXMOR_SOLICITUDES_DET_TAB
                                SET    TARIFASP_SIN_DESC = ROUND(GETRATE_SIN_AJUSTE * GETRATE_CON_AJUSTE / (SELECT SUM(GETRATE_CON_AJUSTE)
                                                                                                            FROM   XXMOR_SOLICITUDES_ENC_TAB E,
                                                                                                                   XXMOR_SOLICITUDES_DET_TAB D
                                                                                                            WHERE  E.ID_REQUEST = ((SELECT ID_REQUEST
                                                                                                                                    FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                                                                                                    WHERE  ID_SOLICITUD = P_ID_SOL_REF)
                                                                                                                                  )
                                                                                                            AND     E.ID_SOLICITUD       = D.ID_SOLICITUD
                                                                                                            AND     D.LINEA              = P_LINEA
                                                                                                            AND     D.GETRATE_CON_AJUSTE IS NOT NULL
                                                                                                           )
                                                                                      ,2),
                                       --TARIFASP_CON_DESC = P_MONTO,
                                       DIVISION_MONTOS = 1
                                WHERE  ID_SOLICITUD IN (SELECT ID_SOLICITUD
                                                        FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                        WHERE  ID_REQUEST = (SELECT ID_REQUEST
                                                                             FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                                             WHERE  ID_SOLICITUD = P_ID_SOL_REF
                                                                            )
                                                       )
                                AND    DIVISION_MONTOS IS NULL
                                AND    LINEA           = P_LINEA;
                            ELSE
                                dbms_output.put_line(' Monto Diferente de 0/null');
                                -- si el monto de la linea traia una tarifa != 0
                                UPDATE XXMOR_SOLICITUDES_DET_TAB
                                SET    TARIFASP_SIN_DESC  = ROUND(TARIFASP_SIN_DESC * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE,2),
                                       TARIFASP_CON_DESC  = 777, --ROUND(NVL(TARIFASP_CON_DESC,0) * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE,2),
                                       TOT_LINEA_SIN_DESC = ROUND(V_TOT_SPOTS * (TARIFASP_SIN_DESC * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE),2),
                                       TOT_LINEA_CON_DESC = ROUND(V_TOT_SPOTS * (NVL(TARIFASP_CON_DESC,0) * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE),2),
                                       DIVISION_MONTOS    = 1
                                WHERE  ID_SOLICITUD IN (SELECT ID_SOLICITUD
                                                        FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                        WHERE  ID_REQUEST = (SELECT ID_REQUEST
                                                                             FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                                             WHERE  ID_SOLICITUD = P_ID_SOL_REF
                                                                            )
                                                       )
                                 AND DIVISION_MONTOS IS NULL
                                 AND LINEA           = P_LINEA;
                            END IF;
                        END IF;
                    ELSE
                        --Si la linea trae tarifa manual
                        IF V_AUT_TM > 0 THEN
                            UPDATE XXMOR_SOLICITUDES_DET_TAB
                            SET    TARIFASP_SIN_DESC  = ROUND(TARIFASP_SIN_DESC * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE,2),
                                   TARIFASP_CON_DESC  = 777, --ROUND(NVL(TARIFASP_CON_DESC,0) * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE,2),
                                   TOT_LINEA_SIN_DESC = ROUND(V_TOT_SPOTS * (TARIFASP_SIN_DESC * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE),2),
                                   TOT_LINEA_CON_DESC = ROUND(V_TOT_SPOTS * (NVL(TARIFASP_CON_DESC,0) * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE),2),
                                   DIVISION_MONTOS    = 1
                            WHERE  ID_SOLICITUD IN (SELECT ID_SOLICITUD
                                                    FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                    WHERE  ID_REQUEST = (SELECT ID_REQUEST
                                                                         FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                                         WHERE  ID_SOLICITUD = P_ID_SOL_REF
                                                                        )
                                                   )
                            AND DIVISION_MONTOS IS NULL
                            --                             AND (select count(getrate_sin_ajuste)
                            --                                    FROM XXMOR_SOLICITUDES_ENC_TAB E,
                            --                                             XXMOR_SOLICITUDES_DET_TAB d
                            --                                    where E.ID_SOLICITUD = D.ID_SOLICITUD
                            --                                    and e.id_solicitud IN ( SELECT ID_SOLICITUD
                            --                                                                    FROM  XXMOR_SOLICITUDES_ENC_TAB
                            --                                                                    WHERE ID_REQUEST = (SELECT id_request
                            --                                                                                                       FROM XXMOR_SOLICITUDES_ENC_TAB
                            --                                                                                                       WHERE id_solicitud = P_ID_SOL_REF))
                            --                                    AND LINEA = P_LINEA )
                            --                                    =
                            --                                    (select count(AGRUPADOR_MULTIPLE) as AgrupadorMultiple
                            --                                    from XXMOR_CAT_AGRUPADOR_MULT_TAB
                            --                                    where AGRUPADOR_MULTIPLE = (select AGRUPADOR
                            --                                                                                     from  XXMOR.XXMOR_SOLICITUDES_ENC_TAB
                            --                                                                                     where id_solicitud = P_ID_SOL_REF) )
                            AND LINEA           = P_LINEA;
                        ELSE
                            --Si la linea es tarifa normal
                            UPDATE XXMOR_SOLICITUDES_DET_TAB
                            SET    TARIFASP_SIN_DESC  = ROUND(GETRATE_SIN_AJUSTE  * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE,2),
                                   TARIFASP_CON_DESC  = ROUND(NVL(GETRATE_SIN_AJUSTE ,0) * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE,2),
                                   TOT_LINEA_SIN_DESC = ROUND(V_TOT_SPOTS * (GETRATE_SIN_AJUSTE  * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE),2),
                                   TOT_LINEA_CON_DESC = ROUND(V_TOT_SPOTS * (NVL(GETRATE_SIN_AJUSTE ,0) * GETRATE_CON_AJUSTE / V_SUMA_GET_RATE),2),
                                   DIVISION_MONTOS    = 1
                            WHERE --ID_SOLICITUD = P_ID_SOLICITUD  --P_ID_SOL_REF
                                   ID_SOLICITUD IN (SELECT ID_SOLICITUD
                                                    FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                    WHERE  ID_REQUEST = (SELECT ID_REQUEST
                                                                         FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                                         WHERE  ID_SOLICITUD = P_ID_SOL_REF
                                                                        )
                                                   )
                            AND DIVISION_MONTOS IS NULL
                            AND LINEA           = P_LINEA;
                        END IF;
                    END IF;
                END IF;
            END IF;
        -- END IF;
        COMMIT;
    END XXMOR_UPD_MONTOS_AGR_MUL_PR;
    PROCEDURE XXMOR_AUT_TM_SOBREP_PR
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO_AUT     IN VARCHAR2,
                                P_RATE         IN NUMBER,
                                P_AUX          IN VARCHAR2,
                                P_DET_CONCOM   IN VARCHAR2
                        ) IS
    V_SOLICITUD               XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE;
    V_RTCRD                   VARCHAR2(50);
    V_RTCRD_CA                PLS_INTEGER;  --Para saber si el rtcrd es de ca
    V_RES                     VARCHAR2(20);
    V_TIPO_AUT                VARCHAR2(2);
    V_TARIFASP_SIN_DESC       NUMBER;
    V_TARIFASP_CON_DESC       NUMBER;
    V_TOLERANCIA              NUMBER;
    V_LIM_SUP                 NUMBER;
    V_LIM_INF                 NUMBER;
    V_SOBRECARGO              VARCHAR2(50) := NULL;
    V_ERRORES                 INTEGER;
    V_RATE                    NUMBER;
    V_RATE_ADJ                NUMBER;
    V_EN_RANGO                VARCHAR2(5);
    V_AUT_AUT                 INTEGER;
    V_CREATED_BY              VARCHAR2(100);
    V_EMAIL                   VARCHAR2(100);
    V_ID_FZA_VENTAS           INTEGER;
    V_GET_RATE_FROM           VARCHAR(5);
    V_AGRUPADOR_MULT          INTEGER;
    V_SUM_TARIFASP_SIN_DESC   NUMBER;
    V_MONTO_DIV               PLS_INTEGER:=0; --Si una ord es de agr multiple para saber si ya se dividio
    V_CURRVA_RC               INTEGER;        --para actualizar rpta concom en caso de agrupador multiple
    lin_enc_paradigm          INTEGER;
    lst_estatus_orduni        VARCHAR2(2) := NULL;
    lin_monto_con_desc        NUMBER := 0;
    lin_spots_linea           NUMBER := 0;
    BEGIN
        SELECT NVL(GET_RATE,'SP'),
               XXMOR_RTCRD_CA_FUN(P_ID_SOLICITUD)
        INTO   V_GET_RATE_FROM,
               V_RTCRD_CA
        FROM   XXMOR_FZAS_VTAS_TAB
        WHERE  ID_FZA_VENTAS = (SELECT ID_FZA_VENTAS
                                FROM   XXMOR_SOLICITUDES_ENC_TAB
                                WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                               );
        dbms_output.put_line( 'V_GET_RATE_FROM = '||V_GET_RATE_FROM);
        IF P_LINEA IS NOT NULL THEN
            ---SOBRECARGO Y TARIFAS
            SELECT D.SOBRECARGO,
                   D.TARIFASP_SIN_DESC,
                   D.TARIFASP_CON_DESC
            INTO   V_SOBRECARGO,
                   V_TARIFASP_SIN_DESC,
                   V_TARIFASP_CON_DESC
            FROM   XXMOR_SOLICITUDES_DET_TAB D
            WHERE  D.ID_SOLICITUD = P_ID_SOLICITUD
            AND    D.LINEA        = P_LINEA;
        END IF;
        --Revisamos que tipo de autorizacion de tarifa manual tiene que generar
        IF V_GET_RATE_FROM = 'WS' AND V_RTCRD_CA > 0 THEN
            V_GET_RATE_FROM := 'WS';
        ELSE
            V_GET_RATE_FROM := 'SP';
        END IF;
        IF P_TIPO_AUT != 'CPS' THEN
            IF V_GET_RATE_FROM = 'SP' THEN
                --V_RATE := P_RATE/100;
                --V_RATE_ADJ := TRUNC(TO_NUMBER(P_AUX)/100,2); -- SE MODIFICO 30MAY2013 PUES RECIBE VALOR CON LETRAS
                IF V_TARIFASP_SIN_DESC IS NULL OR V_TARIFASP_SIN_DESC = 0 THEN
                    V_RATE := P_RATE/100;
                ELSE
                    IF P_RATE = 0 THEN
                        V_RATE := P_RATE;
                    ELSE
                        SELECT TARIFASP_SIN_DESC
                        INTO   V_RATE
                        FROM   XXMOR_SOLICITUDES_DET_TAB D
                        WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                        AND    LINEA        = P_LINEA;
                    END IF;
                END IF;
                IF P_AUX IS NOT NULL THEN
                    SELECT TRUNC(V_RATE*(1+(TO_NUMBER(TRIM (REPLACE (REPLACE (UPPER (NVL(P_AUX,'0')), 'DESC. ', '-'), '%', '')))/100)),2)
                    INTO   V_RATE_ADJ
                    FROM   DUAL;
                END IF;
            ELSE
                IF V_SOBRECARGO IS NOT NULL THEN
                    SELECT TRUNC(P_RATE*(1+(TO_NUMBER(TRIM (REPLACE (REPLACE (UPPER (NVL(V_SOBRECARGO,'0')), 'DESC. ', '-'), '%', '')))/100)),2)
                    INTO   V_RATE_ADJ
                    FROM   DUAL;
                    --V_RATE_ADJ := TRUNC(P_RATE*(1+(V_SOBRECARGO/100)),2);
                END IF;
                --El P_RATE proviene del WS, si proviene de una orden de agrupador multiple revisar si hay que actualizar el monto
                SELECT COUNT(AGRUPADOR_MULTIPLE)
                INTO   V_AGRUPADOR_MULT
                FROM   XXMOR_CAT_AGRUPADOR_MULT_TAB
                WHERE  AGRUPADOR_MULTIPLE = (SELECT PLATAFORMA_CANAL
                                             FROM XXMOR_SOLICITUDES_ENC_TAB
                                             WHERE ID_SOLICITUD = P_ID_SOLICITUD
                                            );
                -- SI APARTE LA ORDEN PROVIENE DE UN AGRUPADOR MULTIPLE REVISAR LA SUMA DE LAS LINEAS HERMANAS
                IF V_AGRUPADOR_MULT > 1 THEN
                    /* SELECT SUM(TARIFASP_SIN_DESC)
                    INTO V_SUM_TARIFASP_SIN_DESC
                    FROM XXMOR_SOLICITUDES_DET_TAB D
                    WHERE ID_SOLICITUD IN (SELECT ID_SOLICITUD
                                           FROM   XXMOR_SOLICITUDES_ENC_TAB
                                           WHERE  ID_REQUEST = (SELECT ID_REQUEST
                                                                FROM XXMOR_SOLICITUDES_ENC_TAB
                                                                WHERE ID_SOLICITUD = P_ID_SOLICITUD));*/
                    SELECT NVL(DIVISION_MONTOS,0)
                    INTO   V_MONTO_DIV
                    FROM   XXMOR_SOLICITUDES_DET_TAB D
                    WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                    AND    LINEA        = P_LINEA;
                    -- SI LA SUMA DE LAS LINEAS HERMANAS ES IGUAL A LO QUE TRAE EL P_RATE, ES PORQUE YA SE ACTUALIZARON
                    --IF V_SUM_TARIFASP_SIN_DESC = P_RATE THEN
                    -- SI monto_div = 1 , ES PORQUE YA SE ACTUALIZARON
                    IF V_MONTO_DIV = 1 THEN
                        --se usa el monto de la linea
                        SELECT TARIFASP_SIN_DESC
                        INTO V_RATE
                        FROM XXMOR_SOLICITUDES_DET_TAB D
                        WHERE ID_SOLICITUD = P_ID_SOLICITUD
                        AND LINEA          = P_LINEA;
                    ELSE
                        --Si no pues se usa el P_rate que trae como parametro de entrada
                        IF V_TARIFASP_SIN_DESC IS NULL OR V_TARIFASP_SIN_DESC = 0 THEN
                            V_RATE := P_RATE;
                        ELSE
                            SELECT TARIFASP_SIN_DESC
                            INTO   V_RATE
                            FROM   XXMOR_SOLICITUDES_DET_TAB D
                            WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                            AND    LINEA        = P_LINEA;
                        END IF;
                    END IF;
                ELSE
                    --Si no es agrupador multiple tambien se utiliza el parametro de entrada
                    V_RATE := P_RATE;
                END IF;
            END IF;
        ELSE
            --se trata de una autorizacion de CPS
            V_RATE := P_RATE;
        END IF;
        --Este trunc porque a veces el super getrate lanza como mil decimales
        V_RATE := TRUNC(V_RATE,2);
        SELECT COUNT(0)
        INTO   V_ERRORES
        FROM   XXMOR_CONCOM_RPTA_TAB
        WHERE  ESTATUS_ORDUNI             = '10'
        AND    UPPER(resultadogeneral)   != UPPER('Autorizacion')
        AND    ID_SOLICITUD               = P_ID_SOLICITUD
        AND    TO_NUMBER(NUMLINEA_CONCOM) = P_LINEA;
        -- SE VERIFICA SI SI EL CAMPO AUTORIZACION
        -- SIN RATECARD AUTOMATICA ESTA SELECCIONADO.
        SELECT NVL(FV.RTCRD_AUTH_AUT,0)
        INTO   V_AUT_AUT
        FROM   XXMOR_SOLICITUDES_ENC_TAB E,
               XXMOR_FZAS_VTAS_TAB       FV
        WHERE  E.ID_FZA_VENTAS = FV.ID_FZA_VENTAS
        AND    E.ID_SEG_NEG    = FV.ID_SEG_NEG
        AND    E.ID_SOLICITUD  = P_ID_SOLICITUD;
        IF INSTR(P_TIPO_AUT, 'TM') > 0 THEN
            dbms_output.put_line( 'p_tipo_aut'||P_TIPO_AUT);
            IF V_RATE_ADJ IS NOT NULL THEN
                UPDATE XXMOR_SOLICITUDES_DET_TAB
                SET    GETRATE_SIN_AJUSTE = V_RATE,
                       GETRATE_CON_AJUSTE = V_RATE_ADJ
                WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                AND    LINEA           = P_LINEA
                AND    DIVISION_MONTOS IS NULL;
            ELSE
                IF V_RTCRD_CA = 1 AND V_AGRUPADOR_MULT > 1 THEN
                    UPDATE XXMOR_SOLICITUDES_DET_TAB
                    SET    GETRATE_SIN_AJUSTE = P_RATE
                    WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                    AND    LINEA           =  P_LINEA
                    AND    DIVISION_MONTOS IS NULL;
                ELSE
                    UPDATE XXMOR_SOLICITUDES_DET_TAB
                    SET    GETRATE_SIN_AJUSTE = V_RATE
                    WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                    AND    LINEA           = P_LINEA
                    AND    DIVISION_MONTOS IS NULL;
                END IF;
            END IF;
            --SE CALCULA LA TOLERANCIA
            --15-enero-2013 Se cambia el capo rtcrd por el RTCRDDSCR como parametro para saber si se genera AxTM
            SELECT E.RTCRDDSCR,
                   AUT_TOLERANCIA,
                   CASE WHEN V_RTCRD_CA = 1 AND V_AGRUPADOR_MULT > 1 THEN
                       P_RATE- (NVL(AUT_TOLERANCIA,0))
                   ELSE V_RATE- (NVL(AUT_TOLERANCIA,0)) END,
                   CASE WHEN V_RTCRD_CA = 1 AND V_AGRUPADOR_MULT > 1 THEN
                       P_RATE+(NVL(AUT_TOLERANCIA,0))
                   ELSE V_RATE+(NVL(AUT_TOLERANCIA,0)) END
            INTO   V_RTCRD,
                   V_tolerancia,
                   V_LIM_INF,
                   v_LIM_SUP
            FROM   XXMOR_SOLICITUDES_ENC_TAB E,
                   XXMOR_FZAS_VTAS_TAB       FV
            WHERE  E.ID_SOLICITUD  = P_ID_SOLICITUD
            AND    E.ID_FZA_VENTAS = FV.ID_FZA_VENTAS;
            dbms_output.put_line('V_SOBRECARGO'||V_SOBRECARGO||  ' V_TARIFASP_SIN_DESC, ' || V_TARIFASP_SIN_DESC|| 'V_TARIFASP_CON_DESC ' ||V_TARIFASP_CON_DESC );
            dbms_output.put_line(V_RTCRD);
            IF V_RTCRD IS NOT NULL THEN  --TIENE RATE CARD
                dbms_output.put_line('con ratecard');
                -- SE OBTIENES LOS VALORES DEL MONTO CON DESCUENTO Y NUMERO DE LINEAS
                BEGIN
                    SELECT (CASE
                                WHEN SOBRECARGO IS NOT NULL THEN
                                    (V_RATE * XXMOR_FUNCIONAL_PKG.XXMOR_DESC_MCONTID_FUN(ID_SOLICITUD)) *
                                        (CASE
                                             WHEN ABS(TO_NUMBER(TRIM(REPLACE(REPLACE(UPPER(NVL(SOBRECARGO,'0')), 'DESC. ', '-'), '%', '')))) < 1 THEN
                                                 (1 + TO_NUMBER(TRIM(REPLACE(REPLACE(UPPER(NVL(SOBRECARGO,'0')), 'DESC. ', '-'), '%', ''))))
                                         ELSE
                                             (1 + (TO_NUMBER(TRIM(REPLACE(REPLACE(UPPER(NVL(SOBRECARGO,'0')), 'DESC. ', '-'), '%', '')))/100))
                                         END)
                            ELSE
                                (V_RATE * XXMOR_FUNCIONAL_PKG.XXMOR_DESC_MCONTID_FUN(ID_SOLICITUD))
                            END) MONTO_DESC_SOB,
                           XXMOR_FUNCIONAL_PKG.XXMOR_SOL_TOTALES_FUN(P_ID_SOLICITUD, P_LINEA, 'SP_X_L')
                    INTO   lin_monto_con_desc,
                           lin_spots_linea
                    FROM   XXMOR_SOLICITUDES_DET_TAB
                    WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                    AND    LINEA        = P_LINEA;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        lin_monto_con_desc := 0;
                        lin_spots_linea    := 0;
                    WHEN OTHERS THEN
                        lin_monto_con_desc := 0;
                        lin_spots_linea    := 0;
                END;
                IF V_GET_RATE_FROM = 'SP' THEN
                    IF V_LIM_INF <= V_TARIFASP_SIN_DESC AND V_TARIFASP_SIN_DESC <= V_LIM_SUP THEN   --TIENE RATE CARD Y ESTA DENTRO DEL RANGO
                        --TIENE RATECARD ESTA EN EL RANGO Y TIENE SOBRECARGO
                        IF V_SOBRECARGO IS NOT NULL THEN
                            INSERT INTO XXMOR_CONCOM_RPTA_TAB
                                   ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID, DESC_CONCOM,
                                     POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                                     DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                                     CREATED_BY
                                   )
                            SELECT E.ID_SOLICITUD, ID_SEG_NEG, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                                   'LINEA', NULL, LINEA, 'ERROR','SOBRECARGO',
                                   'AUTORIZACION - SOBRECARGO.- Verificar Ajuste Variable Contrato (' ||d.SOBRECARGO|| ') de la linea con tarifa '||TO_CHAR(D.GETRATE_SIN_AJUSTE,'9999999999999.00')||' quedando en ' || TO_CHAR(D.GETRATE_CON_AJUSTE,'99999999999.99'), 'AUTORIZACION', NULL,'10', SYSDATE,
                                   'ORDUNI2'
                            FROM   XXMOR_SOLICITUDES_DET_TAB D,
                                   XXMOR_SOLICITUDES_ENC_TAB E
                            WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
                            AND    E.ID_SOLICITUD = D.ID_SOLICITUD
                            AND    D.LINEA        = p_LINEA
                            AND    E.RTCRDDSCR    IS NOT NULL
                            AND    NOT EXISTS       (SELECT 1
                                                     FROM   XXMOR_CONCOM_RPTA_TAB C
                                                     WHERE  C.ID_SOLICITUD         = D.ID_SOLICITUD
                                                     AND    C.NUMLINEA_CONCOM      = D.LINEA
                                                     AND    C.NUMLINEA_CONCOM      IS NOT NULL
                                                     AND    UPPER(C.ACCION_CONCOM) = 'RECHAZO'
                                                     AND    TO_NUMBER(d.LINEA)     = TO_NUMBER(C.NUMLINEA_CONCOM)
                                                    )
                            AND    NOT EXISTS       (SELECT 1
                                                     FROM   XXMOR_CONCOM_RPTA_TAB c
                                                     WHERE  C.ID_SOLICITUD             = E.ID_SOLICITUD
                                                     AND    C.NUMLINEA_CONCOM          IS NOT NULL
                                                     AND    CAMPO_CONCOM               = 'SOBRECARGO'
                                                     AND    TO_NUMBER(NUMLINEA_CONCOM) = D.LINEA
                                                    );
                        END IF;
                        dbms_output.put_line('tarifa sp sin desc entre lim sup e inf');
                    ELSE --TIENE RATE CARD NO ESTA EN EL RANGO
                        IF V_SOBRECARGO IS NULL THEN --TIENE RATE CARD NO ESTA EN EL RANGO Y NO TIENE SOBRECARGO
                            dbms_output.put_line('CON RATECARD Y FUERA DE LOS LIMITES Y SIN SOBRECARGO');
                            IF V_GET_RATE_FROM = 'SP' THEN
                                INSERT INTO XXMOR_CONCOM_RPTA_TAB
                                       ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID,   DESC_CONCOM,
                                         POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                                         DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                                         CREATED_BY
                                       )
                                SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                                       'LINEA', NULL,LINEA, 'ERROR','TARIFA_MANUAL',
                                       'AUTORIZACION - Tarifa Manual.- La tarifa de la linea '||TO_CHAR(D.TARIFASP_SIN_DESC,'9999999999999.00')|| ' no corresponde con la tarifa de sistema ' || TO_CHAR(D.GETRATE_SIN_AJUSTE,'9999999999999.00'), 'AUTORIZACION', NULL,'10', SYSDATE,
                                       'ORDUNI2'
                                FROM   XXMOR_SOLICITUDES_DET_TAB D,
                                       XXMOR_SOLICITUDES_ENC_TAB E
                                WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
                                AND    E.ID_SOLICITUD = D.ID_SOLICITUD
                                AND    D.LINEA        = P_LINEA
                                AND    E.RTCRDDSCR    IS NOT NULL
                                AND    D.DIVISION_MONTOS IS NULL
                                AND    NOT EXISTS       (SELECT 1
                                                         FROM   XXMOR_CONCOM_RPTA_TAB C
                                                         WHERE  C.ID_SOLICITUD         = D.ID_SOLICITUD
                                                         AND    C.NUMLINEA_CONCOM      = D.LINEA
                                                         AND    C.NUMLINEA_CONCOM      IS NOT NULL
                                                         AND    UPPER(C.ACCION_CONCOM) = 'RECHAZO'
                                                         AND    TO_NUMBER(D.LINEA)     = TO_NUMBER(C.NUMLINEA_CONCOM)
                                                        )
                                AND    NOT EXISTS       (SELECT 1
                                                         FROM   XXMOR_CONCOM_RPTA_TAB c
                                                         WHERE  C.ID_SOLICITUD             = E.ID_SOLICITUD
                                                         AND    C.NUMLINEA_CONCOM          IS NOT NULL
                                                         AND    CAMPO_CONCOM               = 'TARIFA_MANUAL'
                                                         AND    TO_NUMBER(NUMLINEA_CONCOM) = D.LINEA
                                                        );
                            ELSE
                                UPDATE XXMOR_SOLICITUDES_DET_TAB
                                SET    TARIFASP_SIN_DESC  = V_RATE,
                                       TARIFASP_CON_DESC  = TRUNC(lin_monto_con_desc,2),
                                       TOT_LINEA_SIN_DESC = TRUNC((V_RATE * lin_spots_linea),2),
                                       TOT_LINEA_CON_DESC = TRUNC((lin_monto_con_desc * lin_spots_linea),2)
                                WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                                AND    LINEA           = P_LINEA
                                AND    DIVISION_MONTOS IS NULL;
                            END IF;
                        ELSE --TIENE RATE CARD NO ESTA EN EL RANGO Y TIENE SOBRECARGO
                            dbms_output.put_line('-CON RATECARD Y FUERA DE LOS LIMITES Y CON SOBRECARGO');
                            INSERT INTO XXMOR_CONCOM_RPTA_TAB
                                   ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID,   DESC_CONCOM,
                                     POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                                     DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                                     CREATED_BY
                                   )
                            SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                                   'LINEA', NULL, LINEA, 'ERROR','SOBRECARGO',
                                   'RECHAZO - La linea contiene Tarifa Manual y Sobrecargo lo cual no esta permitido' , 'RECHAZO', NULL,'10', SYSDATE,
                                   'ORDUNI2'
                            FROM   XXMOR_SOLICITUDES_DET_TAB D,
                                   XXMOR_SOLICITUDES_ENC_TAB E
                            WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
                            AND    E.ID_SOLICITUD = D.ID_SOLICITUD
                            AND    D.LINEA        = P_LINEA
                            AND    NOT EXISTS       (SELECT 1
                                                     FROM   XXMOR_CONCOM_RPTA_TAB c
                                                     WHERE  C.ID_SOLICITUD             = E.ID_SOLICITUD
                                                     AND    C.NUMLINEA_CONCOM          IS NOT NULL
                                                     AND    CAMPO_CONCOM               = 'SOBRECARGO'
                                                     AND    TO_NUMBER(NUMLINEA_CONCOM) = D.LINEA
                                                    );
                        END IF;
                    END IF;
                ELSIF V_GET_RATE_FROM = 'WS' THEN
                    --TIENE RATECARD Y TIENE SOBRECARGO se rechaza --verificar con tavo 16-04-2013
                    IF V_SOBRECARGO IS NOT NULL THEN
                        INSERT INTO XXMOR_CONCOM_RPTA_TAB
                               ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID,   DESC_CONCOM,
                                 POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                                 DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                                 CREATED_BY
                               )
                        SELECT E.ID_SOLICITUD, ID_SEG_NEG, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                               'LINEA', NULL, LINEA, 'ERROR','SOBRECARGO',
                               'AUTORIZACION - SOBRECARGO.- Verificar Ajuste Variable Contrato (' ||d.SOBRECARGO|| ') de la linea con tarifa '||TO_CHAR(D.GETRATE_SIN_AJUSTE,'9999999999999.00')||' quedando en ' || TO_CHAR(D.GETRATE_CON_AJUSTE,'99999999999.99'), 'AUTORIZACION', NULL,'10', SYSDATE,
                               'ORDUNI2'
                        FROM   XXMOR_SOLICITUDES_DET_TAB d,
                               XXMOR_SOLICITUDES_ENC_TAB E
                        WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
                        AND    E.ID_SOLICITUD = D.ID_SOLICITUD
                        AND    D.LINEA        = P_LINEA
                        AND    E.RTCRDDSCR    IS NOT NULL
                        AND    NOT EXISTS       (SELECT 1
                                                 FROM   XXMOR_CONCOM_RPTA_TAB C
                                                 WHERE  C.ID_SOLICITUD         = D.ID_SOLICITUD
                                                 AND    C.NUMLINEA_CONCOM      = D.LINEA
                                                 AND    C.NUMLINEA_CONCOM      IS NOT NULL
                                                 AND    UPPER(C.ACCION_CONCOM) = 'RECHAZO'
                                                 AND    TO_NUMBER(D.LINEA)     = TO_NUMBER(C.NUMLINEA_CONCOM)
                                                )
                        AND    NOT EXISTS       (SELECT 1
                                                 FROM   XXMOR_CONCOM_RPTA_TAB C
                                                 WHERE  C.ID_SOLICITUD             = E.ID_SOLICITUD
                                                 AND    C.NUMLINEA_CONCOM          IS NOT NULL
                                                 AND    CAMPO_CONCOM               = 'SOBRECARGO'
                                                 AND    TO_NUMBER(NUMLINEA_CONCOM) = D.LINEA
                                                );
                        -- SE ACTUALIZAN MONTOS
                        UPDATE XXMOR_SOLICITUDES_DET_TAB
                        SET    TARIFASP_SIN_DESC  = V_RATE,
                               TARIFASP_CON_DESC  = TRUNC(lin_monto_con_desc,2),
                               TOT_LINEA_SIN_DESC = TRUNC((V_RATE * lin_spots_linea),2),
                               TOT_LINEA_CON_DESC = TRUNC((lin_monto_con_desc * lin_spots_linea),2)
                        WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                        AND    LINEA           = P_LINEA
                        AND    DIVISION_MONTOS IS NULL;
                    ELSE
                        --La orden es de agrupador multiple
                        IF V_AGRUPADOR_MULT > 1 THEN
                            dbms_output.put_line('la orden es de agrupador multiple');
                            -- SI ES DE CA, AGRUPADOR MULTIPLE Y LA TARIFA LINEA = 0 O NULL
                            IF V_TARIFASP_SIN_DESC IS NULL OR V_TARIFASP_SIN_DESC = 0 THEN
                                UPDATE XXMOR_SOLICITUDES_DET_TAB
                                SET    TARIFASP_SIN_DESC  = V_RATE,
                                       TARIFASP_CON_DESC  = TRUNC(lin_monto_con_desc,2),
                                       TOT_LINEA_SIN_DESC = TRUNC((V_RATE * lin_spots_linea),2),
                                       TOT_LINEA_CON_DESC = TRUNC((lin_monto_con_desc * lin_spots_linea),2)
                                WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                                AND    LINEA           = P_LINEA
                                AND    DIVISION_MONTOS IS NULL;
                            ELSE
                                --TIENE RATE CARD y tarifa de la linea != 0 verificar que ESTe DENTRO DEL RANGO
                                IF V_LIM_INF <= V_TARIFASP_SIN_DESC AND V_TARIFASP_SIN_DESC <= V_LIM_SUP THEN
                                    dbms_output.put_line(' la tarifa esta dentro de los limites V_LIM_INF:'||V_LIM_INF||'  V_LIM_SUP:'||V_LIM_SUP||' V_TARIFASP_SIN_DESC: '||V_TARIFASP_SIN_DESC );
                                    UPDATE XXMOR_SOLICITUDES_DET_TAB
                                    SET    TARIFASP_SIN_DESC  = V_RATE,
                                           TARIFASP_CON_DESC  = TRUNC(lin_monto_con_desc,2),
                                           TOT_LINEA_SIN_DESC = TRUNC((V_RATE * lin_spots_linea),2),
                                           TOT_LINEA_CON_DESC = TRUNC((lin_monto_con_desc * lin_spots_linea),2)
                                    WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                                    AND    LINEA           = P_LINEA
                                    AND    DIVISION_MONTOS IS NULL;
                                ELSE
                                    dbms_output.put_line('tarifa sp sobrepasa la tolerancia');
                                    --si no esta dentro del rango entonces se manda a generar una autorizacion de TM
                                    INSERT INTO XXMOR_CONCOM_RPTA_TAB
                                           ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID,   DESC_CONCOM,
                                             POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                                             DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                                             CREATED_BY
                                           )
                                    SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                                           'LINEA', NULL,LINEA, 'ERROR','TARIFA_MANUAL',
                                           'AUTORIZACION - Tarifa Manual.- La tarifa de la linea '||TO_CHAR(D.TARIFASP_SIN_DESC,'9999999999999.00')|| ' no corresponde con la tarifa de sistema ' || TO_CHAR(D.GETRATE_SIN_AJUSTE,'9999999999999.00'), 'AUTORIZACION', NULL,'10', SYSDATE,
                                           'ORDUNI2'
                                    FROM   XXMOR_SOLICITUDES_DET_TAB D,
                                           XXMOR_SOLICITUDES_ENC_TAB E
                                    WHERE  E.ID_SOLICITUD    = P_ID_SOLICITUD
                                    AND    E.ID_SOLICITUD    = D.ID_SOLICITUD
                                    AND    D.LINEA           = P_LINEA
                                    AND    D.DIVISION_MONTOS IS NULL
                                    AND    E.RTCRDDSCR       IS NOT NULL
                                    AND    NOT EXISTS          (SELECT 1
                                                                FROM   XXMOR_CONCOM_RPTA_TAB C
                                                                WHERE  C.ID_SOLICITUD         = D.ID_SOLICITUD
                                                                AND    C.NUMLINEA_CONCOM      = D.LINEA
                                                                AND    C.NUMLINEA_CONCOM      IS NOT NULL
                                                                AND    UPPER(C.ACCION_CONCOM) = 'RECHAZO'
                                                                AND    TO_NUMBER(D.LINEA)     = TO_NUMBER(C.NUMLINEA_CONCOM)
                                                               )
                                    AND    NOT EXISTS          (SELECT 1
                                                                FROM   XXMOR_CONCOM_RPTA_TAB C
                                                                WHERE  C.ID_SOLICITUD             = E.ID_SOLICITUD
                                                                AND    C.NUMLINEA_CONCOM          IS NOT NULL
                                                                AND    CAMPO_CONCOM               = 'TARIFA_MANUAL'
                                                                AND    TO_NUMBER(NUMLINEA_CONCOM) = D.LINEA
                                                               );
                                    IF SQL%FOUND THEN
                                        SELECT XXMOR_ID_RPTA_CONCOM_SQ.CURRVAL
                                        INTO   V_CURRVA_RC
                                        FROM   DUAL;
                                        ---si alguna hermana ya fue autorizada cambiar el estatus a autorizada
                                        UPDATE XXMOR_CONCOM_RPTA_TAB
                                        SET    ESTATUS_ORDUNI = '20'
                                        WHERE  ID_RPTA_CONCOM = V_CURRVA_RC
                                        AND    (SELECT COUNT(1)
                                                FROM   XXMOR_CONCOM_RPTA_TAB C
                                                WHERE  C.ID_SOLICITUD IN (SELECT ID_SOLICITUD
                                                                          FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                                          WHERE  ID_REQUEST = (SELECT ID_REQUEST
                                                                                               FROM   XXMOR_SOLICITUDES_ENC_TAB
                                                                                               WHERE ID_SOLICITUD = P_ID_SOLICITUD
                                                                                              )
                                                                         )
                                                AND    C.NUMLINEA_CONCOM          IS NOT NULL
                                                AND    CAMPO_CONCOM               = 'TARIFA_MANUAL'
                                                AND    TO_NUMBER(NUMLINEA_CONCOM) = P_LINEA
                                                AND    ESTATUS_ORDUNI             = '20'
                                               )              > 0;
                                    END IF;
                                END IF;
                            END IF;
                        ELSE
                            -- LA ORDEN NO ES DE AGRUPADOR MULTIPLE
                            dbms_output.put_line('como V_GET_RATE_FROM = WS entonces solo se actualiza el valor de los totales y tarifa');
                            UPDATE XXMOR_SOLICITUDES_DET_TAB
                            SET    TARIFASP_SIN_DESC  = V_RATE,
                                   TARIFASP_CON_DESC  = TRUNC(lin_monto_con_desc,2),
                                   TOT_LINEA_SIN_DESC = TRUNC((V_RATE * lin_spots_linea),2),
                                   TOT_LINEA_CON_DESC = TRUNC((lin_monto_con_desc * lin_spots_linea),2)
                            WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                            AND    LINEA           = P_LINEA
                            AND    DIVISION_MONTOS IS NULL;
                        END IF;
                    END IF;
                END IF;
            ELSE  --NO TIENE RATE CARD
                IF V_GET_RATE_FROM = 'WS' THEN
                    dbms_output.put_line('el rtcrd es de CA/Plan comercial');
                    IF V_SOBRECARGO IS NOT NULL THEN  -- LA ORDEN ES DE PLAN COMERCIAL (SE TARIFICA CON EL WS) NO TIENE RATECARD Y CON SOBRECARGO, SE RECHAZA!!!
                        --Si la linea no tiene ratecard pero si sobrecargo entonces se RECHAZA
                        dbms_output.put_line('LA ORDEN ES DE PLAN COMERCIAL NO TIENE RATECARD  ');
                        INSERT INTO XXMOR_CONCOM_RPTA_TAB
                               ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID,   DESC_CONCOM,
                                 POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                                 DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                                 CREATED_BY
                               )
                        SELECT E.ID_SOLICITUD, ID_SEG_NEG, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                               'LINEA', NULL,LINEA, 'ERROR','SOBRECARGO',
                               'RECHAZO - La linea contiene Tarifa Manual y Sobrecargo lo cual no esta permitido', 'RECHAZO', NULL,'10', SYSDATE,
                               'ORDUNI2'
                        FROM   XXMOR_SOLICITUDES_DET_TAB D,
                               XXMOR_SOLICITUDES_ENC_TAB E
                        WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
                        AND    E.ID_SOLICITUD = D.ID_SOLICITUD
                        AND    D.LINEA        = P_LINEA
                        AND    E.RTCRDDSCR    IS NULL;
                    ELSE
                        dbms_output.put_line('tarifa sp sin desc entre lim sup e inf y no es nulo');
                        --LA ORDEN ES DE PLAN COMERCIAL (SE TARIFICA CON EL WS) NO TIENE RATECARD Y NO TIENE SOBRECARGO
                        INSERT INTO XXMOR_CONCOM_RPTA_TAB
                               ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID,   DESC_CONCOM,
                                 POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                                 DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                                 CREATED_BY
                               )
                        SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                               'LINEA', NULL,LINEA, 'ERROR','TARIFA_MANUAL',
                               'AUTORIZACION - Tarifa Manual.- La tarifa de la linea '||TO_CHAR(D.TARIFASP_SIN_DESC,'9999999999999.00')|| ' no corresponde con la tarifa de sistema ' || TO_CHAR(D.GETRATE_SIN_AJUSTE,'9999999999999.00'), 'AUTORIZACION', NULL,'10', SYSDATE,
                               'ORDUNI2'
                        FROM   XXMOR_SOLICITUDES_DET_TAB D,
                               XXMOR_SOLICITUDES_ENC_TAB E
                        WHERE  E.ID_SOLICITUD    = P_ID_SOLICITUD
                        AND    E.ID_SOLICITUD    = D.ID_SOLICITUD
                        AND    D.LINEA           = P_LINEA
                        AND    D.DIVISION_MONTOS IS NULL
                        AND    E.RTCRDDSCR       IS NOT NULL
                        AND    NOT EXISTS          (SELECT 1
                                                    FROM   XXMOR_CONCOM_RPTA_TAB C
                                                    WHERE  C.ID_SOLICITUD         = D.ID_SOLICITUD
                                                    AND    C.NUMLINEA_CONCOM      = D.LINEA
                                                    AND    C.NUMLINEA_CONCOM      IS NOT NULL
                                                    AND    UPPER(C.ACCION_CONCOM) = 'RECHAZO'
                                                    AND    TO_NUMBER(D.LINEA)     = TO_NUMBER(C.NUMLINEA_CONCOM)
                                                   )
                        AND    NOT EXISTS          (SELECT 1
                                                    FROM   XXMOR_CONCOM_RPTA_TAB c
                                                    WHERE  C.ID_SOLICITUD             = E.ID_SOLICITUD
                                                    AND    C.NUMLINEA_CONCOM          IS NOT NULL
                                                    AND    CAMPO_CONCOM               = 'TARIFA_MANUAL'
                                                    AND    TO_NUMBER(NUMLINEA_CONCOM) = D.LINEA
                                                   );
                    END IF;
                ELSIF  V_GET_RATE_FROM = 'SP' THEN
                    IF V_SOBRECARGO IS NOT NULL THEN  --SIN RATECARD Y FUERA DE LOS LIMITES Y CON SOBRECARGO
                        --Si la linea no tiene ratecard pero si sobrecargo entonces se RECHAZA
                        dbms_output.put_line('LA ORDEN ES DE PLAN COMERCIAL NO TIENE RATECARD  ');
                        INSERT INTO XXMOR_CONCOM_RPTA_TAB
                               ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID,   DESC_CONCOM,
                                 POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                                 DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                                 CREATED_BY
                               )
                        SELECT E.ID_SOLICITUD, ID_SEG_NEG, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                               'LINEA', NULL,LINEA, 'ERROR','SOBRECARGO',
                               'RECHAZO - La linea contiene Tarifa Manual y Sobrecargo lo cual no esta permitido', 'RECHAZO', NULL,'10', SYSDATE,
                               'ORDUNI2'
                        FROM   XXMOR_SOLICITUDES_DET_TAB D,
                               XXMOR_SOLICITUDES_ENC_TAB E
                        WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
                        AND    E.ID_SOLICITUD = D.ID_SOLICITUD
                        AND    D.LINEA        = p_LINEA
                        AND    E.RTCRDDSCR    IS NULL;
                    --ELSIF V_LIM_INF <= V_TARIFASP_SIN_DESC AND V_TARIFASP_SIN_DESC <= V_LIM_SUP THEN
                    --    NULL;
                    ELSE --SIN RATECARD Y FUERA DE LOS LIMITES Y SIN SOBRECARGO
                        dbms_output.put_line('SIN RATECARD Y FUERA DE LOS LIMITES Y SIN SOBRECARGO');
                        INSERT INTO XXMOR_CONCOM_RPTA_TAB
                               ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID,   DESC_CONCOM,
                                 POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                                 DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                                 CREATED_BY
                               )
                        SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                               'LINEA', NULL, LINEA, 'ERROR','TARIFA_MANUAL',
                               'AUTORIZACION - Tarifa Manual.- La orden no tiene Ratecard', 'AUTORIZACION', NULL, '10', SYSDATE,
                               'ORDUNI2'
                        FROM   XXMOR_SOLICITUDES_DET_TAB D,
                               XXMOR_SOLICITUDES_ENC_TAB E
                        WHERE  E.ID_SOLICITUD    = P_ID_SOLICITUD
                        AND    E.ID_SOLICITUD    = D.ID_SOLICITUD
                        AND    D.LINEA           = P_LINEA
                        AND    E.RTCRDDSCR       IS NULL
                        AND    D.DIVISION_MONTOS IS NULL
                        AND    NOT EXISTS          (SELECT 1
                                                    FROM   XXMOR_CONCOM_RPTA_TAB C
                                                    WHERE  C.ID_SOLICITUD         = D.ID_SOLICITUD
                                                    AND    C.NUMLINEA_CONCOM      = D.LINEA
                                                    AND    C.NUMLINEA_CONCOM      IS NOT NULL
                                                    AND    UPPER(C.ACCION_CONCOM) = 'RECHAZO'
                                                    AND    TO_NUMBER(D.LINEA)     = TO_NUMBER(C.NUMLINEA_CONCOM)
                                                   )
                        AND    NOT EXISTS          (SELECT 1
                                                    FROM   XXMOR_CONCOM_RPTA_TAB c
                                                    WHERE  C.ID_SOLICITUD             = E.ID_SOLICITUD
                                                    AND    C.NUMLINEA_CONCOM          IS NOT NULL
                                                    AND    CAMPO_CONCOM               = 'TARIFA_MANUAL'
                                                    AND    TO_NUMBER(NUMLINEA_CONCOM) = D.LINEA
                                                   );
                        -- SE AUTORIZAN DE MANERA AUTOMATICA SI EL CAMPO AUTORIZACION
                        -- SIN RATECARD AUTOMATICA ESTA SELECCIONADO.
                        IF V_AUT_AUT = 1 THEN
                            UPDATE XXMOR_CONCOM_RPTA_TAB
                            SET    ESTATUS_ORDUNI = '20',
                                   UPDATED_DATE   = SYSDATE,
                                   UPDATED_BY     = 'ORDUNI2'
                            WHERE  ID_SOLICITUD               = P_ID_SOLICITUD
                            AND    ACCION_CONCOM              = 'AUTORIZACION'
                            AND    TO_NUMBER(NUMLINEA_CONCOM) = P_LINEA
                            AND    CAMPO_CONCOM               = 'TARIFA_MANUAL'
                            AND    ESTATUS_ORDUNI             = '10';
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
        BEGIN
            --Revisamos si la orden es urgente
            XXMOR_AUT_URGENTE_FUN (P_ID_SOLICITUD, NULL);
            --Revisamos q si es de mkt cumpla con los requisitos del buyunit y coordinador
            XXMOR_REVISAR_BUYUNITMKT_PR(XXMOR_ID_SOLICITUD_SQ.CURRVAL);
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;
        BEGIN
            XXMOR_AUT_OPENLOG_FUN (P_ID_SOLICITUD, NULL, V_RES);
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;
        ----------------
        -- Se revisa si el encabezado ya fue insertado en Paradigm, pues de ser asi
        -- ya no se generan las autorizaciones de CPS ni Credito Corporativo.
        SELECT COUNT(1)
        INTO   lin_enc_paradigm
        FROM   XXMOR_SOLICITUDES_EST_REP_TAB
        WHERE  LINEA            = 0
        AND    ESTAT_ID_FORANEO IS NOT NULL
        AND    ID_SOLICITUD     = P_ID_SOLICITUD;
        IF P_TIPO_AUT = 'CPS' THEN
            SELECT XXMOR_FUNCIONAL_PKG.XXMOR_SOL_TOTALES_FUN (P_ID_SOLICITUD, NULL, 'TCDSC_X_O')
            INTO   V_TARIFASP_CON_DESC
            FROM   DUAL;
            dbms_output.put_line('tipo cps');
            dbms_output.put_line('total_orden:'|| V_TARIFASP_CON_DESC ||' MONTO_CPS:'|| P_RATE );
            IF V_TARIFASP_CON_DESC > P_RATE  THEN
                IF lin_enc_paradigm = 0 THEN
                    INSERT INTO XXMOR_CONCOM_RPTA_TAB
                           ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID, DESC_CONCOM,
                             POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                             DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                             CREATED_BY
                           )
                    SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, '',
                           'ENCABEZADO', NULL,NULL, 'ERROR','CPS',
                           'AUTORIZACION - El total del cps es: '||P_RATE||' Total de la orden con descuento: '||V_TARIFASP_CON_DESC, 'AUTORIZACION', NULL, '10', SYSDATE,
                           'ORDUNI2'
                    FROM   XXMOR_SOLICITUDES_DET_TAB D,
                           XXMOR_SOLICITUDES_ENC_TAB E
                    WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
                    AND    E.ID_SOLICITUD = d.ID_SOLICITUD
                    AND    ROWNUM         = 1
                    AND    NOT EXISTS       (SELECT 1
                                             FROM   XXMOR_CONCOM_RPTA_TAB C
                                             WHERE  C.ID_SOLICITUD         = E.ID_SOLICITUD
                                             AND    C.NUMLINEA_CONCOM      IS NULL
                                             AND    UPPER(C.ACCION_CONCOM) = 'RECHAZO'
                                            )
                    AND    NOT EXISTS       (SELECT 1
                                             FROM   XXMOR_CONCOM_RPTA_TAB C
                                             WHERE  C.ID_SOLICITUD    = E.ID_SOLICITUD
                                             AND    C.NUMLINEA_CONCOM IS NULL
                                             AND    C.CAMPO_CONCOM    = 'CPS'
                                            );
                    COMMIT;
                END IF;
            END IF;
            -- PARA GENERAR LAS AUTORIZACIONES DE TARIFA MANUAL POR NO TRAER RATECARD
            INSERT INTO XXMOR_CONCOM_RPTA_TAB
                   ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID, DESC_CONCOM,
                     POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                     DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                     CREATED_BY
                   )
            SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                   'LINEA', NULL, LINEA, 'ERROR','TARIFA_MANUAL',
                   'AUTORIZACION - Tarifa Manual.- La orden no tiene Ratecard', 'AUTORIZACION', NULL, '10', SYSDATE,
                   'ORDUNI2'
            FROM   XXMOR_SOLICITUDES_DET_TAB D,
                   XXMOR_SOLICITUDES_ENC_TAB E
            WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
            AND    E.RTCRDDSCR    IS NULL
            AND    E.ID_SOLICITUD = D.ID_SOLICITUD
            AND    NOT EXISTS       (SELECT 1
                                     FROM   XXMOR_CONCOM_RPTA_TAB C
                                     WHERE  C.ID_SOLICITUD         = D.ID_SOLICITUD
                                     AND    C.NUMLINEA_CONCOM      = D.LINEA
                                     AND    C.NUMLINEA_CONCOM      IS NOT NULL
                                     AND    UPPER(C.ACCION_CONCOM) = 'RECHAZO'
                                     AND    TO_NUMBER(D.LINEA)     = TO_NUMBER(C.NUMLINEA_CONCOM)
                                    )
            AND NOT EXISTS          (SELECT 1
                                     FROM   XXMOR_CONCOM_RPTA_TAB C
                                     WHERE  C.ID_SOLICITUD               = E.ID_SOLICITUD
                                     AND    C.NUMLINEA_CONCOM            IS NOT NULL
                                     AND    C.CAMPO_CONCOM               = 'TARIFA_MANUAL'
                                     AND    TO_NUMBER(C.NUMLINEA_CONCOM) = D.LINEA
                                    );
            -- SE AUTORIZAN DE MANERA AUTOMATICA SI EL CAMPO AUTORIZACION
            -- SIN RATECARD AUTOMATICA ESTA SELECCIONADO.
            IF V_AUT_AUT = 1 THEN
                UPDATE XXMOR_CONCOM_RPTA_TAB
                SET    ESTATUS_ORDUNI = '20',
                       UPDATED_DATE   = SYSDATE,
                       UPDATED_BY     = 'ORDUNI2'
                WHERE  ID_SOLICITUD               = P_ID_SOLICITUD
                AND    ACCION_CONCOM              = 'AUTORIZACION'
                AND    CAMPO_CONCOM               = 'TARIFA_MANUAL'
                AND    ESTATUS_ORDUNI             = '10';
            END IF;
        ELSIF SUBSTR(P_TIPO_AUT,1,8) = 'CREDCORP' THEN
            dbms_output.put_line('tipo Credito Corp');
            SELECT XXMOR_FUNCIONAL_PKG.XXMOR_SOL_TOTALES_FUN (P_ID_SOLICITUD, NULL, 'TCD_X_O')
            INTO   V_TARIFASP_CON_DESC
            FROM   DUAL;
            IF P_TIPO_AUT = 'CREDCORP10' THEN
                lst_estatus_orduni := '10';
            ELSE
                lst_estatus_orduni := '20';
            END IF;
            INSERT INTO XXMOR_CONCOM_RPTA_TAB
                   ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID,   DESC_CONCOM,
                     POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                     DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI,
                     CREATED_DATE, CREATED_BY
                   )
            SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, '',
                   'ENCABEZADO', NULL, NULL, 'ERROR','CRED_CORP',
                   P_DET_CONCOM, 'AUTORIZACION', NULL, lst_estatus_orduni,
                   SYSDATE, 'ORDUNI2'
            FROM   XXMOR_SOLICITUDES_DET_TAB D,
                   XXMOR_SOLICITUDES_ENC_TAB E
            WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
            AND    E.ID_SOLICITUD = D.ID_SOLICITUD
            AND    ROWNUM         = 1
            AND    NOT EXISTS       (SELECT 1
                                     FROM   XXMOR_CONCOM_RPTA_TAB C
                                     WHERE  C.ID_SOLICITUD         = E.ID_SOLICITUD
                                     AND    C.NUMLINEA_CONCOM      IS NULL
                                     AND    UPPER(C.ACCION_CONCOM) = 'RECHAZO'
                                    )
            AND    NOT EXISTS       (SELECT 1
                                     FROM   XXMOR_CONCOM_RPTA_TAB C
                                     WHERE  C.ID_SOLICITUD    = E.ID_SOLICITUD
                                     AND    C.NUMLINEA_CONCOM IS NULL
                                     AND    C.CAMPO_CONCOM    = 'CRED_CORP'
                                    );
            COMMIT;
        END IF;
    END XXMOR_AUT_TM_SOBREP_PR;
    PROCEDURE XXMOR_AUT_ENV_CORREO_PR
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_MAIL_ADDRESS IN VARCHAR,
                                P_AUT_RECH     IN VARCHAR
                        ) IS
    /*
    Procedimiento para autorizar las ordenes de mercadotecnia
    */
    V_FLAG_AUTOM              PLS_INTEGER; --AUTORIZACION AUTOMATICA
    V_FLAG_MKT                PLS_INTEGER;
    V_MKT_MAIL_DIRECTOR       VARCHAR2(50);
    V_MKT_MAIL_GERENTE        VARCHAR2(50);
    V_MKT_MAIL_COORDINADOR    VARCHAR2(50);
    V_BUYUNIT                 VARCHAR2(50);
    V_RECHAZO                 PLS_INTEGER := 0;
    V_ID_FZA_VENTAS           PLS_INTEGER;
    V_REQ                     VARCHAR2(2000);
    V_LOC_PROC                VARCHAR2(3000);
    V_LINEAS                  VARCHAR2(2000);
    LST_ERROR                 VARCHAR2(500) := NULL;
    CURSOR BUYUNITS_CUR IS
    SELECT DISTINCT NVL(BUYUNTID,'NULO') AS BUYUNTID
    FROM  XXMOR_SOLICITUDES_DET_TAB
    WHERE ID_SOLICITUD = P_ID_SOLICITUD;
    CURSOR LINEAS_CUR IS
    SELECT DISTINCT
           D.LINEA
    FROM   XXMOR.XXMOR_SOLICITUDES_DET_TAB D,
           XXMOR.XXMOR_CONCOM_RPTA_TAB C
    WHERE  D.ID_SOLICITUD          = P_ID_SOLICITUD
    AND    C.ID_SOLICITUD          = D.ID_SOLICITUD
    AND    C.NUMLINEA_CONCOM       = D.LINEA
    AND    C.ESTATUS_ORDUNI        = '20'
    AND    C.ACCION_CONCOM         = 'AUTORIZACION'
    AND    C.CAMPO_CONCOM          = 'TARIFA_MANUAL'
    AND    INSTR(C.UPDATED_BY,'@') > 0;
    BEGIN
        IF P_AUT_RECH = 'AUTORIZAR' THEN
            UPDATE XXMOR.XXMOR_CONCOM_RPTA_TAB
            SET    ESTATUS_ORDUNI = '20',
                   UPDATED_BY     = SUBSTR(P_MAIL_ADDRESS,1,20),
                   UPDATED_DATE   = SYSDATE
            WHERE  ID_SOLICITUD   = P_ID_SOLICITUD
            AND    ACCION_CONCOM  = 'AUTORIZACION'
            AND    CAMPO_CONCOM   = 'TARIFA_MANUAL'
            AND    1              = (SELECT MERCADOTECNIA
                                     FROM   XXMOR.XXMOR_FZAS_VTAS_TAB
                                     WHERE  ID_FZA_VENTAS = (SELECT ID_FZA_VENTAS
                                                             FROM   XXMOR.XXMOR_SOLICITUDES_ENC_TAB
                                                             WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                                            )
                                    )
            AND    EXISTS           (SELECT 1
                                     FROM   XXMOR_SOLICITUDES_DET_TAB D,
                                            XXMOR_CAT_BUYUNIT_MKT_TAB BM
                                     WHERE  BM.ID_SEG_NEG    = 1
                                     AND    NVL(TRIM(D.BUYUNTID),'SIN BUYUNIT') = NVL(TRIM(BM.BUYUNTID),'SIN BUYUNIT')
                                     AND    D.ID_SOLICITUD   = P_ID_SOLICITUD
                                     AND    BM.ID_FZA_VENTAS = (SELECT E.ID_FZA_VENTAS
                                                                FROM   XXMOR_SOLICITUDES_ENC_TAB E
                                                                WHERE  E.ID_SOLICITUD = D.ID_SOLICITUD
                                                               )
                                     AND    (TRIM(UPPER(BM.MKT_GERENTE))     = TRIM(UPPER(P_MAIL_ADDRESS)) OR
                                             TRIM(UPPER(BM.MKT_COORDINADOR)) = TRIM(UPPER(P_MAIL_ADDRESS)) OR
                                             TRIM(UPPER(BM.MKT_DIRECTOR))    = TRIM(UPPER(P_MAIL_ADDRESS))
                                            )
                                    );
            --Se reprocesan las lineas aurorizadas
            FOR REN_LINEAS_CUR IN LINEAS_CUR LOOP
                V_LINEAS := V_LINEAS || TO_CHAR(REN_LINEAS_CUR.LINEA)||',';
                dbms_output.put_line('V_LINEAS: '||V_LINEAS);
            END LOOP;
            SELECT SUBSTR(V_LINEAS,1,LENGTH(V_LINEAS)-1)
            INTO   V_LINEAS
            FROM   DUAL;
            SELECT VALOR_PARAMETRO
            INTO   V_LOC_PROC
            FROM   XXMOR_CONF_PARAMS_GRLS_TAB
            WHERE  NOMBRE_PARAMETRO = 'EnvLineasAConcom';
            V_REQ := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:mor="http://xmlns.oracle.com/MOR_jws/MORBsRecibirSolicitudes/MORBsEnviarLineaAConCom">
                               <soapenv:Header/>
                               <soapenv:Body>
                                  <mor:process>
                                     <mor:idSolicitud>'||P_ID_SOLICITUD||'</mor:idSolicitud>
                                     <mor:lineas>'|| V_LINEAS ||'</mor:lineas>
                                  </mor:process>
                               </soapenv:Body>
                            </soapenv:Envelope>';
            XXMOR_CALL_WS_SP(V_REQ, V_LOC_PROC);
        ELSIF P_AUT_RECH = 'RECHAZAR' THEN
            INSERT INTO XXMOR_CONCOM_RPTA_TAB
                   ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID,   DESC_CONCOM,
                     POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                     DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                     CREATED_BY
                   )
            SELECT E.ID_SOLICITUD, ID_SEG_NEG, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                   'LINEA', NULL,LINEA, 'ERROR','SOBRECARGO',
                   'RECHAZO - La linea ha sido rechazada por Email/Tarifa Manual', 'RECHAZO', NULL, '10', SYSDATE,
                   SUBSTR(P_MAIL_ADDRESs,1,20)
            FROM   XXMOR_SOLICITUDES_DET_TAB d,
                   XXMOR_SOLICITUDES_ENC_TAB E
            WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
            AND    E.ID_SOLICITUD = D.ID_SOLICITUD
            AND    D.LINEA        IN (SELECT TO_NUMBER(NUMLINEA_CONCOM)
                                      FROM   XXMOR_CONCOM_RPTA_TAB
                                      WHERE  ID_SOLICITUD = D.ID_SOLICITUD
                                      AND    NUMLINEA_CONCOM IS NOT NULL
                                      AND    CAMPO_CONCOM = 'TARIFA_MANUAL'
                                     );
        ELSE
            NULL;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            LST_ERROR := SQLERRM;
            -- Se inserta en la tabla de errores el error encontrado
            INSERT INTO XXMOR_LOG_ERRORES_TAB
                        (
                                ID_ERROR,
                                DESC_ERROR,
                                ARCHIVO_ERROR,
                                METODO_ERROR,
                                HORA_ERROR
                        )
            VALUES      (       XXMOR.XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                'Error al Autorizar por correo la Orden: '||P_ID_SOLICITUD||': '||LST_ERROR,
                                'XXMOR_FUNCIONAL_PKG',
                                'XXMOR_AUT_ENV_CORREO_PR',
                                SYSDATE
                        );
    END XXMOR_AUT_ENV_CORREO_PR;
    --ESTE PROCEDIMIENTO SE USA EN BPEL
    PROCEDURE XXMOR_SEMANA_CONF_PR
                        (
                                P_IDENT_FZA_VENTAS IN  VARCHAR2,
                                P_DIA_INICIO       IN  VARCHAR2,
                                P_HORA_INICIO      IN  VARCHAR2,
                                P_DIA_FIN          IN  VARCHAR2,
                                P_HORA_FIN         IN  VARCHAR2,
                                O_ACTUALIZA        OUT INTEGER
                        ) IS
    V_SE_ACTUALIZA  INTEGER;
    V_ID_FZA_VTAS   INTEGER;
    BEGIN
        SELECT ID_FZA_VENTAS
        INTO   V_ID_FZA_VTAS
        FROM   XXMOR_FZAS_VTAS_TAB FV
        WHERE  FV.IDENT_FZA_VENTAS = P_IDENT_FZA_VENTAS;
        UPDATE XXMOR_CONCOM_RPTA_TAB R
        SET    ESTATUS_ORDUNI = '20',
               UPDATED_DATE   = SYSDATE,
               UPDATED_BY     = 'SEMANA_CONF_PR'
        WHERE  INSTR(UPPER(ACCION_CONCOM),UPPER('RETENCION')) > 0
        AND    R.ESTATUS_ORDUNI = '10'
        AND    EXISTS             (SELECT 1
                                   FROM   XXMOR_SOLICITUDES_ENC_TAB E
                                   WHERE  R.ID_SOLICITUD  = E.ID_SOLICITUD
                                   AND    E.ID_FZA_VENTAS = V_ID_FZA_VTAS
                                  );
    END XXMOR_SEMANA_CONF_PR;
    PROCEDURE XXMOR_GENERAORDENES_PR
                        (
                                P_ID_REQUEST_AUX IN NUMBER
                        ) IS
    V_MCONTID             VARCHAR2(30);
    V_MCONTID_CI          VARCHAR2(30);
    V_MUL_FZAS            NUMBER(2);
    V_CUTIN               NUMBER(2);
    V_FACTURABLE          VARCHAR(12);
    V_AGRUPADOR           VARCHAR(30);
    V_REGION              VARCHAR2(2);
    V_SUFIJO              VARCHAR2(2);
    V_SEGNEG              NUMBER(2);
    V_REQUEST_AUX         INTEGER;
    P_ID_REQUEST          INTEGER;
    V_ID_SOLICITUD_TEMP   INTEGER;
    V_TEMP                NUMBER(30);
    V_AGRUPA              INTEGER;
    V_EXISTE              INTEGER;
    V_USRCHR              VARCHAR2(5);
    V_SPTCHR              VARCHAR2(5);
    V_DESC_T_SERV         VARCHAR2(50);
    V_TIPO_SERVICIO       VARCHAR2(100);
    V_AUX                 VARCHAR2(100);
    V_MC_ING_CUTIN        VARCHAR(30);      --<-- EL MASTERCONTRACT DE LA DERECHA
    V_SPT_5               PLS_INTEGER:=0;
    V_SPT_1               PLS_INTEGER:=0;
    V_PREFIJO_STNID       VARCHAR(5);       --<HASTA ACA CON MCONTID DE LA DERECHA
    V_RTCRD               VARCHAR(50);      --> PARA GEN AUT TARIFA MANUAL SIN RTCRD
    --V_ORD_MKT               PLS_INTEGER;
    V_SOLICITUD_ENC       XXMOR_FUNCIONAL_PKG.Mor_Enc_Rec_Type;
    V_ID_SOLICITUD_NAL    NUMBER;
    V_ID_SOLICITUD_PROV   NUMBER;
    lst_nom_archivo       VARCHAR2(150);
    lst_inserta           VARCHAR2(1);
    lst_orden_mcing       VARCHAR2(1);
    lst_orden_mc          VARCHAR2(1);
    lin_NumRegs_Orig      NUMBER := 0;
    lin_NumRegs_Det       NUMBER := 0;
    CURSOR ORDENES IS
    SELECT ID_REQUEST
    FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
    WHERE  AUX1 = P_ID_REQUEST_AUX;
    CURSOR CUR_PREFIJOS(P_I_ID_REQUEST INTEGER) IS
    SELECT PREFIJO_CANAL,
           AGRUPADOR_MULTIPLE
    FROM   XXMOR_CAT_AGRUPADOR_MULT_TAB
    WHERE  AGRUPADOR_MULTIPLE = (SELECT TRIM(PLATAFORMA_CANAL)
                                 FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                 WHERE  ID_REQUEST = P_I_ID_REQUEST
                                );
    BEGIN
        OPEN ORDENES;
        LOOP
        FETCH ORDENES INTO P_ID_REQUEST;
        EXIT WHEN ORDENES%NOTFOUND;
            SELECT TRIM(OE.MCONTID),
                   TRIM(OE.MCONTID_CUTIN),
                   TRIM(OE.PLATAFORMA_CANAL),
                   TRIM(OE.ID_SEG_NEG),
                   (SELECT SA.NOM_ARCHIVO_SOL
                    FROM   XXMOR_SOLICITUDES_ARCH_TAB SA
                    WHERE  SA.ID_SEG_NEG     = 1
                    AND    SA.ID_ARCHIVO_SOL = OE.ID_ARCHIVO_SOL
                   )
            INTO   V_MCONTID,
                   V_MCONTID_CI,
                   V_AGRUPADOR,
                   V_SEGNEG,
                   lst_nom_archivo
            FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB OE
            WHERE  OE.ID_REQUEST = P_ID_REQUEST;
            lst_inserta := NULL;
            BEGIN
                --Para identificar la fza de ventas, solo se utiliza el tipo de servicio de la primera orden
                SELECT RTRIM(TIPO_SERVICIO)
                INTO   V_TIPO_SERVICIO
                FROM   XXMOR.XXMOR_SOLICITUDES_ORIG_DET_TAB
                WHERE  ID_REQUEST    = P_ID_REQUEST
                AND    LINEA_REQUEST = 1;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    lst_inserta := 'N';
                    V_TIPO_SERVICIO := NULL;
                WHEN OTHERS THEN
                    V_TIPO_SERVICIO := 'NA';
            END;
            IF LENGTH(V_TIPO_SERVICIO) = 2 THEN
                lst_inserta := 'Y';
                BEGIN
                    SELECT USR_CHR,
                           SPT_CHR,
                           DESC_TIPO_SERVICIO
                    INTO   V_USRCHR,
                           V_SPTCHR,
                           V_TIPO_SERVICIO
                    FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                    WHERE  NVL(USR_CHR,' ') = SUBSTR(V_TIPO_SERVICIO,1,1)
                    AND    SPT_CHR          = SUBSTR(V_TIPO_SERVICIO,2,1);
                EXCEPTION
                    WHEN OTHERS THEN
                        V_USRCHR := 'XX';
                        V_SPTCHR := 'XX';
                        -- Se inserta en la tabla de errores el error encontrado
                        INSERT INTO XXMOR_LOG_ERRORES_TAB
                                    (
                                            ID_ERROR,
                                            DESC_ERROR,
                                            ARCHIVO_ERROR,
                                            METODO_ERROR,
                                            HORA_ERROR
                                    )
                        VALUES      (       XXMOR.XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                            'Error al procesar el archivo: '||lst_nom_archivo||', El Valor del Campo Tipo de Servicio '||V_TIPO_SERVICIO||' No es Valido',
                                            'XXMOR_FUNCIONAL_PKG',
                                            'XXMOR_GENERAORDENES_PR',
                                            SYSDATE
                                    );
                END;
                dbms_output.put_line(' -> USR_CHR' ||' ->'|| V_USRCHR||'<-'  );
                dbms_output.put_line(' -> V_SPTCHR ' ||' ->'|| V_SPTCHR||'<-'  );
                IF V_USRCHR != 'XX' AND V_SPTCHR != 'XX' THEN
                    --PONEMOS LA DESCRIPCION DEL SERVICIO QUE REPRESENTAN SPOT-USR CHR
                    SELECT DESC_TIPO_SERVICIO
                    INTO   V_DESC_T_SERV
                    FROM   XXMOR_CAT_TIPO_SERV_TAB
                    WHERE  NVL(USR_CHR,' ') = NVL(V_USRCHR,' ')
                    AND    NVL(SPT_CHR,' ') = V_SPTCHR;
                END IF;
            ELSIF LENGTH(V_TIPO_SERVICIO) > 0 THEN
                lst_inserta := 'Y';
                BEGIN
                    SELECT SPT_CHR,
                           USR_CHR
                    INTO   V_SPTCHR,
                           V_USRCHR
                    FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                    WHERE  UPPER(DESC_TIPO_SERVICIO) = UPPER(V_TIPO_SERVICIO);
                EXCEPTION
                    WHEN OTHERS THEN
                        V_USRCHR := 'XX';
                        V_SPTCHR := 'XX';
                        -- Se inserta en la tabla de errores el error encontrado
                        INSERT INTO XXMOR_LOG_ERRORES_TAB
                                    (
                                            ID_ERROR,
                                            DESC_ERROR,
                                            ARCHIVO_ERROR,
                                            METODO_ERROR,
                                            HORA_ERROR
                                    )
                        VALUES      (       XXMOR.XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                            'Error al procesar el archivo: '||lst_nom_archivo||', El Valor del Campo Tipo de Servicio '||V_TIPO_SERVICIO||' No es Valido',
                                            'XXMOR_FUNCIONAL_PKG',
                                            'XXMOR_GENERAORDENES_PR',
                                            SYSDATE
                                    );
                END;
            END IF;
            dbms_output.put_line(' -> '|| P_ID_REQUEST ||' -> '|| V_AGRUPADOR  );
            IF lst_inserta = 'Y' THEN
                -- Si las ordenes ingresadas no son de television insertar como vienen
                IF V_SegNeg != 1 THEN
                    dbms_output.put_line('La orden no es de television [entonces no la tomamos en cuenta]');
                    INSERT INTO XXMOR_SOLICITUDES_ENC_TAB
                           ( ID_SOLICITUD, ID_REQUEST, ID_SEG_NEG,
                             PROC_POR_LINEA, GARANTIZADO, ADVID,
                             MCONTID, MCONTID_CUTIN, EMAIL,
                             AGYESTNUM, ACCTHDRID, RTCRDDSCR,
                             RTCRDDSCR_CUTIN, COMENTARIOS, PLATAFORMA_CANAL,
                             PRDID_DESC, TOTAL_SPOTS, TOTAL_SIN_DESC,
                             TOTAL_CON_DESC, TIPO_FACTURACION, DESCUENTO,
                             TARGET, CREATED_BY
                           )
                    SELECT XXMOR_ID_SOLICITUD_SQ.NEXTVAL, ID_REQUEST, ID_SEG_NEG,
                           PROC_POR_LINEA, GARANTIZADO, ADVID,
                           MCONTID, MCONTID_CUTIN, EMAIL,
                           AGYESTNUM, ACCTHDRID, RTCRDDSCR,
                           RTCRDDSCR_CUTIN, COMENTARIOS, PLATAFORMA_CANAL,
                           PRDID_DESC, TOTAL_SPOTS, TOTAL_SIN_DESC,
                           TOTAL_CON_DESC, TIPO_FACTURACION, DESCUENTO,
                           TARGET, CREATED_BY
                    FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                    WHERE  ID_REQUEST = P_ID_REQUEST;
                    INSERT INTO XXMOR_SOLICITUDES_DET_TAB
                           ( ID_SOLICITUD, LINEA, STNID,
                             FECHA_INICIO, FECHA_FIN, DURACION,
                             BUYUNTID, HORA_INICIO, HORA_FIN,
                             SPOTS, LUNES, MARTES, MIERCOLES,
                             JUEVES, VIERNES, SABADO, DOMINGO,
                             SPOTS_X_SEMANA, TIPO_SERVICIO, BN,
                             P, MARCA, VERSION, TARIFASP_SIN_DESC,
                             TARIFASP_CON_DESC, TOT_LINEA_SIN_DESC,
                             TOT_LINEA_CON_DESC, SOBRECARGO,
                             OBSERVACIONES, DES_PLATAFORMA, CREATED_BY
                           )
                    SELECT XXMOR_ID_SOLICITUD_SQ.CURRVAL, NVL(LINEA_REQUEST,XXMOR_LINEA_SOLICITUD_SQ.NEXTVAL), STNID,
                           FECHA_INICIO, FECHA_FIN, DURACION,
                           BUYUNTID, HORA_INICIO, HORA_FIN,
                           SPOTS, LUNES, MARTES, MIERCOLES,
                           JUEVES, VIERNES, SABADO, DOMINGO,
                           SPOTS_X_SEMANA, TIPO_SERVICIO, BN,
                           P, MARCA, VERSION, TARIFASP_SIN_DESC,
                           TARIFASP_CON_DESC, TOT_LINEA_SIN_DESC,
                           TOT_LINEA_CON_DESC, INITCAP(SOBRECARGO),
                           OBSERVACIONES, DES_PLATAFORMA,
                           (SELECT CREATED_BY
                            FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                            WHERE  ID_REQUEST = P_ID_REQUEST
                           )
                    FROM   XXMOR_SOLICITUDES_ORIG_DET_TAB
                    WHERE  ID_REQUEST = P_ID_REQUEST;
                ELSE -- V_SegNeg != 1
                    --Revisamos q el agrupador no genere mas de una orden
                    SELECT COUNT(1)
                    INTO   V_EXISTE
                    FROM   XXMOR_CAT_AGRUPADOR_MULT_TAB
                    WHERE  AGRUPADOR_MULTIPLE = (SELECT TRIM(PLATAFORMA_CANAL)
                                                 FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                                 WHERE  ID_REQUEST = P_ID_REQUEST
                                                );
                    IF V_sptchr = '5' OR V_sptchr = '1' THEN
                        lst_orden_mc     := 'N';
                        lst_orden_mcing  := 'N';
                        lin_NumRegs_Orig := 0;
                        lin_NumRegs_Det  := 0;
                        BEGIN
                           SELECT TRIM(MCONTID_CUTIN)
                           INTO   V_MC_ING_CUTIN
                           FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                           WHERE  ID_REQUEST = P_ID_REQUEST;
                           --Para el prefijo que tenemos que concatenar al canal
                           SELECT PREFIJO_CANAL
                           INTO   V_PREFIJO_STNID
                           FROM   XXMOR_CAT_AGRUPADOR_MULT_TAB
                           WHERE  AGRUPADOR_MULTIPLE = (SELECT TRIM(PLATAFORMA_CANAL)
                                                        FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                                        WHERE  ID_REQUEST = P_ID_REQUEST
                                                       );
                        EXCEPTION WHEN OTHERS THEN
                            V_PREFIJO_STNID:='';
                        END;
                        --REVISAMOS QUE TRAIGA LINEAS el spot characteristic = 1
                        SELECT COUNT(1)
                        INTO   V_SPT_1
                        FROM   XXMOR_SOLICITUDES_ORIG_DET_TAB D
                        WHERE  ID_REQUEST = P_ID_REQUEST
                        AND    CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                   SUBSTR(TIPO_SERVICIO,2,1)
                               ELSE
                                   (SELECT SPT_CHR
                                    FROM XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                    WHERE DESC_TIPO_SERVICIO = D.TIPO_SERVICIO
                                   )
                               END = 1;
                        --PARA GENERAR LA ORDEN DEL MASTERCONTRACT DE INGRESOS/CUTIN (EL DE LA DERECHA)
                        dbms_output.put_line('V_MC_ING_CUTIN: '||V_MC_ING_CUTIN );
                        dbms_output.put_line('V_SPT_1: '||V_SPT_1 );
                        IF (V_MC_ING_CUTIN IS NOT NULL) AND (V_SPT_1 > 0) THEN
                            INSERT INTO XXMOR_SOLICITUDES_ENC_TAB
                                   ( ID_SOLICITUD, ID_REQUEST, ID_SEG_NEG,
                                     PROC_POR_LINEA, GARANTIZADO, ADVID,
                                     MCONTID, MCONTID_CUTIN, EMAIL,
                                     AGYESTNUM, ACCTHDRID, RTCRDDSCR,
                                     RTCRDDSCR_CUTIN, COMENTARIOS, PLATAFORMA_CANAL,
                                     PRDID_DESC, TOTAL_SPOTS, TOTAL_SIN_DESC,
                                     TOTAL_CON_DESC, TIPO_FACTURACION, DESCUENTO,
                                     TARGET, CREATED_BY,ID_FZA_VENTAS, ORDEN_ESTATUS
                                   )
                            SELECT XXMOR_ID_SOLICITUD_SQ.NEXTVAL, ID_REQUEST, ID_SEG_NEG,
                                   TRIM(PROC_POR_LINEA), TRIM(DECODE(NVL(GARANTIZADO,'0'),'0','0','1')), TRIM(ADVID),
                                   TRIM(MCONTID_CUTIN), NULL, TRIM(EMAIL),
                                   TRIM(AGYESTNUM), TRIM(ACCTHDRID), TRIM(RTCRDDSCR),
                                   TRIM(RTCRDDSCR_CUTIN), SUBSTR(TRIM(COMENTARIOS),1,132), TRIM(PLATAFORMA_CANAL),
                                   TRIM(PRDID_DESC), TRIM(TOTAL_SPOTS), TRIM(TOTAL_SIN_DESC),
                                   TRIM(TOTAL_CON_DESC), TRIM(TIPO_FACTURACION), TRIM(DESCUENTO),
                                   TRIM(TARGET), CREATED_BY, NULL, 10
                            FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                            WHERE  ID_REQUEST = P_ID_REQUEST;
                            INSERT INTO XXMOR_SOLICITUDES_DET_TAB
                                   ( ID_SOLICITUD, LINEA, STNID,
                                     FECHA_INICIO, FECHA_FIN, DURACION,
                                     BUYUNTID, HORA_INICIO, HORA_FIN,
                                     SPOTS, LUNES, MARTES, MIERCOLES,
                                     JUEVES, VIERNES, SABADO, DOMINGO,
                                     SPOTS_X_SEMANA, TIPO_SERVICIO, USR_CHR,
                                     SPOT_CHR, BN, P, MARCA, VERSION,
                                     TARIFASP_SIN_DESC, TARIFASP_CON_DESC,
                                     TOT_LINEA_SIN_DESC, TOT_LINEA_CON_DESC,
                                     SOBRECARGO, OBSERVACIONES, DES_PLATAFORMA,
                                     LINEA_ESTATUS, CREATED_BY
                                   )
                            SELECT XXMOR_ID_SOLICITUD_SQ.CURRVAL, ROW_NUMBER() OVER (ORDER BY LINEA_REQUEST) NUM_LINEA, V_PREFIJO_STNID||NVL(TRIM(STNID),V_AGRUPADOR),
                                   TRIM(FECHA_INICIO), TRIM(FECHA_FIN), TRIM(DURACION),
                                   TRIM(BUYUNTID), TRIM(HORA_INICIO), TRIM(HORA_FIN),
                                   TRIM(SPOTS), TRIM(LUNES), TRIM(MARTES), TRIM(MIERCOLES),
                                   TRIM(JUEVES), TRIM(VIERNES), TRIM(SABADO), TRIM(DOMINGO),
                                   NVL(SPOTS_X_SEMANA,TO_NUMBER(NVL(TRIM(lunes),0))+TO_NUMBER(NVL(TRIM(martes),0))+TO_NUMBER(NVL(TRIM(miercoles),0))+TO_NUMBER(NVL(TRIM(jueves),0))+TO_NUMBER(NVL(TRIM(viernes),0))+TO_NUMBER(NVL(TRIM(sabado),0))+TO_NUMBER(NVL(TRIM(domingo),0))),
                                   CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                       (SELECT DESC_TIPO_SERVICIO
                                        FROM   XXMOR_CAT_TIPO_SERV_TAB
                                        WHERE  SPT_CHR           = SUBSTR(TIPO_SERVICIO,2,1)
                                        AND    NVL(USR_CHR, ' ') = SUBSTR(TIPO_SERVICIO,1,1)
                                       )
                                   ELSE
                                       CASE WHEN (SELECT COUNT(1)
                                                  FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                  WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                 ) > 0 THEN
                                           UPPER(TIPO_SERVICIO)
                                       ELSE
                                           'NO APLICA'
                                       END
                                   END AS TIPO_SERVICIO,
                                   CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                       SUBSTR(TIPO_SERVICIO,1,1)
                                   ELSE
                                       CASE WHEN (SELECT COUNT(1)
                                                  FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                  WHERE  DESC_TIPO_SERVICIO = TIPO_SERVICIO
                                                 ) > 0 THEN
                                           (SELECT USR_CHR
                                            FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                           )
                                       ELSE
                                           (SELECT USR_CHR
                                            FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                           )
                                       END
                                   END USRCHR,
                                   CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                       SUBSTR(TIPO_SERVICIO,2,1)
                                   ELSE
                                       CASE WHEN (SELECT COUNT(1)
                                                  FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                  WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                 ) > 0 THEN
                                           (SELECT SPT_CHR
                                            FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                           )
                                       ELSE
                                           (SELECT SPT_CHR
                                            FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                           )
                                       END
                                   END SPTCHR,
                                   TRIM(BN), TRIM(P), TRIM(MARCA), TRIM(VERSION), --NVL(TRIM(VERSION),'VER PAUTA'),SE QUITO PARA LAS ORDENES DE MERCA VERSION VIRTUAL
                                   TRIM(TARIFASP_SIN_DESC), TRIM(TARIFASP_CON_DESC),
                                   TRIM(TOT_LINEA_SIN_DESC), TRIM(TOT_LINEA_CON_DESC),
                                   TRIM(INITCAP(SOBRECARGO)), TRIM(OBSERVACIONES),
                                   TRIM(DES_PLATAFORMA), 10,
                                   (SELECT TRIM(CREATED_BY)
                                    FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                    WHERE  ID_REQUEST = P_ID_REQUEST
                                   )
                            FROM   XXMOR_SOLICITUDES_ORIG_DET_TAB
                            WHERE  ID_REQUEST = P_ID_REQUEST
                            AND    CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                       SUBSTR(TIPO_SERVICIO,2,1)
                                   ELSE
                                       (SELECT SPT_CHR
                                        FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                        WHERE  DESC_TIPO_SERVICIO = TIPO_SERVICIO
                                       )
                                   END = 1;
                            lst_orden_mcing := 'Y';
                        ELSE -- NO SE GENERA LA ORDEN DEL MASTERCONTRACT DE INGRESOS/CUTIN
                            lst_orden_mcing := 'N';
                            -- SE ENVIA LA NOTIFICACION DE QUE NO SE PUDO GENERAR LA ORDEN
                            XXMOR_FUNCIONAL_PKG.XXMOR_NOTIFICA_FVTAS_MERCA_PR
                                               (
                                                       'MERCA',
                                                       0,
                                                       P_ID_REQUEST
                                               );
                        END IF;
                        --PARA VER SI SE GENERA LA ORDEN DEL MASTER CONTRACT (de la izquierda)
                        SELECT COUNT(1)
                        INTO   V_SPT_5
                        FROM   XXMOR_SOLICITUDES_ORIG_DET_TAB D
                        WHERE  ID_REQUEST = P_ID_REQUEST
                        AND    CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                   SUBSTR(TIPO_SERVICIO,2,1)
                               ELSE
                                   (SELECT SPT_CHR
                                    FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                    WHERE  DESC_TIPO_SERVICIO = UPPER(D.TIPO_SERVICIO)
                                   )
                               END = 5;
                        dbms_output.put_line('v_MCONTID: '||v_MCONTID );
                        dbms_output.put_line('V_SPT_5: '||V_SPT_5 );
                        IF (v_MCONTID IS NOT NULL) AND (V_SPT_5 > 0) THEN
                            INSERT INTO XXMOR_SOLICITUDES_ENC_TAB
                                   ( ID_SOLICITUD, ID_REQUEST, ID_SEG_NEG,
                                     PROC_POR_LINEA, GARANTIZADO, ADVID,
                                     MCONTID, MCONTID_CUTIN, EMAIL,
                                     AGYESTNUM, ACCTHDRID, RTCRDDSCR,
                                     RTCRDDSCR_CUTIN, COMENTARIOS, PLATAFORMA_CANAL,
                                     PRDID_DESC, TOTAL_SPOTS, TOTAL_SIN_DESC,
                                     TOTAL_CON_DESC, TIPO_FACTURACION, DESCUENTO,
                                     TARGET, CREATED_BY, ID_FZA_VENTAS, ORDEN_ESTATUS
                                   )
                            SELECT XXMOR_ID_SOLICITUD_SQ.NEXTVAL, ID_REQUEST, ID_SEG_NEG,
                                   TRIM(PROC_POR_LINEA), TRIM(DECODE(NVL(GARANTIZADO,'0'),'0','0','1')), TRIM(ADVID),
                                   TRIM(MCONTID), NULL, TRIM(EMAIL),
                                   TRIM(AGYESTNUM), TRIM(ACCTHDRID), TRIM(RTCRDDSCR),
                                   TRIM(RTCRDDSCR_CUTIN), SUBSTR(TRIM(COMENTARIOS),1,132), TRIM(PLATAFORMA_CANAL),
                                   TRIM(PRDID_DESC), TRIM(TOTAL_SPOTS), TRIM(TOTAL_SIN_DESC),
                                   TRIM(TOTAL_CON_DESC), TRIM(TIPO_FACTURACION), TRIM(DESCUENTO),
                                   TRIM(TARGET), CREATED_BY, NULL, 10
                            FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                            WHERE  ID_REQUEST = P_ID_REQUEST;
                            INSERT INTO XXMOR_SOLICITUDES_DET_TAB
                                   ( ID_SOLICITUD, LINEA, STNID,
                                     FECHA_INICIO, FECHA_FIN, DURACION,
                                     BUYUNTID, HORA_INICIO, HORA_FIN,
                                     SPOTS, LUNES, MARTES, MIERCOLES,
                                     JUEVES, VIERNES, SABADO, DOMINGO,
                                     SPOTS_X_SEMANA, TIPO_SERVICIO, USR_CHR,
                                     SPOT_CHR, BN, P, MARCA, VERSION,
                                     TARIFASP_SIN_DESC, TARIFASP_CON_DESC,
                                     TOT_LINEA_SIN_DESC, TOT_LINEA_CON_DESC,
                                     SOBRECARGO, OBSERVACIONES, DES_PLATAFORMA,
                                     LINEA_ESTATUS, CREATED_BY
                                   )
                            SELECT XXMOR_ID_SOLICITUD_SQ.CURRVAL, ROW_NUMBER() OVER (ORDER BY LINEA_REQUEST) NUM_LINEA, V_PREFIJO_STNID||NVL(TRIM(STNID),V_AGRUPADOR),
                                   TRIM(FECHA_INICIO), TRIM(FECHA_FIN), TRIM(DURACION),
                                   TRIM(BUYUNTID), TRIM(HORA_INICIO), TRIM(HORA_FIN),
                                   TRIM(SPOTS), TRIM(LUNES), TRIM(MARTES), TRIM(MIERCOLES),
                                   TRIM(JUEVES), TRIM(VIERNES), TRIM(SABADO), TRIM(DOMINGO),
                                   NVL(SPOTS_X_SEMANA,TO_NUMBER(NVL(TRIM(lunes),0))+TO_NUMBER(NVL(TRIM(martes),0))+TO_NUMBER(NVL(TRIM(miercoles),0))+TO_NUMBER(NVL(TRIM(jueves),0))+TO_NUMBER(NVL(TRIM(viernes),0))+TO_NUMBER(NVL(TRIM(sabado),0))+TO_NUMBER(NVL(TRIM(domingo),0))),
                                   CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                       (SELECT DESC_TIPO_SERVICIO
                                        FROM   XXMOR_CAT_TIPO_SERV_TAB
                                        WHERE  SPT_CHR           = SUBSTR(TIPO_SERVICIO,2,1)
                                        AND    NVL(USR_CHR, ' ') = SUBSTR(TIPO_SERVICIO,1,1)
                                       )
                                   ELSE
                                       CASE WHEN (SELECT COUNT(1)
                                                  FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                  WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                 ) > 0 THEN
                                           UPPER(TIPO_SERVICIO)
                                       ELSE
                                           'NO APLICA'
                                       END
                                   END AS TIPO_SERVICIO,
                                   CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                       SUBSTR(TIPO_SERVICIO,1,1)
                                   ELSE
                                       CASE WHEN (SELECT COUNT(1)
                                                  FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                  WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                 ) > 0 THEN
                                           (SELECT USR_CHR
                                            FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                           )
                                       ELSE
                                           (SELECT USR_CHR
                                            FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                           )
                                       END
                                   END USRCHR,
                                   CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                       SUBSTR(TIPO_SERVICIO,2,1)
                                   ELSE
                                       CASE WHEN (SELECT COUNT(1)
                                                  FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                  WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                 ) > 0 THEN
                                           (SELECT SPT_CHR
                                            FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                           )
                                       ELSE
                                           (SELECT SPT_CHR
                                            FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                           )
                                       END
                                   END SPTCHR,
                                   TRIM(BN), TRIM(P), TRIM(MARCA), TRIM(VERSION), --NVL(TRIM(VERSION),'VER PAUTA'),SE QUITO PARA LAS ORDENES DE MERCA VERSION VIRTUAL
                                   TRIM(TARIFASP_SIN_DESC), TRIM(TARIFASP_CON_DESC),
                                   TRIM(TOT_LINEA_SIN_DESC), TRIM(TOT_LINEA_CON_DESC),
                                   TRIM(INITCAP(SOBRECARGO)), TRIM(OBSERVACIONES),
                                   TRIM(DES_PLATAFORMA), 10,
                                   (SELECT TRIM(CREATED_BY)
                                    FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                    WHERE  ID_REQUEST = P_ID_REQUEST
                                   )
                            FROM   XXMOR_SOLICITUDES_ORIG_DET_TAB
                            WHERE  ID_REQUEST = P_ID_REQUEST
                            AND    CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                       SUBSTR(TIPO_SERVICIO,2,1)
                                   ELSE
                                       (SELECT SPT_CHR
                                        FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                        WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                       )
                                   END = 5;
                            lst_orden_mc := 'Y';
                        ELSE -- NO SE GENERA LA ORDEN LA ORDEN DEL MASTER CONTRACT (de la izquierda)
                            lst_orden_mc := 'N';
                            -- SE ENVIA LA NOTIFICACION DE QUE NO SE PUDO GENERAR LA ORDEN
                            XXMOR_FUNCIONAL_PKG.XXMOR_NOTIFICA_FVTAS_MERCA_PR
                                               (
                                                       'MERCA',
                                                       1,
                                                       P_ID_REQUEST
                                               );
                        END IF;
                        -- SE VALIDA SI ES QUE SE GENERARON LAS 2 ORDENES Y EL NUMERO DE REGISTROS
                        -- ES EL MISMO QUE LOS QUE VENIAN EN EL ARCHIVO.
                        IF lst_orden_mc = 'Y' AND lst_orden_mcing = 'Y' THEN
                            SELECT COUNT(1)
                            INTO   lin_NumRegs_Orig
                            FROM   XXMOR_SOLICITUDES_ORIG_DET_TAB
                            WHERE  ID_REQUEST = P_ID_REQUEST;
                            SELECT COUNT(1)
                            INTO   lin_NumRegs_Det
                            FROM   XXMOR_SOLICITUDES_DET_TAB SD
                            WHERE  EXISTS (SELECT 1
                                           FROM   XXMOR_SOLICITUDES_ENC_TAB SE
                                           WHERE  SE.ID_SOLICITUD = SD.ID_SOLICITUD
                                           AND    SE.ID_REQUEST   = P_ID_REQUEST
                                          );
                            IF lin_NumRegs_Orig > 0 AND lin_NumRegs_Det > 0 THEN
                                IF lin_NumRegs_Orig != lin_NumRegs_Det THEN
                                    -- SE ENVIA LA NOTIFICACION DE QUE LAS ORDENES ESTAN INCOMPLETAS
                                    XXMOR_FUNCIONAL_PKG.XXMOR_NOTIFICA_FVTAS_MERCA_PR
                                                       (
                                                               'MERCA',
                                                               2,
                                                               P_ID_REQUEST
                                                       );
                                END IF;
                            END IF;
                        END IF;
                    ELSE -- V_sptchr = '5' OR V_sptchr = '1'
                        IF V_Existe = 0 THEN
                            IF V_Agrupador != 'CUTIN' THEN
                                dbms_output.put_line('La orden no es de multiOrden ni CUTIN');
                                --generamos el id_solicitud
                                SELECT XXMOR_ID_SOLICITUD_SQ.NEXTVAL
                                INTO   V_ID_SOLICITUD_TEMP
                                FROM   DUAL;
                                INSERT INTO XXMOR_SOLICITUDES_ENC_TAB
                                       ( ID_SOLICITUD, ID_REQUEST, ID_SEG_NEG,
                                         PROC_POR_LINEA, GARANTIZADO, ADVID,
                                         MCONTID, MCONTID_CUTIN, EMAIL,
                                         AGYESTNUM, ACCTHDRID, RTCRDDSCR,
                                         RTCRDDSCR_CUTIN, COMENTARIOS, PLATAFORMA_CANAL,
                                         PRDID_DESC, TOTAL_SPOTS, TOTAL_SIN_DESC,
                                         TOTAL_CON_DESC, TIPO_FACTURACION, DESCUENTO,
                                         TARGET, CREATED_BY, ID_FZA_VENTAS, ORDEN_ESTATUS
                                       )
                                SELECT V_ID_SOLICITUD_TEMP, ID_REQUEST, ID_SEG_NEG,
                                       TRIM(PROC_POR_LINEA), TRIM(DECODE(NVL(GARANTIZADO,'0'),'0','0','1')), TRIM(ADVID),
                                       TRIM(MCONTID), TRIM(MCONTID_CUTIN), TRIM(EMAIL),
                                       TRIM(AGYESTNUM), TRIM(ACCTHDRID), TRIM(RTCRDDSCR),
                                       TRIM(RTCRDDSCR_CUTIN), SUBSTR(TRIM(COMENTARIOS),1,132), TRIM(PLATAFORMA_CANAL)||DECODE(V_SPTCHR,'XX','-ERTS'),
                                       TRIM(PRDID_DESC), TRIM(TOTAL_SPOTS), TRIM(TOTAL_SIN_DESC),
                                       TRIM(TOTAL_CON_DESC), TRIM(TIPO_FACTURACION), TRIM(DESCUENTO),
                                       TRIM(TARGET), CREATED_BY, NULL, 10
                                FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                WHERE  ID_REQUEST = P_ID_REQUEST;
                                INSERT INTO XXMOR_SOLICITUDES_DET_TAB
                                       ( ID_SOLICITUD, LINEA, STNID,
                                         FECHA_INICIO, FECHA_FIN, DURACION,
                                         BUYUNTID, HORA_INICIO, HORA_FIN,
                                         SPOTS, LUNES, MARTES, MIERCOLES,
                                         JUEVES, VIERNES, SABADO, DOMINGO,
                                         SPOTS_X_SEMANA, TIPO_SERVICIO, USR_CHR,
                                         SPOT_CHR, BN, P, MARCA, VERSION,
                                         TARIFASP_SIN_DESC, TARIFASP_CON_DESC,
                                         TOT_LINEA_SIN_DESC, TOT_LINEA_CON_DESC,
                                         SOBRECARGO, OBSERVACIONES, DES_PLATAFORMA,
                                         LINEA_ESTATUS, CREATED_BY
                                       )
                                SELECT XXMOR_ID_SOLICITUD_SQ.CURRVAL, ROW_NUMBER() OVER (ORDER BY LINEA_REQUEST) NUM_LINEA, NVL(TRIM(STNID),V_AGRUPADOR),
                                       TRIM(FECHA_INICIO), TRIM(FECHA_FIN), TRIM(DURACION),
                                       TRIM(BUYUNTID), TRIM(HORA_INICIO), TRIM(HORA_FIN),
                                       TRIM(SPOTS), TRIM(LUNES), TRIM(MARTES), TRIM(MIERCOLES),
                                       TRIM(JUEVES), TRIM(VIERNES), TRIM(SABADO), TRIM(DOMINGO),
                                       NVL(SPOTS_X_SEMANA,TO_NUMBER(NVL(TRIM(lunes),0))+TO_NUMBER(NVL(TRIM(martes),0))+TO_NUMBER(NVL(TRIM(miercoles),0))+TO_NUMBER(NVL(TRIM(jueves),0))+TO_NUMBER(NVL(TRIM(viernes),0))+TO_NUMBER(NVL(TRIM(sabado),0))+TO_NUMBER(NVL(TRIM(domingo),0))),
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           (SELECT DESC_TIPO_SERVICIO
                                            FROM   XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  SPT_CHR           = SUBSTR(TIPO_SERVICIO,2,1)
                                            AND    NVL(USR_CHR, ' ') = SUBSTR(TIPO_SERVICIO,1,1)
                                           )
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               UPPER(TIPO_SERVICIO)
                                           ELSE
                                               'NO APLICA'
                                           END
                                       END AS TIPO_SERVICIO,
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           SUBSTR(TIPO_SERVICIO,1,1)
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               (SELECT USR_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                               )
                                           ELSE
                                               (SELECT USR_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                               )
                                           END
                                       END USRCHR,
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           SUBSTR(TIPO_SERVICIO,2,1)
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               (SELECT SPT_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                               )
                                           ELSE
                                               (SELECT SPT_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                               )
                                           END
                                       END SPTCHR,
                                       TRIM(BN), TRIM(P), TRIM(MARCA), NVL(TRIM(VERSION),'VER PAUTA'),
                                       TRIM(TARIFASP_SIN_DESC), TRIM(TARIFASP_CON_DESC),
                                       TRIM(TOT_LINEA_SIN_DESC), TRIM(TOT_LINEA_CON_DESC),
                                       TRIM(INITCAP(SOBRECARGO)), TRIM(OBSERVACIONES),
                                       TRIM(DES_PLATAFORMA), 10,
                                       (SELECT TRIM(CREATED_BY)
                                        FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                        WHERE  ID_REQUEST = P_ID_REQUEST
                                       )
                                FROM   XXMOR_SOLICITUDES_ORIG_DET_TAB
                                WHERE  ID_REQUEST = P_ID_REQUEST;
                            ELSE -- V_Agrupador != 'CUTIN'
                                dbms_output.put_line('La orden es de CUTIN');
                                -- Se inserta la orden Nacional
                                -- SE OBTIENE EL ID DE LA SOLICITUD EL CUAL SE USARA PARA GUARDAR COMO
                                -- EL LA SOLICITUD HERMANA EN LA ORDEN DE PROVINCIA.
                                SELECT XXMOR_ID_SOLICITUD_SQ.NEXTVAL
                                INTO   V_ID_SOLICITUD_NAL
                                FROM   DUAL;
                                INSERT INTO XXMOR_SOLICITUDES_ENC_TAB
                                       ( ID_SOLICITUD, ID_REQUEST, ID_SEG_NEG,
                                         PROC_POR_LINEA, GARANTIZADO, ADVID,
                                         MCONTID, MCONTID_CUTIN, EMAIL,
                                         AGYESTNUM, ACCTHDRID, RTCRDDSCR,
                                         RTCRDDSCR_CUTIN, COMENTARIOS, PLATAFORMA_CANAL,
                                         PRDID_DESC, TOTAL_SPOTS, TOTAL_SIN_DESC,
                                         TOTAL_CON_DESC, TIPO_FACTURACION, DESCUENTO,
                                         TARGET, CREATED_BY, ID_FZA_VENTAS, ORDEN_ESTATUS
                                       )
                                SELECT V_ID_SOLICITUD_NAL, ID_REQUEST, ID_SEG_NEG,
                                       TRIM(PROC_POR_LINEA), TRIM(DECODE(NVL(GARANTIZADO,'0'),'0','0','1')), TRIM(ADVID),
                                       TRIM(MCONTID), NULL AS MCONTID_CUTIN, TRIM(EMAIL),
                                       TRIM(AGYESTNUM), TRIM(ACCTHDRID), TRIM(RTCRDDSCR),
                                       TRIM(RTCRDDSCR_CUTIN), SUBSTR(TRIM(COMENTARIOS),1,132), 'TVSA'||DECODE(V_SPTCHR,'XX','-ERTS'),
                                       TRIM(PRDID_DESC), TRIM(TOTAL_SPOTS), TRIM(TOTAL_SIN_DESC),
                                       TRIM(TOTAL_CON_DESC), TRIM(TIPO_FACTURACION), TRIM(DESCUENTO),
                                       TRIM(TARGET), CREATED_BY, NULL, 10
                                FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                WHERE  ID_REQUEST = P_ID_REQUEST;
                                INSERT INTO XXMOR_SOLICITUDES_DET_TAB
                                       ( ID_SOLICITUD, LINEA, STNID,
                                         FECHA_INICIO, FECHA_FIN, DURACION,
                                         BUYUNTID, HORA_INICIO, HORA_FIN,
                                         SPOTS, LUNES, MARTES, MIERCOLES,
                                         JUEVES, VIERNES, SABADO, DOMINGO,
                                         SPOTS_X_SEMANA, TIPO_SERVICIO, USR_CHR,
                                         SPOT_CHR, BN, P, MARCA, VERSION,
                                         TARIFASP_SIN_DESC, TARIFASP_CON_DESC,
                                         TOT_LINEA_SIN_DESC, TOT_LINEA_CON_DESC,
                                         SOBRECARGO, OBSERVACIONES, DES_PLATAFORMA,
                                         LINEA_ESTATUS, CREATED_BY
                                       )
                                SELECT XXMOR_ID_SOLICITUD_SQ.CURRVAL, ROW_NUMBER() OVER (ORDER BY LINEA_REQUEST) NUM_LINEA, NVL(TRIM(STNID),V_AGRUPADOR),
                                       TRIM(FECHA_INICIO), TRIM(FECHA_FIN), TRIM(DURACION),
                                       TRIM(BUYUNTID), TRIM(HORA_INICIO), TRIM(HORA_FIN),
                                       TRIM(SPOTS), TRIM(LUNES), TRIM(MARTES), TRIM(MIERCOLES),
                                       TRIM(JUEVES), TRIM(VIERNES), TRIM(SABADO), TRIM(DOMINGO),
                                       TRIM(SPOTS_X_SEMANA),
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           (SELECT DESC_TIPO_SERVICIO
                                            FROM   XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  SPT_CHR           = SUBSTR(TIPO_SERVICIO,2,1)
                                            AND    NVL(USR_CHR, ' ') = SUBSTR(TIPO_SERVICIO,1,1)
                                           )
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               UPPER(TIPO_SERVICIO)
                                           ELSE
                                               'NO APLICA'
                                           END
                                       END AS TIPO_SERVICIO,
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           SUBSTR(TIPO_SERVICIO,1,1)
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               (SELECT USR_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                               )
                                           ELSE
                                               (SELECT USR_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                               )
                                           END
                                       END USRCHR,
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           SUBSTR(TIPO_SERVICIO,2,1)
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               (SELECT SPT_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                               )
                                           ELSE
                                               (SELECT SPT_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                               )
                                           END
                                       END SPTCHR,
                                       TRIM(BN), TRIM(P), TRIM(MARCA), NVL(TRIM(VERSION),'VER PAUTA'),
                                       TRIM(TARIFASP_SIN_DESC), TRIM(TARIFASP_CON_DESC),
                                       TRIM(TOT_LINEA_SIN_DESC), TRIM(TOT_LINEA_CON_DESC),
                                       TRIM(INITCAP(SOBRECARGO)), TRIM(OBSERVACIONES),
                                       TRIM(DES_PLATAFORMA), 10,
                                       (SELECT TRIM(CREATED_BY)
                                        FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                        WHERE  ID_REQUEST = P_ID_REQUEST
                                       )
                                FROM   XXMOR_SOLICITUDES_ORIG_DET_TAB
                                WHERE  ID_REQUEST = P_ID_REQUEST
                                AND    STNID      IN (SELECT CANAL
                                                      FROM   XXMOR_CANALES_NAC_VW
                                                     );
                                -- Se inserta la orden Provincia
                                -- SE OBTIENE EL ID DE LA SOLICITUD EL CUAL SE USARA PARA GUARDAR COMO
                                -- EL LA SOLICITUD HERMANA EN LA ORDEN DE PROVINCIA.
                                SELECT XXMOR_ID_SOLICITUD_SQ.NEXTVAL
                                INTO   V_ID_SOLICITUD_PROV
                                FROM   DUAL;
                                --El master contract cuttin se pone como mconid en el caso de la orden de provincia
                                INSERT INTO XXMOR_SOLICITUDES_ENC_TAB
                                       ( ID_SOLICITUD, ID_REQUEST, ID_SEG_NEG,
                                         PROC_POR_LINEA, GARANTIZADO, ADVID,
                                         MCONTID, MCONTID_CUTIN, EMAIL,
                                         AGYESTNUM, ACCTHDRID, RTCRDDSCR,
                                         RTCRDDSCR_CUTIN, COMENTARIOS, PLATAFORMA_CANAL,
                                         PRDID_DESC, TOTAL_SPOTS, TOTAL_SIN_DESC,
                                         TOTAL_CON_DESC, TIPO_FACTURACION, DESCUENTO,
                                         TARGET, CREATED_BY, ID_FZA_VENTAS,
                                         ORDEN_ESTATUS, ID_SOLICITUD_HNA
                                       )
                                SELECT V_ID_SOLICITUD_PROV, ID_REQUEST, ID_SEG_NEG,
                                       TRIM(PROC_POR_LINEA), TRIM(DECODE(NVL(GARANTIZADO,'0'),'0','0','1')), TRIM(ADVID),
                                       TRIM(MCONTID_CUTIN), NULL, TRIM(EMAIL),
                                       TRIM(AGYESTNUM), TRIM(ACCTHDRID), TRIM(RTCRDDSCR_CUTIN),
                                       NULL, SUBSTR(TRIM(COMENTARIOS),1,132), 'PROVIN'||DECODE(V_SPTCHR,'XX','-ERTS'),
                                       TRIM(PRDID_DESC), TRIM(TOTAL_SPOTS), TRIM(TOTAL_SIN_DESC),
                                       TRIM(TOTAL_CON_DESC), TRIM(TIPO_FACTURACION), TRIM(DESCUENTO),
                                       TRIM(TARGET), CREATED_BY, NULL,
                                       10, V_ID_SOLICITUD_NAL
                                FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                WHERE  ID_REQUEST = P_ID_REQUEST;
                                -- SE ACTUALIZA LA ORDEN DE NACIONAL CON EL ID DE LA ORDEN DE PROVINCIA
                                -- PARA EL CAMPO ID_SOLICITUD_HNA.
                                UPDATE XXMOR_SOLICITUDES_ENC_TAB
                                SET    ID_SOLICITUD_HNA = V_ID_SOLICITUD_PROV
                                WHERE  ID_SOLICITUD = V_ID_SOLICITUD_NAL;
                                INSERT INTO XXMOR_SOLICITUDES_DET_TAB
                                       ( ID_SOLICITUD, LINEA, STNID,
                                         FECHA_INICIO, FECHA_FIN, DURACION,
                                         BUYUNTID, HORA_INICIO, HORA_FIN,
                                         SPOTS, LUNES, MARTES, MIERCOLES,
                                         JUEVES, VIERNES, SABADO, DOMINGO,
                                         SPOTS_X_SEMANA, TIPO_SERVICIO, USR_CHR,
                                         SPOT_CHR, BN, P, MARCA, VERSION,
                                         TARIFASP_SIN_DESC, TARIFASP_CON_DESC,
                                         TOT_LINEA_SIN_DESC, TOT_LINEA_CON_DESC,
                                         SOBRECARGO, OBSERVACIONES, DES_PLATAFORMA,
                                         LINEA_ESTATUS, CREATED_BY
                                       )
                                SELECT XXMOR_ID_SOLICITUD_SQ.CURRVAL, ROW_NUMBER() OVER (ORDER BY LINEA_REQUEST) NUM_LINEA, NVL(TRIM(STNID),V_AGRUPADOR),
                                       TRIM(FECHA_INICIO), TRIM(FECHA_FIN), TRIM(DURACION),
                                       TRIM(BUYUNTID), TRIM(HORA_INICIO), TRIM(HORA_FIN),
                                       TRIM(SPOTS), TRIM(LUNES), TRIM(MARTES), TRIM(MIERCOLES),
                                       TRIM(JUEVES), TRIM(VIERNES), TRIM(SABADO), TRIM(DOMINGO),
                                       TRIM(SPOTS_X_SEMANA),
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           (SELECT DESC_TIPO_SERVICIO
                                            FROM   XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  SPT_CHR           = SUBSTR(TIPO_SERVICIO,2,1)
                                            AND    NVL(USR_CHR, ' ') = SUBSTR(TIPO_SERVICIO,1,1)
                                           )
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               UPPER(TIPO_SERVICIO)
                                           ELSE
                                               'NO APLICA'
                                           END
                                       END AS TIPO_SERVICIO,
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           SUBSTR(TIPO_SERVICIO,1,1)
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               (SELECT USR_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                               )
                                           ELSE
                                               (SELECT USR_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                               )
                                           END
                                       END USRCHR,
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           SUBSTR(TIPO_SERVICIO,2,1)
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               (SELECT SPT_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                               )
                                           ELSE
                                               (SELECT SPT_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                               )
                                           END
                                       END SPTCHR,
                                       TRIM(BN), TRIM(P), TRIM(MARCA), NVL(TRIM(VERSION),'VER PAUTA'),
                                       TRIM(TARIFASP_SIN_DESC), TRIM(TARIFASP_CON_DESC),
                                       TRIM(TOT_LINEA_SIN_DESC), TRIM(TOT_LINEA_CON_DESC),
                                       TRIM(INITCAP(SOBRECARGO)), TRIM(OBSERVACIONES),
                                       TRIM(DES_PLATAFORMA), 10,
                                       (SELECT TRIM(CREATED_BY)
                                        FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                        WHERE  ID_REQUEST = P_ID_REQUEST
                                       )
                                FROM   XXMOR_SOLICITUDES_ORIG_DET_TAB
                                WHERE  ID_REQUEST = P_ID_REQUEST
                                AND    STNID NOT IN (SELECT CANAL
                                                     FROM XXMOR_CANALES_NAC_VW
                                                    );
                            END IF; -- V_Agrupador != 'CUTIN'
                        ELSE -- V_Existe = 0
                            --La solicitud genera mas de una orden
                            SELECT XXMOR_ID_SOLICITUD_SQ.NEXTVAL
                            INTO   V_AGRUPA
                            FROM   DUAL;
                            FOR rec_pref IN CUR_PREFIJOS(P_ID_REQUEST) LOOP
                                INSERT INTO XXMOR_SOLICITUDES_ENC_TAB
                                       ( ID_SOLICITUD, ID_REQUEST, ID_SEG_NEG,
                                         PROC_POR_LINEA, GARANTIZADO, ADVID,
                                         MCONTID, MCONTID_CUTIN, EMAIL,
                                         AGYESTNUM, ACCTHDRID, RTCRDDSCR,
                                         RTCRDDSCR_CUTIN, COMENTARIOS, PLATAFORMA_CANAL,
                                         PRDID_DESC, TOTAL_SPOTS, TOTAL_SIN_DESC,
                                         TOTAL_CON_DESC, TIPO_FACTURACION, DESCUENTO,
                                         TARGET, CREATED_BY, ID_FZA_VENTAS,
                                         ORDEN_ESTATUS, ID_SOLICITUD_HNA
                                       )
                                SELECT XXMOR_ID_SOLICITUD_SQ.NEXTVAL, ID_REQUEST, ID_SEG_NEG,
                                       TRIM(PROC_POR_LINEA), TRIM(DECODE(NVL(GARANTIZADO,'0'),'0','0','1')), TRIM(ADVID),
                                       TRIM(MCONTID), TRIM(MCONTID_CUTIN), TRIM(EMAIL),
                                       TRIM(AGYESTNUM), TRIM(ACCTHDRID), TRIM(RTCRDDSCR),
                                       TRIM(RTCRDDSCR_CUTIN), SUBSTR(TRIM(COMENTARIOS),1,132), TRIM(PLATAFORMA_CANAL)||DECODE(V_SPTCHR,'XX','-ERTS'),
                                       TRIM(PRDID_DESC), TRIM(TOTAL_SPOTS), TRIM(TOTAL_SIN_DESC),
                                       TRIM(TOTAL_CON_DESC), TRIM(TIPO_FACTURACION), TRIM(DESCUENTO),
                                       TRIM(TARGET), CREATED_BY, NULL,
                                       10, V_TEMP
                                FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                WHERE  ID_REQUEST = P_ID_REQUEST;
                                INSERT INTO XXMOR_SOLICITUDES_DET_TAB
                                       ( ID_SOLICITUD, LINEA, STNID,
                                         FECHA_INICIO, FECHA_FIN, DURACION,
                                         BUYUNTID, HORA_INICIO, HORA_FIN,
                                         SPOTS, LUNES, MARTES, MIERCOLES,
                                         JUEVES, VIERNES, SABADO, DOMINGO,
                                         SPOTS_X_SEMANA, TIPO_SERVICIO, USR_CHR,
                                         SPOT_CHR, BN, P, MARCA, VERSION,
                                         TARIFASP_SIN_DESC, TARIFASP_CON_DESC,
                                         TOT_LINEA_SIN_DESC, TOT_LINEA_CON_DESC,
                                         SOBRECARGO, OBSERVACIONES, DES_PLATAFORMA,
                                         LINEA_ESTATUS, CREATED_BY
                                       )
                                SELECT XXMOR_ID_SOLICITUD_SQ.CURRVAL, ROW_NUMBER() OVER (ORDER BY LINEA_REQUEST) NUM_LINEA, rec_pref.PREFIJO_CANAL||TRIM(STNID),
                                       TRIM(FECHA_INICIO), TRIM(FECHA_FIN), TRIM(DURACION),
                                       TRIM(BUYUNTID), TRIM(HORA_INICIO), TRIM(HORA_FIN),
                                       TRIM(SPOTS), TRIM(LUNES), TRIM(MARTES), TRIM(MIERCOLES),
                                       TRIM(JUEVES), TRIM(VIERNES), TRIM(SABADO), TRIM(DOMINGO),
                                       TRIM(SPOTS_X_SEMANA),
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           (SELECT DESC_TIPO_SERVICIO
                                            FROM   XXMOR_CAT_TIPO_SERV_TAB
                                            WHERE  SPT_CHR           = SUBSTR(TIPO_SERVICIO,2,1)
                                            AND    NVL(USR_CHR, ' ') = SUBSTR(TIPO_SERVICIO,1,1)
                                           )
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               UPPER(TIPO_SERVICIO)
                                           ELSE
                                               'NO APLICA'
                                           END
                                       END AS TIPO_SERVICIO,
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           SUBSTR(TIPO_SERVICIO,1,1)
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               (SELECT USR_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                               )
                                           ELSE
                                               (SELECT USR_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                               )
                                           END
                                       END USRCHR,
                                       CASE WHEN LENGTH(TIPO_SERVICIO) = 2 THEN
                                           SUBSTR(TIPO_SERVICIO,2,1)
                                       ELSE
                                           CASE WHEN (SELECT COUNT(1)
                                                      FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                      WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                                     ) > 0 THEN
                                               (SELECT SPT_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = UPPER(TIPO_SERVICIO)
                                               )
                                           ELSE
                                               (SELECT SPT_CHR
                                                FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                                WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                               )
                                           END
                                       END SPTCHR,
                                       TRIM(BN), TRIM(P), TRIM(MARCA), NVL(TRIM(VERSION),'VER PAUTA'),
                                       TRIM(TARIFASP_SIN_DESC), TRIM(TARIFASP_CON_DESC),
                                       TRIM(TOT_LINEA_SIN_DESC), TRIM(TOT_LINEA_CON_DESC),
                                       TRIM(INITCAP(SOBRECARGO)), TRIM(OBSERVACIONES),
                                       TRIM(DES_PLATAFORMA), 10,
                                       (SELECT TRIM(CREATED_BY)
                                        FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
                                        WHERE  ID_REQUEST = P_ID_REQUEST
                                       )
                                FROM   XXMOR_SOLICITUDES_ORIG_DET_TAB
                                WHERE  ID_REQUEST = P_ID_REQUEST;
                            END LOOP;
                        END IF; -- V_Existe = 0
                    END IF; -- V_sptchr = '5' OR V_sptchr = '1'
                END IF; -- V_SegNeg != 1
                DBMS_OUTPUT.PUT_LINE('Antes de entrar a revisar'||P_ID_REQUEST);
                BEGIN
                    INSERT INTO XXMOR_SOLICITUDES_EST_REP_TAB
                           ( ID_SOLICITUD,  LINEA, ID_SIST, CREATED_DATE)
                    SELECT ID_SOLICITUD, 0, 1, SYSDATE
                    FROM   XXMOR_SOLICITUDES_ENC_TAB
                    WHERE  ID_REQUEST  = P_ID_REQUEST;
                    INSERT INTO XXMOR_SOLICITUDES_EST_REP_TAB
                           ( ID_SOLICITUD,  LINEA, ID_SIST, CREATED_DATE)
                    SELECT ID_SOLICITUD, LINEA, 1, SYSDATE
                    FROM   XXMOR_SOLICITUDES_DET_TAB
                    WHERE  ID_SOLICITUD IN (SELECT ID_SOLICITUD
                                            FROM   XXMOR_SOLICITUDES_ENC_TAB
                                            WHERE  ID_REQUEST = P_ID_REQUEST
                                           );
                    -- PARA RECHAZAR LAS ORDENES QUE NO TIENEN UN MASTER CONTRACT VALIDO CON "." (PUNTO)
                    INSERT INTO XXMOR_CONCOM_RPTA_TAB
                           ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM,
                             RESULTADOGENERAL, TRACKINGID, DESC_CONCOM,
                             POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM,
                             ESTATUS_CONCOM, CAMPO_CONCOM, DETALLE_CONCOM,
                             ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI,
                             CREATED_DATE, CREATED_BY
                           )
                    SELECT ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                           NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                           'ENCABEZADO', NULL, NULL,
                           'ERROR','Request/Orden/Encabezado/CPSMasterContract', 'RECHAZO - La orden no tiene un master contract valido',
                           'RECHAZO', NULL, '10',
                           SYSDATE, 'ORDUNI2'
                    FROM   XXMOR_SOLICITUDES_ENC_TAB
                    WHERE  ID_REQUEST         = P_ID_REQUEST
                    AND    INSTR(MCONTID,'.') = 0;
                    --XXMOR_ENV_MAIL_OR_MC_PR(P_ID_REQUEST, 5000);
                    DBMS_OUTPUT.PUT_LINE('el dbms del momento en que se generan las ordenes'||P_ID_REQUEST);
                EXCEPTION
                    WHEN DUP_VAL_ON_INDEX THEN
                        NULL;
                END;
            ELSIF lst_inserta = 'N' THEN
                -- Se inserta en la tabla de errores el error encontrado
                INSERT INTO XXMOR_LOG_ERRORES_TAB
                            (
                                    ID_ERROR,
                                    DESC_ERROR,
                                    ARCHIVO_ERROR,
                                    METODO_ERROR,
                                    HORA_ERROR
                            )
                VALUES      (       XXMOR.XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                    'Error al procesar el archivo: '||lst_nom_archivo||', No Existe Informacion de Lineas',
                                    'XXMOR_FUNCIONAL_PKG',
                                    'XXMOR_GENERAORDENES_PR',
                                    SYSDATE
                            );
            END IF;
        END LOOP;
        CLOSE ORDENES;
    END XXMOR_GENERAORDENES_PR;
    PROCEDURE XXMOR_REVISAR_BUYUNITMKT_PR
                        (
                                P_ID_SOLICITUD IN XXMOR_SOLICITUDES_ENC_TAB.ID_SOLICITUD%TYPE
                        ) IS
    V_ESMKT            CHAR(1):='0';
    V_BuyUnit_tmp      XXMOR_SOLICITUDES_DET_TAB.BUYUNTID%TYPE;
    V_GerenteTmp       VARCHAR(100);
    V_GerenteMkt       VARCHAR(100);
    V_ID_FZA_VENTAS    INTEGER;
    V_RESULTADO        PLS_INTEGER:=1;
    CURSOR BUYUNITMKT_CUR IS
    SELECT ID_SOLICITUD,
           BUYUNTID
    FROM   XXMOR_SOLICITUDES_DET_TAB
    WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
    BEGIN
        SELECT NVL(AUT_X_CORREO,'0')
        INTO   V_ESMKT
        FROM   XXMOR_FZAS_VTAS_TAB
        WHERE  ID_FZA_VENTAS = (SELECT ID_FZA_VENTAS
                                FROM   XXMOR_SOLICITUDES_ENC_TAB
                                WHERE  id_solicitud = P_ID_SOLICITUD
                               );
        DBMS_OUTPUT.PUT_LINE('antes de entrar al if esMkt(Aut)correo: '||v_EsMkt );
        IF V_ESMKT = '1' THEN
            DBMS_OUTPUT.PUT_LINE('v_EsMkt: '||v_EsMkt );
            SELECT ID_FZA_VENTAS
            INTO   V_ID_FZA_VENTAS
            FROM   XXMOR_SOLICITUDES_ENC_TAB SE
            WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
            BEGIN
                SELECT MKT_MAIL_COORDINADOR
                INTO   V_GERENTEMKT
                FROM   XXMOR_CAT_BUYUNIT_MKT_TAB
                WHERE  ID_SEG_NEG    = 1
                AND    ID_FZA_VENTAS = V_ID_FZA_VENTAS
                AND    BUYUNTID      = (SELECT BUYUNTID
                                        FROM   XXMOR_SOLICITUDES_DET_TAB
                                        WHERE  ROWNUM       = 1
                                        AND    ID_SOLICITUD = P_ID_SOLICITUD
                                       );
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    V_GERENTEMKT :=  NULL;
                    V_RESULTADO  := 0;
            END;
            DBMS_OUTPUT.PUT_LINE('V_GerenteMkt: '||V_GerenteMkt );
            IF V_GERENTEMKT IS NOT NULL THEN
                --Se compara linea a linea los coordinadores de mkt para verificar q sean el mismo en todas las lineas
                FOR C_BUYUNIT IN BUYUNITMKT_CUR LOOP
                    SELECT MKT_MAIL_COORDINADOR
                    INTO   V_GERENTETMP
                    FROM   XXMOR_CAT_BUYUNIT_MKT_TAB
                    WHERE  ID_SEG_NEG    = 1
                    AND    ID_FZA_VENTAS = V_ID_FZA_VENTAS
                    AND    BUYUNTID      = C_BUYUNIT.BUYUNTID;
                    DBMS_OUTPUT.PUT_LINE('V_GerenteTmp: '||V_GERENTETMP );
                    IF V_GERENTETMP != V_GERENTEMKT OR V_RESULTADO = 0 THEN
                        V_RESULTADO := 0;
                        DBMS_OUTPUT.PUT_LINE('V_RESULTADO: '||V_RESULTADO );
                    END IF;
                END LOOP;
            END IF;
            --Si las lineas de la orden tienen diferente coordinador de mkt se rechaza la orden, usando la tabla de rpta concom
            IF V_resultado = 0 AND V_GERENTEMKT IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE('-->Se rechaza la orden!!!');
                INSERT INTO XXMOR_CONCOM_RPTA_TAB
                       ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM,
                         RESULTADOGENERAL, TRACKINGID, DESC_CONCOM,
                         POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM,
                         ESTATUS_CONCOM, CAMPO_CONCOM, DETALLE_CONCOM,
                         ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI,
                         CREATED_DATE, CREATED_BY
                       )
                SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                       NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                       'LINEA', NULL, LINEA,
                       'ERROR', 'MKT', 'RECHAZO - Diferentes gerentes de mkt en las lineas de la orden',
                       'RECHAZO', NULL, '10',
                       SYSDATE, 'ORDUNI2'
                FROM   XXMOR_SOLICITUDES_ENC_TAB E,
                       XXMOR_SOLICITUDES_DET_TAB D
                WHERE  E.ID_SOLICITUD = D.ID_SOLICITUD
                AND    E.ID_SOLICITUD = P_ID_SOLICITUD;
            ELSIF V_resultado = 0 AND V_GERENTEMKT IS NULL THEN
                DBMS_OUTPUT.PUT_LINE('-->Se rechaza la orden!!!');
                INSERT INTO XXMOR_CONCOM_RPTA_TAB
                       ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM,
                         RESULTADOGENERAL, TRACKINGID, DESC_CONCOM,
                         POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM,
                         ESTATUS_CONCOM, CAMPO_CONCOM, DETALLE_CONCOM,
                         ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI,
                         CREATED_DATE, CREATED_BY
                       )
                SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                       NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                       'LINEA', NULL, LINEA,
                       'ERROR', 'MKT', 'RECHAZO - No hay gerente de mkt para la orden',
                       'RECHAZO', NULL, '10',
                       SYSDATE, 'ORDUNI2'
                FROM   XXMOR_SOLICITUDES_ENC_TAB E,
                       XXMOR_SOLICITUDES_DET_TAB D
                WHERE  E.ID_SOLICITUD = D.ID_SOLICITUD
                AND    E.ID_SOLICITUD = P_ID_SOLICITUD;
            END IF;
        END IF;
    END XXMOR_REVISAR_BUYUNITMKT_PR;
    PROCEDURE XXMOR_ASIGNA_FZAVTAS_PR
                        (
                                P_ID_REQUEST_AUX IN INTEGER
                        ) IS
    V_ID_FZA_VENTAS     INTEGER;
    V_ID_SOLICITUD      INTEGER;
    V_FZA_VTAS_MKT      INTEGER;
    V_COORDINA_MKT      INTEGER;
    V_COUNT_COORD       INTEGER;
    V_COUNT_NULLS       INTEGER;
    V_TOT_LINEAS        INTEGER;
    V_GEN_VER_VIR       INTEGER;
    V_AUT_X_CORREO      INTEGER;
    V_FZA_VTAS_CH       PLS_INTEGER;
    lst_agrupador        VARCHAR2(10);
    lst_plataforma_canal VARCHAR2(70);
    lst_usa_buyunit      VARCHAR2(1);
    CURSOR ORDENES_CUR IS
    SELECT ID_REQUEST
    FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB
    WHERE  AUX1 = P_ID_REQUEST_AUX;
    CURSOR PESTANIAS_CUR(P_ID_REQUEST INTEGER) IS
    SELECT ID_SOLICITUD
    FROM   XXMOR_SOLICITUDES_ENC_TAB
    WHERE  ID_REQUEST = P_ID_REQUEST;
    BEGIN
        FOR ORDEN IN ORDENES_CUR LOOP
            FOR PESTANIA IN PESTANIAS_CUR(ORDEN.ID_REQUEST) LOOP
                --selecciona todas las ordenes generadas en un request
                V_ID_SOLICITUD := PESTANIA.ID_SOLICITUD;
                DBMS_OUTPUT.PUT_LINE(' V_ID_SOLICITUD: '||V_ID_SOLICITUD);
                -- Se obtiene la plataforma-canal a nivel encabezado con el
                -- cual se va a obtener el agrupador, para posteriormente
                -- actualizar este campo en la tabla de encabezado.
                SELECT NVL(TRIM(PLATAFORMA_CANAL),'SIN PLATAFORMA')
                INTO   lst_plataforma_canal
                FROM   XXMOR_SOLICITUDES_ENC_TAB
                WHERE  ID_SOLICITUD = V_ID_SOLICITUD;
                DBMS_OUTPUT.PUT_LINE('lst_plataforma_canal: '||lst_plataforma_canal);
                SELECT XXMOR_FUNCIONAL_PKG.XXMOR_GET_AGRUPADOR_FN
                                                    (
                                                            lst_plataforma_canal,
                                                            V_ID_SOLICITUD
                                                    )
                INTO   lst_agrupador
                FROM   DUAL;
                DBMS_OUTPUT.PUT_LINE('lst_agrupador: '||lst_agrupador);
                UPDATE XXMOR_SOLICITUDES_ENC_TAB
                SET    AGRUPADOR  = lst_agrupador
                WHERE ID_SOLICITUD = V_ID_SOLICITUD;
                DBMS_OUTPUT.PUT_LINE('SE ACTUALIZO AGRUPADOR');
                SELECT XXMOR_IDENT_FZA_VTAS
                                  (
                                          V_ID_SOLICITUD,
                                          (SELECT USR_CHR
                                           FROM   XXMOR_SOLICITUDES_DET_TAB
                                           WHERE  ID_SOLICITUD = V_ID_SOLICITUD
                                           AND    LINEA        = 1
                                          ),
                                          (SELECT SPOT_CHR
                                           FROM   XXMOR_SOLICITUDES_DET_TAB
                                           WHERE  ID_SOLICITUD = V_ID_SOLICITUD
                                           AND    LINEA        = 1
                                          )
                                  )
                INTO V_ID_FZA_VENTAS
                FROM DUAL;
                -- INICIO OMW - Cambio Notificaciones FVTAS, MERCA, 23-AG0-2016
                IF V_ID_FZA_VENTAS = 0 THEN
                     -- SE ENVIA LA NOTIFICACION DE QUE NO SE OBTUVO FUERZA DE VENTAS (NO FUE POSIBLE OBTENERLA)
                    XXMOR_FUNCIONAL_PKG.XXMOR_NOTIFICA_FVTAS_MERCA_PR
                                       (
                                                'FVTAS',
                                                0,
                                                V_ID_SOLICITUD
                                       );
                ELSIF V_ID_FZA_VENTAS = 1 THEN
                    V_ID_FZA_VENTAS := 0;
                    -- SE ENVIA LA NOTIFICACION DE QUE NO SE OBTUVO FUERZA DE VENTAS (EXISTE MAS DE UNA CON LA MISMA CONFIGURACION)
                    XXMOR_FUNCIONAL_PKG.XXMOR_NOTIFICA_FVTAS_MERCA_PR
                                       (
                                                'FVTAS',
                                                1,
                                                V_ID_SOLICITUD
                                       );
                ELSIF V_ID_FZA_VENTAS < 0 THEN
                    V_ID_FZA_VENTAS := (V_ID_FZA_VENTAS * -1);
                    -- SE ENVIA LA NOTIFICACION DE QUE NO SE OBTUVO FUERZA DE VENTAS (EXISTE PERO ESTA INACTIVA)
                    XXMOR_FUNCIONAL_PKG.XXMOR_NOTIFICA_FVTAS_MERCA_PR
                                   (
                                            'FVTAS',
                                            V_ID_FZA_VENTAS,
                                            V_ID_SOLICITUD
                                   );
                    V_ID_FZA_VENTAS := 0;
                END IF;
                -- FIN OMW - Cambio Notificaciones FVTAS, MERCA, 23-AG0-2016
                UPDATE XXMOR_SOLICITUDES_ENC_TAB E
                SET    E.ID_FZA_VENTAS = V_ID_FZA_VENTAS
                WHERE  ID_SOLICITUD = V_ID_SOLICITUD;
                --WHERE ID_REQUEST = ORDEN.ID_REQUEST; -- Se modifico para que lo haga por Solicitud
                SELECT COUNT(1)
                INTO   V_FZA_VTAS_CH
                FROM   XXMOR_FZAS_VTAS_CANALES_TAB
                WHERE  ID_SEG_NEG    = 1
                AND    ID_FZA_VENTAS = V_ID_FZA_VENTAS;
                --Se genera la informacion de las lineas hermanas
                IF V_FZA_VTAS_CH > 0 THEN
                    XXMOR_GENERA_INF_REP_PR(V_ID_SOLICITUD,V_ID_FZA_VENTAS);
                END IF;
                -- Revisa si necesita autorizacion de MKT (Autorizacion por correo) aut_x_correo
                -- si la fuerza de ventas esde mercadotecnia, y la version es nula se generan versiones virtuales
                SELECT AUT_X_CORREO,
                       MERCADOTECNIA,
                       NVL(USAR_BUYUNIT_MKT,'1') USAR_BUYUNIT_MKT
                INTO   V_AUT_X_CORREO,
                       V_GEN_VER_VIR,
                       lst_usa_buyunit
                FROM   XXMOR_FZAS_VTAS_TAB
                WHERE  ID_SEG_NEG    = 1
                AND    ID_FZA_VENTAS = V_ID_FZA_VENTAS;
                IF V_GEN_VER_VIR = '1' THEN
                    --Generamos las versiones que vienen vacias (para que se generen al momento de usar el ws
                    UPDATE XXMOR_SOLICITUDES_DET_TAB
                    SET    VERSION = 'PP'||DURACION||' '||MARCA
                    WHERE  VERSION IS NULL
                    AND    ID_SOLICITUD = V_ID_SOLICITUD;
                END IF;
                --Si la orden se puede autorizar (en caso de ser necesario) por correo
                IF V_AUT_X_CORREO = '1' THEN
                    IF lst_usa_buyunit = '1' THEN
                        -- CONTAMOS LAS VERSIONES QUE SI TIENEN VERSION
                        /*SELECT COUNT(DISTINCT BM.MKT_COORDINADOR)
                        INTO   V_COUNT_COORD
                        FROM   XXMOR_SOLICITUDES_DET_TAB D
                        LEFT   OUTER JOIN XXMOR_CAT_BUYUNIT_MKT_TAB BM
                        ON     D.BUYUNTID = BM.BUYUNTID
                        AND    D.ID_SOLICITUD = V_ID_SOLICITUD;*/
                        -- SE CAMBIA EL QUERY ANTERIOR POR EL SIGUIENTE PARA EL MANEJO
                        -- DE BYUNITS NULOS EN LAS LINEAS DE LA ORDEN.
                        SELECT COUNT(DISTINCT BM.MKT_COORDINADOR)
                        INTO   V_COUNT_COORD
                        FROM   XXMOR_SOLICITUDES_DET_TAB D,
                               XXMOR_CAT_BUYUNIT_MKT_TAB BM
                        WHERE  NVL(TRIM(D.BUYUNTID),'SIN BUYUNIT') = NVL(TRIM(BM.BUYUNTID),'SIN BUYUNIT')
                        AND    D.ID_SOLICITUD   = V_ID_SOLICITUD
                        AND    BM.ID_FZA_VENTAS = (SELECT E.ID_FZA_VENTAS
                                                   FROM   XXMOR_SOLICITUDES_ENC_TAB E
                                                   WHERE  E.ID_SOLICITUD = D.ID_SOLICITUD
                                                  );
                        -- CONTAMOS SI HAY VERSIONES Q SU COORDINADOR ES NULO
                        /*SELECT COUNT(DISTINCT NVL(BM.MKT_COORDINADOR,1))  --COUNT DISTINCT
                        INTO   V_COUNT_NULLS
                        FROM   XXMOR_SOLICITUDES_DET_TAB D
                        JOIN   XXMOR_CAT_BUYUNIT_MKT_TAB BM
                        ON     D.BUYUNTID = BM.BUYUNTID
                        AND    D.ID_SOLICITUD = V_ID_SOLICITUD
                        AND    BM.MKT_COORDINADOR IS NULL;*/
                        -- SE CAMBIA EL QUERY ANTERIOR POR EL SIGUIENTE PARA EL MANEJO
                        -- DE BYUNITS NULOS EN LAS LINEAS DE LA ORDEN.
                        SELECT COUNT(DISTINCT NVL(BM.MKT_COORDINADOR,1))
                        INTO   V_COUNT_NULLS
                        FROM   XXMOR_SOLICITUDES_DET_TAB D,
                               XXMOR_CAT_BUYUNIT_MKT_TAB BM
                        WHERE  NVL(TRIM(D.BUYUNTID),'SIN BUYUNIT') = NVL(TRIM(BM.BUYUNTID),'SIN BUYUNIT')
                        AND    D.ID_SOLICITUD     = V_ID_SOLICITUD
                        AND    BM.MKT_COORDINADOR IS NULL
                        AND    BM.ID_FZA_VENTAS   = (SELECT E.ID_FZA_VENTAS
                                                     FROM   XXMOR_SOLICITUDES_ENC_TAB E
                                                     WHERE  E.ID_SOLICITUD = D.ID_SOLICITUD
                                                    );
                        IF V_COUNT_NULLS = 0 AND V_COUNT_COORD = 1 THEN
                            NULL;
                        ELSE
                            INSERT INTO XXMOR_CONCOM_RPTA_TAB
                                        (
                                                ID_SOLICITUD,       ID_SEG_NEG,         ID_RPTA_CONCOM,
                                                RESULTADOGENERAL,   TRACKINGID,         DESC_CONCOM,
                                                POSICION_CONCOM,    ID_CONCOM,          NUMLINEA_CONCOM,
                                                ESTATUS_CONCOM,     CAMPO_CONCOM,       DETALLE_CONCOM,
                                                ACCION_CONCOM,      TIPOREGLA_CONCOM,   ESTATUS_ORDUNI,
                                                CREATED_DATE,       CREATED_BY
                                        )
                            SELECT E.ID_SOLICITUD, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                                   NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                                   'LINEA', NULL, LINEA,
                                   'ERROR', 'BUYUNIT-COORDINADOR', 'RECHAZO - La orden de mercadotecnia tiene mas de un coordinador',
                                   'RECHAZO', NULL, '10',
                                   SYSDATE, 'ORDUNI2'
                            FROM   XXMOR_SOLICITUDES_DET_TAB D,
                                   XXMOR_SOLICITUDES_ENC_TAB E
                            WHERE  E.ID_SOLICITUD = V_ID_SOLICITUD
                            AND    E.ID_SOLICITUD = D.ID_SOLICITUD;
                        END IF;
                    END IF; -- lst_usa_buyunit = '1'
                END IF; -- V_AUT_X_CORREO = '1'
            END LOOP;
        END LOOP;
    END XXMOR_ASIGNA_FZAVTAS_PR;
    PROCEDURE XXMOR_GENERA_INF_REP_PR
                        (
                                P_ID_SOLICITUD  IN INTEGER,
                                P_ID_FZA_VENTAS IN INTEGER
                        ) IS
    BEGIN
            --CASO TNCENA (LINEAS QUE TIENEN "HERMANAS" Y SE DIVIDEN EN PORCENTAJES)
           MERGE INTO XXMOR_SOLICITUDES_DET_TAB B
           USING (
              SELECT ID_SOLICITUD,  ROWNUM AS LINEA, LINEA_HNA, STNID, FECHA_INICIO, FECHA_FIN, DURACION, BUYUNTID, HORA_INICIO, HORA_FIN, SPOTS, LUNES, MARTES, MIERCOLES, JUEVES, VIERNES, SABADO, DOMINGO, SPOTS_X_SEMANA, TIPO_SERVICIO, USR_CHR, SPOT_CHR, BN, P, MARCA, VERSION, TARIFASP_SIN_DESC, TARIFASP_CON_DESC, TOT_LINEA_SIN_DESC, TOT_LINEA_CON_DESC, SOBRECARGO, OBSERVACIONES, CREATED_BY, CREATED_DATE, UPDATED_DATE, UPDATED_BY, LINEA_ESTATUS, FECHA_CONCOM, TRACKING_ID_CONCOM, GETRATE_SIN_AJUSTE, GETRATE_CON_AJUSTE
                FROM (SELECT D.ID_SOLICITUD, D.LINEA,
                    CASE WHEN STNID_PADRE = NULL AND STNID_HIJO = NULL THEN NULL
                    WHEN STNID_PADRE = STNID_HIJO AND STNID_PADRE != NULL AND STNID_HIJO != NULL THEN LINEA
                    WHEN STNID_PADRE != STNID_HIJO THEN LINEA
                    END LINEA_HNA,
                    NVL(FC.STNID_HIJO,D.STNID) AS STNID, D.FECHA_INICIO, D.FECHA_FIN, D.DURACION, D.BUYUNTID, D.HORA_INICIO, D.HORA_FIN, D.SPOTS, D.LUNES, D.MARTES, D.MIERCOLES, D.JUEVES, D.VIERNES, D.SABADO, D.DOMINGO, D.SPOTS_X_SEMANA, D.TIPO_SERVICIO, D.USR_CHR, D.SPOT_CHR, D.BN, D.P, D.MARCA, D.VERSION,
                    D.TARIFASP_SIN_DESC*NVL((STNID_PORCENTAJE/100),1) AS TARIFASP_SIN_DESC, D.TARIFASP_CON_DESC*NVL((STNID_PORCENTAJE/100),1) AS TARIFASP_CON_DESC, D.TOT_LINEA_SIN_DESC*NVL((STNID_PORCENTAJE/100),1) AS TOT_LINEA_SIN_DESC, D.TOT_LINEA_CON_DESC*NVL((STNID_PORCENTAJE/100) ,1) AS TOT_LINEA_CON_DESC, D.SOBRECARGO, D.OBSERVACIONES, D.CREATED_BY, D.CREATED_DATE, D.UPDATED_DATE, D.UPDATED_BY, D.LINEA_ESTATUS, D.FECHA_CONCOM, D.TRACKING_ID_CONCOM, D.GETRATE_SIN_AJUSTE, D.GETRATE_CON_AJUSTE
                    FROM XXMOR_SOLICITUDES_DET_TAB D
                         LEFT OUTER JOIN  XXMOR_FZAS_VTAS_CANALES_TAB FC ON FC.ID_FZA_VENTAS = P_ID_FZA_VENTAS
                                                                         AND FC.STNID_PADRE  = D.STNID
                                                                         AND FC.ID_SEG_NEG = 1
                    WHERE D.ID_SOLICITUD = P_ID_SOLICITUD
                    ORDER BY LINEA ASC, FC.STNID_PORCENTAJE DESC)) E
           ON (b.ID_SOLICITUD = E.ID_SOLICITUD AND B.LINEA = E.LINEA)
           WHEN MATCHED THEN
              UPDATE SET B.LINEA_HNA = E.LINEA_HNA,
                        B.STNID = E.STNID, B.FECHA_INICIO = E.FECHA_INICIO, B.FECHA_FIN = E.FECHA_FIN,
                         B.DURACION = E.DURACION, B.BUYUNTID = E.BUYUNTID, B.HORA_INICIO = E.HORA_INICIO, B.HORA_FIN = E.HORA_FIN,
                         B.SPOTS = E.SPOTS, B.LUNES = E.LUNES, B.MARTES = E.MARTES, B.MIERCOLES = E.MIERCOLES, B.JUEVES = E.JUEVES,
                         B.VIERNES = E.VIERNES, B.SABADO = E.SABADO, B.DOMINGO = E.DOMINGO, B.SPOTS_X_SEMANA = E.SPOTS_X_SEMANA,
                         B.TIPO_SERVICIO = E.TIPO_SERVICIO, B.USR_CHR = E.USR_CHR, B.SPOT_CHR = E.SPOT_CHR, B.BN = E.BN, B.P = E.P,
                         B.MARCA = E.MARCA, B.VERSION = E.VERSION, B.TARIFASP_SIN_DESC = E.TARIFASP_SIN_DESC, B.TARIFASP_CON_DESC = E.TARIFASP_CON_DESC,
                         B.TOT_LINEA_SIN_DESC = E.TOT_LINEA_SIN_DESC, B.TOT_LINEA_CON_DESC = E.TOT_LINEA_CON_DESC, B.SOBRECARGO = E.SOBRECARGO,
                         B.OBSERVACIONES = E.OBSERVACIONES
           WHEN NOT MATCHED THEN
              INSERT (ID_SOLICITUD,  LINEA, LINEA_HNA, STNID, FECHA_INICIO, FECHA_FIN, DURACION, BUYUNTID, HORA_INICIO, HORA_FIN, SPOTS, LUNES, MARTES, MIERCOLES, JUEVES, VIERNES, SABADO, DOMINGO, SPOTS_X_SEMANA, TIPO_SERVICIO, USR_CHR, SPOT_CHR, BN, P, MARCA, VERSION, TARIFASP_SIN_DESC, TARIFASP_CON_DESC, TOT_LINEA_SIN_DESC, TOT_LINEA_CON_DESC, SOBRECARGO, OBSERVACIONES, CREATED_BY, CREATED_DATE, UPDATED_DATE, UPDATED_BY, LINEA_ESTATUS, FECHA_CONCOM, TRACKING_ID_CONCOM, GETRATE_SIN_AJUSTE, GETRATE_CON_AJUSTE)
              VALUES (E.ID_SOLICITUD, E.LINEA, E.LINEA_HNA,
                            E.STNID, E.FECHA_INICIO, E.FECHA_FIN, E.DURACION, E.BUYUNTID, E.HORA_INICIO, E.HORA_FIN, E.SPOTS, E.LUNES, E.MARTES, E.MIERCOLES, E.JUEVES, E.VIERNES, E.SABADO, E.DOMINGO, E.SPOTS_X_SEMANA, E.TIPO_SERVICIO, E.USR_CHR, E.SPOT_CHR, E.BN, E.P, E.MARCA, E.VERSION, E.TARIFASP_SIN_DESC, E.TARIFASP_CON_DESC, E.TOT_LINEA_SIN_DESC, E.TOT_LINEA_CON_DESC, E.SOBRECARGO, E.OBSERVACIONES, E.CREATED_BY, E.CREATED_DATE, E.UPDATED_DATE, E.UPDATED_BY, E.LINEA_ESTATUS, E.FECHA_CONCOM, E.TRACKING_ID_CONCOM, E.GETRATE_SIN_AJUSTE, E.GETRATE_CON_AJUSTE);
           --SE GENERA LA INFORMACION PARA EL ESTATUS REPLICA DE LAS LINEAS "HERMANAS"
           INSERT INTO XXMOR_SOLICITUDES_EST_REP_TAB
                  (ID_SOLICITUD, LINEA,
                   ID_SIST, ESTAT_REP
                  )
           SELECT P_ID_SOLICITUD, SD.LINEA,
                  FS.ID_SIST, 0
           FROM   XXMOR.XXMOR_FZAS_VTAS_SISTEMAS_TAB FS,
                  XXMOR.XXMOR_SOLICITUDES_DET_TAB    SD
           WHERE  SD.ID_SOLICITUD = P_ID_SOLICITUD
           AND    ID_FZA_VENTAS   = P_ID_FZA_VENTAS
           AND    ID_SEG_NEG      = 1
           AND    NOT EXISTS        (SELECT 1
                                     FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER2
                                     WHERE  ER2.ID_SOLICITUD = SD.ID_SOLICITUD
                                     AND    ER2.LINEA        = SD.LINEA
                                    );
    END XXMOR_GENERA_INF_REP_PR;
    PROCEDURE XXMOR_SOL_ESTATUS_PR
                        (
                                P_RESPUESTA IN XXMOR_FUNCIONAL_PKG.MOR_RPTA_CONCOM_TYPE
                        ) IS
    V_ENC_ESTATUS_ACT        INTEGER := 0;
    V_DET_ESTATUS_ACT        INTEGER := 0;
    V_ENC_ESTATUS_NVO        INTEGER := 0;
    V_DET_ESTATUS_NVO        INTEGER := 0;
    V_ENC_EST_TIPO_ACT       VARCHAR2(1);
    V_DET_EST_TIPO_ACT       VARCHAR2(1);
    V_ENC_EST_TIPO_NVO       VARCHAR2(1);
    V_DET_EST_TIPO_NVO       VARCHAR2(1);
    V_DISTINCT_STATUS        INTEGER := 0;
    V_PROC_POR_LINEA         INTEGER;
    V_MASTERC_TOPADO         INTEGER := 0;
    V_LN_STATUS_46           VARCHAR2(2);
    BEGIN
        /*--causa un problema de distribuited transaction
        IF P_RESPUESTA.NUMLINEA_CONCOM IS NOT NULL THEN
            UPDATE XXMOR_SOLICITUDES_DET_TAB
            SET    TRACKING_ID_CONCOM = (SELECT TRACKING_ID_CONCOM
                                         FROM   XXMOR_SOLICITUDES_ENC_TAB
                                         WHERE  ID_SOLICITUD = P_RESPUESTA.ID_SOLICITUD
                                        )
            WHERE  ID_SOLICITUD = P_RESPUESTA.ID_SOLICITUD
            AND    LINEA        = P_RESPUESTA.NUMLINEA_CONCOM;
        END IF;
        */
        --SI SE TRATA DE UNA AUTORIZACION HAY QUE CAMBIAR EL ESTATUS DE LA LINEA
        IF P_RESPUESTA.NUMLINEA_CONCOM IS NOT NULL AND UPPER(P_RESPUESTA.ACCION_CONCOM) = 'AUTORIZACION' THEN
            UPDATE XXMOR_SOLICITUDES_DET_TAB
            SET    LINEA_ESTATUS = 45--, UPDATED_DATE =SYSDATE, UPDATED_BY ='SOL_ESTATUS_PR'
            WHERE  ID_SOLICITUD  = P_RESPUESTA.ID_SOLICITUD
            AND    LINEA         = P_RESPUESTA.NUMLINEA_CONCOM
            AND    LINEA_ESTATUS NOT IN (36,46);
        END IF;
        --SI SE TRATA DE UNA AUTORIZACION DE CPS HAY QUE CAMBIAR EL ESTATUS DEL ENCABEZADO
        IF P_RESPUESTA.NUMLINEA_CONCOM IS NULL AND UPPER(P_RESPUESTA.ACCION_CONCOM) = 'AUTORIZACION' AND P_RESPUESTA.CAMPO_CONCOM = 'CPS' THEN
            UPDATE XXMOR_SOLICITUDES_ENC_TAB
            SET    ORDEN_ESTATUS = 45--, UPDATED_DATE =SYSDATE, UPDATED_BY ='SOL_ESTATUS_PR'
            WHERE  ID_SOLICITUD  = P_RESPUESTA.ID_SOLICITUD
            AND    ORDEN_ESTATUS NOT IN (36,46);
        END IF;
        /*
        SELECT COUNT(1)
        INTO   V_MASTERC_TOPADO
        FROM   XXMOR_CONCOM_RPTA_TAB
        WHERE  INSTR(UPPER(DESC_CONCOM),'MASTER TOPADO') > 0
        AND    NUMLINEA_CONCOM IS NULL
        AND    ID_SOLICITUD    = P_Respuesta.ID_SOLICITUD
        AND    ESTATUS_ORDUNI  = '10';
        IF V_MASTERC_TOPADO > 0 THEN
            UPDATE XXMOR_SOLICITUDES_enc_TAB
            SET ORDEN_ESTATUS  = 45
            WHERE id_solicitud = P_Respuesta.ID_SOLICITUD;
        END IF;
        */
        SELECT NVL2(SE.PROC_POR_LINEA,1,0)
        INTO   V_PROC_POR_LINEA
        FROM   XXMOR_SOLICITUDES_ENC_TAB SE
        WHERE  SE.ID_SOLICITUD = P_RESPUESTA.ID_SOLICITUD;
        DBMS_OUTPUT.PUT_LINE('procesar x Linea: ' || V_PROC_POR_LINEA);
        --EStatus y tipo de estatus del encabezado
        BEGIN
            SELECT E.ID_NOTIFICACION,
                   E.TIPO_ESTATUS
            INTO   V_ENC_ESTATUS_ACT,
                   V_ENC_EST_TIPO_ACT
            FROM   XXMOR_SOLICITUDES_ENC_TAB SE,
                   XXMOR_ORDENES_ESTATUS_TAB E
            WHERE  SE.ID_SOLICITUD         = P_RESPUESTA.ID_SOLICITUD
            AND    NVL(SE.ORDEN_ESTATUS,1) = E.ID_NOTIFICACION
            AND    SE.ID_SEG_NEG           = E.ID_SEG_NEG;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            NULL;
        END;
        DBMS_OUTPUT.PUT_LINE(' P_Respuesta.accion_concom: '||P_RESPUESTA.ACCION_CONCOM);
        --Si es linea
        IF P_RESPUESTA.NUMLINEA_CONCOM IS NOT NULL OR TRIM(P_RESPUESTA.NUMLINEA_CONCOM) !='' THEN
            DBMS_OUTPUT.PUT_LINE('es Linea, ACCION_CONCOM: '|| P_RESPUESTA.ACCION_CONCOM);
            --Si la linea ya esta bien
            IF UPPER(P_RESPUESTA.ACCION_CONCOM) = UPPER('LineaBien') THEN
                V_DET_ESTATUS_NVO := 47;
                UPDATE XXMOR_SOLICITUDES_DET_TAB
                SET    LINEA_ESTATUS = V_DET_ESTATUS_NVO --, UPDATED_DATE =SYSDATE, UPDATED_BY ='SOL_ESTATUS_PR'
                WHERE  ID_SOLICITUD = P_RESPUESTA.ID_SOLICITUD
                AND    LINEA        = P_RESPUESTA.NUMLINEA_CONCOM;
            ELSE
                SELECT NVL(E.TIPO_ESTATUS,'T'),
                       NVL(ID_NOTIFICACION,1)
                INTO   V_DET_EST_TIPO_ACT,
                       V_DET_ESTATUS_ACT
                FROM   XXMOR_SOLICITUDES_DET_TAB D,
                       XXMOR_ORDENES_ESTATUS_TAB E
                WHERE  ID_SOLICITUD    = P_RESPUESTA.ID_SOLICITUD
                AND    LINEA           = P_RESPUESTA.NUMLINEA_CONCOM
                AND    D.LINEA_ESTATUS = E.ID_NOTIFICACION;
                --Si el estatus no esta en rechazado o semana confirmacin
                DBMS_OUTPUT.PUT_LINE('Estatus actual: '||V_DET_ESTATUS_ACT);
                IF V_DET_ESTATUS_ACT NOT IN (36,46) THEN
                    --if INSTR(upper(P_Respuesta.accion_concom), upper('Rechazo')) > 0 or
                    --   INSTR(upper(P_Respuesta.accion_concom), upper('semana')) > 0 or
                    --then
                    --            V_DET_EST_TIPO_ACT := 'T';
                    --end if;
                    V_DET_EST_TIPO_ACT := 'T';
                    -- Si el estatus es transitorio
                    DBMS_OUTPUT.PUT_LINE('Tipo Estatus actual: '||V_DET_EST_TIPO_ACT ||' P_Respuesta.accion_concom: '||P_RESPUESTA.ACCION_CONCOM);
                    IF V_DET_EST_TIPO_ACT = 'T' THEN
                        --Si la respuesta de concom indica que es rechazo poner el estatus 46 (rechazo)
                        IF INSTR(UPPER(P_RESPUESTA.ACCION_CONCOM), UPPER('Rechazo')) > 0 OR INSTR(UPPER(P_RESPUESTA.ESTATUS_CONCOM), UPPER('Rechazo')) > 0THEN          --Rechazo
                            V_DET_ESTATUS_NVO := 46;
                        --Si la respuesta de concom indica que es SEMANA CONFIRMACION poner el estatus 36 (rechazo)
                        ELSIF INSTR(UPPER(P_RESPUESTA.ACCION_CONCOM), UPPER('Retencion')) > 0 THEN
                            V_DET_ESTATUS_NVO := 36;
                        --Si no poner error 45
                        ELSE
                            V_DET_ESTATUS_NVO := 45;
                        END IF;
                        DBMS_OUTPUT.PUT_LINE('Estatus nuevo de la linea: '||V_DET_ESTATUS_NVO);
                        --Actualizamos el estatus
                        UPDATE XXMOR_SOLICITUDES_DET_TAB
                        SET    LINEA_ESTATUS = V_DET_ESTATUS_NVO--, UPDATED_DATE =SYSDATE, UPDATED_BY ='SOL_ESTATUS_PR'
                        WHERE  ID_SOLICITUD = P_RESPUESTA.ID_SOLICITUD
                        AND    LINEA        = P_RESPUESTA.NUMLINEA_CONCOM;
                        /*if V_DET_ESTATUS_NVO in (45,46,36) then
                            V_ENC_ESTATUS_NVO  := 45;
                            update XXMOR_SOLICITUDES_ENC_TAB
                            set ORDEN_ESTATUS = V_ENC_ESTATUS_NVO
                            where id_solicitud = P_Respuesta.ID_SOLICITUD;
                            dbms_output.put_line('Estatus nuevo de la orden: '||V_ENC_ESTATUS_NVO);
                        end if;
                        */
                        --si una linea es rechazada o retenida y la orden NO es procesar x linea se rechaza TODA la orden
                        IF V_DET_ESTATUS_NVO IN (36,46) AND V_PROC_POR_LINEA = 0 THEN
                            UPDATE XXMOR_SOLICITUDES_ENC_TAB
                            SET   ORDEN_ESTATUS = V_DET_ESTATUS_NVO --, UPDATED_DATE =SYSDATE, UPDATED_BY ='SOL_ESTATUS_PR'
                            WHERE ID_SOLICITUD = P_RESPUESTA.ID_SOLICITUD;
                        END IF;
                    END IF;
                END IF;
            END IF;
        --Si es encabezado
        ELSE
            DBMS_OUTPUT.PUT_LINE('Entro a modificar encabezado ');
            IF UPPER(P_RESPUESTA.ACCION_CONCOM) = 'ENCABEZADOBIEN'   THEN
                V_ENC_ESTATUS_NVO := 47;
            ELSIF V_ENC_ESTATUS_ACT NOT IN(36, 46) THEN
                IF INSTR(UPPER(P_RESPUESTA.ACCION_CONCOM), UPPER('Rechazo')) > 0 OR INSTR(UPPER(P_RESPUESTA.ESTATUS_CONCOM), UPPER('Rechazo')) > 0 THEN
                    V_ENC_ESTATUS_NVO := 46;
                    UPDATE XXMOR_SOLICITUDES_DET_TAB
                    SET    LINEA_ESTATUS = V_ENC_ESTATUS_NVO
                    WHERE  ID_SOLICITUD = P_RESPUESTA.ID_SOLICITUD;
                    /*INSERT INTO XXMOR_CONCOM_RPTA_TAB
                             (ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM,
                              RESULTADOGENERAL, TRACKINGID, DESC_CONCOM,
                              POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM,
                              ESTATUS_CONCOM, CAMPO_CONCOM, DETALLE_CONCOM,
                              ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI,
                              CREATED_DATE, CREATED_BY
                             )
                      SELECT E.id_solicitud, 1, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                             NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                             'LINEA', NULL, LINEA,
                             'ERROR', 'HDR_RECHAZADO', 'RECHAZO - El encabezado de la orden fue rechazado',
                             'RECHAZO', NULL, '10',
                             SYSDATE, 'ORDUNI2'
                      FROM   XXMOR_SOLICITUDES_det_TAB d,
                             XXMOR_SOLICITUDES_enc_TAB E
                      WHERE  E.id_solicitud = P_Respuesta.ID_SOLICITUD
                      AND    E.id_solicitud = d.id_solicitud;
                    */
                --Si la respuesta de concom indica que es SEMANA CONFIRMACION poner el estatus 36 (rechazo)
                ELSIF INSTR(UPPER(P_RESPUESTA.ACCION_CONCOM), UPPER('semana')) > 0 THEN
                    V_ENC_ESTATUS_NVO := 36;
                ELSIF INSTR(UPPER(P_RESPUESTA.ACCION_CONCOM), UPPER('EncabezadoBien')) > 0 THEN
                    V_ENC_ESTATUS_NVO := 47;
                --Si no poner error 45
                ELSE
                    V_ENC_ESTATUS_NVO := 45;
                END IF;
                --if V_ENC_EST_TIPO_ACT in (45) then
                UPDATE XXMOR_SOLICITUDES_ENC_TAB
                SET    ORDEN_ESTATUS = V_ENC_ESTATUS_NVO--, UPDATED_DATE =SYSDATE, UPDATED_BY ='SOL_ESTATUS_PR'
                WHERE  ID_SOLICITUD = P_RESPUESTA.ID_SOLICITUD;
                --end if;
            END IF;
        END IF;
        --Si todas las lineas tienen el mismo estatus se pone dicho estatus
        SELECT COUNT(*)
        INTO   V_DISTINCT_STATUS
        FROM   (SELECT DISTINCT LINEA_ESTATUS
                FROM   XXMOR_SOLICITUDES_DET_TAB
                WHERE  ID_SOLICITUD = P_RESPUESTA.ID_SOLICITUD
               );
        DBMS_OUTPUT.PUT_LINE('Num de diferentes status de la orden: '||V_DISTINCT_STATUS);
        IF V_DISTINCT_STATUS = 1 THEN
            SELECT DISTINCT LINEA_ESTATUS
            INTO  V_DET_ESTATUS_ACT
            FROM XXMOR_SOLICITUDES_DET_TAB
            WHERE ID_SOLICITUD = P_RESPUESTA.ID_SOLICITUD;
            --le hace ruido al trigger
            UPDATE XXMOR_SOLICITUDES_ENC_TAB
            SET ORDEN_ESTATUS = V_DET_ESTATUS_ACT--, UPDATED_DATE =SYSDATE, UPDATED_BY ='SOL_ESTATUS_PR'
            WHERE ID_SOLICITUD = P_RESPUESTA.ID_SOLICITUD;
            --jlbs
        END IF;
    END XXMOR_SOL_ESTATUS_PR;
    --Este procedimiento se ejecuta en el servicio MORWrapGuardar
    PROCEDURE XXMOR_PROC_RPTA_CC_PR
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) IS
    V_ES_SOBRECARGO     INTEGER :=0;
    V_VER_HORARIO       INTEGER :=0;
    V_LINEA             INTEGER;
    V_AUX               VARCHAR2(20);
    V_ES_OPENLOG        PLS_INTEGER;
    V_ES_URGENTE        PLS_INTEGER;
    V_MATLOC            VARCHAR2(3);
    V_VERSION_LIN       VARCHAR2(30);
    V_ERRORES_LIN       PLS_INTEGER;
    lin_max_reenvios    INTEGER := 0;
    lin_num_reenvios    INTEGER := 0;
    -- INICIO OMW - Cambio Rechazo de Lineas por CANAL-TIPO SERVICIO, 18-SEP-2019
    lstRechazoCanTserv  VARCHAR2(5);
    linNumRegs          NUMBER := 0;
    -- FIN OMW - Cambio Rechazo de Lineas por CANAL-TIPO SERVICIO, 18-SEP-2019
    CURSOR LINEAS_CONCOM_CUR IS
    SELECT ID_SOLICITUD,
           ID_RPTA_CONCOM,
           RESULTADOGENERAL,
           TRACKINGID,
           DESC_CONCOM,
           POSICION_CONCOM,
           ID_CONCOM,
           NUMLINEA_CONCOM,
           ESTATUS_CONCOM,
           CAMPO_CONCOM,
           DETALLE_CONCOM,
           ACCION_CONCOM,
           TIPOREGLA_CONCOM,
           ESTATUS_ORDUNI,
           ID_SEG_NEG
    FROM   XXMOR_CONCOM_RPTA_TAB
    WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
    -- INICIO OMW - Cambio Rechazo de Lineas por CANAL-TIPO SERVICIO, 18-SEP-2019
    -- Se le agrearon los campos de Canal y Tipo de Servicio al cursor.
    CURSOR LINEAS_ORDEN_CUR IS
    SELECT LINEA,
           STNID,
           TIPO_SERVICIO
    FROM   XXMOR_SOLICITUDES_DET_TAB
    WHERE  ID_SOLICITUD =  P_ID_SOLICITUD;
    -- FIN OMW - Cambio Rechazo de Lineas por CANAL-TIPO SERVICIO, 18-SEP-2019
    BEGIN
        SELECT NVL(MATLOC,'0')
        INTO   V_MATLOC
        FROM   XXMOR_FZAS_VTAS_TAB
        WHERE  ID_FZA_VENTAS = (SELECT ID_FZA_VENTAS
                                FROM   XXMOR_SOLICITUDES_ENC_TAB
                                WHERE ID_SOLICITUD = P_ID_SOLICITUD
                               )
        AND ID_SEG_NEG       = 1;
        --Revisamos si la orden tiene lineas  urgentes
        XXMOR_AUT_URGENTE_FUN (P_ID_SOLICITUD, 1);
        --Revisamos si la orden tiene lineas OPEN LOG
        XXMOR_AUT_OPENLOG_FUN (P_ID_SOLICITUD, 1, V_AUX);
        --Si hubiese lineas con reenvio aqui se podria meter el enviar a concom y actualizar el estatus orduni a conveniencia
        --Se actualiza el estatus de las lineas de rtpa_concom de la orden si es que tuvo reenvio
        /*UPDATE XXMOR_CONCOM_RPTA_TAB CR
        SET    CR.ESTATUS_ORDUNI = '20',
               CR.UPDATED_BY     = 'ORDUNI',
               CR.UPDATED_DATE   = SYSDATE
        WHERE  UPPER(CR.ACCION_CONCOM) = 'REENVIO'
        AND    CR.ESTATUS_ORDUNI       = '10'
        AND    CR.ID_SOLICITUD         = P_ID_SOLICITUD;*/
        --Omitimos todos los "errores" de version de la orden provenientes de concom para las lineas que contienen VER PAUTA
        --conforme al correo del 13-Dic-2012
        UPDATE XXMOR_CONCOM_RPTA_TAB CR
        SET    CR.ESTATUS_ORDUNI = '20',
               CR.UPDATED_BY     = 'ORDUNI',
               CR.UPDATED_DATE   = SYSDATE
        WHERE  CR.ID_SOLICITUD   = P_ID_SOLICITUD
        AND    CR.ESTATUS_ORDUNI = '10'
        AND    EXISTS              (SELECT 1
                                    FROM   XXMOR_SOLICITUDES_DET_TAB
                                    WHERE  UPPER(VERSION)                = 'VER PAUTA'
                                    AND    ID_SOLICITUD                  = P_ID_SOLICITUD
                                    AND    TO_NUMBER(CR.NUMLINEA_CONCOM) = LINEA
                                   )
        AND INSTR(UPPER(DESC_CONCOM),'VERSION') = 1;
        -- 06-09-2013 MANEJO REENVIOS DE LA RESPUESTA DE CONCOM
        -- CODIGO PARA VALIDAR QUE SI SE HA ALACANZADO EL NUNMERO MAXIMO DE REENVIOS A CONCOM SE RECHACE EL ENCABEZADO
        -- PRIMERO SE OBTIENE EL NUMERO MAXIMO DE REENVIOS CONFIGURADO EN LOS PARAMETROS GENERALES
        lin_max_reenvios := 0;
        BEGIN
            SELECT TO_NUMBER(VALOR_PARAMETRO) NUM_REENVIOS
            INTO   lin_max_reenvios
            FROM   XXMOR_CONF_PARAMS_GRLS_TAB
            WHERE  NOMBRE_PARAMETRO  = 'NUM_REENVIOS_CONCOM';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                lin_max_reenvios := 0;
            WHEN OTHERS THEN
                lin_max_reenvios := 0;
        END;
        -- se obtiene el numero de reenvios que ya se generaron a nivel encabezado
        lin_num_reenvios := 0;
        SELECT COUNT(1)
        INTO   lin_num_reenvios
        FROM   XXMOR_CONCOM_RPTA_TAB
        WHERE  NUMLINEA_CONCOM         IS NULL
        AND    UPPER(RESULTADOGENERAL) = 'REENVIO'
        AND    ID_SOLICITUD            = P_ID_SOLICITUD;
        IF lin_max_reenvios > 0 THEN
            IF lin_num_reenvios > 0 THEN
                IF lin_num_reenvios = lin_max_reenvios THEN
                    --Se actualiza el estatus de las lineas de rtpa_concom de la orden si es que tuvo reenvio el encabezado
                    UPDATE XXMOR_CONCOM_RPTA_TAB CR
                    SET    CR.ESTATUS_ORDUNI   = '20',
                           CR.UPDATED_BY       = 'ORDUNI2',
                           CR.UPDATED_DATE     = SYSDATE
                    WHERE  CR.NUMLINEA_CONCOM        IS NULL
                    AND    UPPER(CR.ACCION_CONCOM)   = 'REENVIO'
                    AND    CR.ESTATUS_ORDUNI         = '10'
                    AND    CR.ID_SOLICITUD           = P_ID_SOLICITUD;
                    -- se inserta el registro de rechazo para el encabezado
                    INSERT INTO XXMOR_CONCOM_RPTA_TAB
                                (
                                        ID_SOLICITUD,     ID_RPTA_CONCOM,
                                        RESULTADOGENERAL, TRACKINGID,
                                        DESC_CONCOM,      POSICION_CONCOM,
                                        ID_CONCOM,        ESTATUS_CONCOM,
                                        CAMPO_CONCOM,     DETALLE_CONCOM,
                                        ACCION_CONCOM,    TIPOREGLA_CONCOM,
                                        ESTATUS_ORDUNI,   CREATED_DATE,
                                        CREATED_BY,       ID_SEG_NEG
                                )
                    VALUES      (
                                        P_ID_SOLICITUD, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                                        'Sin Reenvio', XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                                        'La orden no pudo ser procesada por ConCom', 'Encabezado',
                                        NULL, 'Error',
                                        'Encabezado', 'Rechazo por reenvios',
                                        'Rechazo', NULL,
                                        '10', SYSDATE,
                                        'ORDUNI2', 1
                                );
                ELSIF lin_num_reenvios < lin_max_reenvios THEN
                    UPDATE XXMOR_CONCOM_RPTA_TAB CR
                    SET    CR.ESTATUS_ORDUNI = '20',
                           CR.UPDATED_BY     = 'ORDUNI',
                           CR.UPDATED_DATE   = SYSDATE
                    WHERE  CR.NUMLINEA_CONCOM        IS NULL
                    AND    UPPER(CR.ACCION_CONCOM)   = 'REENVIO'
                    AND    CR.ESTATUS_ORDUNI         = '10'
                    AND    CR.ID_SOLICITUD           = P_ID_SOLICITUD;
                END IF;
            END IF;
        ELSE
            -- Se inserta en la tabla de errores que no existe el parametro de reenvios configurado.
            INSERT INTO XXMOR_LOG_ERRORES_TAB
                        (
                                ID_ERROR,
                                DESC_ERROR,
                                ARCHIVO_ERROR,
                                METODO_ERROR,
                                HORA_ERROR
                        )
            VALUES      (       XXMOR.XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                'No existe configurado el Valor Maximo de Renvios, en la Tabla XXMOR_CONF_PARAMS_GRLS_TAB o su Valor es 0',
                                'XXMOR_FUNCIONAL_PKG',
                                'XXMOR_PROC_RPTA_CC_PR',
                                SYSDATE
                        );
            IF lin_num_reenvios > 0 THEN
                --Si hubiese lineas con reenvio aqui se podria meter el enviar a concom y actualizar el estatus orduni a conveniencia
                --Se actualiza el estatus de las lineas de rtpa_concom de la orden si es que tuvo reenvio
                UPDATE XXMOR_CONCOM_RPTA_TAB CR
                SET    CR.ESTATUS_ORDUNI = '20',
                       CR.UPDATED_BY     = 'ORDUNI',
                       CR.UPDATED_DATE   = SYSDATE
                WHERE  UPPER(CR.ACCION_CONCOM) = 'REENVIO'
                AND    CR.ESTATUS_ORDUNI       = '10'
                AND    CR.ID_SOLICITUD         = P_ID_SOLICITUD;
            END IF;
        END IF;
        -- PARA RESOLVER EL CONFLICTO DEL LAS VERSIONES EN ORDENES URGENTES
        -- Si esta respuesta contiene la cadena ?|VersionHorario? en el campo Detalle, entonces decides si la mostraras como error o no
        FOR RPTA_CONCOM IN LINEAS_CONCOM_CUR LOOP
            IF RPTA_CONCOM.CAMPO_CONCOM = 'Request/Orden/Encabezado/CPSMasterContract' AND RPTA_CONCOM.ACCION_CONCOM = 'Autorizacion' THEN
                UPDATE XXMOR_CONCOM_RPTA_TAB
                SET    ESTATUS_ORDUNI = '20',
                       UPDATED_BY     = 'ORDUNI',
                       UPDATED_DATE   = SYSDATE
                WHERE  ID_SOLICITUD           = P_ID_SOLICITUD
                AND    ACCION_CONCOM          = 'Autorizacion'
                AND    UPDATED_BY             IS NULL
                AND    UPPER(POSICION_CONCOM) = 'ENCABEZADO'
                AND    CAMPO_CONCOM           = 'Request/Orden/Encabezado/CPSMasterContract'
                AND    ESTATUS_ORDUNI         = '10'
                AND    (SELECT COUNT(1)
                        FROM   XXMOR_CONCOM_RPTA_TAB
                        WHERE  ID_SOLICITUD           = P_ID_SOLICITUD
                        AND    ACCION_CONCOM          = 'Autorizacion'
                        AND    UPDATED_BY             IS NOT NULL
                        AND    UPPER(POSICION_CONCOM) = 'ENCABEZADO'
                        AND    CAMPO_CONCOM           = 'Request/Orden/Encabezado/CPSMasterContract'
                        AND    ESTATUS_ORDUNI         = '20'
                       )                      > 0;
            END IF;
            --REVISAMOS LA PARTE DE MATLOC
            IF V_MATLOC <> '0' THEN
                --TIENE QUE SER UN ERROR RELACIONADO A UNA LINEA
                IF RPTA_CONCOM.NUMLINEA_CONCOM IS NOT NULL THEN
                    --TRAEMOS LA VERSION DE LA LINEA
                    SELECT VERSION
                    INTO   V_VERSION_LIN
                    FROM   XXMOR_SOLICITUDES_DET_TAB
                    WHERE  ID_SOLICITUD = RPTA_CONCOM.ID_SOLICITUD
                    AND    LINEA        = RPTA_CONCOM.NUMLINEA_CONCOM;
                    /*  31-Oct-2012 -lugar de tavo
                        Se decidio QUITAR las reglas de version vacia de concom
                        y comentar estos updates
                    */
                    --SI NO TRAE VERSION -> SE DEJA PASAR
                    IF V_VERSION_LIN IS NULL THEN
                        UPDATE XXMOR_CONCOM_RPTA_TAB
                        SET    ESTATUS_ORDUNI = '20',
                               UPDATED_BY     = 'ORDUNI',
                               UPDATED_DATE   = SYSDATE
                        WHERE  ID_SOLICITUD   = P_ID_SOLICITUD
                        AND    ID_RPTA_CONCOM = RPTA_CONCOM.ID_RPTA_CONCOM
                        AND    INSTR(DETALLE_CONCOM,'La duracion') > 0
                        AND    INSTR(DETALLE_CONCOM,'no existe en paradigm') > 0;
                        UPDATE XXMOR_CONCOM_RPTA_TAB
                        SET    ESTATUS_ORDUNI = '20',
                               UPDATED_BY = 'ORDUNI',
                               UPDATED_DATE = SYSDATE
                        WHERE  ID_SOLICITUD   = P_ID_SOLICITUD
                        AND    ID_RPTA_CONCOM = RPTA_CONCOM.ID_RPTA_CONCOM
                        AND    INSTR(DETALLE_CONCOM,'La version  no contiene ningun caracter.') >0
                        AND    UPPER(ACCION_CONCOM)  != 'RECHAZO';
                        UPDATE XXMOR_CONCOM_RPTA_TAB
                        SET    ESTATUS_ORDUNI = '20'
                        WHERE  ID_SOLICITUD = (SELECT ID_SOLICITUD
                                               FROM   XXMOR_SOLICITUDES_ENC_TAB
                                               WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                               AND    ADVID        IS NOT NULL
                                              )
                        AND ID_RPTA_CONCOM  = RPTA_CONCOM.ID_RPTA_CONCOM
                        AND INSTR(DETALLE_CONCOM,'La version  o el cliente') >0
                        AND INSTR(DETALLE_CONCOM,'viene vacio.') >0;
                    END IF;
                END IF;
            END IF;
            SELECT COUNT(1)
            INTO   V_VER_HORARIO
            FROM   DUAL
            WHERE  INSTR(RPTA_CONCOM.DETALLE_CONCOM,'VersionHorario') > 0;
            DBMS_OUTPUT.PUT_LINE('RPTA_CONCOM.DETALLE_CONCOM: '||RPTA_CONCOM.DETALLE_CONCOM);
            IF V_VER_HORARIO = 1 THEN
                SELECT COUNT(1)
                INTO   V_ES_OPENLOG
                FROM   XXMOR_CONCOM_RPTA_TAB
                WHERE  CAMPO_CONCOM    = 'OPENLOG'
                AND    ID_SOLICITUD    = P_ID_SOLICITUD
                AND    NUMLINEA_CONCOM = RPTA_CONCOM.NUMLINEA_CONCOM;
                SELECT COUNT(1)
                INTO   V_ES_URGENTE
                FROM   XXMOR_CONCOM_RPTA_TAB
                WHERE  CAMPO_CONCOM    = 'URGENTE'
                AND    ID_SOLICITUD    = P_ID_SOLICITUD
                AND    NUMLINEA_CONCOM = RPTA_CONCOM.NUMLINEA_CONCOM;
                IF V_ES_URGENTE > 0 OR V_ES_OPENLOG > 0 THEN
                    --Si la linea es urgente u open log, muestras el error que haya sido reportado con esta leyenda.
                    NULL;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('NO ES URGENTE NI OPENLOG: '||RPTA_CONCOM.NUMLINEA_CONCOM);
                    -- Si la linea no es urgente ni open log, no muestras el error, ni lo tomas en cuenta, y no escribes COPYS
                    -- no generar copys se encuentra en la vista XXMOR_PARA_COPY_VW
                    -- 11/Enero/2013 Se agrega el comentario en la linea de la version
                    UPDATE XXMOR_SOLICITUDES_DET_TAB D
                    SET    D.OBSERVACIONES = D.VERSION
                    WHERE  D.ID_SOLICITUD = P_ID_SOLICITUD
                    AND    EXISTS           (SELECT 1
                                             FROM   XXMOR_CONCOM_RPTA_TAB RC
                                             WHERE  RC.ID_SOLICITUD               = P_ID_SOLICITUD
                                             AND    RC.ESTATUS_ORDUNI             = '10'
                                             AND    RC.NUMLINEA_CONCOM            = RPTA_CONCOM.NUMLINEA_CONCOM
                                             AND    INSTR(RC.DETALLE_CONCOM,'VersionHorario') > 0
                                             AND    RC.ACCION_CONCOM             != 'AUTORIZACION'
                                             AND    RC.ID_SOLICITUD               = D.ID_SOLICITUD
                                             AND    TO_NUMBER(RC.NUMLINEA_CONCOM) = D.LINEA
                                            );
                    -- Se cambio el valor con el que se actualiza ESTATUS_ORDUNI por '30' esto
                    -- para poder manejar cuando se generan Copys y cuando no por VersionHorario
                    -- OMW 09-MAY-2016
                    UPDATE XXMOR_CONCOM_RPTA_TAB
                    SET    ESTATUS_ORDUNI = '30',
                           UPDATED_BY     = 'ORDUNI',
                           UPDATED_DATE   = SYSDATE
                    WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
                    AND    ESTATUS_ORDUNI  = '10'
                    AND    NUMLINEA_CONCOM = RPTA_CONCOM.NUMLINEA_CONCOM
                    AND    INSTR(DETALLE_CONCOM,'VersionHorario') > 0
                    AND    ACCION_CONCOM  != 'AUTORIZACION';
                END IF;
            END IF;
            --SE IGNORAN LAS RESPUESTAS DE CONCOM CUYAS LINEAS YA FUERON INSERTADAS EN PARADIGM
            UPDATE XXMOR_CONCOM_RPTA_TAB CR
            SET    CR.ESTATUS_ORDUNI = '20',
                   CR.UPDATED_BY     = 'ORDUNI',
                   CR.UPDATED_DATE   = SYSDATE
            WHERE  CR.ID_SOLICITUD   = P_ID_SOLICITUD
            AND    CR.ID_RPTA_CONCOM = RPTA_CONCOM.ID_RPTA_CONCOM
            AND    CR.ESTATUS_ORDUNI = '10'
            AND    EXISTS              (SELECT 1
                                        FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                                        WHERE  ER.ID_SOLICITUD  = CR.ID_SOLICITUD
                                        AND    ER.LINEA         = TO_NUMBER(CR.NUMLINEA_CONCOM)
                                        AND    ESTAT_ID_FORANEO IS NOT NULL
                                       );
            -- 06-09-2013 MANEJO REENVIOS DE LA RESPUESTA DE CONCOM
            -- se obtiene el numero de reenvios que ya se generaron a nivel linea
            lin_num_reenvios := 0;
            SELECT COUNT(1)
            INTO   lin_num_reenvios
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  UPPER(POSICION_CONCOM)  = 'LINEA'
            AND    UPPER(RESULTADOGENERAL) = 'REENVIO'
            AND    UPPER(ACCION_CONCOM)    = 'REENVIO'
            AND    ID_SOLICITUD            = P_ID_SOLICITUD
            AND    NUMLINEA_CONCOM         = RPTA_CONCOM.NUMLINEA_CONCOM;
            IF lin_max_reenvios > 0 THEN
                IF lin_num_reenvios > 0 THEN
                    IF lin_num_reenvios = lin_max_reenvios THEN
                        -- Se actualiza el estatus de las lineas de rtpa_concom de la orden
                        -- si es que tuvo reenvio la linea que se esta procesando.
                        UPDATE XXMOR_CONCOM_RPTA_TAB CR
                        SET    CR.ESTATUS_ORDUNI   = '20',
                               CR.UPDATED_BY       = 'ORDUNI2',
                               CR.UPDATED_DATE     = SYSDATE
                        WHERE  UPPER(CR.POSICION_CONCOM)  = 'LINEA'
                        AND    UPPER(CR.RESULTADOGENERAL) = 'REENVIO'
                        AND    UPPER(CR.ACCION_CONCOM)    = 'REENVIO'
                        AND    CR.ID_SOLICITUD            = P_ID_SOLICITUD
                        AND    CR.NUMLINEA_CONCOM         = RPTA_CONCOM.NUMLINEA_CONCOM;
                        -- se inserta el registro de rechazo para la Linea
                        INSERT INTO XXMOR_CONCOM_RPTA_TAB
                                    (
                                            ID_SOLICITUD,     ID_RPTA_CONCOM,
                                            RESULTADOGENERAL, TRACKINGID,
                                            DESC_CONCOM,      POSICION_CONCOM,
                                            ID_CONCOM,        NUMLINEA_CONCOM,
                                            ESTATUS_CONCOM,   CAMPO_CONCOM,
                                            DETALLE_CONCOM,   ACCION_CONCOM,
                                            TIPOREGLA_CONCOM, ESTATUS_ORDUNI,
                                            CREATED_DATE,     CREATED_BY,
                                            ID_SEG_NEG
                                    )
                        VALUES      (
                                            P_ID_SOLICITUD, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                                            'Sin Reenvio', XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                                            'La Linea no pudo ser procesada por ConCom', 'Linea',
                                            NULL, RPTA_CONCOM.NUMLINEA_CONCOM,
                                            'Error', 'Linea',
                                            'Rechazo por reenvios', 'Rechazo',
                                            NULL, '10',
                                            SYSDATE, 'ORDUNI2', 1
                                    );
                    ELSIF lin_num_reenvios < lin_max_reenvios THEN
                        UPDATE XXMOR_CONCOM_RPTA_TAB CR
                        SET    CR.ESTATUS_ORDUNI = '20',
                               CR.UPDATED_BY     = 'ORDUNI',
                               CR.UPDATED_DATE   = SYSDATE
                        WHERE  UPPER(CR.POSICION_CONCOM)  = 'LINEA'
                        AND    UPPER(CR.RESULTADOGENERAL) = 'REENVIO'
                        AND    UPPER(CR.ACCION_CONCOM)    = 'REENVIO'
                        AND    CR.ESTATUS_ORDUNI          = '10'
                        AND    CR.ID_SOLICITUD            = P_ID_SOLICITUD
                        AND    CR.NUMLINEA_CONCOM         = RPTA_CONCOM.NUMLINEA_CONCOM;
                    END IF;
                END IF;
            ELSE
                -- Se inserta en la tabla de errores que no existe el parametro de reenvios configurado.
                INSERT INTO XXMOR_LOG_ERRORES_TAB
                            (
                                    ID_ERROR,
                                    DESC_ERROR,
                                    ARCHIVO_ERROR,
                                    METODO_ERROR,
                                    HORA_ERROR
                            )
                VALUES      (       XXMOR.XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                    'No existe configurado el Valor Maximo de Renvios, en la Tabla XXMOR_CONF_PARAMS_GRLS_TAB o su Valor es 0',
                                    'XXMOR_FUNCIONAL_PKG',
                                    'XXMOR_PROC_RPTA_CC_PR',
                                    SYSDATE
                            );
            END IF;
        END LOOP;
        --Se elimina la informacion de las autorizaciones de open log y orden urgente
        --        DELETE FROM XXMOR_CONCOM_RPTA_TAB CR
        --        WHERE CR.CAMPO_CONCOM IN ( 'URGENTE')
        --        AND ID_SOLICITUD = P_ID_SOLICITUD
        --        AND RESULTADOGENERAL = '1'
        --        AND TRACKINGID =(SELECT MAX(TRACKINGID)
        --                                     FROM XXMOR_CONCOM_RPTA_TAB
        --                                     WHERE CR.CAMPO_CONCOM IN ( 'URGENTE')
        --                                     AND RESULTADOGENERAL = '1'
        --                                     AND   ID_SOLICITUD = P_ID_SOLICITUD);
        --
        --        DELETE FROM XXMOR_CONCOM_RPTA_TAB CR
        --        WHERE CR.CAMPO_CONCOM IN ( 'OPENLOG')
        --        AND ID_SOLICITUD = P_ID_SOLICITUD
        --        AND RESULTADOGENERAL = '1'
        --        AND TRACKINGID =(SELECT MAX(TRACKINGID)
        --                                     FROM XXMOR_CONCOM_RPTA_TAB
        --                                     WHERE CR.CAMPO_CONCOM IN ( 'OPENLOG')
        --                                     AND RESULTADOGENERAL = '1'
        --                                     AND   ID_SOLICITUD = P_ID_SOLICITUD);
        --        AND NUMLINEA_CONCOM not in (SELECT DISTINCT NUMLINEA_CONCOM
        --                                                   FROM XXMOR_CONCOM_RPTA_TAB
        --                                                   WHERE ID_SOLICITUD = P_ID_SOLICITUD
        --                                                   AND ESTATUS_ORDUNI = '20'
        --                                                   AND INSTR(DETALLE_CONCOM,'VersionHorario') > 0);
        /*
          SELECT COUNT(1)
          INTO   V_ES_SOBRECARGO
          FROM   XXMOR_CONCOM_RPTA_TAB
          WHERE  ID_SOLICITUD = P_ID_SOLICITUD
          AND    CAMPO_CONCOM = 'SOBRECARGO';
          UPDATE XXMOR_CONCOM_RPTA_TAB
          SET ESTATUS_ORDUNI = '20'
          WHERE ID_SOLICITUD = P_ID_SOLICITUD
          AND     NUMLINEA_CONCOM IN (SELECT LINEA
                                      FROM XXMOR_SOLICITUDES_DET_TAB
                                      WHERE VERSION = 'VER PAUTA'
                                      AND ID_SOLICITUD = P_ID_SOLICITUD )
          AND     INSTR(DESC_CONCOM,'VERSION -') > 0;
          IF V_ES_SOBRECARGO = 0 THEN
              UPDATE XXMOR_CONCOM_RPTA_TAB
              SET ESTATUS_ORDUNI = '20'
              WHERE ID_SOLICITUD = P_ID_SOLICITUD
              AND     INSTR(UPPER(DETALLE_CONCOM),'HORARIO')>0;
              --AND 1=2; --Este update esta incompleto revisar
          END IF;
        */
        -- se definio el 31 Oct 12 que se meteria una linea de rpta concom que diga explicitamente que la linea esta bien en caso de que
        -- cuando entren lineas "mal" y se omitan quede un registro que diga que existe una linea que diga que ya esta bien.
        FOR LINEA_ORDEN IN LINEAS_ORDEN_CUR LOOP
            SELECT COUNT(1)
            INTO   V_ERRORES_LIN
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD    = P_ID_SOLICITUD
            AND    NUMLINEA_CONCOM = TO_CHAR(LINEA_ORDEN.LINEA)
            AND    ESTATUS_ORDUNI  = '10';
            IF V_ERRORES_LIN = 0 THEN
                INSERT INTO XXMOR_CONCOM_RPTA_TAB
                                 (
                                         ID_SOLICITUD,     ID_RPTA_CONCOM,
                                         RESULTADOGENERAL, TRACKINGID,
                                         NUMLINEA_CONCOM,  ACCION_CONCOM,
                                         ESTATUS_ORDUNI,   CREATED_DATE,
                                         CREATED_BY,       ID_SEG_NEG
                                 )
                VALUES           (
                                         P_ID_SOLICITUD, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                                         'Bien', XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                                         TO_CHAR(LINEA_ORDEN.LINEA), 'LineaBien',
                                         '20', SYSDATE,
                                         'ConComWsResponseSP', 1
                                 );
            END IF;
            V_ERRORES_LIN := 0;
            SELECT COUNT(1)
            INTO   V_ERRORES_LIN
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD             = P_ID_SOLICITUD
            AND    NVL(NUMLINEA_CONCOM,'0') = TO_CHAR(LINEA_ORDEN.LINEA)
            AND    UPPER(ACCION_CONCOM)     = 'RECHAZO'
            AND    ESTATUS_ORDUNI           = '10';
            IF V_ERRORES_LIN > 0 THEN
                --PARA ACTUALIZAR A ESTATUS 20 LAS LINEAS QUE CONCOM RECHAZA Y QUE
                --POR REPROCESOS ANTERIORES (O DE LA ULTIMA RESPUESTA DE CONCOM( TIENEN AUTORIZACIONES O REPROCESOS (QUE YA NO TIENEN CASO)
                UPDATE XXMOR_CONCOM_RPTA_TAB CR
                SET    CR.ESTATUS_ORDUNI = '20',
                       CR.UPDATED_BY     = 'ORDUNI',
                       CR.UPDATED_DATE   = SYSDATE
                WHERE  CR.ID_SOLICITUD   = P_ID_SOLICITUD
                AND    UPPER(CR.ACCION_CONCOM) IN ('REPROCESO','AUTORIZACION')
                AND    CR.NUMLINEA_CONCOM      = TO_CHAR(LINEA_ORDEN.LINEA)
                AND    CR.ESTATUS_ORDUNI       = '10';
            -- INICIO OMW - Cambio Rechazo de Lineas por CANAL-TIPO SERVICIO, 18-SEP-2019
            ELSIF V_ERRORES_LIN = 0 THEN
                -- Se verifica si se deben rechazar Lineas por Canal-Tipo Servicio configurados en la tabla XXMOR_MAP_CANAL_TSERV_RECH_TAB
                BEGIN
                    lstRechazoCanTserv := 'N';
                    SELECT NVL(VALOR_PARAMETRO,'N') RECHAZO_CANAL_TSERV
                    INTO   lstRechazoCanTserv
                    FROM   XXMOR_CONF_PARAMS_GRLS_TAB
                    WHERE  UPPER(NOMBRE_PARAMETRO) = 'RECHAZO_CANAL_TIPO_SERVICIO';
                EXCEPTION
                    WHEN OTHERS THEN
                        lstRechazoCanTserv := 'N';
                END;
                IF lstRechazoCanTserv = 'S' THEN
                    -- Se valida si el Canal y Tipo de Servicio de la linea, existe actuvo en la tabla
                    -- XXMOR_MAP_CANAL_TSERV_RECH_TAB.
                    linNumRegs := 0;
                    BEGIN
                        SELECT COUNT(1)
                        INTO   linNumRegs
                        FROM   XXMOR_MAP_CANAL_TSERV_RECH_TAB
                        WHERE  ACTIVO        = '1'
                        AND    CANAL         = LINEA_ORDEN.STNID
                        AND    TIPO_SERVICIO = LINEA_ORDEN.TIPO_SERVICIO;
                    EXCEPTION
                        WHEN OTHERS THEN
                            linNumRegs := 0;
                    END;
                    -- Si la combinacion de Canal y Tipo de Servicio existe, se rechaza la linea.
                    IF linNumRegs > 0 THEN
                        INSERT INTO XXMOR_CONCOM_RPTA_TAB
                               ( ID_SOLICITUD, ID_SEG_NEG, ID_RPTA_CONCOM, RESULTADOGENERAL, TRACKINGID,   DESC_CONCOM,
                                 POSICION_CONCOM, ID_CONCOM, NUMLINEA_CONCOM, ESTATUS_CONCOM, CAMPO_CONCOM,
                                 DETALLE_CONCOM, ACCION_CONCOM, TIPOREGLA_CONCOM, ESTATUS_ORDUNI, CREATED_DATE,
                                 CREATED_BY
                               )
                        SELECT E.ID_SOLICITUD, ID_SEG_NEG, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL, XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL, NULL,
                               'LINEA', NULL,D.LINEA, 'ERROR','RECHAZO CANAL-TIPO SERVICIO',
                               'RECHAZO - El Canal '||LINEA_ORDEN.STNID||' y Tipo de Servicio: '||LINEA_ORDEN.TIPO_SERVICIO||' estan configurados para Rechazo', 'RECHAZO', NULL,'10', SYSDATE,
                               'ORDUNI2'
                        FROM   XXMOR_SOLICITUDES_DET_TAB D,
                               XXMOR_SOLICITUDES_ENC_TAB E
                        WHERE  E.ID_SOLICITUD = P_ID_SOLICITUD
                        AND    E.ID_SOLICITUD = D.ID_SOLICITUD
                        AND    D.LINEA        = LINEA_ORDEN.LINEA
                        AND    NOT EXISTS       (SELECT 1
                                                 FROM   XXMOR_CONCOM_RPTA_TAB C
                                                 WHERE  C.ID_SOLICITUD         = D.ID_SOLICITUD
                                                 AND    C.NUMLINEA_CONCOM      = D.LINEA
                                                 AND    C.NUMLINEA_CONCOM      IS NOT NULL
                                                 AND    C.CAMPO_CONCOM         = 'RECHAZO CANAL-TIPO SERVICIO'
                                                 AND    UPPER(C.ACCION_CONCOM) = 'RECHAZO'
                                                 AND    TO_NUMBER(D.LINEA)     = TO_NUMBER(C.NUMLINEA_CONCOM)
                                                );
                    END IF;
                END IF;
            -- FIN OMW - Cambio Rechazo de Lineas por CANAL-TIPO SERVICIO, 18-SEP-2019
            END IF;
        END LOOP;
        --pARA REVISAR LO DE LOS COPYS DEL COPY JOB LIST
        XXMOR_COPY_UPDATE_PR(P_ID_SOLICITUD);
    END XXMOR_PROC_RPTA_CC_PR;
    PROCEDURE XXMOR_COPY_UPDATE_PR
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) IS
    V_COUNT_COPY_VC        PLS_INTEGER;
    V_COPY_X_ORDEN         VARCHAR2(1);
    V_LINEA_CON_COPY       INTEGER;
    V_MIN_LINEA_VC         INTEGER;
    V_ID_FZA_VENTAS        INTEGER;
    CURSOR LINEAS_ORD_CUR IS
    SELECT VERSION,STNID,
    CASE WHEN COUNT(VERSION) = 1
            THEN MIN (LINEA)
            ELSE 0
            END
    AS NUMLINE
    FROM XXMOR_SOLICITUDES_DET_TAB
    WHERE ID_SOLICITUD = P_ID_SOLICITUD
    HAVING COUNT(VERSION) > 1
    GROUP BY VERSION, STNID;
    BEGIN
        -- SE MODIFICO ESTO POR LA FUNCION PARA SABER SI LA SOLICITUD
        -- MANEJA COPYS POR ORDEN O POR LINEA 27-MAY-2013
        /*SELECT TO_NUMBER(NVL(COPYS_X_ORDEN,0))
          INTO V_COPY_X_ORDEN
          FROM XXMOR_FZAS_VTAS_TAB
          WHERE ID_FZA_VENTAS = (SELECT ID_FZA_VENTAS
                                 FROM   XXMOR_SOLICITUDES_ENC_TAB
                                 WHERE ID_SOLICITUD = P_ID_SOLICITUD
                                );
        */
        SELECT ID_FZA_VENTAS
        INTO   V_ID_FZA_VENTAS
        FROM   XXMOR_SOLICITUDES_ENC_TAB
        WHERE ID_SOLICITUD = P_ID_SOLICITUD;
        V_COPY_X_ORDEN := XXMOR_FUNCIONAL_PKG.XXMOR_COPYS_POR_ORDEN_FN(V_ID_FZA_VENTAS,P_ID_SOLICITUD);
        --IF V_COPY_X_ORDEN > 0 THEN
        IF V_COPY_X_ORDEN = 'Y' THEN
            dbms_output.put_line(' --COPYS POR ORDEN: '||V_COPY_X_ORDEN );
            FOR C_VER_STN IN LINEAS_ORD_CUR LOOP
                --CONTAMOS SI LA COMBINACION VERSION CANAL YA TIENE COPYS
                SELECT COUNT(1)
                INTO   V_COUNT_COPY_VC
                FROM   XXMOR_SOLICITUDES_DET_TAB     D,
                       XXMOR_SOLICITUDES_EST_REP_TAB R
                WHERE  D.ID_SOLICITUD = R.ID_SOLICITUD
                AND    R.LINEA        = D.LINEA
                AND    D.VERSION      = C_VER_STN.VERSION
                AND    D.STNID        = C_VER_STN.STNID
                AND    R.ROTID        IS NOT NULL;
                dbms_output.put_line(' --YA TIENE COPYS?: '||V_COUNT_COPY_VC );
                -- SI YA TIENE ENTONCES REVISAMOS Q LA LINEA A LA QUE SE LE ASIGNO EL COPY SEA LA MENOR
                -- SI NO ENTONCES BORRAMOS
                IF V_COUNT_COPY_VC > 0 THEN
                    --SACAMOS LA LINEA Q TIENE EL COPY
                    SELECT MIN(R.LINEA)
                    INTO   V_LINEA_CON_COPY
                    FROM   XXMOR_SOLICITUDES_DET_TAB D,
                           XXMOR_SOLICITUDES_EST_REP_TAB R
                    WHERE  R.ID_SOLICITUD = p_ID_SOLICITUD
                    AND    D.ID_SOLICITUD = R.ID_SOLICITUD
                    AND    R.LINEA        = D.LINEA
                    AND    D.VERSION      = C_VER_STN.VERSION
                    AND    D.STNID        = C_VER_STN.STNID
                    AND    R.ROTID        IS NOT NULL;
                    dbms_output.put_line(' --LINEA CON COPY: '||V_LINEA_CON_COPY );
                    --SACAMOS LA MENOR DE LAS LINEAS EN GENERAL
                    SELECT MIN(R.LINEA)
                    INTO   V_MIN_LINEA_VC
                    FROM   XXMOR_SOLICITUDES_DET_TAB D,
                           XXMOR_SOLICITUDES_EST_REP_TAB R
                    WHERE  R.ID_SOLICITUD = p_ID_SOLICITUD
                    AND    D.ID_SOLICITUD = R.ID_SOLICITUD
                    AND    R.LINEA        = D.LINEA
                    AND    D.VERSION      = C_VER_STN.VERSION
                    AND    D.STNID        = C_VER_STN.STNID;
                    dbms_output.put_line(' --LINEA MAS PEQUE?A: '||V_MIN_LINEA_VC );
                    --SI LA LINEA Q NO TIENE COPY ES MAYOR A LA LINEA QUE TIENE EL COPY  ENTONCES
                    --CAMBIAMOS LOS ROTIDS
                    IF V_MIN_LINEA_VC = V_LINEA_CON_COPY THEN
                        UPDATE XXMOR_SOLICITUDES_EST_REP_TAB
                        SET ROTID = (SELECT ROTID
                                     FROM   XXMOR_SOLICITUDES_EST_REP_TAB
                                     WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                     AND LINEA = V_LINEA_CON_COPY
                                    ),
                            AUX1  = (SELECT AUX1
                                     FROM   XXMOR_SOLICITUDES_EST_REP_TAB
                                     WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                     AND    LINEA        = V_LINEA_CON_COPY
                                    )
                        WHERE ID_SOLICITUD = P_ID_SOLICITUD
                        AND   LINEA        = (SELECT MAX(R.LINEA)
                                              FROM   XXMOR_SOLICITUDES_DET_TAB D,
                                                     XXMOR_SOLICITUDES_EST_REP_TAB R
                                               WHERE R.ID_SOLICITUD = p_ID_SOLICITUD
                                               AND   D.ID_SOLICITUD = R.ID_SOLICITUD
                                               AND   R.LINEA        = D.LINEA
                                               AND   D.VERSION      = C_VER_STN.VERSION
                                               AND   D.STNID        = C_VER_STN.STNID
                                             );
                        UPDATE XXMOR_SOLICITUDES_EST_REP_TAB
                        SET ROTID = NULL,
                            AUX1  = NULL
                        WHERE ID_SOLICITUD = P_ID_SOLICITUD
                        AND   LINEA        = V_LINEA_CON_COPY;
                    END IF;
                END IF;
            END LOOP;
        END IF;
    END XXMOR_COPY_UPDATE_PR;
    PROCEDURE XXMOR_HTML_EMAIL_PR
                        (
                                P_MAILS_NOTIFICAR   IN VARCHAR2,
                                P_SUBJECT           IN VARCHAR2,
                                P_TEXT              IN VARCHAR2 DEFAULT NULL,
                                P_HTML              IN CLOB
                        ) IS
    V_BUFFER_SIZE      CONSTANT PLS_INTEGER := 4000;
    V_BUFFER_NEXT      PLS_INTEGER := 4000;
    V_BODY_BUFFER      VARCHAR2(8000 CHAR);
    V_FROM             VARCHAR2(100);
    LST_SMTP_SRV       VARCHAR2(100);
    LIN_SMTP_PRT       NUMBER;
    LST_ERROR          VARCHAR2(500) := NULL;
    V_TEMP             VARCHAR2(100);
    V_MAILS_TO         VARCHAR(3000);
    V_CUENTA_DIRS      PLS_INTEGER;
    L_BOUNDARY         VARCHAR2(255) DEFAULT 'a1b2c3d4e3f2g1';
    L_CONNECTION       UTL_SMTP.CONNECTION;
    L_BODY_HTML        CLOB := EMPTY_CLOB;
    L_OFFSET           NUMBER;
    L_AMMOUNT          NUMBER;
    L_TEMP             VARCHAR2(32767) DEFAULT NULL;
    lst_requiere_aut   VARCHAR2(1);
    lst_error_usr_smtp VARCHAR2(1);
    lst_usuario_smtp   VARCHAR2(50);
    lst_password_smtp  VARCHAR2(50);
    CURSOR MAILS_NOTIFICAR_CUR IS
    WITH VALUE_LIST AS
    (SELECT P_MAILS_NOTIFICAR  AS VAL FROM DUAL)
    SELECT SUBSTR(val, (DECODE(LEVEL, 1, 0, INSTR(val, ',', 1, LEVEL -1)) + 1),
                       (DECODE(INSTR(val, ',', 1, LEVEL) -1, -1, LENGTH(val), INSTR(val, ',', 1, LEVEL) -1))
                       -(DECODE(LEVEL, 1, 0, INSTR(val, ',', 1, LEVEL -1)) + 1) + 1) CORREO
    FROM VALUE_LIST CONNECT BY LEVEL <= (SELECT(LENGTH(val) -LENGTH(REPLACE(val, ',', NULL)))
    FROM VALUE_LIST);
    BEGIN
        -- Se obtien la direccion IP del smtp server
        -- asi como el puerto.
        BEGIN
            LST_SMTP_SRV := NULL;
            LIN_SMTP_PRT := NULL;
            SELECT SUBSTR(VALOR_PARAMETRO,1,(INSTR(VALOR_PARAMETRO,':')-1)) SERVIDOR,
                   SUBSTR(VALOR_PARAMETRO,(INSTR(VALOR_PARAMETRO,':')+1))   PUERTO
            INTO   LST_SMTP_SRV,
                   LIN_SMTP_PRT
            FROM   XXMOR_CONF_PARAMS_GRLS_TAB
            WHERE  UPPER(NOMBRE_PARAMETRO) = 'SMTP_SERVER';
        EXCEPTION
            WHEN OTHERS THEN
                LST_SMTP_SRV := NULL;
                LIN_SMTP_PRT := NULL;
        END;
        IF LST_SMTP_SRV IS NOT NULL AND LIN_SMTP_PRT IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Servidor de Correo: '||LST_SMTP_SRV);
            DBMS_OUTPUT.PUT_LINE('Puerto: '||LIN_SMTP_PRT);
            -- Se verifica si es necesaria la autenticacion en el servidor SMTP.
            BEGIN
                lst_Requiere_aut := 'N';
                SELECT NVL(VALOR_PARAMETRO,'N') REQUIERE_AUTENTICACION
                INTO   lst_Requiere_aut
                FROM   XXMOR_CONF_PARAMS_GRLS_TAB
                WHERE  UPPER(NOMBRE_PARAMETRO) = 'USAR_AUTENTICACION_ENV_CORREO';
            EXCEPTION
                WHEN OTHERS THEN
                    lst_Requiere_aut := 'N';
            END;
            lst_usuario_smtp  := NULL;
            lst_password_smtp := NULL;
            IF lst_requiere_aut = 'S' THEN
                -- Se obtien el usuario y contrase?a si es necesaria la
                -- autenticacion en el servidor SMTP.
                BEGIN
                    SELECT SUBSTR(VALOR_PARAMETRO,1,(INSTR(VALOR_PARAMETRO,'/')-1)) USUARIO,
                           SUBSTR(VALOR_PARAMETRO,(INSTR(VALOR_PARAMETRO,'/')+1))   PASSWORD
                    INTO   lst_usuario_smtp,
                           lst_password_smtp
                    FROM   XXMOR_CONF_PARAMS_GRLS_TAB
                    WHERE  UPPER(NOMBRE_PARAMETRO) = 'USUARIO_ENVIO_CORREOS';
                EXCEPTION
                    WHEN OTHERS THEN
                        lst_usuario_smtp  := NULL;
                        lst_password_smtp := NULL;
                END;
                IF lst_usuario_smtp IS NOT NULL AND lst_password_smtp IS NOT NULL THEN
                    lst_error_usr_smtp := 'N';
                    V_FROM := '<'||lst_usuario_smtp||'@televisa.com.mx>';
                ELSE
                    lst_error_usr_smtp := 'S';
                    IF lst_usuario_smtp IS NOT NULL THEN
                        V_FROM := '<'||lst_usuario_smtp||'@televisa.com.mx>';
                    ELSE
                        V_FROM := '<servicio_orduni@televisa.com.mx>';
                    END IF;
                    DBMS_OUTPUT.PUT_LINE('No Es Posible Enviar la Notificacion: Revise la Configuracion en Paramentros Generales del Usuario y Contrase?a para el Envio de Correos');
                    INSERT INTO XXMOR_LOG_ERRORES_TAB
                                (
                                        ID_ERROR,
                                        DESC_ERROR,
                                        ARCHIVO_ERROR,
                                        METODO_ERROR,
                                        HORA_ERROR
                                )
                    VALUES      (
                                        XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                        'No Es Posible Enviar la Notificacion: Revise la Configuracion en Paramentros Generales del Usuario y Contrase?a para el Envio de Correos',
                                        NULL,
                                        'Procedimiento XXMOR_HTML_EMAIL_PR',
                                        SYSDATE
                                );
                END IF;
            ELSE
                lst_error_usr_smtp := 'N';
                V_FROM := '<servicio_orduni@televisa.com.mx>';
            END IF;
            IF lst_error_usr_smtp = 'N' THEN
                DBMS_OUTPUT.PUT_LINE('V_FROM: '|| V_FROM);
                --V_FROM := '<'||lst_usuario_smtp||'@televisa.com.mx>';
                L_CONNECTION := UTL_SMTP.OPEN_CONNECTION( LST_SMTP_SRV, LIN_SMTP_PRT );
                UTL_SMTP.HELO( L_CONNECTION, LST_SMTP_SRV );
               IF lst_requiere_aut = 'S' THEN
                    UTL_SMTP.COMMAND( L_CONNECTION, 'AUTH LOGIN' );
                    UTL_SMTP.COMMAND( L_CONNECTION, UTL_RAW.CAST_TO_VARCHAR2( UTL_ENCODE.BASE64_ENCODE( UTL_RAW.CAST_TO_RAW( lst_usuario_smtp ))) );
                    UTL_SMTP.COMMAND( L_CONNECTION, UTL_RAW.CAST_TO_VARCHAR2( UTL_ENCODE.BASE64_ENCODE( UTL_RAW.CAST_TO_RAW( lst_password_smtp ))) );
                END IF;
                UTL_SMTP.MAIL( L_CONNECTION, V_FROM );
                DBMS_OUTPUT.PUT_LINE(' P_MAILS_NOTIFICAR:'|| P_MAILS_NOTIFICAR);
                FOR RCPT IN MAILS_NOTIFICAR_CUR LOOP
                    BEGIN
                        DBMS_OUTPUT.PUT_LINE('RCPT.CORREO:'||RCPT.CORREO);
                        IF RCPT.CORREO IS NOT NULL THEN
                            V_TEMP :=   '<' || TRIM(RCPT.CORREO) ||'>';
                            DBMS_OUTPUT.PUT_LINE('V_TEMP:'||V_TEMP);
                            utl_smtp.rcpt( l_connection, V_TEMP );
                            V_MAILS_TO := V_MAILS_TO || V_TEMP||',';
                            DBMS_OUTPUT.PUT_LINE('V_MAILS_TO FOR:'||V_MAILS_TO);
                        END IF;
                    EXCEPTION
                        WHEN OTHERS THEN
                            INSERT INTO XXMOR_LOG_ERRORES_TAB(ID_ERROR, DESC_ERROR, ARCHIVO_ERROR, METODO_ERROR)
                            VALUES(XXMOR_LOG_ERROR_SQ.NEXTVAL, 'No pudo enviarse la notificacion a el siguiente destinatario:'||V_TEMP||'  ', NULL, 'procedure XXMOR_HTML_EMAIL_PR subject: '||p_subject|| ',...) ');
                    END;
                END LOOP;
                V_MAILS_TO := SUBSTR(V_MAILS_TO,1,LENGTH(V_MAILS_TO)-1);
                DBMS_OUTPUT.PUT_LINE('V_MAILS_TO:'||V_MAILS_TO);
                l_temp := l_temp || 'MIME-Version: 1.0' ||  CHR(13) || CHR(10);
                l_temp := l_temp || 'To: ' || P_MAILS_NOTIFICAR || CHR(13) || CHR(10);
                l_temp := l_temp || 'From: Servicio OrdUni' || V_FROM || CHR(13) || CHR(10);
                l_temp := l_temp || 'Subject: ' || p_subject || CHR(13) || CHR(10);
                l_temp := l_temp || 'Reply-To: ' || V_FROM ||  CHR(13) || CHR(10);
                l_temp := l_temp || 'Content-Type: multipart/alternative; boundary=' ||
                                     CHR(34) || l_boundary ||  CHR(34) || CHR(13) ||
                                     CHR(10);
                ----------------------------------------------------
                -- Write the headers
                dbms_lob.createtemporary( l_body_html, FALSE, 10 );
                dbms_lob.write(l_body_html,LENGTH(l_temp),1,l_temp);
                ----------------------------------------------------
                -- Write the text boundary
                l_offset := dbms_lob.getlength(l_body_html) + 1;
                l_temp   := '--' || l_boundary || CHR(13)||CHR(10);
                l_temp   := l_temp || 'content-type: text/plain; charset=us-ascii' ||
                              CHR(13) || CHR(10) || CHR(13) || CHR(10);
                dbms_lob.write(l_body_html,LENGTH(l_temp),l_offset,l_temp);
                ----------------------------------------------------
                -- Este cacho es para enviar un mail en forma de texto pero no se usa aqui
                -- l_offset := dbms_lob.getlength(l_body_html) + 1;
                -- dbms_lob.write(l_body_html,LENGTH(p_text),l_offset,p_text);
                ----------------------------------------------------
                -- Write the HTML boundary
                l_temp   := CHR(13)||CHR(10)||CHR(13)||CHR(10)||'--' || l_boundary ||
                                CHR(13) || CHR(10);
                l_temp   := l_temp || 'content-type: text/html;' ||
                              CHR(13) || CHR(10) || CHR(13) || CHR(10);
                l_offset := dbms_lob.getlength(l_body_html) + 1;
                dbms_lob.write(l_body_html,LENGTH(l_temp),l_offset,l_temp);
                ----------------------------------------------------
                -- Write the HTML portion of the message
                FOR I IN 0 .. FLOOR(DBMS_LOB.GETLENGTH(p_html) / V_BUFFER_SIZE) LOOP
                    DBMS_LOB.READ(p_html, V_BUFFER_NEXT, I * V_BUFFER_SIZE + 1, V_BODY_BUFFER);
                    l_offset := dbms_lob.getlength(l_body_html) + 1;
                    dbms_lob.write(l_body_html,LENGTH(V_BODY_BUFFER),l_offset,V_BODY_BUFFER);
                END LOOP;
                --DBMS_OUTPUT.PUT_LINE(V_BODY_BUFFER);
                dbms_lob.write(l_body_html,LENGTH(V_BODY_BUFFER),l_offset,V_BODY_BUFFER);
                ----------------------------------------------------
                -- Write the final html boundary
                l_temp   := CHR(13) || CHR(10) || '--' ||  l_boundary || '--' || CHR(13);
                l_offset := dbms_lob.getlength(l_body_html) + 1;
                dbms_lob.write(l_body_html,LENGTH(l_temp),l_offset,l_temp);
                ----------------------------------------------------
                -- Send the email in 1900 byte chunks to UTL_SMTP
                l_offset  := 1;
                l_ammount := 1900;
                BEGIN
                    utl_smtp.open_data(l_connection);
                    WHILE l_offset < dbms_lob.getlength(l_body_html) LOOP
                        utl_smtp.write_data(l_connection,
                                            dbms_lob.substr(l_body_html,l_ammount,l_offset));
                        l_offset  := l_offset + l_ammount ;
                        l_ammount := LEAST(1900,dbms_lob.getlength(l_body_html) - l_ammount);
                    END LOOP;
                    utl_smtp.close_data(l_connection);
                    --utl_smtp.quit( l_connection );
                    dbms_lob.freetemporary(l_body_html);
                EXCEPTION
                    WHEN OTHERS THEN
                        utl_smtp.quit(l_connection);
                END;
                utl_smtp.quit(l_connection);
                DBMS_OUTPUT.PUT_LINE('Correo Enviado');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('No Es Posible Enviar la Notificacion: Revise la Configuracion en Paramentros Generales del Servidor y Puerto para el Envio de Correos');
            INSERT INTO XXMOR_LOG_ERRORES_TAB
                        (
                                ID_ERROR,
                                DESC_ERROR,
                                ARCHIVO_ERROR,
                                METODO_ERROR,
                                HORA_ERROR
                        )
            VALUES      (
                                XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                'No Es Posible Enviar la Notificacion: Revise la Configuracion en Paramentros Generales del Servidor y Puerto para el Envio de Correos',
                                NULL,
                                'Procedimiento XXMOR_HTML_EMAIL_PR',
                                SYSDATE
                        );
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al generar el correo: '||SQLERRM);
            LST_ERROR := SQLERRM;
            INSERT INTO XXMOR_LOG_ERRORES_TAB
                        (
                                ID_ERROR,
                                DESC_ERROR,
                                ARCHIVO_ERROR,
                                METODO_ERROR
                        )
            VALUES      (
                                XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                'No Es Posible Enviar la Notificacion: '||LST_ERROR,
                                NULL,
                                'Procedimiento XXMOR_HTML_EMAIL_PR'
                        );
    END XXMOR_HTML_EMAIL_PR;
    PROCEDURE XXMOR_REVISAR_SEMANA_CONF_PR AS
    V_REQ      VARCHAR2(3000);
    V_LOC_PROC VARCHAR2(3000);
    CURSOR FZAS_CON_SC_CUR IS
    SELECT DISTINCT F.ID_FZA_VENTAS, F.IDENT_FZA_VENTAS
    FROM   XXMOR_SOLICITUDES_DET_TAB D,
           XXMOR_SOLICITUDES_ENC_TAB E,
           XXMOR_CONCOM_RPTA_TAB     R,
           XXMOR_FZAS_VTAS_TAB       F
    WHERE  E.ID_SOLICITUD   = D.ID_SOLICITUD
    AND    E.ID_FZA_VENTAS  = F.ID_FZA_VENTAS
    AND    D.ID_SOLICITUD   = R.ID_SOLICITUD
    AND    D.LINEA          = R.NUMLINEA_CONCOM
    AND    E.ID_SEG_NEG     = 1
    AND    INSTR(UPPER(R.ACCION_CONCOM),UPPER('RETENCION')) > 0
    AND    R.ESTATUS_ORDUNI = '10';
    BEGIN
        --4    SEMANA_CONFIRMAR    Direccion del ws de liberar ordenes    http://10.7.0.251:8003/soa-infra/services/default/MORBsRecibirSolicitudes/morbsliberarsemanaconf_client_ep    WS
        SELECT VALOR_PARAMETRO
        INTO   V_LOC_PROC
        FROM   XXMOR_CONF_PARAMS_GRLS_TAB
        WHERE  NOMBRE_PARAMETRO = 'SEMANA_CONFIRMAR';
         --DBMS_OUTPUT.PUT_LINE( TO_CHAR(V_ID_REMISION)||'<   >'||TO_CHAR(V_ID_WAREHOUSE));
        FOR FZA_CONF IN FZAS_CON_SC_CUR LOOP
            V_REQ :='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:mor="http://xmlns.oracle.com/MOR_jws/MORBsRecibirSolicitudes/MORBsLiberarSemanaConf">
                   <soapenv:Header/>
                   <soapenv:Body>
                      <mor:process>
                         <mor:idFzaVentas>'||FZA_CONF.ID_FZA_VENTAS||'</mor:idFzaVentas>
                         <mor:identFzaVentas>'||FZA_CONF.IDENT_FZA_VENTAS||'</mor:identFzaVentas>
                      </mor:process>
                   </soapenv:Body>
                </soapenv:Envelope>';
            XXMOR_CALL_WS_SP(V_REQ, V_LOC_PROC);
        END LOOP;
        DELETE FROM XXMOR_EJECUCIONES_PROG_TAB
        WHERE NOMBRE_PROCESO = 'XXMOR_REVISAR_SEMANA_CONF_PR'
        AND HORA_INI_EJECUCION <= SYSDATE -1;
        INSERT INTO XXMOR_EJECUCIONES_PROG_TAB(ID_EJECUCION, NOMBRE_PROCESO)
        VALUES(XXMOR_EJECUCIONES_PROG_SEQ.NEXTVAL, 'XXMOR_REVISAR_SEMANA_CONF_PR');
        /*UPDATE XXMOR_EJECUCIONES_PROG_TAB
          SET HOA_FIN_EJECUCION = SYSDATE, STATUS_EJECUCION = 'B'
          WHERE ID_EJECUCION = XXMOR_EJECUCIONES_PROG_SEQ.CURRVAL;
        */
        COMMIT;
    END XXMOR_REVISAR_SEMANA_CONF_PR;
    PROCEDURE XXMOR_ENV_SOL_REZAGADAS AS
    --Selecciona los encabezados de las ordenes que no han sido insertados y que no tienen erorres
    -- Y que tienen al menos una linea bien que enviar
    CURSOR ORC_ENVIAR_CUR IS
    SELECT ER.ID_SOLICITUD
    FROM   XXMOR_SOLICITUDES_EST_REP_TAB  ER,
           (SELECT D.ID_SOLICITUD,
                   COUNT(1)  --LINEA
            FROM   XXMOR_SOLICITUDES_DET_TAB   D,
                   (SELECT DISTINCT ID_SOLICITUD,
                           NUMLINEA_CONCOM
                    FROM   XXMOR_CONCOM_RPTA_TAB
                    WHERE  TRUNC(CREATED_DATE) = TRUNC(SYSDATE)
                    AND    NUMLINEA_CONCOM     IS NOT NULL
                    AND    ID_SEG_NEG          = 1
                    MINUS
                    SELECT DISTINCT ID_SOLICITUD,
                           NUMLINEA_CONCOM
                    FROM   XXMOR_CONCOM_RPTA_TAB
                    WHERE  TRUNC(CREATED_DATE) = TRUNC(SYSDATE)
                    AND    NUMLINEA_CONCOM     IS NOT NULL
                    AND    ESTATUS_ORDUNI      = '10'
                    AND    ID_SEG_NEG          = 1
                   )                           CR
            WHERE  TRUNC(D.CREATED_DATE) = TRUNC(SYSDATE)
            AND    D.ID_SOLICITUD        = CR.ID_SOLICITUD
            AND    D.LINEA               = CR.NUMLINEA_CONCOM
            AND    EXISTS                  (SELECT 1
                                            FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                                            WHERE  TRUNC(ER.CREATED_DATE) = TRUNC(SYSDATE)
                                            AND    ER.ID_SOLICITUD        = D.ID_SOLICITUD
                                            AND    ER.LINEA               = D.LINEA
                                            AND    ER.ESTAT_ID_FORANEO    IS NULL
                                           )
            GROUP BY D.ID_SOLICITUD
           )                              LB
    WHERE  ER.LINEA               = 0
    AND    ER.ID_SOLICITUD        = LB.ID_SOLICITUD
    AND    ER.ESTAT_ID_FORANEO    IS NULL
    AND    TRUNC(ER.CREATED_DATE) = TRUNC(SYSDATE)
    AND    NVL(AUX3,0)           != 1 --No se esta insertando (proceso BPEL)
    AND    (SELECT ((P.VALOR_PARAMETRO/60)/(24*60)) + ER.CREATED_DATE
            FROM   XXMOR_CONF_PARAMS_GRLS_TAB P
            WHERE  NOMBRE_PARAMETRO = 'pollingTimer'
           )                      < SYSDATE
    AND    NOT EXISTS               (SELECT 1
                                     FROM   XXMOR_CONCOM_RPTA_TAB C
                                     WHERE  C.ID_SOLICITUD    = ER.ID_SOLICITUD
                                     AND    C.ESTATUS_ORDUNI  = '10'
                                     AND    C.NUMLINEA_CONCOM IS NULL
                                    );
    V_TEMP      PLS_INTEGER;
    BEGIN
        FOR C_SOLICITUD IN ORC_ENVIAR_CUR  LOOP
            SELECT XXMOR_ENV_SOL_CONCOM_FUN(C_SOLICITUD.ID_SOLICITUD)
            INTO   V_TEMP
            FROM   DUAL;
        END LOOP;
    END XXMOR_ENV_SOL_REZAGADAS;
    PROCEDURE XXMOR_CALL_WS_SP
                        (
                                P_SOAP_REQUEST IN VARCHAR2,
                                P_REQ          IN VARCHAR2
                        ) AS
    soap_request   varchar2(30000);
    soap_respond   varchar2(30000);
    http_req       utl_http.req;
    http_resp      utl_http.resp;
    launch_url     varchar2(240) ;
    BEGIN
        http_req:= utl_http.begin_request(p_req ,'POST', 'HTTP/1.1' );
        utl_http.set_header(http_req, 'Content-Type', 'text/xml') ;
        utl_http.set_header(http_req, 'Content-Length', LENGTH(p_soap_request)) ;
        utl_http.set_header(http_req, 'SOAPAction', 'process');
        utl_http.write_text(http_req, p_soap_request) ;
        http_resp:= utl_http.get_response(http_req) ;
        utl_http.read_text(http_resp, soap_respond) ;
        utl_http.end_response(http_resp);
    EXCEPTION
        WHEN utl_http.end_of_body THEN
            utl_http.end_response(http_resp);
    END XXMOR_CALL_WS_SP;
    PROCEDURE XXMOR_SOL_NOTIFICACION_PR
                        (
                                P_SOLICITUD IN XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE
                        ) IS
    P_ID_SOLICITUD     INTEGER := P_SOLICITUD.ID_SOLICITUD;
    MSG_FROM           VARCHAR2(3200);    ----- MAIL BOX SENDING THE EMAIL
    MSG_TO             VARCHAR2(3200):= P_SOLICITUD.EMAIL;
    MSG_SUBJECT        VARCHAR2(3200);          ----- EMAIL SUBJECT
    MSG_TEXT           VARCHAR2(3200);
    LST_SMTP_SRV       VARCHAR2(100);
    LIN_SMTP_PRT       NUMBER;
    V_OUTPUT1          CLOB;
    V_BUFFER_SIZE      CONSTANT PLS_INTEGER := 4000;
    V_BUFFER_NEXT      PLS_INTEGER := 4000;
    V_BODY_BUFFER      VARCHAR2(8000 CHAR);
    V_ESTATUS_DESC     VARCHAR2(100);
    V_ERRORES_LINEA    VARCHAR2(32000);
    V_FUERZA_VENTAS    VARCHAR2(100);
    V_FECHA            VARCHAR2(150);
    V_ID_PARADIGM      VARCHAR2(25);
    V_ID_ONAIR         VARCHAR2(25);
    V_COLOR            VARCHAR2(10);
    V_EST_LINEA        VARCHAR2(5);
    V_AUX              INTEGER;
    V_NOMBRE_ARCHIVO   VARCHAR2(150);
    V_DIR_LOGO         VARCHAR2(200);
    lstTxtFooter       VARCHAR2(3001);
    CURSOR CUR_HDR_SOL IS
    SELECT ID_SOLICITUD,
           ID_REQUEST,
           ID_SEG_NEG,
           ID_FZA_VENTAS,
           ID_SOLICITUD_HNA,
           NVL2(PROC_POR_LINEA,'SI','NO') PROC_POR_LINEA,
           DECODE(GARANTIZADO,'1','SI','NO') GARANTIZADO,
           ADVID,
           MCONTID,
           MCONTID_CUTIN,
           EMAIL,
           AGYESTNUM,
           ACCTHDRID,
           RTCRDDSCR,
           RTCRD,
           RTCRDDSCR_CUTIN,
           RTCRD_CUTIN,
           COMENTARIOS,
           SECNUM,
           PLATAFORMA_CANAL,
           AGRUPADOR,
           PRDID_DESC,
           PRDID,
           TOTAL_SPOTS,
           TOTAL_SIN_DESC,
           TOTAL_CON_DESC,
           TIPO_FACTURACION,
           DESCUENTO,
           TARGET,
           CREATED_DATE,
           CREATED_BY,
           UPDATED_DATE,
           UPDATED_BY,
           ORDEN_ESTATUS,
           FECHA_CONCOM,
           TRACKING_ID_CONCOM,
           AUX1,
           AUX2,
           AUX3
    FROM   XXMOR_SOLICITUDES_ENC_TAB
    WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
    V_HDR_SOL CUR_HDR_SOL%ROWTYPE;
    CURSOR CUR_DET_SOL IS
    SELECT ID_SOLICITUD,
           LINEA,
           LINEA_HNA,
           STNID,
           FECHA_INICIO,
           FECHA_FIN,
           DURACION,
           BUYUNTID,
           HORA_INICIO,
           HORA_FIN,
           SPOTS,
           LUNES,
           MARTES,
           MIERCOLES,
           JUEVES,
           VIERNES,
           SABADO,
           DOMINGO,
           SPOTS_X_SEMANA,
           TIPO_SERVICIO,
           USR_CHR,
           SPOT_CHR,
           BN,
           P,
           MARCA,
           VERSION,
           TARIFASP_SIN_DESC,
           TARIFASP_CON_DESC,
           TOT_LINEA_SIN_DESC,
           TOT_LINEA_CON_DESC,
           SOBRECARGO,
           OBSERVACIONES,
           CREATED_BY,
           CREATED_DATE,
           UPDATED_DATE,
           UPDATED_BY,
           DES_PLATAFORMA
    FROM   XXMOR_SOLICITUDES_DET_TAB
    WHERE  ID_SOLICITUD = P_ID_SOLICITUD
    ORDER BY LINEA ASC;
    V_DET_SOL CUR_DET_SOL%ROWTYPE;
    CURSOR AUTORIZACIONES_CUR IS
    SELECT UPDATED_BY||' autorizo por '||CAMPO_CONCOM AS AUTORIZACION_MSG
    FROM   XXMOR_CONCOM_RPTA_TAB cr
    WHERE  ID_SOLICITUD         = P_ID_SOLICITUD
    AND    NUMLINEA_CONCOM      = V_DET_SOL.LINEA
    AND    ESTATUS_ORDUNI       = '20'
    AND    UPPER(ACCION_CONCOM) = 'AUTORIZACION'
    AND    NOT EXISTS             (SELECT 1
                                   FROM   XXMOR_CONCOM_RPTA_TAB CR2
                                   WHERE  CR2.ID_SOLICITUD         = CR.ID_SOLICITUD
                                   AND    CR2.NUMLINEA_CONCOM      = CR.NUMLINEA_CONCOM
                                   AND    UPPER(CR2.ACCION_CONCOM) = 'RECHAZO'
                                  );
    c utl_tcp.connection;
    rc integer;
    BEGIN
        SELECT DESC_NOTIFICACION
        INTO   V_ESTATUS_DESC
        FROM   XXMOR_ORDENES_ESTATUS_TAB
        WHERE  ID_NOTIFICACION = DECODE(P_SOLICITUD.ORDEN_ESTATUS,20,10,P_SOLICITUD.ORDEN_ESTATUS);
        SELECT A.NOM_ARCHIVO_SOL
        INTO   V_NOMBRE_ARCHIVO
        FROM   XXMOR_SOLICITUDES_ARCH_TAB     A,
               XXMOR_SOLICITUDES_ENC_TAB      E,
               XXMOR_SOLICITUDES_ORIG_ENC_TAB EO
        WHERE  E.ID_SOLICITUD    = P_ID_SOLICITUD
        AND    E.ID_REQUEST      = EO.ID_REQUEST
        AND    EO.ID_ARCHIVO_SOL = A.ID_ARCHIVO_SOL
        AND    E.ID_SEG_NEG      = 1
        AND    E.ID_SEG_NEG      = A.ID_SEG_NEG;
        --Parametro ip de la imagen del correo
        SELECT VALOR_PARAMETRO
        INTO   V_DIR_LOGO
        FROM   XXMOR_CONF_PARAMS_GRLS_TAB
        WHERE  NOMBRE_PARAMETRO = 'LogoMail';
        -- Se obtien la direccion IP del smtp server
        -- asi como el puerto.
        SELECT SUBSTR(VALOR_PARAMETRO,1,(INSTR(VALOR_PARAMETRO,':')-1)) SERVIDOR,
               SUBSTR(VALOR_PARAMETRO,(INSTR(VALOR_PARAMETRO,':')+1))   PUERTO
        INTO   LST_SMTP_SRV,
               LIN_SMTP_PRT
        FROM   XXMOR_CONF_PARAMS_GRLS_TAB
        WHERE  UPPER(NOMBRE_PARAMETRO) = 'SMTP_SERVER';
        msg_from     := '<servicio_orduni@televisa.com.mx>';
        msg_to       := '<'||LOWER(TRIM(P_SOLICITUD.EMAIL))||'>';
        msg_subject  := 'Orden '||P_ID_SOLICITUD||'/'||V_NOMBRE_ARCHIVO||' ('||V_ESTATUS_DESC||')';
        msg_text     := 'Estatus de la orden '||P_ID_SOLICITUD||' (Revise archivo adjunto)';
        OPEN CUR_HDR_SOL;
            FETCH CUR_HDR_SOL
            INTO  V_HDR_SOL;
        CLOSE CUR_HDR_SOL;
        SELECT TO_CHAR(SYSDATE,'Daydd Monthyyyy HH24:MI','NLS_LANGUAGE=SPANISH')
        INTO   v_fecha
        FROM   DUAL;
        SELECT XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN(P_ID_SOLICITUD,V_DET_SOL.linea,'lineaMail')
        INTO   V_errores_linea
        FROM   DUAL;
        BEGIN
            SELECT NOMBRE_FZA_VENTAS
            INTO   V_FUERZA_VENTAS
            FROM   XXMOR_FZAS_VTAS_TAB
            WHERE  ID_FZA_VENTAS = V_HDR_SOL.ID_FZA_VENTAS
            AND    ID_SEG_NEG    = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_FUERZA_VENTAS := 'SIN FUERZA DE VENTAS';
        END;
        BEGIN
            SELECT ESTAT_ID_FORANEO
            INTO   V_ID_PARADIGM
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB
            WHERE  ID_SIST      = 1
            AND    ID_SOLICITUD = P_ID_SOLICITUD
            AND    LINEA        = 0;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                V_ID_PARADIGM := ' ';
        END;
        BEGIN
            SELECT ESTAT_ID_FORANEO
            INTO   V_ID_ONAIR
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB
            WHERE  ID_SIST      = 2
            AND    ID_SOLICITUD = P_ID_SOLICITUD
            AND    LINEA        = 0;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_ID_ONAIR := ' ';
        END;
        v_output1:='<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Televisa - Orduni</title>
        </head>
        <body>
        <table  width="1330" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td align="left" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#252671">
        <tr>
        <td width="180" rowspan="3" align="center" valign="middle"><!--img src="'||V_DIR_LOGO||'" width="150" height="50"/--></td>
        <td height="20" align="left">;</td>
        </tr>
        <tr>
        <td height="20" align="left" valign="bottom" style="font-family:Verdana, Geneva, sans-serif; font-size:20px; font-weight:bold; color:#FFF;">Correo de Notificacion</td>
        </tr>
        <tr>
        <td height="30" align="left" valign="middle" style="font-family:Verdana, Geneva, sans-serif; font-size:14px; color:#FFF;">De la orden no: ' || P_ID_SOLICITUD|| '</td>
        </tr>
        </table></td>
        </tr>
        <tr>
        <td>;</td>
        </tr>
        <tr>
            <td bgcolor="#FF801A" height="1"></td>
        </tr>
        <tr>
        <td bgcolor="#FBE194" height="1"></td>
        </tr>
        <tr>
        <td>;</td>
        </tr>
        <tr>
        <td bgcolor="#666666"><table width="100%" border="0" cellspacing="1" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:#000;">
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Clave Cliente</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.ADVID|| '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Clave Encabezado de<br/>Cliente - Agencia</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.ACCTHDRID|| '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Fuerza de<br/>Ventas</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_FUERZA_VENTAS|| '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">CPS - Master Contract</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.MCONTID|| '</td>
        </tr>
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Nombre Tarifa</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.rtcrddscr || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Categoria de<br/>Producto</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.PRDID_DESC || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Plataforma<br/>Canal</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.PLATAFORMA_CANAL || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Ref folio</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.AGYESTNUM || '</td>
        </tr>
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Nombre / email<br/>Responsable(s)</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.EMAIL || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Target</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.TARGET || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Garantizado</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.GARANTIZADO || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Proc x linea</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.PROC_POR_LINEA || '</td>
        </tr>
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Total Spots</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.TOTAL_SPOTS || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Total Tarifa Ref</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.TOTAL_SIN_DESC || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Tot Tarifa Def</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.TOTAL_con_DESC || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4"></td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Tipo facturacion</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.TIPO_FACTURACION || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Ajuste Variable Cont</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF">' || V_HDR_SOL.Descuento || '</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Comentarios de la<br/>Orden de Servicio</td>
        <td style="padding: 3px;" align="left" valign="middle" bgcolor="#FFFFFF" colspan="3" >' || V_HDR_SOL.comentarios || '</td>
        </tr>
        <tr>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">ID PARADIGM</td>
        <td style="padding: 3px;" align="left" valign="middle"  bgcolor="#FFFFFF">'||V_ID_PARADIGM||'</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">ID ONAIR</td>
        <td style="padding: 3px;" align="left" valign="middle"  bgcolor="#FFFFFF">'||V_ID_ONAIR||'</td>
        <td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#E4E4E4">Estatus Encabezado</td>
        <td style="padding: 3px;" align="left" valign="middle" colspan="3" bgcolor="#FFFFFF">' || xxmor_funcional_pkg.xxmor_Ident_Errores_FUN(P_ID_SOLICITUD, NULL, 'lineaMail') || '</td>
        </tr>
        </table></td>
        </tr>
        <tr>
        <td>;</td>
        </tr>
        <tr>
        <td bgcolor="#FF801A" height="1"></td>
        </tr>
        <tr>
        <td bgcolor="#FBE194" height="1"></td>
        </tr>
        <tr>
        <td>;</td>
        </tr>
        <tr>
        <td bgcolor="#666666">
          <table width="100%" border="0" cellspacing="1" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
        <!--tr>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF" width="70">;</td>
        <td colspan="2" align="center" valign="middle" bgcolor="#E4E4E4">Fecha</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF" width="100">;</td>
        <td bgcolor="#FFFFFF" width="50">;</td>
        <td bgcolor="#FFFFFF" width="50">;</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td colspan="7" align="center" valign="middle" bgcolor="#E4E4E4" style="font-weight:bold">Cantidad de<br/>Transmisiones</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF" width="30">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        <td bgcolor="#FFFFFF">;</td>
        </tr-->
        <tr>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
                <tr>
                <td align="center" valign="middle">L</td>
                </tr>
                <tr>
                <td align="center" valign="middle">?</td>
                </tr>
                <tr>
                <td align="center" valign="middle">n</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Estatus</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
                <tr>
                <td align="center" valign="middle">ID</td>
                </tr>
                <tr>
                <td align="center" valign="middle">PGM</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
                <tr>
                <td align="center" valign="middle">ID</td>
                </tr>
                <tr>
                <td align="center" valign="middle">ONAIR</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">C</td>
        </tr>
        <tr>
        <td align="center" valign="middle">a</td>
        </tr>
        <tr>
        <td align="center" valign="middle">n</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
        <tr>
        <td align="center" valign="middle">Fecha</td>
        </tr>
        <tr>
        <td align="center" valign="middle">inicio</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
        <tr>
        <td align="center" valign="middle">Fecha</td>
        </tr>
        <tr>
        <td align="center" valign="middle">fin</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">D</td>
        </tr>
        <tr>
        <td align="center" valign="middle">u</td>
        </tr>
        <tr>
        <td align="center" valign="middle">r</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Programa /<br/>Paquete /<br/>Bloque Horario</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">H</td>
        <td align="center" valign="middle"> </td>
        </tr>
        <tr>
        <td align="center" valign="middle">o</td>
        <td align="center" valign="middle">I</td>
        </tr>
        <tr>
        <td align="center" valign="middle">r</td>
        <td align="center" valign="middle">n</td>
        </tr>
        <tr>
        <td align="center" valign="middle">a</td>
        <td align="center" valign="middle">i</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">H</td>
        <td align="center" valign="middle">;</td>
        </tr>
        <tr>
        <td align="center" valign="middle">o</td>
        <td align="center" valign="middle">F</td>
        </tr>
        <tr>
        <td align="center" valign="middle">r</td>
        <td align="center" valign="middle">i</td>
        </tr>
        <tr>
        <td align="center" valign="middle">a</td>
        <td align="center" valign="middle">n</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">S</td>
        <td align="center" valign="middle">X</td>
        </tr>
        <tr>
        <td align="center" valign="middle">p</td>
        <td align="center" valign="middle">;</td>
        </tr>
        <tr>
        <td align="center" valign="middle">o</td>
        <td align="center" valign="middle">S</td>
        </tr>
        <tr>
        <td align="center" valign="middle">t</td>
        <td align="center" valign="middle">e</td>
        </tr>
        <tr>
        <td align="center" valign="middle">s</td>
        <td align="center" valign="middle">m</td>
        </tr>
        </table>
        </td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr><td align="center">L</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">M</td>
        </tr>
        <tr>
        <td align="center">a</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">M</td>
        </tr>
        <tr>
        <td align="center">i</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">J</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">V</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">S</td>
        </tr>
        </table></td>
        <td width="20" align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center">D</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
        <tr>
        <td align="center" valign="middle">T</td>
        <td align="center" valign="middle">;</td>
        </tr>
        <tr>
        <td align="center" valign="middle">o</td>
        <td align="center" valign="middle">;</td>
        </tr>
        <tr>
        <td align="center" valign="middle">t</td>
        <td align="center" valign="middle">;</td>
        </tr>
        </table></td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Tipo de Servicio</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">BN</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">P</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Marca</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Version</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
                <tr>
                <td align="center" valign="middle">Tarifa Ref</td>
                </tr>
                <tr>
                <td align="center" valign="middle">Por Spot</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
                <tr>
                <td align="center" valign="middle">Tarifa</td>
                </tr>
                <tr>
                <td align="center" valign="middle">Definitiva</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
                <tr>
                <td align="center" valign="middle">Tot linea</td>
                </tr>
                <tr>
                <td align="center" valign="middle">Tar Ref</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#000;">
                <tr>
                <td align="center" valign="middle">Tot linea</td>
                </tr>
                <tr>
                <td align="center" valign="middle">Tar Def</td>
                </tr>
            </table>
        </td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Ajuste</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Observaciones</td>
        <td align="center" valign="bottom" bgcolor="#E4E4E4" style="padding-bottom:3px">Plataforma</td>
        </tr>';
        BEGIN
            OPEN CUR_DET_SOL;
            LOOP
                FETCH CUR_DET_SOL INTO V_DET_SOL;
                EXIT WHEN CUR_DET_SOL%NOTFOUND;
                SELECT XXMOR_ORDEN_ESTATUS_FUN
                                  (
                                       P_ID_SOLICITUD,
                                       V_DET_SOL.LINEA,
                                       'ESTATUS_LINEA'
                                  )
                INTO   V_EST_LINEA
                FROM   DUAL;
                BEGIN
                    SELECT ESTAT_ID_FORANEO
                    INTO   V_ID_PARADIGM
                    FROM   XXMOR_SOLICITUDES_EST_REP_TAB
                    WHERE  ID_SIST      = 1
                    AND    ID_SOLICITUD = P_ID_SOLICITUD
                    AND    LINEA        = V_DET_SOL.LINEA;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        V_ID_PARADIGM := ' ';
                END;
                BEGIN
                    SELECT ESTAT_ID_FORANEO
                    INTO   V_ID_ONAIR
                    FROM   XXMOR_SOLICITUDES_EST_REP_TAB
                    WHERE  ID_SIST      = 2
                    AND    ID_SOLICITUD = P_ID_SOLICITUD
                    AND    LINEA        = V_DET_SOL.LINEA;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        V_ID_ONAIR := ' ';
                END;
                IF V_EST_LINEA = '36' THEN
                    V_COLOR := 'FFFFFF'; --BLANCO
                    SELECT DESC_NOTIFICACION
                    INTO   V_ERRORES_LINEA
                    FROM   XXMOR_ORDENES_ESTATUS_TAB
                    WHERE  ID_NOTIFICACION = 36;
                ELSIF V_EST_LINEA = '46' THEN
                    /*
                    SELECT REPLACE(DESC_NOTIFICACION,'Orden', 'Linea')||(SELECT ' por: ' || REPLACE(CREATED_BY,'ConComWsResponse','Condiciones Comerciales')
                                                                         FROM   XXMOR_CONCOM_RPTA_TAB C
                                                                         WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                                                         AND    NUMLINEA_CONCOM = V_DET_SOL.LINEA
                                                                         AND    UPPER(ACCION_CONCOM) = 'RECHAZO'
                                                                         AND    ROWNUM = 1
                                                                        )
                    INTO   V_ERRORES_LINEA
                    FROM   XXMOR_ORDENES_ESTATUS_TAB
                    WHERE  ID_NOTIFICACION = 46;
                    */
                    SELECT CASE CREATED_BY WHEN 'ConComWsResponse' THEN
                               'Linea rechazada por: Condiciones Comerciales'
                           ELSE
                               'Linea rechazada por: '||REPLACE(CREATED_BY,'ConComWsResponse','Condiciones Comerciales')||' ('|| CAMPO_CONCOM||')'
                           END
                    INTO   V_ERRORES_LINEA
                    FROM   XXMOR_CONCOM_RPTA_TAB C
                    WHERE  ID_SOLICITUD         = P_ID_SOLICITUD
                    AND    NUMLINEA_CONCOM      = V_DET_SOL.LINEA
                    AND    UPPER(ACCION_CONCOM) = 'RECHAZO'
                    AND    ROWNUM               = 1;
                    SELECT XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN(P_ID_SOLICITUD,V_DET_SOL.linea,'lineaMail')||'
                    '||V_errores_linea
                    INTO   V_errores_linea
                    FROM   DUAL;
                ELSIF V_EST_LINEA = '45' THEN
                    SELECT XXMOR_FUNCIONAL_PKG.XXMOR_IDENT_ERRORES_FUN(P_ID_SOLICITUD,V_DET_SOL.linea,'lineaMail')
                    INTO   V_errores_linea
                    FROM   DUAL;
                ELSE
                    SELECT REPLACE(DESC_NOTIFICACION,'Orden completa', 'Linea')
                    INTO   V_ERRORES_LINEA
                    FROM   XXMOR_ORDENES_ESTATUS_TAB
                    WHERE  ID_NOTIFICACION = TO_NUMBER(V_EST_LINEA);
                END IF;
                FOR AUTORIZACION IN AUTORIZACIONES_CUR LOOP
                    V_ERRORES_LINEA := V_ERRORES_LINEA||'<br>'||AUTORIZACION.AUTORIZACION_MSG;
                END LOOP;
                SELECT COUNT(1)
                INTO   V_AUX
                FROM   XXMOR_SOLICITUDES_DET_TAB
                WHERE  TRACKING_ID_CONCOM = (SELECT TRACKING_ID_CONCOM
                                             FROM   XXMOR_SOLICITUDES_ENC_TAB
                                             WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                                            )
                AND    ID_SOLICITUD       = P_ID_SOLICITUD
                AND    LINEA              = V_DET_SOL.LINEA;
                IF V_AUX > 0 THEN
                    V_COLOR := 'F7DCC3';
                ELSE
                    V_COLOR := 'FFFFFF';
                END IF;
                V_OUTPUT1 := V_OUTPUT1 || '<tr>
                                <td align="center" width="10" valign="middle" bgcolor="#'||V_COLOR||'">' || TO_CHAR(V_DET_SOL.LINEA) || '</td>
                                <td align="center" width="300" bgcolor="#'||V_COLOR||'">' || V_ERRORES_LINEA || '</td>
                                <td align="center" width="40" bgcolor="#'||V_COLOR||'">' || V_ID_PARADIGM || '</td>
                                <td align="center" width="40" bgcolor="#'||V_COLOR||'">' || V_ID_ONAIR || '</td>
                                <td align="center" width="60" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.STNID|| '</td>
                                <td align="center" width="60" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.FECHA_INICIO|| '</td>
                                <td align="center" width="60" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.FECHA_FIN|| '</td>
                                <td align="center" width="20" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.DURACION|| '</td>
                                <td align="center" width="70" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.BUYUNTID|| '</td>
                                <td align="center" width="30" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.HORA_INICIO|| '</td>
                                <td align="center" width="30" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.HORA_FIN|| '</td>
                                <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.SPOTS|| '</td>
                                <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.LUNES|| '</td>
                                <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.MARTES|| '</td>
                                <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.MIERCOLES|| '</td>
                                <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.JUEVES|| '</td>
                                <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.VIERNES|| '</td>
                                <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.SABADO|| '</td>
                                <td align="center" width="15" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.DOMINGO|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.SPOTS_X_SEMANA|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.TIPO_SERVICIO|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.BN|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.P|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.MARCA|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.VERSION|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.TARIFASP_SIN_DESC|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.TARIFASP_CON_DESC|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.TOT_LINEA_SIN_DESC|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.TOT_LINEA_CON_DESC|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.SOBRECARGO|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.OBSERVACIONES|| '</td>
                                <td align="center" bgcolor="#'||V_COLOR||'">' || V_DET_SOL.DES_PLATAFORMA|| '</td>
                          </tr>';
            END LOOP;
            CLOSE CUR_DET_SOL;
            BEGIN
                SELECT VALOR_PARAMETRO
                INTO   lstTxtFooter
                FROM   XXMOR_CONF_PARAMS_GRLS_TAB
                WHERE  NOMBRE_PARAMETRO = 'EMAIL_TXT_ORD_ST_FOOTER';
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    lstTxtFooter := '';
            END;
            v_output1 := v_output1 ||'</table></td>
                  </tr>
                      <tr><td>;</td></tr>
                      <tr style="font-size:small; font-weight:bold; font-family:sans-serif;">
                        <td>'||lstTxtFooter||'</td>
                      </tr>
                      <tr><td>;</td></tr>
                      <tr><td bgcolor="#FCE49F" height="3"></td></tr>
                      <tr><td bgcolor="#FF801A" height="3"></td></tr>
                      <tr><td bgcolor="#D50000" height="3"></td></tr>
                  <tr><td style="font-family:Verdana, Geneva, sans-serif; font-size:12px; font-weight:bold color:#000;">'|| v_fecha ||'</td></tr>
                </table>
                </body>';
        END;
        --CLOSE CUR_HDR_SOL;
        c  := utl_tcp.open_connection(LST_SMTP_SRV, LIN_SMTP_PRT);        ----- OPEN SMTP PORT CONNECTION
        rc := utl_tcp.write_line(c, 'HELO '||LST_SMTP_SRV);               ----- PERFORMS HANDSHAKING WITH SMTP SERVER
        dbms_output.put_line(utl_tcp.get_line(c, TRUE));
        rc := utl_tcp.write_line(c, 'HELO '||LST_SMTP_SRV);               ----- PERFORMS HANDSHAKING, INCLUDING EXTRA INFORMATION
        dbms_output.put_line(utl_tcp.get_line(c, TRUE));
        rc := utl_tcp.write_line(c, 'MAIL FROM: '||msg_from);             ----- MAIL BOX SENDING THE EMAIL
        dbms_output.put_line(utl_tcp.get_line(c, TRUE));
        rc := utl_tcp.write_line(c, 'RCPT TO: '||msg_to);                 ----- MAIL BOX RECIEVING THE EMAIL
        dbms_output.put_line(utl_tcp.get_line(c, TRUE));
        rc := utl_tcp.write_line(c, 'DATA');                              ----- EMAIL MESSAGE BODY START
        dbms_output.put_line(utl_tcp.get_line(c, TRUE));
        rc := utl_tcp.write_line(c, 'Date: '||TO_CHAR( SYSDATE, 'dd Mon yy hh24:mi:ss' ));
        rc := utl_tcp.write_line(c, 'From: '||msg_from||' <'||msg_from||'>');
        rc := utl_tcp.write_line(c, 'MIME-Version: 1.0');
        rc := utl_tcp.write_line(c, 'To: '||msg_to||' <'||msg_to||'>');
        rc := utl_tcp.write_line(c, 'Subject: '||msg_subject);
        rc := utl_tcp.write_line(c, 'Content-Type: multipart/mixed;');  ----- INDICATES THAT THE BODY CONSISTS OF MORE THAN ONE PART
        rc := utl_tcp.write_line(c, ' boundary="-----SECBOUND"');       ----- SEPERATOR USED TO SEPERATE THE BODY PARTS
        rc := utl_tcp.write_line(c, '');                                ----- DO NOT REMOVE THIS BLANK LINE - PART OF MIME STANDARD
        rc := utl_tcp.write_line(c, '-------SECBOUND');
        rc := utl_tcp.write_line(c, 'Content-Type: text/plain');        ----- 1ST BODY PART. EMAIL TEXT MESSAGE
        rc := utl_tcp.write_line(c, 'Content-Transfer-Encoding: 7bit');
        rc := utl_tcp.write_line(c, '');
        rc := utl_tcp.write_line(c, msg_text);                          ----- TEXT OF EMAIL MESSAGE
        rc := utl_tcp.write_line(c, '');
        rc := utl_tcp.write_line(c, '-------SECBOUND');
        rc := utl_tcp.write_line(c, 'Content-Type: text/plain;');       ----- 2ND BODY PART.
        --rc := utl_tcp.write_line(c, ' name="Test.html"');
        rc := utl_tcp.write_line(c, ' name='||'EstatusOrden_'||P_ID_SOLICITUD||'.html');
        rc := utl_tcp.write_line(c, 'Content-Transfer_Encoding: 8bit');
        rc := utl_tcp.write_line(c, 'Content-Disposition: attachment;'); ----- INDICATES THAT THIS IS AN ATTACHMENT
        --rc := utl_tcp.write_line(c, ' filename="Test.html"');             ----- SUGGESTED FILE NAME FOR ATTACHMENT
        rc := utl_tcp.write_line(c, ' name='||'EstatusOrden_'||P_ID_SOLICITUD||'.html');
        rc := utl_tcp.write_line(c, '');
        FOR I IN 0 .. FLOOR(DBMS_LOB.GETLENGTH(v_output1) / V_BUFFER_SIZE) LOOP
            DBMS_LOB.READ(v_output1, V_BUFFER_NEXT, I * V_BUFFER_SIZE + 1, V_BODY_BUFFER);
            RC := UTL_TCP.WRITE_TEXT(C, V_BODY_BUFFER);
        END LOOP;
        --rc := utl_tcp.write_line(c, '-------SECBOUND--');
        rc := utl_tcp.write_line(c, '');
        rc := utl_tcp.write_line(c, '.');                    ----- EMAIL MESSAGE BODY END
        dbms_output.put_line(utl_tcp.get_line(c, TRUE));
        rc := utl_tcp.write_line(c, 'QUIT');                 ----- ENDS EMAIL TRANSACTION
        dbms_output.put_line(utl_tcp.get_line(c, TRUE));
        utl_tcp.close_connection(c);                         ----- CLOSE SMTP PORT CONNECTION
    --    EXCEPTION
    --      WHEN others THEN
    --           BEGIN
    --               INSERT INTO XXMOR_LOG_ERRORES_TAB(ID_ERROR, DESC_ERROR, ARCHIVO_ERROR, METODO_ERROR)
    --               VALUES(XXMOR_LOG_ERROR_SQ.NEXTVAL, 'No pudo enviarse la notificacion', NULL, 'procedure XXMOR_HTML_EMAIL_PR(to:'||msg_TO||', subject: '||msg_subject|| ',...) ');
    --               --raise_application_error(-20000, SQLERRM);
    --           END;
    END XXMOR_SOL_NOTIFICACION_PR;
    PROCEDURE XXMOR_ENV_NOTIFICACION_PR
                        (
                                P_SOLICITUD IN XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE
                        ) AS
    V_SOLICITUD      XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE;
    V_JOBN           PLS_INTEGER;
    V_PART1          VARCHAR(3000);
    V_PART2          VARCHAR(3000);
    V_AUX            VARCHAR(3000);
    V_MAIL_ESTATUS   VARCHAR(100);
    V_MAIL_INT       PLS_INTEGER;
    V_MAIL_EXT       PLS_INTEGER;
    V_MAIL_FAC       PLS_INTEGER;
    V_LISTA_MAILS    VARCHAR(3000);
    V_NOMBRE_ARCHIVO VARCHAR(300);
    CURSOR MAILS_USRS_CUR IS
    SELECT ID_USER,
           ADMINISTRADOR
    FROM   XXMOR_FZAS_VTAS_USUARIOS_TAB
    WHERE  ID_SEG_NEG    = 1
    AND    ID_FZA_VENTAS = P_SOLICITUD.ID_FZA_VENTAS
    AND    ADMINISTRADOR = 1;
    CURSOR MAILS_FACTUR_CUR IS
    WITH VALUE_LIST AS
    (SELECT MAILS_FACTUR||',' AS val FROM XXMOR_SOL_FACTUR_MAILS_TAB WHERE id_solicitud = P_SOLICITUD.ID_SOLICITUD)
    SELECT SUBSTR(val, (DECODE(LEVEL, 1, 0, INSTR(val, ',', 1, LEVEL -1)) + 1),
                       (DECODE(INSTR(val, ',', 1, LEVEL) -1, -1, LENGTH(val), INSTR(val, ',', 1, LEVEL) -1))
                       -(DECODE(LEVEL, 1, 0, INSTR(val, ',', 1, LEVEL -1)) + 1) + 1) CORREO
    FROM VALUE_LIST CONNECT BY LEVEL <= (SELECT(LENGTH(val) -LENGTH(REPLACE(val, ',', NULL)))
    FROM VALUE_LIST);
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ENTRA -->XXMOR_ENV_NOTIFICACION_PR');
        BEGIN
            SELECT NVL(USUARIO_INTERNO,0),
                   NVL(USUARIO_AGENCIA,0),
                   NVL(USUARIO_FACTUR,0)
            INTO   V_MAIL_INT,
                   V_MAIL_EXT,
                   V_MAIL_FAC
            FROM   XXMOR_CONF_NOTIFIC_TAB
            WHERE  ID_SEG_NEG      = 1
            AND    ID_FZA_VENTAS   = P_SOLICITUD.ID_FZA_VENTAS
            AND    ID_NOTIFICACION = P_SOLICITUD.ORDEN_ESTATUS;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_MAIL_INT := 0;
                V_MAIL_EXT := 0;
                V_MAIL_FAC := 0;
        END;
        SELECT A.NOM_ARCHIVO_SOL
        INTO   V_NOMBRE_ARCHIVO
        FROM   XXMOR_SOLICITUDES_ARCH_TAB A,
               XXMOR_SOLICITUDES_ENC_TAB E,
               XXMOR_SOLICITUDES_ORIG_ENC_TAB EO
        WHERE  E.ID_SOLICITUD    = P_SOLICITUD.ID_SOLICITUD
        AND    E.ID_REQUEST      = EO.ID_REQUEST
        AND    EO.ID_ARCHIVO_SOL = A.ID_ARCHIVO_SOL
        AND    E.ID_SEG_NEG      = 1
        AND    E.ID_SEG_NEG      = A.ID_SEG_NEG;
        SELECT 'Orden '||P_SOLICITUD.ID_SOLICITUD||'('||V_NOMBRE_ARCHIVO||') '||DESC_NOTIFICACION
        INTO   V_MAIL_ESTATUS
        FROM   XXMOR.XXMOR_ORDENES_ESTATUS_TAB
        WHERE  ID_NOTIFICACION = P_SOLICITUD.ORDEN_ESTATUS
        AND    ID_SEG_NEG      = 1;
        V_PART1 := 'DECLARE
                        v_Solicitud xxmor_Funcional_pkg.Mor_Enc_Rec_Type;
                    BEGIN
                        v_SOLICITUD.ID_SOLICITUD  := '  || P_SOLICITUD.ID_SOLICITUD ||';
                        v_SOLICITUD.ADVID         := '''|| P_SOLICITUD.ADVID ||''';
                        v_SOLICITUD.ACCTHDRID     := '''|| P_SOLICITUD.ACCTHDRID ||''';
                        v_SOLICITUD.MCONTID       := '''|| P_SOLICITUD.MCONTID ||''';
                        v_SOLICITUD.RTCRDDSCR     := '''|| P_SOLICITUD.RTCRDDSCR ||''';
                        v_SOLICITUD.COMENTARIOS   := '''|| P_SOLICITUD.COMENTARIOS ||''';
                        v_SOLICITUD.ORDEN_ESTATUS := '  || P_SOLICITUD.ORDEN_ESTATUS ||';
                        v_SOLICITUD.EMAIL         := ''';
                        V_PART2 := ''';
                        BEGIN
                        --   XXMOR_FUNCIONAL_PKG.XXMOR_SOL_NOTIFICACION_PR ( v_SOLICITUD );
                        END;
                        commit;
                    END; ';
        V_LISTA_MAILS   := 'BEGIN
                                 XXMOR_FUNCIONAL_PKG.XXMOR_HTML_EMAIL_PR(''';
        --DBMS_OUTPUT.PUT_LINE(V_PART1||'marodriguezg@televisa.com.mx'||V_PART2);
        --
        IF V_MAIL_INT = 1 THEN
            FOR DESTINATARIOS IN MAILS_USRS_CUR LOOP
                V_AUX := V_PART1|| DESTINATARIOS.ID_USER ||'@televisa.com.mx' ||V_PART2;
                --DBMS_OUTPUT.PUT_LINE(V_AUX);
                --SYS.DBMS_JOB.SUBMIT(V_JOBN,  V_AUX);
                V_AUX := V_PART1|| P_SOLICITUD.CREATED_BY ||'@televisa.com.mx' ||V_PART2;
                V_LISTA_MAILS:= V_LISTA_MAILS ||DESTINATARIOS.ID_USER ||'@televisa.com.mx,';
                --DBMS_OUTPUT.PUT_LINE(V_AUX);
                --SYS.DBMS_JOB.SUBMIT(V_JOBN,  V_AUX);
            END LOOP;
            IF P_SOLICITUD.CREATED_BY IS NOT NULL THEN
                V_LISTA_MAILS:= V_LISTA_MAILS ||P_SOLICITUD.CREATED_BY ||'@televisa.com.mx,';
            END IF;
        END IF;
        --Mail externo
        IF V_MAIL_EXT = 1 AND INSTR(P_SOLICITUD.EMAIL,'@') > 0 THEN
            V_AUX := V_PART1|| TRIM(LOWER(P_SOLICITUD.EMAIL)) ||V_PART2;
            --DBMS_OUTPUT.PUT_LINE(V_AUX);
            V_LISTA_MAILS:= V_LISTA_MAILS ||TRIM(LOWER(P_SOLICITUD.EMAIL))||',';
            --SYS.DBMS_JOB.SUBMIT(V_JOBN,  V_AUX);
        END IF;
        --Mail FACTUR
        IF V_MAIL_FAC = 1 THEN
            FOR DESTINATARIOS IN MAILS_FACTUR_CUR LOOP
                V_AUX := V_PART1|| DESTINATARIOS.CORREO||V_PART2;
                DBMS_OUTPUT.PUT_LINE( DESTINATARIOS.CORREO);
                --SYS.DBMS_JOB.SUBMIT(V_JOBN,  V_AUX);
                --DBMS_OUTPUT.PUT_LINE(V_AUX);
                --SYS.DBMS_JOB.SUBMIT(V_JOBN,  V_AUX);
                IF INSTR(V_LISTA_MAILS,DESTINATARIOS.CORREO) = 0 THEN
                    V_LISTA_MAILS := V_LISTA_MAILS ||DESTINATARIOS.CORREO||',';
                END IF;
            END LOOP;
        END IF;
        --Si no se identifico fza de ventas enviar al administrador del sistema
        IF P_SOLICITUD.ID_FZA_VENTAS = 0 THEN
            SELECT V_PART1||TRIM(VALOR_PARAMETRO)||V_PART2
            INTO   V_AUX
            FROM   XXMOR_CONF_PARAMS_GRLS_TAB
            WHERE  NOMBRE_PARAMETRO = 'SysAdmin';
            SELECT V_LISTA_MAILS||TRIM(VALOR_PARAMETRO)
            INTO   V_LISTA_MAILS
            FROM   XXMOR_CONF_PARAMS_GRLS_TAB
            WHERE  NOMBRE_PARAMETRO = 'SysAdmin'
            AND    INSTR(V_LISTA_MAILS,VALOR_PARAMETRO) = 0;
            --SYS.DBMS_JOB.SUBMIT(V_JOBN,  V_AUX);
        END IF;
        V_LISTA_MAILS := V_LISTA_MAILS || ''','''|| V_MAIL_ESTATUS ||''',null,XXMOR_FUNCIONAL_PKG.XXMOR_HTML_MAIL('|| P_SOLICITUD.ID_SOLICITUD ||', NULL, 10)); END;';
        DBMS_JOB.SUBMIT(V_JOBN,  V_LISTA_MAILS);
        DBMS_OUTPUT.PUT_LINE('V_LISTA_MAILS: ' || TRIM(V_LISTA_MAILS));
        DBMS_OUTPUT.PUT_LINE('SALE -->XXMOR_ENV_NOTIFICACION_PR');
    END XXMOR_ENV_NOTIFICACION_PR;
    PROCEDURE XXMOR_ENV_NOTIFICACION_ST_PR
                        (
                                P_ID_SOLICITUD    IN INTEGER,
                                P_LINEAS          IN VARCHAR2,
                                P_ID_NOTIFICACION IN INTEGER
                        ) IS
    V_MAIL_INT          PLS_INTEGER;
    V_MAIL_EXT          PLS_INTEGER;
    V_MAIL_FAC          PLS_INTEGER;
    V_LISTA_MAILS       VARCHAR(3000);
    V_LISTA_MAILS_MKT   VARCHAR(3000);
    V_NOMBRE_ARCHIVO    VARCHAR(300);
    V_AUTORIZACIONES    PLS_INTEGER;
    V_RECHAZOS          PLS_INTEGER;
    V_ERRORES_LIN       NUMBER;
    V_SOLICITUD         XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE;
    V_MAIL_SUBJECT      VARCHAR(300);
    --Mails de buyunit-Mercadotecnia
    CURSOR ADD_BUYUNT_MKT_CUR(C_ID_SOLICITUD INTEGER) IS
    SELECT NVL2(MKT_DIRECTOR,MKT_DIRECTOR||', ',' ')||
           NVL2(MKT_GERENTE,MKT_GERENTE||', ',' ')||
           NVL2(MKT_COORDINADOR,MKT_COORDINADOR||', ',' ')||
           NVL2(MKT_EJECUTIVO,MKT_EJECUTIVO||', ',' ') AS MAILS
    FROM   XXMOR.XXMOR_CAT_BUYUNIT_MKT_TAB BM
    WHERE  EXISTS (SELECT 1
                   FROM   XXMOR_SOLICITUDES_ENC_TAB E,
                          XXMOR_SOLICITUDES_DET_TAB D,
                          XXMOR_FZAS_VTAS_TAB FV
                   WHERE  E.ID_SOLICITUD   = C_ID_SOLICITUD
                   AND    E.ID_SOLICITUD   = D.ID_SOLICITUD
                   AND    E.ID_FZA_VENTAS  = FV.ID_FZA_VENTAS
                   AND    FV.MERCADOTECNIA = 1 --LA ORDEN TIENE QUE SER DE UNA FZA DE VTAS DE MKT
                   AND    E.ID_FZA_VENTAS  = BM.ID_FZA_VENTAS
                   AND    NVL(TRIM(D.BUYUNTID),'SIN BUYUNIT') = NVL(TRIM(BM.BUYUNTID),'SIN BUYUNIT')
                  );
    CURSOR MAILS_USRS_CUR IS
    SELECT ID_USER,
           ADMINISTRADOR
    FROM   XXMOR_FZAS_VTAS_USUARIOS_TAB
    WHERE  ID_SEG_NEG    = 1
    AND    ID_FZA_VENTAS = (SELECT ID_FZA_VENTAS
                            FROM   XXMOR_SOLICITUDES_ENC_TAB
                            WHERE  ID_SOLICITUD = P_ID_SOLICITUD
                           )
    AND    ADMINISTRADOR = 1;
    CURSOR LINEAS_ORDEN_CUR IS
    SELECT LINEA
    FROM   XXMOR_SOLICITUDES_DET_TAB
    WHERE  ID_SOLICITUD =  P_ID_SOLICITUD;
    BEGIN
        -- Debido a que hay ordenes de cable-sky que al no obtener ratecard se rechazan las lineas
        -- es necesario revisar que si dichas lineas tienen autorizaciones y dichos registros aun
        -- siguen en estatus 10, es necesario actualizarlos a 20 para que la orden pueda consultarse
        -- de manera correcta (12-07-2013).
        FOR LINEA_ORDEN IN LINEAS_ORDEN_CUR LOOP
            V_ERRORES_LIN := 0;
            SELECT COUNT(1)
            INTO   V_ERRORES_LIN
            FROM   XXMOR_CONCOM_RPTA_TAB
            WHERE  ID_SOLICITUD             = P_ID_SOLICITUD
            AND    NVL(NUMLINEA_CONCOM,'0') = TO_CHAR(LINEA_ORDEN.LINEA)
            AND    UPPER(ACCION_CONCOM)     = 'RECHAZO'
            AND    ESTATUS_ORDUNI           = '10';
            IF V_ERRORES_LIN > 0 THEN
                -- PARA ACTUALIZAR A ESTATUS 20 LAS LINEAS QUE FUERON RECHAZADAS Y QUE
                -- AUN SIGUEN CON ESTATUS 10.
                UPDATE XXMOR_CONCOM_RPTA_TAB CR
                SET    CR.ESTATUS_ORDUNI = '20',
                       CR.UPDATED_BY     = 'ORDUNI',
                       CR.UPDATED_DATE   = SYSDATE
                WHERE CR.ID_SOLICITUD       = P_ID_SOLICITUD
                AND UPPER(CR.ACCION_CONCOM) IN ('REPROCESO','AUTORIZACION')
                AND NUMLINEA_CONCOM         = TO_CHAR(LINEA_ORDEN.LINEA)
                AND ESTATUS_ORDUNI          = '10';
            END IF;
        END LOOP;
        --Revisamos si tiene rechazos
        SELECT COUNT(1)
        INTO   v_rechazos
        FROM   XXMOR_CONCOM_RPTA_TAB
        WHERE  ID_SOLICITUD         = P_ID_SOLICITUD
        AND    UPPER(ACCION_CONCOM) = 'RECHAZO'
        AND    ESTATUS_ORDUNI       = '10';
        --Revisamos si tiene autorizaciones
        SELECT COUNT(1)
        INTO   v_autorizaciones
        FROM   XXMOR_CONCOM_RPTA_TAB
        WHERE  ID_SOLICITUD         = P_ID_SOLICITUD
        AND    UPPER(ACCION_CONCOM) = 'AUTORIZACION'
        AND    ESTATUS_ORDUNI       = '10';
        SELECT ID_SOLICITUD,
               ADVID,
               ACCTHDRID,
               MCONTID,
               RTCRDDSCR,
               COMENTARIOS,
               ID_FZA_VENTAS,
               EMAIL,
               CREATED_BY
        INTO   V_SOLICITUD.ID_SOLICITUD,
               V_SOLICITUD.ADVID,
               V_SOLICITUD.ACCTHDRID,
               V_SOLICITUD.MCONTID,
               V_SOLICITUD.RTCRDDSCR,
               V_SOLICITUD.COMENTARIOS,
               V_SOLICITUD.ID_FZA_VENTAS,
               V_SOLICITUD.EMAIL,
               V_SOLICITUD.CREATED_BY
        FROM   XXMOR_SOLICITUDES_ENC_TAB
        WHERE  ID_SOLICITUD =  P_ID_SOLICITUD;
        BEGIN
            SELECT NVL(USUARIO_INTERNO,0),
                   NVL(USUARIO_AGENCIA,0),
                   NVL(USUARIO_FACTUR,0)
            INTO   V_MAIL_INT,
                   V_MAIL_EXT,
                   V_MAIL_FAC
            FROM   XXMOR_CONF_NOTIFIC_TAB
            WHERE  ID_SEG_NEG      = 1
            AND    ID_FZA_VENTAS   = V_SOLICITUD.ID_FZA_VENTAS
            AND    ID_NOTIFICACION = P_ID_NOTIFICACION;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_MAIL_INT := 0;
                V_MAIL_EXT := 0;
                V_MAIL_FAC := 0;
        END;
        SELECT A.NOM_ARCHIVO_SOL
        INTO   V_NOMBRE_ARCHIVO
        FROM   XXMOR_SOLICITUDES_ARCH_TAB     A,
               XXMOR_SOLICITUDES_ENC_TAB      E,
               XXMOR_SOLICITUDES_ORIG_ENC_TAB EO
        WHERE  E.ID_SOLICITUD    = P_ID_SOLICITUD
        AND    E.ID_REQUEST      = EO.ID_REQUEST
        AND    EO.ID_ARCHIVO_SOL = A.ID_ARCHIVO_SOL
        AND    E.ID_SEG_NEG      = 1
        AND    E.ID_SEG_NEG      = A.ID_SEG_NEG;
        SELECT 'Orden '|| P_ID_SOLICITUD ||' ('||V_NOMBRE_ARCHIVO||') ' || DESC_NOTIFICACION
        INTO   V_MAIL_SUBJECT
        FROM   XXMOR.XXMOR_ORDENES_ESTATUS_TAB
        WHERE  ID_NOTIFICACION = P_ID_NOTIFICACION
        AND    ID_SEG_NEG      = 1;
        V_LISTA_MAILS := NULL;
        --Mail interno
        IF V_MAIL_INT = 1 THEN
            FOR DESTINATARIOS IN MAILS_USRS_CUR LOOP
                V_LISTA_MAILS := V_LISTA_MAILS ||DESTINATARIOS.ID_USER ||'@televisa.com.mx,';
            END LOOP;
            V_LISTA_MAILS:= V_LISTA_MAILS ||V_SOLICITUD.CREATED_BY ||'@televisa.com.mx,';
            DBMS_OUTPUT.PUT_LINE( 'sale mail interno: '||V_LISTA_MAILS);
        END IF;
        --Mail externo
        IF V_MAIL_EXT = 1 AND INSTR(V_SOLICITUD.EMAIL,'@') > 0 THEN
            DBMS_OUTPUT.PUT_LINE( 'entra a mail externo');
            V_LISTA_MAILS:= V_LISTA_MAILS ||TRIM(LOWER(V_SOLICITUD.EMAIL))||',';
            DBMS_OUTPUT.PUT_LINE( 'sale mail externo: '||V_LISTA_MAILS);
        END IF;
        --Mail FACTUR
        IF V_MAIL_FAC = 1 THEN
            V_LISTA_MAILS := V_LISTA_MAILS || XXMOR_FUNCIONAL_PKG.XXMOR_GET_MAILS_FACTUR_FUN(P_ID_SOLICITUD)||',';
            DBMS_OUTPUT.PUT_LINE( 'sale mail factur: '||V_LISTA_MAILS);
        END IF;
        --Mails de mkt - buyunit
        IF P_ID_NOTIFICACION = 35 THEN --Estatus despues de validaciones
            -- SE ENVIA LA NOTIFICACION DESPUES DE VALIDACION
            IF LENGTH(V_LISTA_MAILS) > 5 THEN
                DBMS_OUTPUT.PUT_LINE( 'V_LISTA_MAILS: '||V_LISTA_MAILS ||' V_MAIL_SUBJECT: '|| V_MAIL_SUBJECT);
                XXMOR_HTML_EMAIL_PR(V_LISTA_MAILS, V_MAIL_SUBJECT, NULL, XXMOR_HTML_MAIL(P_ID_SOLICITUD, NULL, 10)  );
            END IF;
            FOR C_MAILS IN ADD_BUYUNT_MKT_CUR(P_ID_SOLICITUD) LOOP
                V_LISTA_MAILS_MKT := V_LISTA_MAILS_MKT ||C_MAILS.MAILS;
                DBMS_OUTPUT.PUT_LINE( 'C_MAILS.MAILS: ' ||C_MAILS.MAILS);
            END LOOP;
            IF LENGTH(V_LISTA_MAILS_MKT ) > 5 THEN
                SELECT 'Orden '|| P_ID_SOLICITUD ||' ('||V_NOMBRE_ARCHIVO||') ' || DESC_NOTIFICACION
                INTO   V_MAIL_SUBJECT
                FROM   XXMOR.XXMOR_ORDENES_ESTATUS_TAB
                WHERE  ID_NOTIFICACION = 84
                AND    ID_SEG_NEG      = 1;
                DBMS_OUTPUT.PUT_LINE( 'V_LISTA_MAILS_MKT: '||V_LISTA_MAILS_MKT ||' V_MAIL_SUBJECT: '|| V_MAIL_SUBJECT);
                XXMOR_HTML_EMAIL_PR(V_LISTA_MAILS_MKT, V_MAIL_SUBJECT, NULL, XXMOR_HTML_MAIL(P_ID_SOLICITUD, P_LINEAS, P_ID_NOTIFICACION)  );
            END IF;
        --Si es estatus 100 (orden con autorizaciones Generadas)
        --ELSIF P_ID_NOTIFICACION = 100 AND V_AUTORIZACIONES > 0 THEN
        ELSIF P_ID_NOTIFICACION = 100 THEN
            -- SE ENVIA LA NOTIFICACION DESPUES DE QUE SE GENERA LA AUTORIZACION
            IF LENGTH(V_LISTA_MAILS) > 5 THEN
                DBMS_OUTPUT.PUT_LINE( 'V_LISTA_MAILS: '||V_LISTA_MAILS ||' V_MAIL_SUBJECT: '|| V_MAIL_SUBJECT);
                XXMOR_HTML_EMAIL_PR(V_LISTA_MAILS, V_MAIL_SUBJECT, NULL, XXMOR_HTML_MAIL(P_ID_SOLICITUD, P_LINEAS, 10)  );
            END IF;
            FOR C_MAILS IN ADD_BUYUNT_MKT_CUR(P_ID_SOLICITUD) LOOP
                V_LISTA_MAILS_MKT := V_LISTA_MAILS_MKT ||C_MAILS.MAILS;
                DBMS_OUTPUT.PUT_LINE( 'C_MAILS.MAILS: ' ||C_MAILS.MAILS);
            END LOOP;
            IF LENGTH(V_LISTA_MAILS_MKT ) > 5 THEN
                SELECT 'Orden '|| P_ID_SOLICITUD ||' ('||V_NOMBRE_ARCHIVO||') ' || DESC_NOTIFICACION
                INTO   V_MAIL_SUBJECT
                FROM   XXMOR.XXMOR_ORDENES_ESTATUS_TAB
                WHERE  ID_NOTIFICACION = 84
                AND    ID_SEG_NEG      = 1;
                DBMS_OUTPUT.PUT_LINE( 'V_LISTA_MAILS_MKT: '||V_LISTA_MAILS_MKT ||' V_MAIL_SUBJECT: '|| V_MAIL_SUBJECT);
                XXMOR_HTML_EMAIL_PR(V_LISTA_MAILS_MKT, V_MAIL_SUBJECT, NULL, XXMOR_HTML_MAIL(P_ID_SOLICITUD, P_LINEAS, P_ID_NOTIFICACION)  );
            END IF;
        --Si es estatus 101 (orden con rechazos generados)
        ELSIF P_ID_NOTIFICACION = 101 AND V_RECHAZOS > 0 THEN --Estatus despues de Rechazos
            -- SE ENVIA LA NOTIFICACION DESPUES DE RECHAZO
            IF LENGTH(V_LISTA_MAILS) > 5 THEN
                DBMS_OUTPUT.PUT_LINE( 'V_LISTA_MAILS: '||V_LISTA_MAILS ||' V_MAIL_SUBJECT: '|| V_MAIL_SUBJECT);
                XXMOR_HTML_EMAIL_PR(V_LISTA_MAILS, V_MAIL_SUBJECT, NULL, XXMOR_HTML_MAIL(P_ID_SOLICITUD, P_LINEAS, 10)  );
            END IF;
            FOR C_MAILS IN ADD_BUYUNT_MKT_CUR(P_ID_SOLICITUD) LOOP
                V_LISTA_MAILS_MKT := V_LISTA_MAILS_MKT ||C_MAILS.MAILS;
                DBMS_OUTPUT.PUT_LINE( 'C_MAILS.MAILS: ' ||C_MAILS.MAILS);
            END LOOP;
            IF LENGTH(V_LISTA_MAILS_MKT ) > 5 THEN
                SELECT 'Orden '|| P_ID_SOLICITUD ||' ('||V_NOMBRE_ARCHIVO||') ' || DESC_NOTIFICACION
                INTO   V_MAIL_SUBJECT
                FROM   XXMOR.XXMOR_ORDENES_ESTATUS_TAB
                WHERE  ID_NOTIFICACION = 84
                AND    ID_SEG_NEG      = 1;
                DBMS_OUTPUT.PUT_LINE( 'V_LISTA_MAILS_MKT: '||V_LISTA_MAILS_MKT ||' V_MAIL_SUBJECT: '|| V_MAIL_SUBJECT);
                XXMOR_HTML_EMAIL_PR(V_LISTA_MAILS_MKT, V_MAIL_SUBJECT, NULL, XXMOR_HTML_MAIL(P_ID_SOLICITUD, P_LINEAS, P_ID_NOTIFICACION)  );
            END IF;
        --Si es estatus 4 (Detalle de Insercion en Paradigm)
        ELSIF P_ID_NOTIFICACION = 4 THEN
            -- SE ENVIA LA NOTIFICACION DESPUES DE INSERCION
            IF LENGTH(V_LISTA_MAILS) > 5 THEN
                DBMS_OUTPUT.PUT_LINE( 'V_LISTA_MAILS: '||V_LISTA_MAILS ||' V_MAIL_SUBJECT: '|| V_MAIL_SUBJECT);
                XXMOR_HTML_EMAIL_PR(V_LISTA_MAILS, V_MAIL_SUBJECT, NULL, XXMOR_HTML_MAIL(P_ID_SOLICITUD, NULL, 10)  );
            END IF;
        END IF;
    END XXMOR_ENV_NOTIFICACION_ST_PR;
    PROCEDURE XXMOR_ENV_NOTIFICACION_PR
                        (
                                P_ID_SOLICITUD    IN INTEGER,
                                P_LINEAS          IN VARCHAR2,
                                P_ID_NOTIFICACION IN VARCHAR2
                        ) IS
    V_SOLICITUD     XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE;
    V_CREATED_BY    VARCHAR2(100);
    V_EMAIL         VARCHAR2(100);
    V_ID_FZA_VENTAS INTEGER;
    V_TRACKING_ID   INTEGER;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ENTRA XXMOR_ENV_NOTIFICACION_PR2');
        SELECT CREATED_BY,
               EMAIL,
               ID_FZA_VENTAS
        INTO   V_CREATED_BY,
               V_EMAIL,
               V_ID_FZA_VENTAS
        FROM   XXMOR_SOLICITUDES_ENC_TAB
        WHERE  ID_SOLICITUD = P_ID_SOLICITUD;
        V_SOLICITUD.ID_SOLICITUD  := P_ID_SOLICITUD;
        V_SOLICITUD.ORDEN_ESTATUS := P_ID_NOTIFICACION;
        V_SOLICITUD.CREATED_BY    := V_CREATED_BY;
        V_SOLICITUD.EMAIL         := V_EMAIL;
        V_SOLICITUD.ID_FZA_VENTAS := V_ID_FZA_VENTAS;
        XXMOR_ENV_NOTIFICACION_PR ( V_SOLICITUD );
        DBMS_OUTPUT.PUT_LINE('SALE XXMOR_ENV_NOTIFICACION_PR2');
    END XXMOR_ENV_NOTIFICACION_PR;
    --PROCEDIMIENTO PARA ENVIAR NOTIFICACIONES EN EL DETALLE DE INSERCION A PARADIGM
    PROCEDURE XXMOR_ENV_NOTIF_OCPGM_PR
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) IS
    V_LINEAS_ORD          PLS_INTEGER;
    V_LINEAS_INSERTADAS   PLS_INTEGER;
    V_EST_ENC             PLS_INTEGER;
    V_SOLICITUD           XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE;
    V_CREATED_BY          VARCHAR2(100);
    V_EMAIL               VARCHAR2(100);
    V_ID_FZA_VENTAS       INTEGER;
    V_TRACKING_ID         INTEGER;
    BEGIN
        SELECT ORDEN_ESTATUS
        INTO V_EST_ENC
        FROM XXMOR_SOLICITUDES_ENC_TAB
        WHERE ID_SOLICITUD = P_ID_SOLICITUD;
        SELECT COUNT(1)
        INTO V_LINEAS_ORD
        FROM XXMOR_SOLICITUDES_DET_TAB
        WHERE ID_SOLICITUD = P_ID_SOLICITUD;
        SELECT COUNT(1)
        INTO V_LINEAS_INSERTADAS
        FROM XXMOR_SOLICITUDES_DET_TAB
        WHERE LINEA_ESTATUS = 60
        AND   ID_SOLICITUD = P_ID_SOLICITUD;
        IF (V_LINEAS_INSERTADAS = V_LINEAS_ORD AND V_LINEAS_INSERTADAS != 0) THEN
            SELECT CREATED_BY, EMAIL, ID_FZA_VENTAS
            INTO  V_CREATED_BY, V_EMAIL, V_ID_FZA_VENTAS
            FROM XXMOR_SOLICITUDES_ENC_TAB
            WHERE ID_SOLICITUD = P_ID_SOLICITUD;
            V_SOLICITUD.id_solicitud  := P_ID_SOLICITUD;
            V_SOLICITUD.ORDEN_ESTATUS := 4;
            V_SOLICITUD.CREATED_BY    := V_CREATED_BY;
            V_SOLICITUD.EMAIL         := V_EMAIL;
            V_SOLICITUD.ID_FZA_VENTAS := V_ID_FZA_VENTAS;
            -- XXMOR_ENV_NOTIFICACION_PR ( V_SOLICITUD );
        END IF;
    END XXMOR_ENV_NOTIF_OCPGM_PR;
    --Usado en bpel para notificar y en genera ordenes
    PROCEDURE XXMOR_ENV_MAIL_OR_MC_PR
                        (
                                P_ID_REQUEST IN INTEGER,
                                P_ID_ESTATUS IN INTEGER
                        ) IS
    CURSOR SOL_MCONTID_MAL_CUR IS
    SELECT ID_SOLICITUD
    FROM   XXMOR_SOLICITUDES_ENC_TAB E
    WHERE  E.ID_SEG_NEG         = 1
    --AND    INSTR(E.MCONTID,'.') = 0
    AND    EXISTS (SELECT 1
                   FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB OE
                   WHERE  E.ID_REQUEST = OE.ID_REQUEST
                   AND    OE.AUX1      = P_ID_REQUEST
                  );
    V_SOLICITUD       XXMOR_FUNCIONAL_PKG.MOR_ENC_REC_TYPE;
    V_CREATED_BY      VARCHAR2(100);
    V_EMAIL           VARCHAR2(100);
    V_ID_FZA_VENTAS   INTEGER;
    V_TRACKING_ID     INTEGER;
    V_MCONTID         VARCHAR2(30);
    BEGIN
        FOR C_ORD_MAL IN SOL_MCONTID_MAL_CUR LOOP
            dbms_output.put_line('hola_rec_type id_sol: '||C_ORD_MAL.ID_SOLICITUD);
            SELECT CREATED_BY, EMAIL, ID_FZA_VENTAS, MCONTID
            INTO  V_CREATED_BY, V_EMAIL, V_ID_FZA_VENTAS, V_MCONTID
            FROM XXMOR_SOLICITUDES_ENC_TAB
            WHERE ID_SOLICITUD = C_ORD_MAL.ID_SOLICITUD;
            V_SOLICITUD.id_solicitud   := C_ORD_MAL.ID_SOLICITUD;
            V_SOLICITUD.ORDEN_ESTATUS  := P_ID_ESTATUS;
            V_SOLICITUD.CREATED_BY     := V_CREATED_BY;
            V_SOLICITUD.EMAIL          := V_EMAIL;
            V_SOLICITUD.ID_FZA_VENTAS  := V_ID_FZA_VENTAS;
            IF P_ID_ESTATUS = 5000 THEN
                V_SOLICITUD.ORDEN_ESTATUS  := 46;
                XXMOR_ENV_NOTIFICACION_PR ( V_SOLICITUD );
            ELSE
                XXMOR_ENV_NOTIFICACION_ST_PR(C_ORD_MAL.ID_SOLICITUD, NULL, P_ID_ESTATUS);
            END IF;
            --No se obtuvo fuerza de ventas
            IF V_ID_FZA_VENTAS IS NULL THEN
                V_SOLICITUD.ORDEN_ESTATUS  := 25;
                XXMOR_ENV_NOTIFICACION_PR ( V_SOLICITUD );
            END IF;
            -- No tiene master contract
            IF V_MCONTID IS NULL THEN
                V_SOLICITUD.ORDEN_ESTATUS  := 46;
                XXMOR_ENV_NOTIFICACION_PR ( V_SOLICITUD );
            END IF;
            dbms_output.put_line(V_SOLICITUD.EMAIL);
        END LOOP;
        dbms_output.put_line('bye bye');
    END XXMOR_ENV_MAIL_OR_MC_PR;
    PROCEDURE XXMOR_SET_DB2_IDS_PR
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_ORDLNID      IN INTEGER
                        ) IS
    V_ORDLNID              INTEGER := -1;
    V_SUMA                 INTEGER;
    lst_id_enc             VARCHAR2(15);
    lst_desc_error         VARCHAR2(4000);
    lin_ordid              INTEGER := 0;
    lin_val_max_ordlnid    NUMBER;
    lin_val_max_ordid      NUMBER;
    CURSOR LINEAS_BIEN_CUR IS
    SELECT ID_SOLICITUD, LINEA
    FROM   XXMOR_SOLICITUDES_DET_TAB D
    WHERE  ID_SOLICITUD = P_ID_SOLICITUD
    AND    EXISTS         (--que todavia no han sido numeradas
                           SELECT 1
                           FROM   XXMOR_SOLICITUDES_EST_REP_TAB R
                           WHERE  R.ID_SOLICITUD = P_ID_SOLICITUD
                           AND    R.ID_SOLICITUD = D.ID_SOLICITUD
                           AND    R.LINEA        = D.LINEA
                           AND    R.AUX2         IS NULL
                          )
    AND    NOT EXISTS     (--que el encabezado este bien
                           SELECT 1
                           FROM   XXMOR_CONCOM_RPTA_TAB CR
                           WHERE  CR.ESTATUS_ORDUNI     = '10'
                           AND    CR.ID_SOLICITUD       = D.ID_SOLICITUD
                           AND    TRIM(NUMLINEA_CONCOM) IS NULL
                          )
    AND    NOT EXISTS     ( --LINEAS QUE ESTEN BIEN
                           SELECT 1
                           FROM   XXMOR_CONCOM_RPTA_TAB CR
                           WHERE  CR.ESTATUS_ORDUNI             = '10'
                           AND    CR.ID_SOLICITUD               = D.ID_SOLICITUD
                           AND    TO_NUMBER(CR.NUMLINEA_CONCOM) = D.LINEA
                          )
    AND    EXISTS         (--LINEAS QUE NO HAYAN ENTRADO A PARADIGM
                           SELECT 1
                           FROM   XXMOR_SOLICITUDES_EST_REP_TAB ER
                           WHERE  ER.ID_SOLICITUD     = D.ID_SOLICITUD
                           AND    ER.LINEA            = D.LINEA
                           AND    ER.ESTAT_ID_FORANEO IS NULL )
    ORDER BY ID_SOLICITUD, LINEA;
    BEGIN
        -- Se lleva a cabo la obtencion del ID para el encabezado, siempre y cuando este listo para insercion.
        lin_val_max_ordid := 0;
        BEGIN
            SELECT VALOR_PARAMETRO
            INTO   lin_val_max_ordid
            FROM   XXMOR_CONF_PARAMS_GRLS_TAB
            WHERE  NOMBRE_PARAMETRO = 'VALOR_MAX_ORDID';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                lin_val_max_ordid := 0;
        END;
        lst_id_enc := NULL;
        BEGIN
            SELECT NVL(AUX2,'-1')
            INTO   lst_id_enc
            FROM   XXMOR_SOLICITUDES_EST_REP_TAB
            WHERE  LINEA        = 0
            AND    ID_SOLICITUD = P_ID_SOLICITUD;
        EXCEPTION
            WHEN OTHERS THEN
                lst_id_enc := 'ERROR';
        END;
        IF lst_id_enc = '-1' THEN
            -- Se obtiene el siguiente valor de la secuencia
            SELECT XXMOR.XXMOR_ORDID_SQ.NEXTVAL
            INTO   lin_ordid
            FROM   DUAL;
            IF lin_ordid >= lin_val_max_ordid THEN
                lin_ordid      := -1;
                lst_desc_error := 'ID Solicitud: '||P_ID_SOLICITUD||' - El Valor de la Secuencia de Oracle para el manejo del ID del Encabezado ha llegado a su Maximo Definido';
            END IF;
        ELSIF lst_id_enc = 'ERROR' THEN
            lin_ordid      := -1;
            lst_desc_error := 'ID Solicitud: '||P_ID_SOLICITUD||' - No Fue Posible Verificar si la Solicitud Ya Tiene Asignado el ID de Paradigm';
        ELSE
            lin_ordid      := 0;
        END IF; -- SIN VALOR
        IF lin_ordid > 0 THEN
            -- Se actualiza el la tabla
            -- con el ID del encabezado
            UPDATE XXMOR_SOLICITUDES_EST_REP_TAB
            SET    AUX2         = TO_CHAR(lin_ordid)
            WHERE  LINEA        = 0
            AND    ID_SOLICITUD = P_ID_SOLICITUD;
        ELSIF lin_ordid = -1 THEN
            -- Se insterta el error en la tabla de LOG
            INSERT INTO XXMOR_LOG_ERRORES_TAB
                   (   ID_ERROR,
                       DESC_ERROR,
                       ARCHIVO_ERROR,
                       METODO_ERROR
                   )
            VALUES (   XXMOR_LOG_ERROR_SQ.NEXTVAL,
                       lst_desc_error,
                       'XXMOR_SET_DB2_IDS_PR',
                       'Procedimiento XXMOR_FUNCIONAL_PKG.XXMOR_SET_DB2_IDS_PR'
                   );
        END IF;
        -- Se lleva a cabo la obtencion de los ID's de las lineas que estan listas para insertarse.
        lin_val_max_ordlnid := 0;
        BEGIN
            SELECT VALOR_PARAMETRO
            INTO   lin_val_max_ordlnid
            FROM   XXMOR_CONF_PARAMS_GRLS_TAB
            WHERE  NOMBRE_PARAMETRO = 'VALOR_MAX_ORDLNID';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                lin_val_max_ordlnid := 0;
        END;
        FOR C_LINEA_BIEN IN LINEAS_BIEN_CUR LOOP
            DBMS_OUTPUT.PUT_LINE(C_LINEA_BIEN.LINEA);
            SELECT XXMOR.XXMOR_ORDLNID_SQ.NEXTVAL
            INTO   V_ORDLNID
            FROM   DUAL;
            IF V_ORDLNID >= lin_val_max_ordlnid THEN
                V_ORDLNID := -1;
            END IF;
            UPDATE XXMOR_SOLICITUDES_EST_REP_TAB
            SET    AUX2 = TO_CHAR(V_ORDLNID)
            WHERE  ID_SOLICITUD = C_LINEA_BIEN.ID_SOLICITUD
            AND    LINEA        = C_LINEA_BIEN.LINEA;
        END LOOP;
    END XXMOR_SET_DB2_IDS_PR;
    --Envia las solicitudes de agrupador multiple que no han sido enviadas por no tener
    --los montos calculados completos para poder dividir
    PROCEDURE XXMOR_AM_SEND_SOL_PEND_PR
                        (
                                P_ID_SOLICITUD IN INTEGER
                        ) IS
    V_ORD_SIN_GR_CA_AUX      PLS_INTEGER;
    V_ORD_CON_GR_CA          PLS_INTEGER;
    V_CONF_AGR_MULT          INTEGER := 0;
    V_SOLS_BIEN              PLS_INTEGER := 0;
    V_RETURN                 INTEGER;
    V_AUX                    VARCHAR2(11);
    CURSOR SOLICITUDES_CUR IS
    SELECT ID_SOLICITUD
    FROM XXMOR_SOLICITUDES_ENC_TAB
    WHERE ID_SOLICITUD IN (SELECT ID_SOLICITUD
                           FROM   XXMOR_SOLICITUDES_ENC_TAB
                           WHERE  ID_REQUEST = (SELECT ID_REQUEST
                                                FROM XXMOR_SOLICITUDES_ENC_TAB
                                                WHERE ID_SOLICITUD = P_ID_SOLICITUD
                                               )
                          );
    BEGIN
        --contamos el numero de ordenes/linea generadas por el agrupador multiple
        SELECT COUNT(AGRUPADOR_MULTIPLE)
        INTO V_CONF_AGR_MULT
        FROM XXMOR_CAT_AGRUPADOR_MULT_TAB
        WHERE AGRUPADOR_MULTIPLE IN (SELECT AGRUPADOR
                                     FROM   XXMOR.XXMOR_SOLICITUDES_ENC_TAB
                                     WHERE ID_SOLICITUD = P_ID_SOLICITUD
                                    );
        IF V_CONF_AGR_MULT > 0 THEN
            FOR C_SOLICITUD IN SOLICITUDES_CUR LOOP
                   SELECT XXMOR_FUNCIONAL_PKG.XXMOR_SOL_AGR_MULT_VAL_FUN(C_SOLICITUD.ID_SOLICITUD)
                   INTO V_AUX FROM DUAL;
                   IF V_AUX = 1 THEN
                        V_SOLS_BIEN := V_SOLS_BIEN + 1;
                    END IF;
            END LOOP;
            --Si todas estan bien se reenvian para que se calculen
            IF V_SOLS_BIEN = V_CONF_AGR_MULT THEN
                FOR C_SOLICITUD IN SOLICITUDES_CUR LOOP
                    IF C_SOLICITUD.ID_SOLICITUD != P_ID_SOLICITUD THEN
                         --V_AUX := XXMOR_ENV_SOL_CONCOM_FUN( C_SOLICITUD.ID_SOLICITUD);
                        dbms_output.put_line('V_AUX:' || V_AUX);
                        dbms_output.put_line('P_ID_SOLICITUD:' || P_ID_SOLICITUD);
                        dbms_output.put_line('C_SOLICITUD.ID_SOLICITUD:' || C_SOLICITUD.ID_SOLICITUD);
                    END IF;
                END LOOP;
            END IF;
        END IF;
    END XXMOR_AM_SEND_SOL_PEND_PR;
    -- Procedimiento que indica si se lleva a cabo la validacion de
    -- Credito Corporativo.
    PROCEDURE XXMOR_EJECUTA_AUTH_CREDCORP_PR
                        (
                                piinIdSolicitud IN  NUMBER,
                                poinAutorizar   OUT NUMBER
                        ) IS
    lin_Reproceso NUMBER;
    lin_aut_CC    NUMBER;
    BEGIN
        SELECT DECODE(COUNT(1), 0, 0, 1)
        INTO   lin_Reproceso
        FROM   (SELECT DISTINCT ID_SOLICITUD
                FROM   (SELECT DISTINCT CRT.ID_SOLICITUD,
                               NUMLINEA_CONCOM
                        FROM   XXMOR_CONCOM_RPTA_TAB CRT
                        WHERE  CRT.ESTATUS_ORDUNI   = '10'
                        AND    UPPER(ACCION_CONCOM) IN ('REPROCESO', 'REENVIO')
                        MINUS
                        SELECT DISTINCT CRT.ID_SOLICITUD,
                               NUMLINEA_CONCOM
                        FROM   XXMOR_CONCOM_RPTA_TAB CRT
                        WHERE  CRT.ESTATUS_ORDUNI = '10'
                        AND UPPER (ACCION_CONCOM) IN ('RECHAZO', 'RETENCION')
                       )
               ) RE
        WHERE RE.ID_SOLICITUD = piinIdSolicitud;
        IF lin_Reproceso = 0 THEN
            -- VALIDAR CREDITO
            SELECT COUNT(1)
            INTO   lin_aut_CC
            FROM   XXMOR_CONCOM_RPTA_TAB RC
            WHERE  UPPER(RC.CAMPO_CONCOM)      = 'CRED_CORP'
            AND    UPPER(RC.ACCION_CONCOM)     = UPPER('AUTORIZACION')
            --AND    NVL(RC.ESTATUS_ORDUNI,'10') = '10'
            AND    RC.ID_SOLICITUD             = piinIdSolicitud;
            IF lin_aut_CC = 0 THEN
                poinAutorizar := 1;
            ELSE
                poinAutorizar := 0;
            END IF;
        ELSE
            poinAutorizar := 0;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Autorizar:'||poinAutorizar);
    END XXMOR_EJECUTA_AUTH_CREDCORP_PR;
    -- Procedimiento que valida si una orden tiene error para corregir
    PROCEDURE XXMOR_REVISA_ERROR_ARCHIVO_PR
                        (
                                piinIdArchivoSol IN  NUMBER
                        ) IS
    lin_id_archivo  NUMBER := NULL;
    BEGIN
        SELECT COUNT(ARCH.ID_ARCHIVO_SOL)
        INTO   lin_id_archivo
        FROM   XXMOR.XXMOR_SOLICITUDES_ARCH_TAB ARCH
        WHERE  ARCH.ARCHIVO_PROCESADO = 3
        AND    ARCH.ID_ARCHIVO_SOL    = piinIdArchivoSol;
        IF  lin_id_archivo > 0 THEN
            UPDATE XXMOR.XXMOR_SOLICITUDES_ARCH_TAB ARCH
            SET    ARCH.ARCHIVO_PROCESADO = 4
            WHERE  ARCH.ID_ARCHIVO_SOL    = lin_id_archivo;
            DBMS_OUTPUT.PUT_LINE('lin_id_archivo:'||lin_id_archivo||' Actualizado en XXMOR_SOLICITUDES_ARCH_TAB! ');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            INSERT INTO XXMOR_LOG_ERRORES_TAB(ID_ERROR, DESC_ERROR, ARCHIVO_ERROR, METODO_ERROR)
            VALUES (XXMOR_LOG_ERROR_SQ.NEXTVAL,
                    'Error al validar si el id_archivo:'||piinIdArchivoSol||' tiene error para corregir',
                    NULL,
                    'Procedimiento XXMOR_REVISA_ERROR_ARCHIVO_PR'
                   );
    END XXMOR_REVISA_ERROR_ARCHIVO_PR;
    /* Procedimiento que realiza la creacion en HTML del cuerpo del mensaje a enviar via      */
    /* correo electronico a cada uno de los usuarios a quienes hay que enviar la notificacion */
    PROCEDURE XXCC_CREA_HTML_FVTAS_MERCA_PR
                      (
                              piinLine           IN      VARCHAR2
                      ) IS
    BEGIN
        -- SE VA CREANDO EL CUERPO DEL MENSAJE
        --
        XXMOR_FUNCIONAL_PKG.glo_document := XXMOR_FUNCIONAL_PKG.glo_document||piinLine;
        utl_smtp.write_data(g_conexion, utl_tcp.crlf);
        utl_smtp.write_data(g_conexion, piinLine|| utl_tcp.crlf);
        utl_smtp.write_data(g_conexion, utl_tcp.crlf);
    END XXCC_CREA_HTML_FVTAS_MERCA_PR;
    /* Procedimiento que realiza el envio del correo electronico a cada uno de los usuarios  */
    /* a quienes hay que enviar la notificacion ya sea por que no fue posible obtener la     */
    /* Fuerza de Ventas o por no poder crear las 2 Ordenes de Servicio de Mercadotecnia      */
    PROCEDURE XXMOR_NOTIFICA_FVTAS_MERCA_PR
                      (
                              pistTipoNotif      IN      VARCHAR2,
                              piinValor          IN      NUMBER,
                              piinIdSolRequest   IN      NUMBER
                      ) IS
    lst_from             VARCHAR2(100);
    lst_smtp_srv         VARCHAR2(100);
    lin_smtp_prt         NUMBER;
    lst_error            VARCHAR2(500) := NULL;
    lst_mail             VARCHAR2(50);
    lst_mail_orden       VARCHAR2(50);
    lst_mails_notificar  VARCHAR2(3000);
    lst_mails_destino    VARCHAR(3000);
    lst_subject          VARCHAR2(240) := NULL;
    lst_fecha            VARCHAR2(50) := NULL;
    lst_archivo_sol      VARCHAR2(100) := NULL;
    lst_motivo           VARCHAR2(240) := NULL;
    lst_fuerza_ventas    VARCHAR2(50) := NULL;
    lst_requiere_aut     VARCHAR2(1);
    lst_error_usr_smtp   VARCHAR2(1);
    lst_usuario_smtp     VARCHAR2(50);
    lst_password_smtp    VARCHAR2(50);
    lst_ordenes_cutin    VARCHAR2(50);
    CURSOR MAILS_NOTIFICAR_CUR(pistMailsNotificar IN VARCHAR2) IS
    WITH VALUE_LIST AS
    (SELECT pistMailsNotificar AS VAL FROM DUAL)
     SELECT SUBSTR(VAL, (DECODE(LEVEL, 1, 0, INSTR(VAL, ',', 1, LEVEL -1)) + 1),
                        (DECODE(INSTR(VAL, ',', 1, LEVEL) -1, -1, LENGTH(VAL), INSTR(VAL, ',', 1, LEVEL) -1))
                        -(DECODE(LEVEL, 1, 0, INSTR(val, ',', 1, LEVEL -1)) + 1) + 1) CORREO
     FROM VALUE_LIST CONNECT BY LEVEL <= (SELECT(LENGTH(VAL) -LENGTH(REPLACE(VAL, ',', NULL)))
     FROM VALUE_LIST);
    CURSOR ORDENES_CUTIN_CUR IS
    SELECT ID_SOLICITUD
    FROM   XXMOR_SOLICITUDES_ENC_TAB
    WHERE  ID_REQUEST = piinIdSolRequest;
    BEGIN
        -- Se obtien la direccion IP del smtp server
        -- asi como el puerto.
        BEGIN
            lst_smtp_srv := NULL;
            lin_smtp_prt := NULL;
            SELECT SUBSTR(VALOR_PARAMETRO,1,(INSTR(VALOR_PARAMETRO,':')-1)) SERVIDOR,
                   SUBSTR(VALOR_PARAMETRO,(INSTR(VALOR_PARAMETRO,':')+1))   PUERTO
            INTO   lst_smtp_srv,
                   lin_smtp_prt
            FROM   XXMOR_CONF_PARAMS_GRLS_TAB
            WHERE  UPPER(NOMBRE_PARAMETRO) = 'SMTP_SERVER';
        EXCEPTION
            WHEN OTHERS THEN
                lst_smtp_srv := NULL;
                lin_smtp_prt := NULL;
        END;
        IF lst_smtp_srv IS NOT NULL AND lin_smtp_prt IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Servidor de Correo: '||lst_smtp_srv);
            DBMS_OUTPUT.PUT_LINE('Puerto: '||lin_smtp_prt);
            -- Se verifica si es necesaria la autenticacion en el servidor SMTP.
            BEGIN
                lst_Requiere_aut := 'N';
                SELECT NVL(VALOR_PARAMETRO,'N') REQUIERE_AUTENTICACION
                INTO   lst_Requiere_aut
                FROM   XXMOR_CONF_PARAMS_GRLS_TAB
                WHERE  UPPER(NOMBRE_PARAMETRO) = 'USAR_AUTENTICACION_ENV_CORREO';
            EXCEPTION
                WHEN OTHERS THEN
                    lst_Requiere_aut := 'N';
            END;
            lst_usuario_smtp  := NULL;
            lst_password_smtp := NULL;
            IF lst_requiere_aut = 'S' THEN
                -- Se obtien el usuario y contrase?a si es necesaria la
                -- autenticacion en el servidor SMTP.
                BEGIN
                    SELECT SUBSTR(VALOR_PARAMETRO,1,(INSTR(VALOR_PARAMETRO,'/')-1)) USUARIO,
                           SUBSTR(VALOR_PARAMETRO,(INSTR(VALOR_PARAMETRO,'/')+1))   PASSWORD
                    INTO   lst_usuario_smtp,
                           lst_password_smtp
                    FROM   XXMOR_CONF_PARAMS_GRLS_TAB
                    WHERE  UPPER(NOMBRE_PARAMETRO) = 'USUARIO_ENVIO_CORREOS';
                EXCEPTION
                    WHEN OTHERS THEN
                        lst_usuario_smtp  := NULL;
                        lst_password_smtp := NULL;
                END;
                IF lst_usuario_smtp IS NOT NULL AND lst_password_smtp IS NOT NULL THEN
                    lst_error_usr_smtp := 'N';
                    lst_from := '<'||lst_usuario_smtp||'@televisa.com.mx>';
                ELSE
                    lst_error_usr_smtp := 'S';
                    IF lst_usuario_smtp IS NOT NULL THEN
                        lst_from := '<'||lst_usuario_smtp||'@televisa.com.mx>';
                    ELSE
                        lst_from := '<servicio_orduni@televisa.com.mx>';
                    END IF;
                    DBMS_OUTPUT.PUT_LINE('No Es Posible Enviar la Notificacion: Revise la Configuracion en Paramentros Generales del Usuario y Contrase?a para el Envio de Correos');
                    INSERT INTO XXMOR_LOG_ERRORES_TAB
                                (
                                        ID_ERROR,
                                        DESC_ERROR,
                                        ARCHIVO_ERROR,
                                        METODO_ERROR,
                                        HORA_ERROR
                                )
                    VALUES      (
                                        XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                        'No Es Posible Enviar la Notificacion: Revise la Configuracion en Paramentros Generales del Usuario y Contrase?a para el Envio de Correos',
                                        NULL,
                                        'Procedimiento XXMOR_HTML_EMAIL_PR',
                                        SYSDATE
                                );
                END IF;
            ELSE
                lst_error_usr_smtp := 'N';
                lst_from := '<servicio_orduni@televisa.com.mx>';
            END IF;
            IF lst_error_usr_smtp = 'N' THEN
                SELECT TO_CHAR(SYSDATE,'Day DD "de" Month "de" YYYY HH24:MI','NLS_DATE_LANGUAGE=SPANISH')
                INTO   lst_fecha
                FROM   DUAL;
                DBMS_OUTPUT.PUT_LINE('lst_from: '||lst_from);
                g_conexion := UTL_SMTP.OPEN_CONNECTION( lst_smtp_srv, lin_smtp_prt );
                UTL_SMTP.HELO( g_conexion, lst_smtp_srv );
                IF lst_requiere_aut = 'S' THEN
                    UTL_SMTP.COMMAND( g_conexion, 'AUTH LOGIN' );
                    UTL_SMTP.COMMAND( g_conexion, UTL_RAW.CAST_TO_VARCHAR2( UTL_ENCODE.BASE64_ENCODE( UTL_RAW.CAST_TO_RAW( lst_usuario_smtp ))) );
                    UTL_SMTP.COMMAND( g_conexion, UTL_RAW.CAST_TO_VARCHAR2( UTL_ENCODE.BASE64_ENCODE( UTL_RAW.CAST_TO_RAW( lst_password_smtp ))) );
                END IF;
                UTL_SMTP.MAIL( g_conexion, lst_from );
                IF pistTipoNotif = 'FVTAS' THEN
                    lst_subject := 'No Fue Posible Obtener la Fuerza de Ventas para la Solicitud: '||piinIdSolRequest;
                    SELECT SA.NOM_ARCHIVO_SOL,
                           SE.EMAIL
                    INTO   lst_archivo_sol,
                           lst_mail_orden
                    FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB SOE,
                           XXMOR_SOLICITUDES_ENC_TAB      SE,
                           XXMOR_SOLICITUDES_ARCH_TAB     SA
                    WHERE  SOE.ID_REQUEST     = SE.ID_REQUEST
                    AND    SOE.ID_ARCHIVO_SOL = SA.ID_ARCHIVO_SOL
                    AND    SE.ID_SOLICITUD    = piinIdSolRequest;
                    BEGIN
                        SELECT VALOR_PARAMETRO
                        INTO   lst_mails_notificar
                        FROM   XXMOR_CONF_PARAMS_GRLS_TAB
                        WHERE  UPPER(NOMBRE_PARAMETRO) = 'CORREOS_FVTAS';
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            lst_mails_notificar := 'NDFVTAS';
                            --lst_mails_notificar := 'omejiam@televisa.com.mx,osmemo@gmail.com,';
                        WHEN OTHERS THEN
                            lst_mails_notificar := 'OTHERS';
                    END;
                ELSE -- MERCA
                    SELECT SA.NOM_ARCHIVO_SOL,
                           SOE.EMAIL
                    INTO   lst_archivo_sol,
                           lst_mail_orden
                    FROM   XXMOR_SOLICITUDES_ORIG_ENC_TAB SOE,
                           XXMOR_SOLICITUDES_ARCH_TAB     SA
                    WHERE  SOE.ID_ARCHIVO_SOL = SA.ID_ARCHIVO_SOL
                    AND    SOE.ID_REQUEST     = piinIdSolRequest;
                    lst_subject := 'Detalles en la Generacion de las 2 Ordenes de Mercadotecnia para el archivo: '||lst_archivo_sol;
                    BEGIN
                        SELECT VALOR_PARAMETRO
                        INTO   lst_mails_notificar
                        FROM   XXMOR_CONF_PARAMS_GRLS_TAB
                        WHERE  UPPER(NOMBRE_PARAMETRO) = 'CORREOS_MERCA';
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            lst_mails_notificar := 'NDMERCA';
                            --lst_mails_notificar := 'omejiam@televisa.com.mx,osmemo@gmail.com,';
                        WHEN OTHERS THEN
                            lst_mails_notificar := 'OTHERS';
                    END;
                END IF;
                IF INSTR(lst_mails_notificar,'@') > 0 THEN
                    IF INSTR(lst_mail_orden,'@') > 0 THEN
                        lst_mails_notificar := lst_mails_notificar||lst_mail_orden||',';
                    END IF;
                    DBMS_OUTPUT.PUT_LINE('lst_mails_notificar:'||lst_mails_notificar);
                    FOR RCPT IN MAILS_NOTIFICAR_CUR(lst_mails_notificar) LOOP
                        BEGIN
                            DBMS_OUTPUT.PUT_LINE('RCPT.CORREO:'||RCPT.CORREO);
                            IF RCPT.CORREO IS NOT NULL THEN
                                lst_mail :=  '<'||TRIM(RCPT.CORREO)||'>';
                                DBMS_OUTPUT.PUT_LINE('lst_mail:'||lst_mail);
                                utl_smtp.rcpt( g_conexion, lst_mail );
                                lst_mails_destino := lst_mails_destino||lst_mail||',';
                                DBMS_OUTPUT.PUT_LINE('lst_mails_destino FOR:'||lst_mails_destino);
                            END IF;
                        EXCEPTION
                            WHEN OTHERS THEN
                                INSERT INTO XXMOR_LOG_ERRORES_TAB(ID_ERROR, DESC_ERROR, ARCHIVO_ERROR, METODO_ERROR)
                                VALUES(XXMOR_LOG_ERROR_SQ.NEXTVAL, 'No pudo enviarse la notificacion a el siguiente destinatario:'||lst_mail||'  ', NULL, 'Procedimiento XXMOR_NOTIFICA_FVTAS_MERCA_PR subject: '||lst_subject|| ',...) ');
                        END;
                    END LOOP;
                    lst_mails_destino := SUBSTR(lst_mails_destino,1,LENGTH(lst_mails_destino)-1);
                    DBMS_OUTPUT.PUT_LINE('lst_mails_destino:'||lst_mails_destino);
                    -- Start body of email
                    --
                    sys.utl_smtp.open_data(g_conexion);
                    sys.utl_smtp.write_data(g_conexion, 'From'||': '||lst_from||utl_tcp.crlf);
                    sys.utl_smtp.write_data(g_conexion, 'To'||': '||lst_mails_destino||utl_tcp.crlf);
                    sys.utl_smtp.write_data(g_conexion, 'Subject'||': '||lst_subject||utl_tcp.crlf);
                    sys.utl_smtp.write_data(g_conexion, 'MIME-version: 1.0'||utl_tcp.crlf);
                    sys.utl_smtp.write_data(g_conexion, 'Content-Type: '||'text/html; charset=utf-8'||utl_tcp.crlf);
                    sys.utl_smtp.write_data(g_conexion, 'Content-Transfer-Encoding: '||'8bit'||utl_tcp.crlf);
                    /*****************************************************************/
                    XXMOR_FUNCIONAL_PKG.glo_document := NULL;
                    -- **********
                    --
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<html>');
                    --
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<style type="text/css">');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<!--');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('table {color:#000000; font-size: 10pt; font-weight: bold; line-height:1.5; padding:2px; text-align:left}');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('h1, h2, h3, h4 {color: #00000}');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('h3 {font-size: 16pt}');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('td {background-color: #f7f7e7; color: #000000; font-weight: NORMAL; font-SIZE: 11pt; border-style: solid; border-width: 1; border-color: #CCCC99; white-SPACE: nowrap}');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('tr {background-color: #f7f7e7; color: #000000; font-weight: NORMAL; font-SIZE: 11pt; white-SPACE: nowrap}');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('th {background-color: #CCCC99; color: #336699; height: 20; border-style: solid; border-width: 1; border-left-color: #f7f7e7; border-right-color: #f7f7e7; border-top-width: 0; border-bottom-width: 0; white-SPACE: nowrap}');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('-->');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('</style>');
                    --
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<head>');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<title> CORREO DE NOTIFICACION </title>');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('</head>');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<BODY>');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<p>');
                    --XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<br>');
                    --XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<br>');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<b><CENTER><FONT SIZE=4 COLOR="black" align="button"> CORREO DE NOTIFICACI'||CHR(38)||'Oacute;'||'N </FONT></CENTER></b>');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('</p>');
                    --XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<br>');
                    -- **********
                    -- **********
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('<p>');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('    <br> Estimado Usuario: ');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('    <br>');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('    <br> Por medio del presente le notificamos que el d'||CHR(38)||'iacute;'||'a de hoy: '||lst_fecha||',');
                    IF pistTipoNotif = 'FVTAS' THEN
                        IF piinValor = 0 THEN
                            lst_motivo := 'no existe ninguna Fuerza de Ventas con los datos de la solicitud';
                        ELSIF piinValor = 1 THEN
                            lst_motivo := 'existe mas de una Fuerza de Ventas con los datos de la solicitud';
                        ELSE
                            SELECT NOMBRE_FZA_VENTAS
                            INTO   lst_fuerza_ventas
                            FROM   XXMOR_FZAS_VTAS_TAB
                            WHERE  ID_SEG_NEG    = 1
                            AND    ID_FZA_VENTAS = piinValor;
                            lst_motivo := 'la Fuerza de Ventas: '||lst_fuerza_ventas||' esta Inactiva';
                        END IF;
                        XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('         No fue posible obtener la Fuerza de Ventas para la Solicitud '||piinIdSolRequest||', asociada al archivo '||lst_archivo_sol||',');
                        XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('         debido a que '||lst_motivo||'.');
                    ELSE
                        IF piinValor = 0 THEN
                            XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('         No fue posible crear la orden del Master Contract de Ingresos (CUTIN) asociada al archivo '||lst_archivo_sol||'.');
                        ELSIF piinValor = 1 THEN
                            XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('         No fue posible crear la orden del Master Contract Normal asociada al archivo '||lst_archivo_sol||'.');
                        ELSE
                            FOR RSOL IN ORDENES_CUTIN_CUR LOOP
                                lst_ordenes_cutin := lst_ordenes_cutin||RSOL.ID_SOLICITUD||',';
                            END LOOP;
                            lst_ordenes_cutin := SUBSTR(lst_ordenes_cutin,1,LENGTH(lst_ordenes_cutin)-1);
                            XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('         se crearon las 2 ordenes de Mercadotecnia CUTIN, asociadas al arvhivo '||lst_archivo_sol||',');
                            XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('         pero el n'||CHR(38)||'uacute;'||'mero de l'||CHR(38)||'iacute;'||'neas no es correcto en una de ellas.');
                            XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('         Por favor revise las solicitudes generadas ('||lst_ordenes_cutin||').');
                        END IF;
                    END IF;
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('    <br>');
                    --XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('    <br>');
                    --XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('    <br>');
                    --XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('    <br> Agradeciendo de antemano su atenci'||CHR(38)||'oacute;'||'n.  Muchas Gracias!!!!!.');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('    <br>');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('    <br> Saludos.');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('</p>');
                    -- **********
                    -- **********
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('</BODY>');
                    XXMOR_FUNCIONAL_PKG.XXCC_CREA_HTML_FVTAS_MERCA_PR('</html>');
                    -- **********
                    -- FINALIZAMOS
                    DBMS_OUTPUT.PUT_LINE('===>  Correo Enviado');
                    sys.utl_smtp.close_data(g_conexion);
                    sys.utl_smtp.quit(g_conexion);
                ELSE
                    DBMS_OUTPUT.PUT_LINE('No Es Posible Enviar la Notificacion: Revise la Configuracion en Parametros Generales de los Correos de Notificacion');
                    IF lst_mails_notificar = 'NDFVTAS' THEN
                        lst_error := 'Revise la Configuracion en Parametros Generales de los Correos de Notificacion para Fuerza de Ventas';
                    ELSIF lst_mails_notificar = 'NDMERCA' THEN
                        lst_error := 'Revise la Configuracion en Parametros Generales de los Correos de Notificacion para Mercadotecnia';
                    ELSE
                        lst_error := SQLERRM;
                    END IF;
                    INSERT INTO XXMOR_LOG_ERRORES_TAB
                                (
                                        ID_ERROR,
                                        DESC_ERROR,
                                        ARCHIVO_ERROR,
                                        METODO_ERROR,
                                        HORA_ERROR
                                )
                    VALUES      (
                                        XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                        'No Es Posible Enviar la Notificacion: '||lst_error,
                                        NULL,
                                        'Procedimiento XXMOR_NOTIFICA_FVTAS_MERCA_PR',
                                        SYSDATE
                                );
                END IF;
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('No Es Posible Enviar la Notificacion: Revise la Configuracion en Parametros Generales del Servidor y Puerto para el Envio de Correos');
            INSERT INTO XXMOR_LOG_ERRORES_TAB
                        (
                                ID_ERROR,
                                DESC_ERROR,
                                ARCHIVO_ERROR,
                                METODO_ERROR,
                                HORA_ERROR
                        )
            VALUES      (
                                XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                'No Es Posible Enviar la Notificacion: Revise la Configuracion en Parametros Generales del Servidor y Puerto para el Envio de Correos',
                                NULL,
                                'Procedimiento XXMOR_NOTIFICA_FVTAS_MERCA_PR',
                                SYSDATE
                        );
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al generar el correo: '||SQLERRM);
            lst_error := SQLERRM;
            INSERT INTO XXMOR_LOG_ERRORES_TAB
                        (
                                ID_ERROR,
                                DESC_ERROR,
                                ARCHIVO_ERROR,
                                METODO_ERROR
                        )
            VALUES      (
                                XXMOR_LOG_ERROR_SQ.NEXTVAL,
                                'No Es Posible Enviar la Notificacion: '||lst_error,
                                NULL,
                                'Procedimiento XXMOR_NOTIFICA_FVTAS_MERCA_PR'
                        );
    END XXMOR_NOTIFICA_FVTAS_MERCA_PR;
END XXMOR_FUNCIONAL_PKG;
/;
