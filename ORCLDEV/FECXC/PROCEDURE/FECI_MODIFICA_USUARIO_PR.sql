CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_MODIFICA_USUARIO_PR" 
(
    p_ID_USUARIO    NUMBER,
    p_ID_ROL        NUMBER,
    p_EMAIL         VARCHAR2,
    p_NOMBRES       VARCHAR2,
    p_APELLIDOS     VARCHAR2,
    p_ESTATUS       NUMBER,
    p_USUARIO_ALTA  NUMBER,
    p_ARRAY         VARCHAR2,
    p_RESPUESTA     OUT NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    CONTADOR            NUMBER;
    CONTADOR_EXISTENTE  NUMBER;
BEGIN
    -- Verificar si el usuario existe por el ID
    SELECT COUNT(ID_USUARIO) INTO CONTADOR FROM FECI_USUARIO_TAB WHERE ID_USUARIO = p_ID_USUARIO;
    IF CONTADOR > 0 THEN
        -- Verificar si el correo electr?o ya est?sociado a otro usuario
        SELECT COUNT(ID_USUARIO) INTO CONTADOR_EXISTENTE FROM FECI_USUARIO_TAB
        WHERE ID_USUARIO <> p_ID_USUARIO AND DES_EMAIL = p_EMAIL;
        IF CONTADOR_EXISTENTE > 0 THEN
            -- ERROR: Usuario asociado a otro registro
            p_RESPUESTA := -4;
        ELSE
            -- Actualizar el usuario en FECI_USUARIO_TAB
            UPDATE FECI_USUARIO_TAB
            SET
                ID_ROL = p_ID_ROL,
                DES_EMAIL = p_EMAIL,
                DES_NOMBRES = p_NOMBRES,
                DES_APELLIDOS = p_APELLIDOS,
                FEC_ULT_MODIFICACION = SYSDATE,
                ID_USUARIO_ULT_MODIF = p_USUARIO_ALTA,
                IND_ESTADO = p_ESTATUS
            WHERE
                ID_USUARIO = p_ID_USUARIO;
            -- Desactivar registros existentes en FECI_EMP_USU_TAB
            UPDATE FECI_EMP_USU_TAB
            SET IND_ESTADO = 0,
                ID_USUARIO_ULT_MODIF = p_USUARIO_ALTA,
                FEC_ULT_MODIFICACION = SYSDATE
            WHERE ID_USUARIO = p_ID_USUARIO;
            -- Insertar nuevos registros en FECI_EMP_USU_TAB
            FOR i IN 1..REGEXP_COUNT(p_ARRAY, ',') + 1 LOOP
                INSERT INTO FECI_EMP_USU_TAB
                (
                    ID_USUARIO, ID_EMPRESA, FEC_CREACION, FEC_ULT_MODIFICACION, ID_USUARIO_CREACION, ID_USUARIO_ULT_MODIF, IND_ESTADO
                )
                VALUES
                (
                    p_ID_USUARIO, REGEXP_SUBSTR(p_ARRAY, '[^,]+', 1, i), SYSDATE, SYSDATE, p_USUARIO_ALTA, 0, 1
                );
            END LOOP;
            p_RESPUESTA := p_ID_USUARIO;
        END IF;
    ELSE
        -- ERROR: Usuario inexistente por ID
        p_RESPUESTA := -3;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejar otras excepciones
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        p_RESPUESTA := -1; -- C?o de error personalizado, ajusta seg?n sea necesario
END FECI_MODIFICA_USUARIO_PR;
/
