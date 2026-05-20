CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_INSERTA_SEGMENTO_FORECAST_PR" 
(
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
    CONTADOR_SEG        NUMBER := 0;
    CONTADOR_PRES       NUMBER := 0;
    CONTADOR_EST        NUMBER := 0;
    RESPUESTA           NUMBER := 0;
    SEGMENTO_ID         NUMBER := 0;
    VALIDA              NUMBER := 0;
BEGIN
    -- Verificar si el segmento no existe en clasificaciones
    SELECT COUNT(FOLIO_RECIBO) INTO CONTADOR_SEG FROM FECI_CLASIFICACIONES_VW
    WHERE COD_SEGMENTO = p_CODIGO;
    IF CONTADOR_SEG = 0 THEN
        -- Verificar si el segmento no existe en presupuestos
        SELECT COUNT(ID_PRESUPUESTO) INTO CONTADOR_PRES FROM FECI_PRESUPUESTO_TAB
        WHERE COD_SEGMENTO = p_CODIGO;
        IF CONTADOR_PRES = 0 THEN
            -- Verificar si el segmento no existe en ESTIMACIONES
            SELECT COUNT(ID_ESTIMACION) INTO CONTADOR_EST FROM FECI_ESTIMACION_TAB
            WHERE COD_SEGMENTO = p_CODIGO;
            IF CONTADOR_EST = 0 THEN
                SELECT COUNT(ID_SEGMENTO) INTO VALIDA FROM FECI_SEGMENTO_CAT
                WHERE COD_SEGMENTO = p_CODIGO AND DES_SEGMENTO = p_DESCRIPCION;
                IF VALIDA = 0 THEN
                    -- Insertar en FECI_SEGMENTO_CAT
                    INSERT INTO FECI_SEGMENTO_CAT
                    (
                        COD_SEGMENTO, DES_SEGMENTO, COD_MONEDA, IND_CPS,IND_PAIS, FEC_CREACION, FEC_ULT_MODIFICACION, ID_USUARIO_CREACION, ID_USUARIO_ULT_MODIF, IND_ESTADO
                    )
                    VALUES
                    (
                        p_CODIGO, p_DESCRIPCION, p_MONEDA, p_IND_CPS, p_IND_PAIS,SYSDATE, SYSDATE, p_USUARIO, 0, 1
                    )
                    RETURNING ID_SEGMENTO INTO SEGMENTO_ID;
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
                                SEGMENTO_ID, REGEXP_SUBSTR(p_GRUPO_FORECAST, '[^,]+', 1, i), SYSDATE, SYSDATE, p_USUARIO, 0, 1
                            );
                        EXCEPTION
                            WHEN OTHERS THEN
                                NULL; -- Puedes manejar la excepci?eg?n tus necesidades
                        END;
                    END LOOP;
                    RESPUESTA := SEGMENTO_ID;
                ELSE
                    RESPUESTA := -96; -- YA ESTA REGISTRADO EL SEGMENTO
                END IF;
            ELSE
                RESPUESTA := -97; -- EXISTE EN ESTIMACIONES
            END IF;
        ELSE
            RESPUESTA := -98; -- EXISTE EN PRESUPUESTOS
        END IF;
    ELSE
        RESPUESTA := -99; -- EXISTE EN CLASIFICACIONES
    END IF;
    p_RESPUESTA := RESPUESTA;
END FECI_INSERTA_SEGMENTO_FORECAST_PR;
/
