CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_INSERTA_CONCEPTO_REGION_PR" 
(
    p_CODIGO                VARCHAR2,
    p_DESCRIPCION           VARCHAR2,
    p_REGIONES              VARCHAR2,
    p_USUARIO               NUMBER,
    p_RESPUESTA    OUT      NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    CONTADOR_CLAS        NUMBER := 0;
    CONTADOR_PRES       NUMBER := 0;
    RESPUESTA           NUMBER := 0;
    CONCEPTO_ID         NUMBER := 0;
    VALIDA              NUMBER := 0;
BEGIN
    -- Verificar si el concepto no existe en clasificaciones
    SELECT COUNT(FOLIO_RECIBO) INTO CONTADOR_CLAS FROM FECI_CLASIFICACIONES_VW
    WHERE COD_CONCEPTO = p_CODIGO;
    IF CONTADOR_CLAS = 0 THEN
        -- Verificar si el segmento no existe en presupuestos
        SELECT COUNT(ID_PRESUPUESTO) INTO CONTADOR_PRES FROM FECI_PRESUPUESTO_TAB
        WHERE COD_CONCEPTO = p_CODIGO;
        IF CONTADOR_PRES = 0 THEN
           SELECT COUNT(ID_CONCEPTO) INTO VALIDA FROM FECI_CONCEPTO_CAT
                WHERE COD_CONCEPTO = p_CODIGO AND DES_CONCEPTO = p_DESCRIPCION;
                IF VALIDA = 0 THEN
                    -- Insertar en FECI_CONCEPTO_CAT
                    INSERT INTO FECI_CONCEPTO_CAT
                    (
                        COD_CONCEPTO, DES_CONCEPTO, FEC_CREACION, FEC_ULT_MODIFICACION, ID_USUARIO_CREACION, ID_USUARIO_ULT_MODIF, IND_ESTADO
                    )
                    VALUES
                    (
                        p_CODIGO, p_DESCRIPCION, SYSDATE, SYSDATE, p_USUARIO, 0, 1
                    )
                    RETURNING ID_CONCEPTO INTO CONCEPTO_ID;
                    IF(p_REGIONES <> '') THEN
                        -- Procesar el array
                        FOR i IN 1..REGEXP_COUNT(p_REGIONES, ',') + 1 LOOP
                            BEGIN
                                -- Intentar insertar en FECI_REGN_CONC_CAT
                                INSERT INTO FECI_REGN_CONC_CAT
                                (
                                    ID_REGION, ID_CONCEPTO, FEC_CREACION, FEC_ULT_MODIFICACION, ID_USUARIO_CREACION,
                                    ID_USUARIO_ULT_MODIF, IND_ESTADO
                                )
                                VALUES
                                (
                                    REGEXP_SUBSTR(p_REGIONES, '[^,]+', 1, i),CONCEPTO_ID , SYSDATE, SYSDATE, p_USUARIO, 0, 1
                                );
                            END;
                        END LOOP;
                    END IF;
                    RESPUESTA := CONCEPTO_ID;
                ELSE
                    RESPUESTA := -96; -- YA ESTA REGISTRADO EL CONCEPTO
                END IF;
        ELSE
            RESPUESTA := -98; -- EXISTE EN PRESUPUESTOS
        END IF;
    ELSE
        RESPUESTA := -99; -- EXISTE EN CLASIFICACIONES
    END IF;
    p_RESPUESTA := RESPUESTA;
END FECI_INSERTA_CONCEPTO_REGION_PR;
/
