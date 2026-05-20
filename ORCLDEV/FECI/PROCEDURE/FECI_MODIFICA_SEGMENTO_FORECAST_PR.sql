CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_MODIFICA_SEGMENTO_FORECAST_PR" 
(
    p_ID_SEGMENTO           NUMBER,
    p_CODIGO                VARCHAR2,
    p_DESCRIPCION           VARCHAR2,
    p_MONEDA                VARCHAR2,
    p_IND_CPS               NUMBER,
    p_IND_PAIS              NUMBER,
    p_GRUPO_FORECAST        VARCHAR2,
    p_USUARIO               NUMBER,
    p_RESPUESTA    OUT      NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    RESPUESTA           NUMBER := 0;
    RESPUESTA_DES       NUMBER := 0;
    VALIDA              NUMBER := 0;
BEGIN
    SELECT COUNT (ID_SEGMENTO) INTO VALIDA  FROM FECI_SEGMENTO_CAT
    WHERE  COD_SEGMENTO = p_CODIGO AND  DES_SEGMENTO = p_DESCRIPCION AND
    ID_SEGMENTO <> p_ID_SEGMENTO ;
    IF VALIDA = 0 THEN
        -- MODIFICA en FECI_SEGMENTO_CAT
        UPDATE FECI_SEGMENTO_CAT SET
        DES_SEGMENTO = p_DESCRIPCION,
        COD_MONEDA = p_MONEDA,
        IND_CPS = p_IND_CPS,
        IND_PAIS = p_IND_PAIS,
        FEC_ULT_MODIFICACION = SYSDATE,
        ID_USUARIO_ULT_MODIF = p_USUARIO
        WHERE ID_SEGMENTO = p_ID_SEGMENTO;
       UPDATE FECI_GRFC_SEGM_CAT SET
        IND_ESTADO = 0,
        FEC_ULT_MODIFICACION = SYSDATE,
        ID_USUARIO_ULT_MODIF = p_USUARIO
        WHERE ID_SEGMENTO = p_ID_SEGMENTO;
       IF p_GRUPO_FORECAST <> ' ' THEN
            -- Procesar el array
            FOR i IN 1..REGEXP_COUNT(p_GRUPO_FORECAST, ',') + 1 LOOP
                BEGIN
                    -- Intentar insertar en FECI_GRFC_SEGM_CAT
                    INSERT INTO FECI_GRFC_SEGM_CAT
                    (
                        ID_SEGMENTO, ID_GRUPO_FORECAST, FEC_CREACION, FEC_ULT_MODIFICACION, ID_USUARIO_CREACION,
                        ID_USUARIO_ULT_MODIF, IND_ESTADO
                    )
                    VALUES
                    (
                        p_ID_SEGMENTO, REGEXP_SUBSTR(p_GRUPO_FORECAST, '[^,]+', 1, i), SYSDATE, SYSDATE, p_USUARIO, 0, 1
                    );
                END;
            END LOOP;
       END IF;
        RESPUESTA := p_ID_SEGMENTO;
    ELSE
        RESPUESTA := -96; -- EXISTE EN OTRO ID
    END IF;
    p_RESPUESTA := RESPUESTA;
END FECI_MODIFICA_SEGMENTO_FORECAST_PR;
/
