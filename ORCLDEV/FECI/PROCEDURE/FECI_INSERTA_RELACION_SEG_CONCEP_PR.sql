CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_INSERTA_RELACION_SEG_CONCEP_PR" 
(
    p_ID_SEGMENTO           NUMBER,
    p_FORECAST                NUMBER,
    p_CONCEPTOS        VARCHAR2,
    p_USUARIO               NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
        UPDATE FECI_SEGM_CONC_CAT SET
        IND_ESTADO = 0
        WHERE  ID_SEGMENTO =  p_ID_SEGMENTO
        AND ID_GRUPO_FORECAST = p_FORECAST;
        -- Procesar el array
        FOR i IN 1..REGEXP_COUNT(p_CONCEPTOS, ',') + 1 LOOP
            BEGIN
                -- Intentar insertar en FECI_GRFC_SEGM_CAT
                INSERT INTO FECI_SEGM_CONC_CAT
                (
                    ID_SEGMENTO, ID_GRUPO_FORECAST, ID_CONCEPTO,FEC_CREACION, FEC_ULT_MODIFICACION, ID_USUARIO_CREACION,
                    ID_USUARIO_ULT_MODIF, IND_ESTADO
                )
                VALUES
                (
                    p_ID_SEGMENTO,p_FORECAST, REGEXP_SUBSTR(p_CONCEPTOS, '[^,]+', 1, i), SYSDATE, SYSDATE, p_USUARIO, 0, 1
                );
            END;
        END LOOP;
END FECI_INSERTA_RELACION_SEG_CONCEP_PR;
/
