CREATE OR REPLACE EDITIONABLE PROCEDURE "XXMOR"."XXMOR_REPROCESAR_ENC_DET_PR" (
   V_ID_SOL                VARCHAR2,
   V_PROC_X_LINEA          VARCHAR2,
   V_GARANTIZADO           VARCHAR2,
   V_CVE_CLIENTE           VARCHAR2,
   V_MASTER_CONTRACT       VARCHAR2,
   V_NOMBRE_EMAIL_RESP     VARCHAR2,
   V_REF_FOLIO             VARCHAR2,
   V_CVE_AGENCIA           VARCHAR2,
   V_NOMBRE_TARIFA         VARCHAR2,
   V_CANAL_ORD_PLAT        VARCHAR2,
   V_CAT_PROD              VARCHAR2,
   V_TOTAL_SPOTS           VARCHAR2,
   V_TOTAL_ORD_SIN_DESC    VARCHAR2,
   V_TOTAL_ORD_CON_DESC    VARCHAR2,
   V_TIPO_FACT             VARCHAR2,
   V_TARGET                VARCHAR2,
   V_COMENTARIOS           VARCHAR2,
   V_USUARIO_ORDUNI        VARCHAR2,
   V_ARRAYS_SIZE           VARCHAR2,
   V_LINEA                 ARRAY_TVCH2,
   V_STNID                 ARRAY_TVCH2,
   V_FECHA_INICIO          ARRAY_TVCH2,
   V_FECHA_FIN             ARRAY_TVCH2,
   V_DURACION              ARRAY_TVCH2,
   V_BUYUNTID              ARRAY_TVCH2,
   V_HORA_INICIO           ARRAY_TVCH2,
   V_HORA_FIN              ARRAY_TVCH2,
   V_SPOTS                 ARRAY_TVCH2,
   V_LUNES                 ARRAY_TVCH2,
   V_MARTES                ARRAY_TVCH2,
   V_MIERCOLES             ARRAY_TVCH2,
   V_JUEVES                ARRAY_TVCH2,
   V_VIERNES               ARRAY_TVCH2,
   V_SABADO                ARRAY_TVCH2,
   V_DOMINGO               ARRAY_TVCH2,
   V_SPOTS_X_SEMANA        ARRAY_TVCH2,
   V_TIPO_SERVICIO         ARRAY_TVCH2,
   V_BN                    ARRAY_TVCH2,
   V_P_                    ARRAY_TVCH2,
   V_MARCA                 ARRAY_TVCH2,
   V_VERSION_              ARRAY_TVCH2,
   V_TARIFA_SP_SIN_DESC    ARRAY_TVCH2,
   V_TARIFA_SP_CON_DESC    ARRAY_TVCH2,
   V_TOT_LIN_SIN_DESC      ARRAY_TVCH2,
   V_TOT_LIN_CON_DESC      ARRAY_TVCH2,
   V_SOBRECARGO            ARRAY_TVCH2,
   V_OBSERVACIONES         ARRAY_TVCH2,
   V_ID_TARIFA             VARCHAR2
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   limiteLineas   NUMBER;
   theLinea       NUMBER;
   sptChrBd       VARCHAR2(10);
   usrChrBd       VARCHAR2(10);
   lst_advid      XXMOR_SOLICITUDES_ENC_TAB.ADVID%TYPE;
   lst_accthdrid  XXMOR_SOLICITUDES_ENC_TAB.ACCTHDRID%TYPE;
   lst_secnum     XXMOR_SOLICITUDES_ENC_TAB.SECNUM%TYPE;
BEGIN
    lst_secnum := NULL;
    SELECT ADVID,
           ACCTHDRID,
           SECNUM
    INTO   lst_advid,
           lst_accthdrid,
           lst_secnum
    FROM   XXMOR_SOLICITUDES_ENC_TAB
    WHERE  ID_SEG_NEG   = 1
    AND    ID_SOLICITUD = TO_NUMBER(V_ID_SOL);
    IF lst_advid != V_CVE_CLIENTE OR lst_accthdrid != V_CVE_AGENCIA THEN
        SELECT TRIM(CAST(SECNUM AS char(2))) AS secnum
        INTO   lst_secnum
        FROM   PARADB.ACCTHDR@ORDUNIDB2
        WHERE  TRIM(UPPER(ADVID))     = TRIM(UPPER(V_CVE_CLIENTE))
        AND    UPPER(TRIM(ACCTHDRID)) = TRIM(UPPER(V_CVE_AGENCIA));
    END IF;
   -- 1.- Actualzar el encabezado
   UPDATE   XXMOR_SOLICITUDES_ENC_TAB
      SET   PROC_POR_LINEA   = V_PROC_X_LINEA,
            GARANTIZADO      = V_GARANTIZADO,
            ADVID            = V_CVE_CLIENTE,
            MCONTID          = V_MASTER_CONTRACT,
            EMAIL            = V_NOMBRE_EMAIL_RESP,
            AGYESTNUM        = V_REF_FOLIO,
            ACCTHDRID        = V_CVE_AGENCIA,
            RTCRDDSCR        = V_NOMBRE_TARIFA,
            PLATAFORMA_CANAL = V_CANAL_ORD_PLAT,
            PRDID_DESC       = V_CAT_PROD,
            TOTAL_SPOTS      = V_TOTAL_SPOTS,
            TOTAL_SIN_DESC   = V_TOTAL_ORD_SIN_DESC,
            TOTAL_CON_DESC   = V_TOTAL_ORD_CON_DESC,
            TIPO_FACTURACION = V_TIPO_FACT,
            TARGET           = V_TARGET,
            COMENTARIOS      = V_COMENTARIOS,
            SECNUM           = lst_secnum,
            UPDATED_BY       = V_USUARIO_ORDUNI,
            UPDATED_DATE     = SYSDATE,
            RTCRD            = V_ID_TARIFA
    WHERE   ID_SEG_NEG   = 1
    AND     ID_SOLICITUD = TO_NUMBER (V_ID_SOL);
    COMMIT;
   --2.- Actualizar las lineras
   limiteLineas := TO_NUMBER (V_ARRAYS_SIZE);
   FOR i IN 1 .. limiteLineas
   LOOP
      theLinea := TO_NUMBER (V_LINEA (i));
      -- buscar valor de spotChar y usrChar
      sptChrBd := NULL;
      usrChrBd := NULL;
      BEGIN
          SELECT NVL(SPT_CHR,NULL),
                 NVL(USR_CHR,NULL)
          INTO sptChrBd,
               usrChrBd
          FROM   XXMOR_CAT_TIPO_SERV_TAB
          WHERE UPPER(DESC_TIPO_SERVICIO) = UPPER(V_TIPO_SERVICIO(i));
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
            sptChrBd := NULL;
            usrChrBd := NULL;
        WHEN TOO_MANY_ROWS THEN
            sptChrBd := NULL;
            usrChrBd := NULL;
      END;
      UPDATE   XXMOR_SOLICITUDES_DET_TAB
         SET   STNID              = V_STNID (i),
               FECHA_INICIO       = V_FECHA_INICIO (i),
               FECHA_FIN          = V_FECHA_FIN (i),
               DURACION           = V_DURACION (i),
               BUYUNTID           = V_BUYUNTID (i),
               HORA_INICIO        = V_HORA_INICIO (i),
               HORA_FIN           = V_HORA_FIN (i),
               SPOTS              = V_SPOTS (i),
               LUNES              = V_LUNES (i),
               MARTES             = V_MARTES (i),
               MIERCOLES          = V_MIERCOLES (i),
               JUEVES             = V_JUEVES (i),
               VIERNES            = V_VIERNES (i),
               SABADO             = V_SABADO (i),
               DOMINGO            = V_DOMINGO (i),
               SPOTS_X_SEMANA     = V_SPOTS_X_SEMANA (i),
               TIPO_SERVICIO      = V_TIPO_SERVICIO (i),
               USR_CHR            = usrChrBd,
               SPOT_CHR           = TO_NUMBER(sptChrBd),
               BN                 = V_BN (i),
               P                  = V_P_ (i),
               MARCA              = V_MARCA (i),
               VERSION            = V_VERSION_ (i),
               --TARIFASP_SIN_DESC  = V_TARIFA_SP_SIN_DESC (i),
               --TARIFASP_CON_DESC  = V_TARIFA_SP_CON_DESC (i),
               --TOT_LINEA_SIN_DESC = V_TOT_LIN_SIN_DESC (i),
               --TOT_LINEA_CON_DESC = V_TOT_LIN_CON_DESC (i),
               SOBRECARGO         = V_SOBRECARGO (i),
               OBSERVACIONES      = V_OBSERVACIONES (i),
               UPDATED_BY         = V_USUARIO_ORDUNI,
               UPDATED_DATE       = SYSDATE
       WHERE   ID_SOLICITUD = TO_NUMBER (V_ID_SOL)
       AND     LINEA        = theLinea;
      COMMIT;
   END LOOP;
   COMMIT;
END XXMOR_REPROCESAR_ENC_DET_PR;
/
