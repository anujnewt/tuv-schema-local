CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_MODIFICA_CONCEPTO_REGION_PR" 
(
    p_ID_CONCEPTO             NUMBER,
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
    SELECT COUNT(ID_CONCEPTO) INTO VALIDA FROM FECI_CONCEPTO_CAT
    WHERE  DES_CONCEPTO = p_DESCRIPCION AND ID_CONCEPTO <>  p_ID_CONCEPTO;
    IF VALIDA = 0 THEN
        -- Insertar en FECI_CONCEPTO_CAT
        UPDATE  FECI_CONCEPTO_CAT SET
        DES_CONCEPTO = p_DESCRIPCION,
        FEC_ULT_MODIFICACION = SYSDATE,
        ID_USUARIO_ULT_MODIF = p_USUARIO
        WHERE  ID_CONCEPTO = p_ID_CONCEPTO
        RETURNING ID_CONCEPTO INTO CONCEPTO_ID;
       UPDATE  FECI_REGN_CONC_CAT SET
        IND_ESTADO = 0
        WHERE ID_CONCEPTO = CONCEPTO_ID;
        -- Procesar el array
        IF p_REGIONES <> ' ' THEN
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
        RESPUESTA := -96; -- YA ESTA REGISTRADA LA DESCRIPCION EL CONCEPTO
    END IF;
    p_RESPUESTA := RESPUESTA;
END FECI_MODIFICA_CONCEPTO_REGION_PR;
/
