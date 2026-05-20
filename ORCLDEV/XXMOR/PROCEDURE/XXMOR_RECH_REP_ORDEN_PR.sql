CREATE OR REPLACE EDITIONABLE PROCEDURE "XXMOR"."XXMOR_RECH_REP_ORDEN_PR" 
                                 (
                                         ID_SOL   NUMBER,
                                         LNS      ARRAY_TVCH2,
                                         LN_SIZE  NUMBER,
                                         EST      VARCHAR2,
                                         USUARIO  VARCHAR2,
                                         MOTIVO   VARCHAR2
                                 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
TOT_LINEAS         NUMBER;
V_DISTINCT_STATUS  NUMBER;
V_LN_STATUS_46     VARCHAR2(2);
BEGIN
    IF (EST = '46') THEN
        /*
        SELECT COUNT(LINEA)
        INTO   TOT_LINEAS
        FROM   XXMOR_SOLICITUDES_DET_TAB
        WHERE  ID_SOLICITUD = ID_SOL;
        IF (TOT_LINEAS = LN_SIZE) THEN
            INSERT INTO XXMOR_CONCOM_RPTA_TAB
                   (
                           ID_SOLICITUD,
                           ID_SEG_NEG,
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
                           CREATED_DATE,
                           CREATED_BY
                   )
            VALUES
                   (
                           ID_SOL,
                           1,
                           XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                           NULL,
                           XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                           NULL,
                           'LINEA',
                           NULL,
                           NULL,
                           'ERROR',
                           MOTIVO,
                           'RECHAZO - La l?a fue rechazada manualmente',
                           'RECHAZO',
                           NULL,
                           10,
                           SYSDATE,
                           USUARIO
                   );
            COMMIT;
        END IF;
        */
        FOR tLN IN 1..LN_SIZE LOOP
            INSERT INTO XXMOR_CONCOM_RPTA_TAB
                   (
                           ID_SOLICITUD,
                           ID_SEG_NEG,
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
                           CREATED_DATE,
                           CREATED_BY
                   )
            VALUES
                   (
                           ID_SOL,
                           1,
                           XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                           NULL,
                           XXMOR_ID_RPTA_CONCOM_SQ.NEXTVAL,
                           NULL,
                           'LINEA',
                           NULL,
                           LNS(tLN),
                           'ERROR',
                           MOTIVO,
                           'RECHAZO - La l?a fue rechazada manualmente',
                           'RECHAZO',
                           NULL,
                           10,
                           SYSDATE,
                           USUARIO
                   );
            IF SQL%FOUND THEN
                -- se actualiza el estatus de los registros para la misma linea
                -- rechazada que se hayan generado por autorizaci? reproceso
                UPDATE XXMOR_CONCOM_RPTA_TAB
                SET    ESTATUS_ORDUNI = '20',
                       UPDATED_BY     = 'ORDUNI',
                       UPDATED_DATE   = SYSDATE
                WHERE  ID_SOLICITUD           = ID_SOL
                AND    NUMLINEA_CONCOM        = LNS(tLN)
                AND    ESTATUS_ORDUNI         = '10'
                AND    UPPER(POSICION_CONCOM) = 'LINEA'
                AND    UPPER(ACCION_CONCOM)   IN ('AUTORIZACION','REPROCESO');
                COMMIT;
            END IF;
        END LOOP;
        -- Verificar si todas las lineas estan rechazadas
        SELECT COUNT(*)
        INTO   V_DISTINCT_STATUS
        FROM   (SELECT DISTINCT LINEA_ESTATUS
                FROM   XXMOR_SOLICITUDES_DET_TAB
                WHERE  ID_SOLICITUD = ID_SOL
               );
        IF (V_DISTINCT_STATUS = 1) THEN
            SELECT DISTINCT LINEA_ESTATUS
            INTO   V_LN_STATUS_46
            FROM   XXMOR_SOLICITUDES_DET_TAB
            WHERE  ID_SOLICITUD = ID_SOL;
            IF (V_LN_STATUS_46 = '46') THEN
                UPDATE XXMOR_SOLICITUDES_ENC_TAB
                SET    ORDEN_ESTATUS = 45   --,UPDATED_DATE = SYSDATE, UPDATED_BY = 'SOL_ESTATUS_PR'
                WHERE  ID_SOLICITUD  = ID_SOL
                AND    ORDEN_ESTATUS NOT IN (36);
                -- COMMIT;
                UPDATE XXMOR_SOLICITUDES_EST_REP_TAB
                SET    ESTAT_REP    = '0'
                WHERE  ID_SOLICITUD = ID_SOL
                AND    ESTAT_REP    = '2';
                -- COMMIT;
                UPDATE  XXMOR_CONCOM_RPTA_TAB
                SET     ESTATUS_ORDUNI   = '10',
                        ACCION_CONCOM    = 'RECHAZO'
                WHERE   ID_SOLICITUD     = ID_SOL
                AND     NUMLINEA_CONCOM  IS NULL;
                COMMIT;
                -- SELECT ORDEN_ESTATUS FROM XXMOR_SOLICITUDES_ENC_TAB
                -- WHERE  id_solicitud  = :ID_SOL
            END IF;
        END IF;
    ELSE -- EST != '46'
        IF (LN_SIZE = 0) THEN
            UPDATE XXMOR_CONCOM_RPTA_TAB
            SET    ESTATUS_ORDUNI = '20',
                   UPDATED_BY     = USUARIO,
                   UPDATED_DATE   = SYSDATE
            WHERE  ID_SOLICITUD         = ID_SOL
            AND    ESTATUS_ORDUNI       = '10'
            AND    UPPER(ACCION_CONCOM) IN ('REENVIO','REPROCESO');
            -- AND    UPPER(ACCION_CONCOM) = 'REPROCESO'; -- SE CAMBIO PARA QUE LOS REENVIOS TAMBIEN FUNCIONEN
            UPDATE XXMOR_SOLICITUDES_ENC_TAB
            SET    ORDEN_ESTATUS = EST
            WHERE  ID_SOLICITUD  = ID_SOL;
            COMMIT;
        ELSE
            FOR tLN IN 1..LN_SIZE LOOP
                UPDATE XXMOR_CONCOM_RPTA_TAB
                SET    ESTATUS_ORDUNI = '20',
                       UPDATED_BY     = USUARIO,
                       UPDATED_DATE   = SYSDATE
                WHERE  ID_SOLICITUD         = ID_SOL
                AND    NUMLINEA_CONCOM      = LNS(tLN)
                AND    ESTATUS_ORDUNI       = '10'
                AND    UPPER(ACCION_CONCOM) IN ('REENVIO','REPROCESO');
                -- AND    UPPER(ACCION_CONCOM) = 'REPROCESO'; -- SE CAMBIO PARA QUE LOS REENVIOS TAMBIEN FUNCIONEN
                UPDATE XXMOR_SOLICITUDES_DET_TAB
                SET    LINEA_ESTATUS = EST
                WHERE  ID_SOLICITUD  = ID_SOL
                AND    LINEA         = LNS(tLN);
                COMMIT;
            END LOOP;
            UPDATE XXMOR_CONCOM_RPTA_TAB
            SET    ESTATUS_ORDUNI = '20',
                   UPDATED_BY     = USUARIO,
                   UPDATED_DATE   = SYSDATE
            WHERE  ID_SOLICITUD         = ID_SOL
            AND    NUMLINEA_CONCOM      IS NULL
            AND    ESTATUS_ORDUNI       = '10'
            AND    UPPER(ACCION_CONCOM) IN ('REENVIO','REPROCESO');
            -- AND    UPPER(ACCION_CONCOM) = 'REPROCESO'; -- SE CAMBIO PARA QUE LOS REENVIOS TAMBIEN FUNCIONEN
            COMMIT;
        END IF;
    END IF;
    -- COMMIT;
END;
/
