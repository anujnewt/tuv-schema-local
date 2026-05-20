CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_INSERTA_ROL_PR" 
(
    p_COD_ROL         VARCHAR2,
    p_DES_ROL          VARCHAR2,
    p_USUARIO_CREACION   NUMBER,
    p_OPERACIONES          VARCHAR2,
    p_RESPUESTA  OUT NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    CONTADOR        NUMBER;
   ROL_ID       NUMBER;
   RESPUESTA    NUMBER;
BEGIN
    -- Verificar si el usuario ya existe
    SELECT COUNT(ID_ROL) INTO CONTADOR FROM FECI_ROL_TAB WHERE COD_ROL = p_COD_ROL AND NOM_ROL = p_DES_ROL;
    IF CONTADOR = 0 THEN
        -- Realizar INSERT de usuario
            INSERT INTO FECI_ROL_TAB
            (
                COD_ROL, NOM_ROL, FEC_CREACION, FEC_ULT_MODIFICACION, ID_USUARIO_CREACION, ID_USUARIO_ULT_MODIF, IND_ESTADO
            )
            VALUES
            (
                p_COD_ROL, p_DES_ROL,SYSDATE, SYSDATE, p_USUARIO_CREACION, 0, 1
            )
            RETURNING ID_ROL INTO ROL_ID;
            -- Procesar el array
            FOR i IN 1..REGEXP_COUNT(p_OPERACIONES, ',') + 1 LOOP
                BEGIN
                    -- Intentar insertar en FECI_EMP_USU_TAB
                    INSERT INTO FECI_ROL_OPERACION_TAB
                    (
                        ID_ROL, ID_OPERACION, FEC_CREACION, FEC_ULT_MODIFICACION, ID_USUARIO_CREACION, ID_USUARIO_ULT_MODIF, IND_ESTADO
                    )
                    VALUES
                    (
                        ROL_ID, REGEXP_SUBSTR(p_OPERACIONES, '[^,]+', 1, i), SYSDATE, SYSDATE, p_USUARIO_CREACION, 0, 1
                    );
                END;
                RESPUESTA := ROL_ID;
            END LOOP;
    ELSE
        RESPUESTA := -3;
    END IF;
        p_RESPUESTA := RESPUESTA;
END FECI_INSERTA_ROL_PR;
/
