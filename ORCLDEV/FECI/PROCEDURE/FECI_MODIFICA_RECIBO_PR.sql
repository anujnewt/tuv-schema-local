CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_MODIFICA_RECIBO_PR" (
    p_COD_ESTADO_RECIBO VARCHAR2,
    p_ID_USUARIO NUMBER,
    p_FOLIO_RECIBO VARCHAR2,
    p_TIPO_RECIBO VARCHAR2
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
    CASE p_TIPO_RECIBO
        WHEN 'BATCH' THEN
            CASE p_COD_ESTADO_RECIBO
                WHEN 'PEND' THEN
                    UPDATE FECI_RECIBO_TAB
                    SET
                        ID_USUARIO_CLASIFICACION = p_ID_USUARIO,
                        COD_ESTADO_RECIBO = 'CLSF',
                        FEC_CLASIFICACION = SYSDATE,
                        FEC_ULT_MODIFICACION = SYSDATE
                    WHERE FOLIO_RECIBO = p_FOLIO_RECIBO;
                WHEN 'CLSF' THEN
                    UPDATE FECI_RECIBO_TAB
                    SET
                        ID_USUARIO_CLASIFICACION = p_ID_USUARIO,
                        FEC_CLASIFICACION = SYSDATE,
                        FEC_ULT_MODIFICACION = SYSDATE
                    WHERE FOLIO_RECIBO = p_FOLIO_RECIBO;
                WHEN 'APLC' THEN
                    UPDATE FECI_RECIBO_TAB
                    SET
                        ID_USUARIO_CLASIFICACION = p_ID_USUARIO,
                        FEC_CLASIFICACION = SYSDATE,
                        FEC_ULT_MODIFICACION = SYSDATE
                    WHERE FOLIO_RECIBO = p_FOLIO_RECIBO;
            END CASE;
        WHEN 'MANUAL' THEN
            CASE p_COD_ESTADO_RECIBO
                WHEN 'PEND' THEN
                    UPDATE FECI_RECIBO_MANUAL_TAB
                    SET
                        ID_USUARIO_CLASIFICACION = p_ID_USUARIO,
                        COD_ESTADO_RECIBO = 'CLSF',
                        FEC_CLASIFICACION = SYSDATE,
                        FEC_ULT_MODIFICACION = SYSDATE
                    WHERE FOLIO_RECIBO_MANUAL = p_FOLIO_RECIBO;
                WHEN 'CLSF' THEN
                    UPDATE FECI_RECIBO_MANUAL_TAB
                    SET
                        ID_USUARIO_CLASIFICACION = p_ID_USUARIO,
                        FEC_CLASIFICACION = SYSDATE,
                        FEC_ULT_MODIFICACION = SYSDATE
                    WHERE FOLIO_RECIBO_MANUAL = p_FOLIO_RECIBO;
                WHEN 'APLC' THEN
                    UPDATE FECI_RECIBO_MANUAL_TAB
                    SET
                        ID_USUARIO_CLASIFICACION = p_ID_USUARIO,
                        FEC_CLASIFICACION = SYSDATE,
                        FEC_ULT_MODIFICACION = SYSDATE
                    WHERE FOLIO_RECIBO_MANUAL = p_FOLIO_RECIBO;
            END CASE;
    END CASE;
    UPDATE FECI_CLASIFICACION_TAB
    SET IND_ESTADO = 0,
    FEC_ULT_MODIFICACION = SYSDATE,
    ID_USUARIO_ULT_MODIF = p_ID_USUARIO
    WHERE FOLIO_RECIBO = p_FOLIO_RECIBO
    AND TIPO_RECIBO = p_TIPO_RECIBO
    AND IND_ESTADO = 1;
END FECI_MODIFICA_RECIBO_PR;
/
