CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_MODIFICA_ROL_PR" 
(
    p_ID_ROL         NUMBER,
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
    RESPUESTA    NUMBER;
BEGIN
    -- Verificar si el usuario ya existe
    SELECT COUNT(ID_ROL) INTO CONTADOR FROM FECI_ROL_TAB WHERE ID_ROL = p_ID_ROL ;
    IF CONTADOR = 0 THEN
        RESPUESTA := -3;
    ELSE
        -- Realizar INSERT de usuario
            UPDATE FECI_ROL_OPERACION_TAB SET
            IND_ESTADO = 0 ,
            FEC_ULT_MODIFICACION = SYSDATE,
            ID_USUARIO_ULT_MODIF = p_USUARIO_CREACION
            WHERE ID_ROL = p_ID_ROL;
            UPDATE FECI_ROL_TAB
            SET
            COD_ROL = p_COD_ROL,
            NOM_ROL = p_DES_ROL,
            FEC_ULT_MODIFICACION = SYSDATE,
            ID_USUARIO_ULT_MODIF = p_USUARIO_CREACION
            WHERE ID_ROL = p_ID_ROL;
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
                        p_ID_ROL, REGEXP_SUBSTR(p_OPERACIONES, '[^,]+', 1, i), SYSDATE, SYSDATE, p_USUARIO_CREACION, 0, 1
                    );
                END;
                RESPUESTA := p_ID_ROL;
            END LOOP;
    END IF;
        p_RESPUESTA := RESPUESTA;
END FECI_MODIFICA_ROL_PR;
/
