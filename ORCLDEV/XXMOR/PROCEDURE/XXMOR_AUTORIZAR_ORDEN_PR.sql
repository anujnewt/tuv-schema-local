CREATE OR REPLACE EDITIONABLE PROCEDURE "XXMOR"."XXMOR_AUTORIZAR_ORDEN_PR" 
                                 (
                                         ID_SOL    NUMBER,
                                         LNS       ARRAY_TVCH2,
                                         LN_SIZE   NUMBER,
                                         TIPO_AUT  VARCHAR2,
                                         EST       VARCHAR2,
                                         P_USUARIO VARCHAR2
                                 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
AUTS    NUMBER;
ERRS    NUMBER;
RETEN   NUMBER;
BEGIN
    IF (TIPO_AUT = 'REQUEST/ORDEN/ENCABEZADO/CPSMASTERCONTRACT' OR TIPO_AUT = 'CPS') THEN
        UPDATE XXMOR_CONCOM_RPTA_TAB
        SET    ESTATUS_ORDUNI = EST,
               UPDATED_DATE   = SYSDATE,
               UPDATED_BY     = P_USUARIO
        WHERE  ID_SOLICITUD           = ID_SOL
        AND    UPPER(ACCION_CONCOM)   = 'AUTORIZACION'
        AND    UPPER(CAMPO_CONCOM)    = TIPO_AUT
        AND    UPPER(POSICION_CONCOM) = 'ENCABEZADO';
    ELSE
        FOR tLN IN 1..LN_SIZE LOOP
            UPDATE XXMOR_CONCOM_RPTA_TAB
            SET    ESTATUS_ORDUNI = EST,
                   UPDATED_DATE   = SYSDATE,
                   UPDATED_BY     = P_USUARIO
            WHERE  ID_SOLICITUD         = ID_SOL
            AND    UPPER(ACCION_CONCOM) = 'AUTORIZACION'
            AND    UPPER(CAMPO_CONCOM)  = TIPO_AUT
            AND    NUMLINEA_CONCOM      = LNS(tLN);
        END LOOP;
    END IF;
    COMMIT;
END;
/
