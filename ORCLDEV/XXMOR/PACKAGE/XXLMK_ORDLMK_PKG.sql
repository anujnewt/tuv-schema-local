CREATE OR REPLACE EDITIONABLE PACKAGE "XXMOR"."XXLMK_ORDLMK_PKG" 
AS
    PROCEDURE XXLMK_ASIGNASPTUSRCHR_PR
                        (
                                P_ID IN NUMBER
                        );
    PROCEDURE XXMOR_ASIGNA_FZAVTAS_PR
                        (
                                P_ID IN INTEGER
                        );
    FUNCTION XXMOR_IDENT_FZA_VTAS
                        (
                                P_ID_SOLICITUD IN NUMBER,
                                P_USRCHR       IN VARCHAR2,
                                P_SPTCHR       IN VARCHAR2
                        ) RETURN NUMBER;
    FUNCTION XXMOR_GET_AGRUPADOR_FN
                        (
                                pistCanal       IN VARCHAR2,
                                piinIdSolicitud IN INTEGER
                        ) RETURN VARCHAR2;
    PROCEDURE XXLMK_UPD_AUT_ORD_ST_PR
                            (
                                piinOrdId   IN INTEGER
                            );
    FUNCTION XXLMK_INSERT_CONF_ORD_URG_FN (
                                     piinTIPO_ORDEN     NUMBER,
                                     A_DIA              ARRAY_TVCH2,
                                     A_DIA_CIERRE       ARRAY_TVCH2,
                                     A_HORA_CIERRE      ARRAY_TVCH2,
                                     A_MINUTO_CIERRE    ARRAY_TVCH2,
                                     piinTOP_CONFIG         NUMBER,
                                     pistCREATED_BY            VARCHAR2
                                 ) RETURN NUMBER;
    FUNCTION XXLMK_SOL_FECHAS_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO         IN VARCHAR2
                        ) RETURN VARCHAR2;
    PROCEDURE XXLMK_AUT_URGENTE_PR
                            (
                                    P_ID_SOLICITUD IN NUMBER,
                                    poinNUM_AUTS    OUT NUMBER
                            );
    PROCEDURE XXLMK_AUT_URGENTE2_PR
                            (
                                    P_ID_SOLICITUD IN NUMBER,
                                    poinNUM_AUTS    OUT NUMBER
                            );
    PROCEDURE XXLMK_AUT_OPENLOG_PR
                        (
                                P_ID_SOLICITUD IN  NUMBER,
                                piinNUM_AUTS   OUT NUMBER
                        );
    PROCEDURE XXLMK_AUT_RECH_ORD_URG_PR (
                                                piinNUM_ORD NUMBER,
                                                A_LINEAS    ARRAY_TVCH2,
                                                piinTAM_ARR NUMBER,
                                                piinIND_AUT_RECH    NUMBER,
                                                pistUSER    VARCHAR2
                                             );
    PROCEDURE XXLMK_AUT_RECH_ORD_OPLG_PR (
                                            piinNUM_ORD NUMBER,
                                            A_LINEAS    ARRAY_TVCH2,
                                            piinTAM_ARR NUMBER,
                                            piinIND_AUT_RECH    NUMBER,
                                            pistUSER    VARCHAR2
                                         );
    PROCEDURE XXLMK_UPDT_ORD_ST_SPOTS (piinORD_ID NUMBER);
    PROCEDURE XXLMK_AUT_TM_LN_PR
                            (
                                    P_ID_SOLICITUD IN NUMBER,
                                    poinNUM_AUTS    OUT NUMBER
                            );
    PROCEDURE XXLMK_AUT_RECH_ORD_TM_PR (
                                            piinNUM_ORD NUMBER,
                                            A_LINEAS    ARRAY_TVCH2,
                                            piinTAM_ARR NUMBER,
                                            piinIND_AUT_RECH    NUMBER,
                                            pistUSER    VARCHAR2
                                         );
    FUNCTION XXLMK_CAN_DUR_EXEPT_CONF_FUN(piinID_AJUS INTEGER,
                                        piinID_GRUPO INTEGER,
                                        piinNUM_BREK_NOM_TIME INTEGER)
                                        RETURN NUMBER;
    FUNCTION XXLMK_CAN_DUR_EXEPT_FMT_FUN(piinID_AJUS INTEGER,
                                            piinID_GRUPO INTEGER,
                                            piinNUM_BREK_NOM_TIME INTEGER) RETURN VARCHAR2;
    PROCEDURE XXLMK_INS_UPD_SPT_REC_INF_PR(piinID_SPOT INTEGER, piinNUM_SPOT INTEGER, piinNUM_SCHED_TIME_ORIG VARCHAR2,
                                            piinIND_STATUS_LMK_ORIG VARCHAR2, piinIND_ESTATUS_MOV INTEGER,
                                            piinID_RAZON_CANCEL INTEGER, piinIND_CAMBIO_STATUS INTEGER, pistCVE_CREADO_POR VARCHAR2);
    PROCEDURE XXLMK_SMOD_ADD_CAN_GRP_PR(piinGRUPO_CANAL INTEGER, piinCANAL INTEGER, piinINDEX INTEGER, piinNETWORK INTEGER, piinSKY INTEGER, piinIZZI INTEGER, pistCREATED_BY VARCHAR);
    PROCEDURE XXLMK_SMOD_UPD_CAN_GRP_PR(piinGRUPO_CANAL INTEGER, piinCANAL INTEGER, piinINDEX INTEGER, piinNETWORK INTEGER, piinSKY INTEGER, piinIZZI INTEGER, pistUPDATED_BY VARCHAR);
    PROCEDURE XXLMK_SMOD_UPD_DIST_CFG_PR(piinGRUPO_CANAL INTEGER, piinNUM_CANS INTEGER, piinINDEX INTEGER, piinPERCENTAGE NUMBER, pistUPDATED_BY VARCHAR);
    PROCEDURE XXLMK_SMOD_DEL_CAN_GRP_PR(piinGRUPO_CANAL INTEGER, piinCANAL INTEGER);
   PROCEDURE XXLMK_AUT_EXTEMPORANEA_PR
                        (
                                P_ID_SOLICITUD IN  NUMBER,
                                piinNUM_AUTS   OUT NUMBER
                        );
   PROCEDURE XXLMK_AUT_RECH_ORD_EXT_PR (
                                            piinNUM_ORD NUMBER,
                                            A_LINEAS    ARRAY_TVCH2,
                                            piinTAM_ARR NUMBER,
                                            piinIND_AUT_RECH    NUMBER,
                                            pistUSER    VARCHAR2
                                         );
END;
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "XXMOR"."XXLMK_ORDLMK_PKG" 
AS
    PROCEDURE XXLMK_ASIGNASPTUSRCHR_PR
                        (
                                P_ID IN NUMBER
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
    V_PREFIJO_STNID       VARCHAR(5);       --<HASTA AC? CON MCONTID DE LA DERECHA
    V_RTCRD               VARCHAR(50);      --> PARA GEN AUT TARIFA MANUAL SIN RTCRD
    --V_ORD_MKT               PLS_INTEGER;
    V_ID_SOLICITUD_NAL    NUMBER;
    V_ID_SOLICITUD_PROV   NUMBER;
    lst_nom_archivo       VARCHAR2(150);
    lst_inserta           VARCHAR2(1);
    lst_orden_mcing       VARCHAR2(1);
    lst_orden_mc          VARCHAR2(1);
    lin_NumRegs_Orig      NUMBER := 0;
    lin_NumRegs_Det       NUMBER := 0;
    CURSOR  LINEAS IS
    SELECT  ID_ORDHDR, ID_LINEA, DES_TIPO_SERVICIO
    FROM    XXLMK_ORDLN_TAB
    WHERE   ID_ORDHDR = P_ID;
    CURSOR ORDENES IS
    SELECT ID_ORDHDR
    FROM   XXLMK_ORDHDR_TAB
    WHERE  ID_ORDHDR = P_ID;
    CURSOR CUR_PREFIJOS(P_I_ID_REQUEST INTEGER) IS
    SELECT PREFIJO_CANAL,
           AGRUPADOR_MULTIPLE
    FROM   XXMOR.XXMOR_CAT_AGRUPADOR_MULT_TAB
    WHERE  AGRUPADOR_MULTIPLE = (SELECT TRIM(DES_PLAT_CANAL)
                                 FROM   XXLMK_ORDHDR_TAB
                                 WHERE  ID_ORDHDR = P_ID
                                );
    BEGIN
        OPEN ORDENES;
        LOOP
        FETCH ORDENES INTO P_ID_REQUEST;
        EXIT WHEN ORDENES%NOTFOUND;
            SELECT TRIM(OE.CVE_MCONTID),
                   TRIM(OE.CVE_MCONT_CUTIN),
                   TRIM(OE.DES_PLAT_CANAL),
                   TRIM(OE.ID_SEG_NEG)
            INTO   V_MCONTID,
                   V_MCONTID_CI,
                   V_AGRUPADOR,
                   V_SEGNEG
            FROM   XXLMK_ORDHDR_TAB OE
            WHERE  OE.ID_ORDHDR = P_ID;
            lst_inserta := NULL;
            BEGIN
                --Para identificar la fza de ventas, solo se utiliza el tipo de servicio de la primera orden
                SELECT RTRIM(DES_TIPO_SERVICIO)
                INTO   V_TIPO_SERVICIO
                FROM   XXLMK_ORDLN_TAB
                WHERE  ID_ORDHDR    = P_ID
                AND    NUM_LINEA = 1;
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
                END;
            END IF;
            dbms_output.put_line(' -> '|| P_ID_REQUEST ||' -> '|| V_AGRUPADOR  );
            IF lst_inserta = 'Y' THEN
                -- Si las ordenes ingresadas no son de television insertar como vienen
                IF V_SegNeg != 1 THEN
                     dbms_output.put_line('');
                ELSE -- V_SegNeg != 1
                    dbms_output.put_line('');
                    FOR LN IN LINEAS
                    LOOP
                        UPDATE  XXLMK_ORDLN_TAB     OL
                        SET     DES_USRCHR =
                        CASE WHEN LENGTH(LN.DES_TIPO_SERVICIO) = 2 THEN
                               SUBSTR(LN.DES_TIPO_SERVICIO,1,1)
                           ELSE
                               CASE WHEN (SELECT COUNT(1)
                                          FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                          WHERE  UPPER(REPLACE(DESC_TIPO_SERVICIO, ' ', '')) = UPPER(REPLACE(LN.DES_TIPO_SERVICIO, ' ', ''))
                                         ) > 0 THEN
                                   (SELECT USR_CHR
                                    FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                    WHERE  UPPER(REPLACE(DESC_TIPO_SERVICIO, ' ', '')) = UPPER(REPLACE(LN.DES_TIPO_SERVICIO, ' ', ''))
                                   )
                               ELSE
                                   (SELECT USR_CHR
                                    FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                    WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                   )
                               END
                           END,
                        DES_SPTCHR =
                        CASE WHEN LENGTH(LN.DES_TIPO_SERVICIO) = 2 THEN
                               SUBSTR(LN.DES_TIPO_SERVICIO,2,1)
                           ELSE
                               CASE WHEN (SELECT COUNT(1)
                                          FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                          WHERE  UPPER(REPLACE(DESC_TIPO_SERVICIO, ' ', '')) = UPPER(REPLACE(LN.DES_TIPO_SERVICIO, ' ', ''))
                                         ) > 0 THEN
                                   (SELECT SPT_CHR
                                    FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                    WHERE  UPPER(REPLACE(DESC_TIPO_SERVICIO, ' ', '')) = UPPER(REPLACE(LN.DES_TIPO_SERVICIO, ' ', ''))
                                   )
                               ELSE
                                   (SELECT SPT_CHR
                                    FROM   XXMOR.XXMOR_CAT_TIPO_SERV_TAB
                                    WHERE  DESC_TIPO_SERVICIO = 'NO APLICA'
                                   )
                               END
                            END
                         WHERE  OL.ID_LINEA = LN.ID_LINEA;
                    END LOOP;
                END IF; -- V_SegNeg != 1
                DBMS_OUTPUT.PUT_LINE('');
            ELSIF lst_inserta = 'N' THEN
                DBMS_OUTPUT.PUT_LINE('');
            END IF;
        END LOOP;
        CLOSE ORDENES;
  END XXLMK_ASIGNASPTUSRCHR_PR;
  PROCEDURE XXMOR_ASIGNA_FZAVTAS_PR
                        (
                                P_ID IN INTEGER
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
    SELECT ID_ORDHDR
    FROM   XXLMK_ORDHDR_TAB
    WHERE  ID_ORDHDR = P_ID;
    BEGIN
        FOR ORDEN IN ORDENES_CUR LOOP
                V_ID_SOLICITUD := ORDEN.ID_ORDHDR;
                DBMS_OUTPUT.PUT_LINE(' V_ID_SOLICITUD: '||V_ID_SOLICITUD);
                SELECT NVL(TRIM(DES_PLAT_CANAL),'SIN PLATAFORMA')
                INTO   lst_plataforma_canal
                FROM   XXLMK_ORDHDR_TAB
                WHERE  ID_ORDHDR = V_ID_SOLICITUD;
                DBMS_OUTPUT.PUT_LINE('lst_plataforma_canal: '||lst_plataforma_canal);
                SELECT XXLMK_ORDLMK_PKG.XXMOR_GET_AGRUPADOR_FN
                                                    (
                                                            lst_plataforma_canal,
                                                            V_ID_SOLICITUD
                                                    )
                INTO   lst_agrupador
                FROM   DUAL;
                DBMS_OUTPUT.PUT_LINE('lst_agrupador: '||lst_agrupador);
                UPDATE XXLMK_ORDHDR_TAB
                SET    DES_AGRUPADOR  = lst_agrupador
                WHERE ID_ORDHDR = V_ID_SOLICITUD;
                DBMS_OUTPUT.PUT_LINE('SE ACTUALIZO AGRUPADOR');
                SELECT XXMOR_IDENT_FZA_VTAS
                                  (
                                          V_ID_SOLICITUD,
                                          (SELECT DES_USRCHR
                                           FROM   XXLMK_ORDLN_TAB
                                           WHERE  ID_ORDHDR = V_ID_SOLICITUD
                                           AND    NUM_LINEA        = 1
                                          ),
                                          (SELECT DES_SPTCHR
                                           FROM   XXLMK_ORDLN_TAB
                                           WHERE  ID_ORDHDR = V_ID_SOLICITUD
                                           AND    NUM_LINEA        = 1
                                          )
                                  )
                INTO V_ID_FZA_VENTAS
                FROM DUAL;
                IF V_ID_FZA_VENTAS = 0 THEN
                    NULL;
                ELSIF V_ID_FZA_VENTAS = 1 THEN
                    V_ID_FZA_VENTAS := 0;
                ELSIF V_ID_FZA_VENTAS < 0 THEN
                    V_ID_FZA_VENTAS := (V_ID_FZA_VENTAS * -1);
                    V_ID_FZA_VENTAS := 0;
                END IF;
                UPDATE XXLMK_ORDHDR_TAB E
                SET    E.ID_FZA_VENTAS = V_ID_FZA_VENTAS
                WHERE  ID_ORDHDR = V_ID_SOLICITUD;
                SELECT COUNT(1)
                INTO   V_FZA_VTAS_CH
                FROM   XXMOR_FZAS_VTAS_CANALES_TAB
                WHERE  ID_SEG_NEG    = 1
                AND    ID_FZA_VENTAS = V_ID_FZA_VENTAS;
        END LOOP;
  END XXMOR_ASIGNA_FZAVTAS_PR;
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
        SELECT TRIM(DES_AGRUPADOR)                                    AGRUPADOR,
               TRIM(CVE_ADVID)                                        CLIENTE,
               SUBSTR(TRIM(CVE_MCONTID),1,2)                          REGION,
               SUBSTR(TRIM(CVE_MCONTID),INSTR(TRIM(CVE_MCONTID),'.')-2,2) SUFIJO,
               CVE_ACCTHDRID,
               CVE_MCONTID,
               DES_RTCRD,
               DES_EMAIL
        INTO   V_AGRUPADOR,
               V_CLIENTE,
               V_REGION,
               V_SUFIJO,
               V_ACCTHDRID,
               V_MCONTID,
               V_RTCRDDSCR,
               V_EMAIL
        FROM   XXLMK_ORDHDR_TAB
        WHERE  ID_ORDHDR = P_ID_SOLICITUD;
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
                    AND    DECODE(NVL(V.CLIENTE,'*'),'*','*',V.CLIENTE)        = NVL((SELECT CVE_ACCTHDRID
                                                                                      FROM   XXLMK_ORDHDR_TAB
                                                                                      WHERE  ID_ORDHDR = P_ID_SOLICITUD
                                                                                      AND    CVE_ACCTHDRID    IN (SELECT CLIENTE
                                                                                                              FROM   XXMOR_FZAS_VENTAS_IDS_VW
                                                                                                             )
                                                                                     ),'*')
                    AND    NVL(V.SUFIJO,'*')                                   = NVL((SELECT SUBSTR(CVE_MCONTID,INSTR(CVE_MCONTID,'.')-2,2)
                                                                                      FROM   XXLMK_ORDHDR_TAB
                                                                                      WHERE  ID_ORDHDR                           = P_ID_SOLICITUD
                                                                                      AND    SUBSTR(CVE_MCONTID,INSTR(CVE_MCONTID,'.')-2,2) IN (SELECT SUFIJO
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
                    AND    DECODE(NVL(v.CLIENTE,'*'),'*','*',v.CLIENTE) = NVL((SELECT CVE_ACCTHDRID
                                                                               FROM   XXLMK_ORDHDR_TAB
                                                                               WHERE  ID_ORDHDR = P_ID_SOLICITUD
                                                                               AND    CVE_ACCTHDRID    IN (SELECT CLIENTE
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
            SELECT DISTINCT AGRUPADOR
            INTO   lst_agrupador
            FROM   XXLMK_AGRUPADOR_SOLICITUD_TAB
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
    PROCEDURE XXLMK_UPD_AUT_ORD_ST_PR
                            (
                                piinOrdId   IN INTEGER
                            )
    IS
        linST_AUTS INTEGER;
        linST_AUTS_LNS INTEGER;
        linTM   INTEGER;
        linCC   INTEGER;
        linNWST INTEGER;
    BEGIN
        /*BEGIN
            SELECT  NVL(AUT.IND_ESTATUS, 1)
            INTO    linTM
            FROM    XXLMK_AUTORIZACIONES_TAB AUT
            WHERE   AUT.IND_TIPO_AUT = 'TM'
            AND     AUT.ID_ORDEN = piinOrdId;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                linTM := -1;
        END;
        BEGIN
            SELECT  NVL(AUT.IND_ESTATUS, 1)
            INTO    linCC
            FROM    XXLMK_AUTORIZACIONES_TAB AUT
            WHERE   AUT.IND_TIPO_AUT = 'CC'
            AND     AUT.ID_ORDEN = piinOrdId;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                linCC := -1;
        END;
        IF linTM = -1 AND linCC = -1 THEN
            -- NO TIENE AUTORIZACIONES
            RETURN;
        END IF;
        IF linTM = 1 AND linCC = 1 THEN
            -- AUTORIZACIONES PENDIENTES
            RETURN;
        END IF;
        IF linTM = 2 AND linCC = 2 THEN
            -- TODO AUTORIZADO
            linNWST := 7;
        ELSIF linTM = 3 AND linCC = 3 THEN
            -- TODO RECHAZADO
            linNWST := 6;
        ELSIF linTM = -1 AND linCC = 2 THEN
            linNWST := 7;
        ELSIF linTM = 2 AND linCC = -1 THEN
            linNWST := 7;
        ELSIF linTM = -1 AND linCC = 3 THEN
            linNWST := 6;
        ELSIF linTM = 3 AND linCC = -1 THEN
            linNWST := 6;
        ELSIF linTM = 3 THEN
            -- RECHAZADA TM
            linNWST := 4;
        ELSIF linCC = 3 THEN
            -- RECHAZADA CC
            linNWST := 5;
        END IF;
        UPDATE  XXLMK_ORDHDR_TAB
        SET     IND_ESTATUS = linNWST
        WHERE   ID_ORDHDR = piinOrdId;*/
        SELECT  COUNT(*)
        INTO    linST_AUTS
        FROM    XXLMK_AUTORIZACIONES_TAB    A
        WHERE   A.ID_ORDEN = piinOrdId
        AND     A.IND_NIVEL = 'E'
        AND     A.IND_ESTATUS = 3;
        IF(linST_AUTS > 0) THEN
            DBMS_OUTPUT.PUT_LINE('TODAS LAS AUTORIZACIONES RECHAZADAS - SE RECHAZA ORDEN');
            UPDATE  XXLMK_ORDHDR_TAB
            SET IND_ESTATUS = 6
            WHERE   ID_ORDHDR = piinOrdId;
            RETURN;
        END IF;
        SELECT  CASE
                WHEN COUNT(*) = SUM(REJECTED)
                THEN 1
                ELSE 0 END AS ALL_REJECTED
        INTO    linST_AUTS_LNS
        FROM    (
            SELECT  CASE
                    WHEN OL.IND_ESTATUS = 4
                    THEN 1
                    ELSE 0 END AS REJECTED
            FROM    XXLMK_ORDLN_TAB OL
            WHERE   OL.ID_ORDHDR = piinOrdId
        );
        IF(linST_AUTS_LNS = 1) THEN
            DBMS_OUTPUT.PUT_LINE('TODAS LAS LINEAS RECHAZADAS - SE RECHAZA ORDEN');
            UPDATE  XXLMK_ORDHDR_TAB
            SET IND_ESTATUS = 6
            WHERE   ID_ORDHDR = piinOrdId;
            RETURN;
        END IF;
        SELECT  CASE
                WHEN COUNT(*) = NVL(SUM(AUTHORIZED), 0)
                THEN 1
                ELSE 0 END AS ALL_AUTHORIZED
        INTO    linST_AUTS
        FROM (
            SELECT  CASE
                    WHEN A.IND_ESTATUS = 2
                    THEN 1
                    ELSE 0 END AS AUTHORIZED
            FROM    XXLMK_AUTORIZACIONES_TAB    A
            WHERE   A.ID_ORDEN = piinOrdId
            AND     A.IND_NIVEL = 'E'
        );
        IF(linST_AUTS = 1) THEN
            DBMS_OUTPUT.PUT_LINE('TODAS LAS AUTORIZACIONES AUTORIZADAS A NIVEL ENCABEZADO');
            SELECT CASE
                    WHEN COUNT(*) = SUM(AUTHORIZED)
                    THEN 1
                    ELSE 0 END AS ALL_AUTORIZED
            INTO    linST_AUTS_LNS
            FROM (
                SELECT  CASE
                        WHEN A.IND_ESTATUS = 2
                        THEN 1
                        ELSE 0 END AS AUTHORIZED
                FROM    XXLMK_AUTORIZACIONES_TAB    A
                WHERE   A.ID_ORDEN = piinOrdId
                AND     A.IND_NIVEL = 'L'
            );
            IF(linST_AUTS_LNS = 1) THEN
                DBMS_OUTPUT.PUT_LINE('TODAS LAS AUTORIZACIONES AUTORIZADAS A NIVEL LINEA - CAMBIAR ESTATUS A ORDEN V?LIDA');
                UPDATE  XXLMK_ORDHDR_TAB
                SET     IND_ESTATUS = 7
                WHERE   ID_ORDHDR = piinOrdId;
                RETURN;
            END IF;
            SELECT  COUNT(*)
            INTO    linST_AUTS_LNS
            FROM    XXLMK_AUTORIZACIONES_TAB    A
            WHERE   A.ID_ORDEN = piinOrdId
            AND     A.IND_NIVEL = 'L'
            AND     A.IND_ESTATUS = 1;
            IF(linST_AUTS_LNS = 0) THEN
                DBMS_OUTPUT.PUT_LINE('NO HAY AUTORIZACIONES PENDIENTES - ACTUALIZAR ESTATUS A ORDEN V?LIDA');
                UPDATE  XXLMK_ORDHDR_TAB
                SET     IND_ESTATUS = 7
                WHERE   ID_ORDHDR = piinOrdId;
            END IF;
        END IF;
    END XXLMK_UPD_AUT_ORD_ST_PR;
    FUNCTION XXLMK_INSERT_CONF_ORD_URG_FN (
                                     piinTIPO_ORDEN     NUMBER,
                                     A_DIA              ARRAY_TVCH2,
                                     A_DIA_CIERRE       ARRAY_TVCH2,
                                     A_HORA_CIERRE      ARRAY_TVCH2,
                                     A_MINUTO_CIERRE    ARRAY_TVCH2,
                                     piinTOP_CONFIG         NUMBER,
                                     pistCREATED_BY            VARCHAR2
                                 ) RETURN NUMBER IS
        resultado       NUMBER;
        linDia          NUMBER;
        linDiaCierre    NUMBER;
        linHoraCierre   NUMBER;
        linMinutoCierre NUMBER;
        BEGIN
            resultado := 1;
            -- BORRAR CONFIGURACIN
            DELETE FROM XXLMK_CONF_ORD_URG_TAB WHERE IND_TIPO_ORDEN = piinTIPO_ORDEN;
            COMMIT;
            IF(piinTOP_CONFIG>0) THEN
                FOR i IN 1..piinTOP_CONFIG LOOP
                    linDia := TO_NUMBER(A_DIA(i));
                    linDiaCierre := TO_NUMBER(A_DIA_CIERRE(i));
                    linHoraCierre := TO_NUMBER(A_HORA_CIERRE(i));
                    linMinutoCierre := TO_NUMBER(A_MINUTO_CIERRE(i));
                    INSERT INTO XXLMK_CONF_ORD_URG_TAB (ID_CONF, IND_TIPO_ORDEN, NUM_DIA, NUM_DIA_CIERRE, NUM_HORA_CIERRE, NUM_MINUTO_CIERRE, FEC_CREACION, CVE_CREADO_POR, FEC_ACTUALIZACION, CVE_ACTUALIZADO_POR)
                    VALUES (XXLMK_CONF_ORD_URG_SQ.nextVal, piinTIPO_ORDEN, linDia, linDiaCierre, linHoraCierre, linMinutoCierre, SYSDATE, pistCREATED_BY, SYSDATE, pistCREATED_BY);
                END LOOP;
                COMMIT;
            END IF;
            RETURN resultado;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20000, 'ERROR: '||SQLERRM);
    END XXLMK_INSERT_CONF_ORD_URG_FN;
    FUNCTION XXLMK_SOL_FECHAS_FUN
                        (
                                P_ID_SOLICITUD IN INTEGER,
                                P_LINEA        IN INTEGER,
                                P_TIPO         IN VARCHAR2
                        ) RETURN VARCHAR2 AS
        V_Total     varchar2(100);
    BEGIN
        IF P_TIPO = 'F_1A_T' THEN
            BEGIN
                SELECT TO_CHAR(TO_DATE(DES_FEC_INI, 'yyyymmdd')
                                          +  CASE
                                          WHEN CAN_LUN != 0 THEN 0
                                          WHEN CAN_MAR != 0 THEN 1
                                          WHEN CAN_MIE != 0 THEN 2
                                          WHEN CAN_JUE != 0 THEN 3
                                          WHEN CAN_VIE != 0 THEN 4
                                          WHEN CAN_SAB != 0 THEN 5
                                          WHEN CAN_DOM != 0 THEN 6
                                          ELSE NULL
                                       END,'YYYYMMDD')
                INTO    V_Total
                FROM    XXLMK_ORDLN_TAB
                WHERE   ID_ORDHDR = P_ID_SOLICITUD
                AND     NUM_LINEA = P_Linea;
            EXCEPTION
                WHEN OTHERS THEN
                    V_Total := '00010101';
            END;
        ELSIF P_TIPO = 'F_U_T' THEN
            BEGIN
                SELECT TO_CHAR(TO_DATE(DES_FEC_FIN, 'yyyymmdd')
                                          -  CASE
                                          WHEN CAN_DOM != 0 THEN 0
                                          WHEN CAN_SAB != 0 THEN 1
                                          WHEN CAN_VIE != 0 THEN 2
                                          WHEN CAN_JUE  != 0 THEN 3
                                          WHEN CAN_MIE != 0 THEN 4
                                          WHEN CAN_MAR != 0 THEN 5
                                          WHEN CAN_LUN != 0 THEN 6
                                          ELSE NULL
                                       END,'YYYYMMDD')
                INTO    V_Total
                FROM    XXLMK_ORDLN_TAB
                WHERE   ID_ORDHDR = P_ID_SOLICITUD
                AND     NUM_LINEA = P_Linea;
            EXCEPTION
                WHEN OTHERS THEN
                    V_Total := '00010101';
            END;
        END IF;
        RETURN V_Total;
    END XXLMK_SOL_FECHAS_FUN;
    PROCEDURE XXLMK_AUT_URGENTE_PR
                        (
                                P_ID_SOLICITUD  IN NUMBER,
                                poinNUM_AUTS    OUT NUMBER
                        ) IS
    BEGIN
        BEGIN
            EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_TERRITORY=MEXICO';
        END;
        INSERT INTO XXLMK_AUTORIZACIONES_TAB
               (ID_AUT, ID_ORDEN, IND_ESTATUS,
                IND_TIPO_AUT, IND_NIVEL, NUM_LINEA,
                DES_AUT,
                FEC_CREACION, CVE_CREADO_POR,
                FEC_ACTUALIZACION, CVE_ACTUALIZADO_POR
               )
         SELECT XXLMK_AUTORIZACIONES_SQ.nextVal, ID_ORDHDR, 1,
                'URG', 'L', NUM_LINEA,
                'Autorizacin - Linea URGENTE: La linea tiene transmisiones que estan fuera de la hora de cierre ('||TO_CHAR(c.dia_cierre_ini,'DD/MM/YYYY hh24:mi')||')',
                SYSDATE, 'System',
                SYSDATE, 'System'
         FROM   XXLMK_ORDLN_TAB D,
                (SELECT IND_TIPO_ORDEN,
                        NUM_DIA,
                        NUM_DIA_CIERRE,
                        NUM_HORA_CIERRE||':'||NUM_MINUTO_CIERRE AS HORA_CIERRE,
                        TO_CHAR(SYSDATE,'D') HOY,
                        CASE WHEN NUM_DIA = TO_NUMBER(TO_CHAR(SYSDATE,'D')) THEN
                            TO_DATE(TO_CHAR(SYSDATE, 'yyyymmdd')
                            ||' '||NUM_HORA_CIERRE||':'||NUM_MINUTO_CIERRE,'YYYYMMDD HH24:MI')
                        END AS Dia_Cierre_INI,
                        NEXT_DAY(TO_DATE(TO_CHAR(SYSDATE, 'yyyymmdd')||'23:59:59','YYYYMMDDHH24:MI:SS'),
                        DECODE(NUM_DIA_CIERRE, 1, 'MON',
                                               2, 'TUE',
                                               3, 'WED',
                                               4, 'THU',
                                               5, 'FRI',
                                               6, 'SAT',
                                               7, 'SUN')
                              ) AS Dia_cierre_Fin
                 FROM   XXLMK_CONF_ORD_URG_TAB
                ) C
         WHERE  ID_ORDHDR = P_ID_SOLICITUD
         AND    C.DIA_CIERRE_INI IS NOT NULL
         AND    TO_CHAR(TO_DATE(XXLMK_ORDLMK_PKG.XXLMK_SOL_FECHAS_FUN (ID_ORDHDR, NUM_LINEA, 'F_1A_T'),'YYYYMMDd'),'D') = C.NUM_DIA_CIERRE
         AND    TO_DATE(XXLMK_ORDLMK_PKG.XXLMK_SOL_FECHAS_FUN (ID_ORDHDR, NUM_LINEA, 'F_1A_T'),'yyyymmdd')
                BETWEEN TRUNC(C.DIA_CIERRE_INI+1) AND TRUNC(C.DIA_CIERRE_FIN)
         AND    SYSDATE > C.DIA_CIERRE_INI
         AND    C.IND_TIPO_ORDEN = (SELECT IND_TIPO_ORDEN
                                    FROM   XXLMK_ORDHDR_TAB
                                    WHERE  ID_ORDHDR = P_ID_SOLICITUD
                                   )
         /*AND    NOT EXISTS        (SELECT 1
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
                                  )*/;
        poinNUM_AUTS := SQL%ROWCOUNT;
        EXCEPTION
            WHEN OTHERS THEN
                poinNUM_AUTS := 0;
    END XXLMK_AUT_URGENTE_PR;
    PROCEDURE XXLMK_AUT_URGENTE2_PR
                        (
                                P_ID_SOLICITUD  IN NUMBER,
                                poinNUM_AUTS    OUT NUMBER
                        ) IS
        CURSOR  AUT_LNS IS
        SELECT  ID_ORDHDR, NUM_LINEA,
                'Autorizacin - Linea URGENTE: La linea tiene transmisiones que estan fuera de la hora de cierre ('||TO_CHAR(c.dia_cierre_ini,'DD/MM/YYYY hh24:mi')||')' AS DESC_AUT
         FROM   XXLMK_ORDLN_TAB D,
                (SELECT IND_TIPO_ORDEN,
                        NUM_DIA,
                        NUM_DIA_CIERRE,
                        NUM_HORA_CIERRE||':'||NUM_MINUTO_CIERRE AS HORA_CIERRE,
                        TO_CHAR(SYSDATE,'D') HOY,
                        CASE WHEN NUM_DIA = TO_NUMBER(TO_CHAR(SYSDATE,'D')) THEN
                            TO_DATE(TO_CHAR(SYSDATE, 'yyyymmdd')
                            ||' '||NUM_HORA_CIERRE||':'||NUM_MINUTO_CIERRE,'YYYYMMDD HH24:MI')
                        END AS Dia_Cierre_INI,
                        NEXT_DAY(TO_DATE(TO_CHAR(SYSDATE, 'yyyymmdd')||'23:59:59','YYYYMMDDHH24:MI:SS'), NUM_DIA_CIERRE) AS Dia_cierre_Fin
                 FROM   XXLMK_CONF_ORD_URG_TAB
                ) C
         WHERE  ID_ORDHDR = P_ID_SOLICITUD
         AND    C.DIA_CIERRE_INI IS NOT NULL
         AND    TO_CHAR(TO_DATE(XXLMK_ORDLMK_PKG.XXLMK_SOL_FECHAS_FUN (ID_ORDHDR, NUM_LINEA, 'F_1A_T'),'YYYYMMDd'),'D') = C.NUM_DIA_CIERRE
         AND    TO_DATE(XXLMK_ORDLMK_PKG.XXLMK_SOL_FECHAS_FUN (ID_ORDHDR, NUM_LINEA, 'F_1A_T'),'yyyymmdd')
                BETWEEN TRUNC(C.DIA_CIERRE_INI+1) AND TRUNC(C.DIA_CIERRE_FIN)
         AND    SYSDATE > C.DIA_CIERRE_INI
         AND    C.IND_TIPO_ORDEN = (SELECT IND_TIPO_ORDEN
                                    FROM   XXLMK_ORDHDR_TAB
                                    WHERE  ID_ORDHDR = P_ID_SOLICITUD
                                   )
         AND NOT EXISTS (SELECT 1 FROM XXLMK_AUTORIZACIONES_TAB A WHERE A.ID_ORDEN = ID_ORDHDR AND A.IND_TIPO_AUT = 'URG' ) ;
    BEGIN
        BEGIN
            EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_TERRITORY=MEXICO';
        END;
        poinNUM_AUTS := 0;
        FOR AUT_LN IN AUT_LNS
        LOOP
            INSERT INTO XXLMK_AUTORIZACIONES_TAB
                   (ID_AUT, ID_ORDEN, IND_ESTATUS,
                    IND_TIPO_AUT, IND_NIVEL, NUM_LINEA,
                    DES_AUT,
                    FEC_CREACION, CVE_CREADO_POR,
                    FEC_ACTUALIZACION, CVE_ACTUALIZADO_POR
                   )
            VALUES
                    (XXLMK_AUTORIZACIONES_SQ.NEXTVAL, AUT_LN.ID_ORDHDR, 1,
                    'URG', 'L', AUT_LN.NUM_LINEA,
                    AUT_LN.DESC_AUT,
                    SYSDATE, 'System',
                    SYSDATE, 'System');
            poinNUM_AUTS := poinNUM_AUTS + SQL%ROWCOUNT;
            UPDATE  XXLMK_ORDLN_TAB
            SET     IND_ESTATUS = 3
            WHERE   ID_ORDHDR = P_ID_SOLICITUD
            AND     NUM_LINEA = AUT_LN.NUM_LINEA;
        END LOOP;
    END XXLMK_AUT_URGENTE2_PR;
    PROCEDURE XXLMK_AUT_OPENLOG_PR
                        (
                                P_ID_SOLICITUD IN  NUMBER,
                                piinNUM_AUTS   OUT NUMBER
                        ) IS
        CURSOR  AUT_LNS IS
        SELECT E.ID_ORDHDR, D.NUM_LINEA,
                   'ERROR', 'OPENLOG', 'AUTORIZACIN - Openlog.- La primera transmisn tiene una fecha igual a la actual' AS DESC_AUT
            FROM   XXLMK_ORDHDR_TAB E,
                   XXLMK_ORDLN_TAB D
            WHERE  E.ID_ORDHDR = P_ID_SOLICITUD
            AND    E.ID_ORDHDR = D.ID_ORDHDR
            AND    TRUNC(SYSDATE) = (SELECT TO_DATE(det.DES_fec_ini,'yyyymmdd')
                                                      +  CASE WHEN CAN_LUN     != 0 THEN 0
                                                              WHEN CAN_MAR    != 0 THEN 1
                                                              WHEN CAN_MIE != 0 THEN 2
                                                              WHEN CAN_JUE    != 0 THEN 3
                                                              WHEN CAN_VIE   != 0 THEN 4
                                                              WHEN CAN_SAB    != 0 THEN 5
                                                              WHEN CAN_DOM   != 0 THEN 6
                                                         ELSE 999 END
                                      FROM   XXLMK_ORDLN_TAB DET
                                      WHERE  DET.ID_ORDHDR = D.ID_ORDHDR
                                      AND    DET.NUM_LINEA        = D.NUM_LINEA
                                     )
           AND  D.IND_ESTATUS = 1
           AND NOT EXISTS (SELECT 1 FROM XXLMK_AUTORIZACIONES_TAB A WHERE A.ID_ORDEN = D.ID_ORDHDR AND A.IND_TIPO_AUT = 'OPLG' );
    BEGIN
        piinNUM_AUTS := 0;
        FOR AUT_LN IN AUT_LNS
        LOOP
            INSERT INTO XXLMK_AUTORIZACIONES_TAB
                   (ID_AUT, ID_ORDEN, IND_ESTATUS,
                    FEC_CREACION, CVE_CREADO_POR, FEC_ACTUALIZACION, CVE_ACTUALIZADO_POR,
                    IND_TIPO_AUT, IND_NIVEL, NUM_LINEA, DES_AUT
                   )
            VALUES (XXLMK_AUTORIZACIONES_SQ.NEXTVAL, AUT_LN.ID_ORDHDR, 1,
                    SYSDATE, 'System', SYSDATE, 'System',
                    'OPLG', 'L', AUT_LN.NUM_LINEA, AUT_LN.DESC_AUT
                    );
            piinNUM_AUTS := piinNUM_AUTS + SQL%ROWCOUNT;
            UPDATE  XXLMK_ORDLN_TAB
            SET     IND_ESTATUS = 3
            WHERE   ID_ORDHDR = P_ID_SOLICITUD
            AND     NUM_LINEA = AUT_LN.NUM_LINEA;
         END LOOP;
    END XXLMK_AUT_OPENLOG_PR;
    PROCEDURE XXLMK_AUT_RECH_ORD_URG_PR (
                                            piinNUM_ORD NUMBER,
                                            A_LINEAS    ARRAY_TVCH2,
                                            piinTAM_ARR NUMBER,
                                            piinIND_AUT_RECH    NUMBER,
                                            pistUSER    VARCHAR2
                                         ) IS
        linIND_ST_LINEA    NUMBER;
        linIND_ST_ORD      NUMBER;
        linID_LINEA        INTEGER;
    BEGIN
        IF (piinTAM_ARR > 0) THEN
            FOR i IN 1..piinTAM_ARR LOOP
                UPDATE  XXLMK_AUTORIZACIONES_TAB
                SET IND_ESTATUS         = piinIND_AUT_RECH,
                    FEC_ACTUALIZACION   = SYSDATE,
                    CVE_ACTUALIZADO_POR = pistUSER
                WHERE   ID_ORDEN    = piinNUM_ORD
                AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i))
                AND     IND_TIPO_AUT = 'URG';
                SELECT  ID_LINEA
                INTO    linID_LINEA
                FROM    XXLMK_ORDLN_TAB
                WHERE   ID_ORDHDR   = piinNUM_ORD
                AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i));
                IF(piinIND_AUT_RECH = 2) THEN
                    SELECT  COUNT(*)
                    INTO    linIND_ST_LINEA
                    FROM    XXLMK_AUTORIZACIONES_TAB A
                    WHERE   A.ID_ORDEN = piinNUM_ORD
                    AND     A.NUM_LINEA = TO_NUMBER(A_LINEAS(i))
                    AND     A.IND_NIVEL = 'L'
                    AND     A.IND_ESTATUS = 1;
                    IF(linIND_ST_LINEA = 0) THEN
                        UPDATE    XXLMK_ORDLN_TAB
                        SET IND_ESTATUS = 5
                        WHERE   ID_ORDHDR   = piinNUM_ORD
                        AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i)) ;
                        UPDATE  XXLMK_LINEAS_SPOTS_TAB
                        SET     IND_ESTATUS = 5
                        WHERE   ID_LINEA = linID_LINEA;
                    END IF;
                    /*SELECT  COUNT(*)
                    INTO    linIND_ST_ORD
                    FROM    XXLMK_AUTORIZACIONES_TAB    A
                    WHERE   A.ID_ORDEN = piinNUM_ORD
                    AND     A.NUM_LINEA = TO_NUMBER(A_LINEAS(i))
                    AND     A.IND_NIVEL = 'E'
                    AND     A.IND_ESTATUS = 1;
                    IF(linIND_ST_ORD = 0) THEN
                        UPDATE  XXLMK_ORDHDR_TAB
                        SET IND_ESTATUS = 7
                        WHERE   ID_ORDHDR = piinNUM_ORD;
                    END IF;*/
                ELSIF(piinIND_AUT_RECH = 3) THEN
                    UPDATE    XXLMK_ORDLN_TAB
                    SET IND_ESTATUS = 4
                    WHERE   ID_ORDHDR   = piinNUM_ORD
                    AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i));
                    UPDATE  XXLMK_LINEAS_SPOTS_TAB
                    SET     IND_ESTATUS = 4
                    WHERE   ID_LINEA = linID_LINEA;
                    /*SELECT  COUNT(*)
                    INTO    linIND_ST_ORD
                    FROM    XXLMK_ORDLN_TAB OL
                    WHERE   OL.ID_ORDHDR = piinNUM_ORD
                    AND
                            (OL.IND_ESTATUS = 3
                            OR  OL.IND_ESTATUS = 5);
                    IF(linIND_ST_ORD = 0) THEN
                        UPDATE  XXLMK_ORDHDR_TAB
                        SET     IND_ESTATUS = 6
                        WHERE   ID_ORDHDR = piinNUM_ORD;
                    END IF;*/
                END IF;
            END LOOP;
            XXLMK_UPD_AUT_ORD_ST_PR(piinNUM_ORD);
            COMMIT;
        END IF;
    END XXLMK_AUT_RECH_ORD_URG_PR;
    PROCEDURE XXLMK_AUT_RECH_ORD_OPLG_PR (
                                            piinNUM_ORD NUMBER,
                                            A_LINEAS    ARRAY_TVCH2,
                                            piinTAM_ARR NUMBER,
                                            piinIND_AUT_RECH    NUMBER,
                                            pistUSER    VARCHAR2
                                         ) IS
        linIND_ST_LINEA    NUMBER;
        linIND_ST_ORD      NUMBER;
        linID_LINEA        INTEGER;
    BEGIN
        IF (piinTAM_ARR > 0) THEN
            FOR i IN 1..piinTAM_ARR LOOP
                UPDATE  XXLMK_AUTORIZACIONES_TAB
                SET IND_ESTATUS         = piinIND_AUT_RECH,
                    FEC_ACTUALIZACION   = SYSDATE,
                    CVE_ACTUALIZADO_POR = pistUSER
                WHERE   ID_ORDEN    = piinNUM_ORD
                AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i))
                AND     IND_TIPO_AUT = 'OPLG';
                SELECT  ID_LINEA
                INTO    linID_LINEA
                FROM    XXLMK_ORDLN_TAB
                WHERE   ID_ORDHDR   = piinNUM_ORD
                AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i));
                IF(piinIND_AUT_RECH = 2) THEN
                    SELECT  COUNT(*)
                    INTO    linIND_ST_LINEA
                    FROM    XXLMK_AUTORIZACIONES_TAB A
                    WHERE   A.ID_ORDEN = piinNUM_ORD
                    AND     A.NUM_LINEA = TO_NUMBER(A_LINEAS(i))
                    AND     A.IND_NIVEL = 'L'
                    AND     A.IND_ESTATUS = 1;
                    IF(linIND_ST_LINEA = 0) THEN
                        UPDATE    XXLMK_ORDLN_TAB
                        SET IND_ESTATUS = 5
                        WHERE   ID_ORDHDR   = piinNUM_ORD
                        AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i)) ;
                        UPDATE  XXLMK_LINEAS_SPOTS_TAB
                        SET     IND_ESTATUS = 5
                        WHERE   ID_LINEA = linID_LINEA;
                    END IF;
                    /*SELECT  COUNT(*)
                    INTO    linIND_ST_ORD
                    FROM    XXLMK_AUTORIZACIONES_TAB    A
                    WHERE   A.ID_ORDEN = piinNUM_ORD
                    AND     A.NUM_LINEA = TO_NUMBER(A_LINEAS(i))
                    AND     A.IND_NIVEL = 'E'
                    AND     A.IND_ESTATUS = 1;
                    IF(linIND_ST_ORD = 0) THEN
                        UPDATE  XXLMK_ORDHDR_TAB
                        SET IND_ESTATUS = 7
                        WHERE   ID_ORDHDR = piinNUM_ORD;
                    END IF;*/
                ELSIF(piinIND_AUT_RECH = 3) THEN
                    UPDATE    XXLMK_ORDLN_TAB
                    SET IND_ESTATUS = 4
                    WHERE   ID_ORDHDR   = piinNUM_ORD
                    AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i));
                    UPDATE  XXLMK_LINEAS_SPOTS_TAB
                    SET     IND_ESTATUS = 4
                    WHERE   ID_LINEA = linID_LINEA;
                    /*SELECT  COUNT(*)
                    INTO    linIND_ST_ORD
                    FROM    XXLMK_ORDLN_TAB OL
                    WHERE   OL.ID_ORDHDR = piinNUM_ORD
                    AND
                            (OL.IND_ESTATUS = 3
                            OR  OL.IND_ESTATUS = 5);
                    IF(linIND_ST_ORD = 0) THEN
                        UPDATE  XXLMK_ORDHDR_TAB
                        SET     IND_ESTATUS = 6
                        WHERE   ID_ORDHDR = piinNUM_ORD;
                    END IF;*/
                END IF;
            END LOOP;
            XXLMK_UPD_AUT_ORD_ST_PR(piinNUM_ORD);
            COMMIT;
        END IF;
    END XXLMK_AUT_RECH_ORD_OPLG_PR;
    PROCEDURE XXLMK_UPDT_ORD_ST_SPOTS (piinORD_ID NUMBER)
    IS
        linSPTS_REPR NUMBER := 0;
        linSPTS_RECH NUMBER := 0;
        linspts_OK   NUMBER := 0;
        linST_ORD NUMBER;
        linNW_ST_ORD NUMBER;
        linNUM_SPOTS NUMBER := 0;
        lstST VARCHAR2(200);
    BEGIN
        SELECT  IND_ESTATUS
        INTO    linST_ORD
        FROM    XXLMK_ORDHDR_TAB    O
        WHERE   O.ID_ORDHDR = piinORD_ID;
        SELECT  COUNT(*)
        INTO    linSPTS_REPR
        FROM    XXLMK_ORDLN_TAB OL
        JOIN    XXLMK_LINEAS_SPOTS_TAB LS
        ON      OL.ID_LINEA = LS.ID_LINEA
        WHERE   LS.IND_ESTATUS = 6
        AND     OL.ID_ORDHDR = piinORD_ID;
        SELECT  COUNT(*)
        INTO    linSPTS_RECH
        FROM    XXLMK_ORDLN_TAB OL
        JOIN    XXLMK_LINEAS_SPOTS_TAB LS
        ON      OL.ID_LINEA = LS.ID_LINEA
        WHERE   LS.IND_ESTATUS = 4
        AND     OL.ID_ORDHDR = piinORD_ID;
        SELECT  COUNT(*)
        INTO    linNUM_SPOTS
        FROM    XXLMK_ORDLN_TAB OL
        JOIN    XXLMK_LINEAS_SPOTS_TAB LS
        ON      OL.ID_LINEA = LS.ID_LINEA
        AND     OL.ID_ORDHDR = piinORD_ID;
        SELECT  CASE
                    WHEN linSPTS_REPR > 0 AND linSPTS_RECH = 0 THEN 10
                    --WHEN linSPTS_REPR = 0 AND linSPTS_RECH > 0 THEN 11
                    WHEN linSPTS_REPR > 0 AND linSPTS_RECH > 0 THEN 12
                    WHEN linSPTS_REPR = 0 AND linSPTS_RECH = 0 THEN 100
                    WHEN linSPTS_RECH = linNUM_SPOTS THEN 6 -- TODAS LAS LINEAS RECHAZADAS -> ORDEN RECHAZADA
                    ELSE  linST_ORD
                END AS ST_ORD
        INTO    linNW_ST_ORD
        FROM    DUAL;
        IF(linNW_ST_ORD = 100) THEN
            SELECT  COUNT(*)
            INTO    linspts_OK
            FROM    XXLMK_ORDLN_TAB OL
            JOIN    XXLMK_LINEAS_SPOTS_TAB LS
            ON      OL.ID_LINEA = LS.ID_LINEA
            WHERE   LS.IND_ESTATUS = 7
            AND     OL.ID_ORDHDR = piinORD_ID;
            IF(linspts_OK != linNUM_SPOTS) THEN
                linNW_ST_ORD := linST_ORD;
            END IF;
        END IF;
        UPDATE  XXLMK_ORDHDR_TAB    O
        SET     O.IND_ESTATUS = linNW_ST_ORD
        WHERE   O.ID_ORDHDR = piinORD_ID;
        SELECT CASE linNW_ST_ORD
                    WHEN 10 THEN 'ORDEN CON REPROCESOS'
                    WHEN 11 THEN 'ORDEN CON RECHAZOS'
                    WHEN 12 THEN 'ORDEN CON REPROCESOS Y RECHAZOS'
                    WHEN 100 THEN 'ORDEN COMPLETA'
                    ELSE 'NO HAY CAMBIO DE ESTATUS'
               END
        INTO    lstST
        FROM DUAL;
        DBMS_OUTPUT.PUT_LINE('ESTATUS: '||lstST);
    END;
    PROCEDURE XXLMK_AUT_TM_LN_PR
                            (
                                    P_ID_SOLICITUD IN NUMBER,
                                    poinNUM_AUTS    OUT NUMBER
                            )
    IS
        CURSOR  AUT_LNS IS
        SELECT  OL.ID_ORDHDR, OL.NUM_LINEA
        FROM    XXLMK_ORDLN_TAB     OL
        WHERE   OL.ID_ORDHDR = P_ID_SOLICITUD
        AND NOT EXISTS (SELECT 1 FROM XXLMK_AUTORIZACIONES_TAB A WHERE A.ID_ORDEN = OL.ID_ORDHDR AND IND_TIPO_AUT = 'TM');
    BEGIN
        poinNUM_AUTS    := 0;
        FOR AUT_LN IN AUT_LNS
        LOOP
            INSERT INTO XXLMK_AUTORIZACIONES_TAB
                   (ID_AUT, ID_ORDEN, IND_ESTATUS,
                    FEC_CREACION, CVE_CREADO_POR, FEC_ACTUALIZACION, CVE_ACTUALIZADO_POR,
                    IND_TIPO_AUT, IND_NIVEL, NUM_LINEA, DES_AUT
                   )
            VALUES (XXLMK_AUTORIZACIONES_SQ.NEXTVAL, AUT_LN.ID_ORDHDR, 1,
                    SYSDATE, 'System', SYSDATE, 'System',
                    'TM', 'L', AUT_LN.NUM_LINEA, 'Taria Manual'
                    );
            poinNUM_AUTS := poinNUM_AUTS + SQL%ROWCOUNT;
            IF(SQL%ROWCOUNT > 0) THEN
	            UPDATE  XXLMK_ORDLN_TAB
	            SET     IND_ESTATUS = 3
	            WHERE   ID_ORDHDR = P_ID_SOLICITUD
	            AND     NUM_LINEA = AUT_LN.NUM_LINEA;
            END IF;
         END LOOP;
    END;
    PROCEDURE XXLMK_AUT_RECH_ORD_TM_PR (
                                            piinNUM_ORD NUMBER,
                                            A_LINEAS    ARRAY_TVCH2,
                                            piinTAM_ARR NUMBER,
                                            piinIND_AUT_RECH    NUMBER,
                                            pistUSER    VARCHAR2
                                         ) IS
        linIND_ST_LINEA    NUMBER;
        linIND_ST_ORD      NUMBER;
        linID_LINEA        INTEGER;
    BEGIN
        IF (piinTAM_ARR > 0) THEN
            FOR i IN 1..piinTAM_ARR LOOP
                UPDATE  XXLMK_AUTORIZACIONES_TAB
                SET IND_ESTATUS         = piinIND_AUT_RECH,
                    FEC_ACTUALIZACION   = SYSDATE,
                    CVE_ACTUALIZADO_POR = pistUSER
                WHERE   ID_ORDEN    = piinNUM_ORD
                AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i))
                AND     IND_TIPO_AUT = 'TM';
                SELECT  ID_LINEA
                INTO    linID_LINEA
                FROM    XXLMK_ORDLN_TAB
                WHERE   ID_ORDHDR   = piinNUM_ORD
                AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i));
                IF(piinIND_AUT_RECH = 2) THEN
                    SELECT  COUNT(*)
                    INTO    linIND_ST_LINEA
                    FROM    XXLMK_AUTORIZACIONES_TAB A
                    WHERE   A.ID_ORDEN = piinNUM_ORD
                    AND     A.NUM_LINEA = TO_NUMBER(A_LINEAS(i))
                    AND     A.IND_NIVEL = 'L'
                    AND     A.IND_ESTATUS = 1;
                    IF(linIND_ST_LINEA = 0) THEN
                        UPDATE    XXLMK_ORDLN_TAB
                        SET IND_ESTATUS = 5
                        WHERE   ID_ORDHDR   = piinNUM_ORD
                        AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i)) ;
                        UPDATE  XXLMK_LINEAS_SPOTS_TAB
                        SET     IND_ESTATUS = 5
                        WHERE   ID_LINEA = linID_LINEA;
                    END IF;
                    /*SELECT  COUNT(*)
                    INTO    linIND_ST_ORD
                    FROM    XXLMK_AUTORIZACIONES_TAB    A
                    WHERE   A.ID_ORDEN = piinNUM_ORD
                    AND     A.NUM_LINEA = TO_NUMBER(A_LINEAS(i))
                    AND     A.IND_NIVEL = 'E'
                    AND     A.IND_ESTATUS = 1;
                    IF(linIND_ST_ORD = 0) THEN
                        UPDATE  XXLMK_ORDHDR_TAB
                        SET IND_ESTATUS = 7
                        WHERE   ID_ORDHDR = piinNUM_ORD;
                    END IF;*/
                ELSIF(piinIND_AUT_RECH = 3) THEN
                    UPDATE    XXLMK_ORDLN_TAB
                    SET IND_ESTATUS = 4
                    WHERE   ID_ORDHDR   = piinNUM_ORD
                    AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i));
                    UPDATE  XXLMK_LINEAS_SPOTS_TAB
                    SET     IND_ESTATUS = 4
                    WHERE   ID_LINEA = linID_LINEA;
                    /*SELECT  COUNT(*)
                    INTO    linIND_ST_ORD
                    FROM    XXLMK_ORDLN_TAB OL
                    WHERE   OL.ID_ORDHDR = piinNUM_ORD
                    AND
                            (OL.IND_ESTATUS = 3
                            OR  OL.IND_ESTATUS = 5);
                    IF(linIND_ST_ORD = 0) THEN
                        UPDATE  XXLMK_ORDHDR_TAB
                        SET     IND_ESTATUS = 6
                        WHERE   ID_ORDHDR = piinNUM_ORD;
                    END IF;*/
                END IF;
            END LOOP;
            XXLMK_UPD_AUT_ORD_ST_PR(piinNUM_ORD);
            COMMIT;
        END IF;
    END XXLMK_AUT_RECH_ORD_TM_PR;
    FUNCTION XXLMK_CAN_DUR_EXEPT_CONF_FUN(piinID_AJUS INTEGER, piinID_GRUPO INTEGER, piinNUM_BREK_NOM_TIME INTEGER) RETURN NUMBER
    IS
        ldtINI  DATE;
        ldtFIN  DATE;
        linDUR  INTEGER;
    BEGIN
        BEGIN
            SELECT  ADC.NUM_DUR_CONF
            INTO    linDUR
            FROM    XXLMK_AJUS_DUR_CONF_GRP_TAB ADC
            WHERE   ID_AJUSTE_BREAKS = piinID_AJUS
            AND     ID_GRUPO = piinID_GRUPO
            AND     NUM_BREAK_TIME = piinNUM_BREK_NOM_TIME;
        EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                    SELECT  NUM_DURACION
                    INTO    linDUR
                    FROM    XXLMK_GRUPOS_CANALES_TAB GC
                    WHERE   GC.ID_GRUPO = piinID_GRUPO;
                EXCEPTION
                    WHEN OTHERS THEN
                        linDUR := 0;
                END;
        END;
        RETURN linDUR;
    END XXLMK_CAN_DUR_EXEPT_CONF_FUN;
    FUNCTION XXLMK_CAN_DUR_EXEPT_FMT_FUN(piinID_AJUS INTEGER, piinID_GRUPO INTEGER, piinNUM_BREK_NOM_TIME INTEGER) RETURN VARCHAR2
    IS
        linDUR  INTEGER;
        lstDUR  VARCHAR2(10);
    BEGIN
        linDUR := XXLMK_CAN_DUR_EXEPT_CONF_FUN(piinID_AJUS, piinID_GRUPO, piinNUM_BREK_NOM_TIME);
        lstDUR := TO_CHAR(TO_DATE(linDUR, 'sssss'), 'hh24:mi:ss');
        RETURN lstDUR;
    END XXLMK_CAN_DUR_EXEPT_FMT_FUN;
    PROCEDURE XXLMK_INS_UPD_SPT_REC_INF_PR(piinID_SPOT INTEGER, piinNUM_SPOT INTEGER, piinNUM_SCHED_TIME_ORIG VARCHAR2,
                                            piinIND_STATUS_LMK_ORIG VARCHAR2, piinIND_ESTATUS_MOV INTEGER,
                                            piinID_RAZON_CANCEL INTEGER, piinIND_CAMBIO_STATUS INTEGER, pistCVE_CREADO_POR VARCHAR2)
    IS
        linCOUNT_SPOT   INTEGER;
    BEGIN
        SELECT COUNT(*)
        INTO linCOUNT_SPOT
        FROM XXLMK_RECOL_SPOTS_CTRL_TAB
        WHERE ID_SPOT = piinID_SPOT;
        IF linCOUNT_SPOT = 0 THEN
            INSERT INTO XXLMK_RECOL_SPOTS_CTRL_TAB(ID_SPOT, NUM_SPOT, NUM_SCHED_TIME_ORIG, IND_STATUS_LMK_ORIG, IND_ESTATUS_MOV, ID_RAZON_CANCEL,
                        IND_CAMBIO_STATUS, IND_NUM_MOVS, CVE_CREADO_POR, FEC_CREACION)
                        VALUES                    (piinID_SPOT, piinNUM_SPOT, piinNUM_SCHED_TIME_ORIG, piinIND_STATUS_LMK_ORIG, piinIND_ESTATUS_MOV, piinID_RAZON_CANCEL,
                        piinIND_CAMBIO_STATUS, 1, pistCVE_CREADO_POR, SYSDATE);
        ELSE
            UPDATE XXLMK_RECOL_SPOTS_CTRL_TAB
            SET
                NUM_SCHED_TIME_ORIG = piinNUM_SCHED_TIME_ORIG,
                IND_STATUS_LMK_ORIG = piinIND_STATUS_LMK_ORIG,
                IND_ESTATUS_MOV = piinIND_ESTATUS_MOV,
                ID_RAZON_CANCEL = piinID_RAZON_CANCEL,
                IND_CAMBIO_STATUS = piinIND_CAMBIO_STATUS,
                IND_NUM_MOVS = IND_NUM_MOVS + 1,
                CVE_ACTUALIZADO_POR = pistCVE_CREADO_POR,
                FEC_ACTUALIZACION = SYSDATE
            WHERE ID_SPOT = piinID_SPOT;
        END IF;
    END XXLMK_INS_UPD_SPT_REC_INF_PR;
    PROCEDURE XXLMK_SMOD_ADD_CAN_GRP_PR(piinGRUPO_CANAL INTEGER, piinCANAL INTEGER, piinINDEX INTEGER, piinNETWORK INTEGER, piinSKY INTEGER, piinIZZI INTEGER, pistCREATED_BY VARCHAR)
    IS
    	linCOUNT_CFG_NCANS INTEGER;
        linPERC_DIST NUMBER(5, 2);
    BEGIN
	    UPDATE XXLMK_SMOD_CONF_CANS_TAB
	    SET IND_ORDEN = IND_ORDEN + 1
	    WHERE ID_GRUPO = piinGRUPO_CANAL
	    AND IND_ORDEN >= piinINDEX;
	    INSERT INTO XXLMK_SMOD_CONF_CANS_TAB(NUM_CANAL, ID_GRUPO, IND_NETWORK, IND_SKY, IND_IZZI, IND_ORDEN, FEC_CREACION, CVE_CREADO_POR)
	    VALUES (piinCANAL, piinGRUPO_CANAL, piinNETWORK, piinSKY, piinIZZI, piinINDEX, SYSDATE, pistCREATED_BY);
	    SELECT NVL(MAX(G.NUM_CANS), 0) + 1
	    INTO linCOUNT_CFG_NCANS
	    FROM XXLMK_SMOD_GRP_NCANS_TAB G
	    WHERE G.ID_GRUPO = piinGRUPO_CANAL;
	    INSERT INTO XXLMK_SMOD_GRP_NCANS_TAB(ID_GRUPO, NUM_CANS, FEC_CREACION, CVE_CREADO_POR, FEC_ACTUALIZACION, CVE_ACTUALIZADO_POR)
	    VALUES (piinGRUPO_CANAL, linCOUNT_CFG_NCANS, SYSDATE, pistCREATED_BY, SYSDATE, pistCREATED_BY);
	    linPERC_DIST := 100 / linCOUNT_CFG_NCANS;
	    FOR COUNTER IN 1..linCOUNT_CFG_NCANS
	    LOOP
	    	INSERT INTO XXLMK_SMOD_NCANS_DIST_TAB(ID_GRUPO, NUM_CANS, NUM_CAN, NUM_PORC_DIST, FEC_CREACION, CVE_CREADO_POR, FEC_ACTUALIZACION, CVE_ACTUALIZADO_POR)
	    	VALUES(piinGRUPO_CANAL, linCOUNT_CFG_NCANS, COUNTER, linPERC_DIST, SYSDATE, pistCREATED_BY, SYSDATE, pistCREATED_BY);
	    END LOOP;
    END XXLMK_SMOD_ADD_CAN_GRP_PR;
    PROCEDURE XXLMK_SMOD_UPD_CAN_GRP_PR(piinGRUPO_CANAL INTEGER, piinCANAL INTEGER, piinINDEX INTEGER, piinNETWORK INTEGER, piinSKY INTEGER, piinIZZI INTEGER, pistUPDATED_BY VARCHAR)
    IS
    BEGIN
	    UPDATE XXLMK_SMOD_CONF_CANS_TAB C
	    SET C.IND_ORDEN = piinINDEX,
	    C.IND_NETWORK = piinNETWORK,
	    C.IND_SKY = piinSKY,
	    C.IND_IZZI = piinIZZI,
	    C.FEC_ACTUALIZACION = SYSDATE,
	    C.CVE_ACTUALIZADO_POR = pistUPDATED_BY
	    WHERE C.ID_GRUPO = piinGRUPO_CANAL
	    AND C.NUM_CANAL = piinCANAL;
    END XXLMK_SMOD_UPD_CAN_GRP_PR;
   PROCEDURE XXLMK_SMOD_UPD_DIST_CFG_PR(piinGRUPO_CANAL INTEGER, piinNUM_CANS INTEGER, piinINDEX INTEGER, piinPERCENTAGE NUMBER, pistUPDATED_BY VARCHAR)
   IS
   BEGIN
		UPDATE XXLMK_SMOD_NCANS_DIST_TAB C
		SET C.NUM_PORC_DIST = piinPERCENTAGE,
		C.FEC_ACTUALIZACION = SYSDATE,
		C.CVE_ACTUALIZADO_POR = pistUPDATED_BY
		WHERE C.ID_GRUPO = piinGRUPO_CANAL
		AND C.NUM_CANS = piinNUM_CANS
		AND C.NUM_CAN = piinINDEX;
   END XXLMK_SMOD_UPD_DIST_CFG_PR;
  PROCEDURE XXLMK_SMOD_DEL_CAN_GRP_PR(piinGRUPO_CANAL INTEGER, piinCANAL INTEGER)
  IS
  	linINDEX INTEGER;
	linCOUNT_CFG_NCANS INTEGER;
  BEGIN
	  SELECT C.IND_ORDEN
	  INTO linINDEX
	  FROM XXLMK_SMOD_CONF_CANS_TAB C
	  WHERE C.ID_GRUPO = piinGRUPO_CANAL
	  AND C.NUM_CANAL = piinCANAL;
	 DELETE FROM XXLMK_SMOD_CONF_CANS_TAB C
	 WHERE C.ID_GRUPO = piinGRUPO_CANAL
	 AND C.NUM_CANAL = piinCANAL;
	 UPDATE XXLMK_SMOD_CONF_CANS_TAB C
	 SET C.IND_ORDEN = C.IND_ORDEN - 1
	 WHERE C.ID_GRUPO = piinGRUPO_CANAL
	 AND C.IND_ORDEN > linINDEX;
	SELECT MAX(G.NUM_CANS)
	    INTO linCOUNT_CFG_NCANS
	    FROM XXLMK_SMOD_GRP_NCANS_TAB G
	    WHERE G.ID_GRUPO = piinGRUPO_CANAL;
	DELETE FROM XXLMK_SMOD_NCANS_DIST_TAB N
	WHERE N.ID_GRUPO = piinGRUPO_CANAL
	AND N.NUM_CANS = linCOUNT_CFG_NCANS;
	DELETE FROM XXLMK_SMOD_GRP_NCANS_TAB N
	WHERE N.ID_GRUPO = piinGRUPO_CANAL
	AND N.NUM_CANS = linCOUNT_CFG_NCANS;
  END XXLMK_SMOD_DEL_CAN_GRP_PR;
  PROCEDURE XXLMK_AUT_EXTEMPORANEA_PR
                        (
                                P_ID_SOLICITUD IN  NUMBER,
                                piinNUM_AUTS   OUT NUMBER
                        ) IS
        CURSOR  AUT_LNS IS
        SELECT E.ID_ORDHDR, D.NUM_LINEA,
                   'ERROR', 'EXTEMPORANEA', 'AUTORIZACIN - Extemporanea.- La primera transmisn tiene una fecha menor a la actual' AS DESC_AUT
            FROM   XXLMK_ORDHDR_TAB E,
                   XXLMK_ORDLN_TAB D
            WHERE  E.ID_ORDHDR = P_ID_SOLICITUD
            AND    E.ID_ORDHDR = D.ID_ORDHDR
            AND    TRUNC(SYSDATE) > (SELECT TO_DATE(det.DES_fec_ini,'yyyymmdd')
                                                      +  CASE WHEN CAN_LUN     != 0 THEN 0
                                                              WHEN CAN_MAR    != 0 THEN 1
                                                              WHEN CAN_MIE != 0 THEN 2
                                                              WHEN CAN_JUE    != 0 THEN 3
                                                              WHEN CAN_VIE   != 0 THEN 4
                                                              WHEN CAN_SAB    != 0 THEN 5
                                                              WHEN CAN_DOM   != 0 THEN 6
                                                         ELSE 999 END
                                      FROM   XXLMK_ORDLN_TAB DET
                                      WHERE  DET.ID_ORDHDR = D.ID_ORDHDR
                                      AND    DET.NUM_LINEA        = D.NUM_LINEA
                                     )
           AND  D.IND_ESTATUS = 1
           AND NOT EXISTS (SELECT 1 FROM XXLMK_AUTORIZACIONES_TAB A WHERE A.ID_ORDEN = D.ID_ORDHDR AND A.IND_TIPO_AUT = 'EXT' );
    BEGIN
        piinNUM_AUTS := 0;
        FOR AUT_LN IN AUT_LNS
        LOOP
            INSERT INTO XXLMK_AUTORIZACIONES_TAB
                   (ID_AUT, ID_ORDEN, IND_ESTATUS,
                    FEC_CREACION, CVE_CREADO_POR, FEC_ACTUALIZACION, CVE_ACTUALIZADO_POR,
                    IND_TIPO_AUT, IND_NIVEL, NUM_LINEA, DES_AUT
                   )
            VALUES (XXLMK_AUTORIZACIONES_SQ.NEXTVAL, AUT_LN.ID_ORDHDR, 1,
                    SYSDATE, 'System', SYSDATE, 'System',
                    'EXT', 'L', AUT_LN.NUM_LINEA, AUT_LN.DESC_AUT
                    );
            piinNUM_AUTS := piinNUM_AUTS + SQL%ROWCOUNT;
            UPDATE  XXLMK_ORDLN_TAB
            SET     IND_ESTATUS = 3
            WHERE   ID_ORDHDR = P_ID_SOLICITUD
            AND     NUM_LINEA = AUT_LN.NUM_LINEA;
         END LOOP;
    END XXLMK_AUT_EXTEMPORANEA_PR;
   PROCEDURE XXLMK_AUT_RECH_ORD_EXT_PR (
                                            piinNUM_ORD NUMBER,
                                            A_LINEAS    ARRAY_TVCH2,
                                            piinTAM_ARR NUMBER,
                                            piinIND_AUT_RECH    NUMBER,
                                            pistUSER    VARCHAR2
                                         ) IS
        linIND_ST_LINEA    NUMBER;
        linIND_ST_ORD      NUMBER;
        linID_LINEA        INTEGER;
    BEGIN
        IF (piinTAM_ARR > 0) THEN
            FOR i IN 1..piinTAM_ARR LOOP
                UPDATE  XXLMK_AUTORIZACIONES_TAB
                SET IND_ESTATUS         = piinIND_AUT_RECH,
                    FEC_ACTUALIZACION   = SYSDATE,
                    CVE_ACTUALIZADO_POR = pistUSER
                WHERE   ID_ORDEN    = piinNUM_ORD
                AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i))
                AND     IND_TIPO_AUT = 'EXT';
                SELECT  ID_LINEA
                INTO    linID_LINEA
                FROM    XXLMK_ORDLN_TAB
                WHERE   ID_ORDHDR   = piinNUM_ORD
                AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i));
                IF(piinIND_AUT_RECH = 2) THEN
                    SELECT  COUNT(*)
                    INTO    linIND_ST_LINEA
                    FROM    XXLMK_AUTORIZACIONES_TAB A
                    WHERE   A.ID_ORDEN = piinNUM_ORD
                    AND     A.NUM_LINEA = TO_NUMBER(A_LINEAS(i))
                    AND     A.IND_NIVEL = 'L'
                    AND     A.IND_ESTATUS = 1;
                    IF(linIND_ST_LINEA = 0) THEN
                        UPDATE    XXLMK_ORDLN_TAB
                        SET IND_ESTATUS = 5
                        WHERE   ID_ORDHDR   = piinNUM_ORD
                        AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i)) ;
                        UPDATE  XXLMK_LINEAS_SPOTS_TAB
                        SET     IND_ESTATUS = 5
                        WHERE   ID_LINEA = linID_LINEA;
                    END IF;
                    /*SELECT  COUNT(*)
                    INTO    linIND_ST_ORD
                    FROM    XXLMK_AUTORIZACIONES_TAB    A
                    WHERE   A.ID_ORDEN = piinNUM_ORD
                    AND     A.NUM_LINEA = TO_NUMBER(A_LINEAS(i))
                    AND     A.IND_NIVEL = 'E'
                    AND     A.IND_ESTATUS = 1;
                    IF(linIND_ST_ORD = 0) THEN
                        UPDATE  XXLMK_ORDHDR_TAB
                        SET IND_ESTATUS = 7
                        WHERE   ID_ORDHDR = piinNUM_ORD;
                    END IF;*/
                ELSIF(piinIND_AUT_RECH = 3) THEN
                    UPDATE    XXLMK_ORDLN_TAB
                    SET IND_ESTATUS = 4
                    WHERE   ID_ORDHDR   = piinNUM_ORD
                    AND     NUM_LINEA   = TO_NUMBER(A_LINEAS(i));
                    UPDATE  XXLMK_LINEAS_SPOTS_TAB
                    SET     IND_ESTATUS = 4
                    WHERE   ID_LINEA = linID_LINEA;
                    /*SELECT  COUNT(*)
                    INTO    linIND_ST_ORD
                    FROM    XXLMK_ORDLN_TAB OL
                    WHERE   OL.ID_ORDHDR = piinNUM_ORD
                    AND
                            (OL.IND_ESTATUS = 3
                            OR  OL.IND_ESTATUS = 5);
                    IF(linIND_ST_ORD = 0) THEN
                        UPDATE  XXLMK_ORDHDR_TAB
                        SET     IND_ESTATUS = 6
                        WHERE   ID_ORDHDR = piinNUM_ORD;
                    END IF;*/
                END IF;
            END LOOP;
            XXLMK_UPD_AUT_ORD_ST_PR(piinNUM_ORD);
            COMMIT;
        END IF;
    END XXLMK_AUT_RECH_ORD_EXT_PR ;
END;
/;
