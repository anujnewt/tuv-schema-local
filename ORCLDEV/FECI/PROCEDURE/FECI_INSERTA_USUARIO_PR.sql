CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_INSERTA_USUARIO_PR" 
(
    p_ID_ROL         NUMBER,
    p_EMAIL          VARCHAR2,
    p_NOMBRES        VARCHAR2,
    p_APELLIDOS      VARCHAR2,
    p_ESTATUS        NUMBER,
    p_USUARIO_ALTA   NUMBER,
    p_Array          VARCHAR2,
    p_ID_USUARIO  OUT NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    CONTADOR        NUMBER;
    ID_USUARIO      NUMBER;
    -- Definir una excepci?ersonalizada para el caso de usuario existente
    EXISTE_USUARIO EXCEPTION;
    -- Definir una excepci?ara controlar el rollback
    ROLLBACK_EXCEPTION EXCEPTION;
    PRAGMA EXCEPTION_INIT(ROLLBACK_EXCEPTION, -20001); -- C?o de error de rollback
BEGIN
    -- Verificar si el usuario ya existe
    SELECT COUNT(ID_USUARIO) INTO CONTADOR FROM FECI_USUARIO_TAB WHERE DES_EMAIL = p_EMAIL;
    IF CONTADOR = 0 THEN
        -- Realizar INSERT de usuario
        BEGIN
            INSERT INTO FECI_USUARIO_TAB
            (
                ID_ROL, DES_EMAIL, DES_NOMBRES, DES_APELLIDOS, FEC_CREACION, FEC_ULT_MODIFICACION, ID_USUARIO_CREACION, ID_USUARIO_ULT_MODIF, IND_ESTADO
            )
            VALUES
            (
                p_ID_ROL, p_EMAIL, p_NOMBRES, p_APELLIDOS, SYSDATE, SYSDATE, p_USUARIO_ALTA, 0, p_ESTATUS
            )
            RETURNING ID_USUARIO INTO ID_USUARIO;
            DBMS_OUTPUT.PUT_LINE('SE REGISTRA EL USUARIO.');
            -- Procesar el array
            FOR i IN 1..REGEXP_COUNT(p_Array, ',') + 1 LOOP
                BEGIN
                    -- Intentar insertar en FECI_EMP_USU_TAB
                    INSERT INTO FECI_EMP_USU_TAB
                    (
                        ID_USUARIO, ID_EMPRESA, FEC_CREACION, FEC_ULT_MODIFICACION, ID_USUARIO_CREACION, ID_USUARIO_ULT_MODIF, IND_ESTADO
                    )
                    VALUES
                    (
                        ID_USUARIO, REGEXP_SUBSTR(p_Array, '[^,]+', 1, i), SYSDATE, SYSDATE, p_USUARIO_ALTA, 0, 1
                    );
                EXCEPTION
                    WHEN OTHERS THEN
                        p_ID_USUARIO := -5;
                        -- Manejar la excepci?e inserci?n FECI_EMP_USU_TAB
                        DBMS_OUTPUT.PUT_LINE('Error al insertar en FECI_EMP_USU_TAB: ' || SQLERRM);
                        -- Hacer rollback
                        RAISE ROLLBACK_EXCEPTION;
                END;
            END LOOP;
        EXCEPTION
            WHEN ROLLBACK_EXCEPTION THEN
                -- Hacer rollback si se levanta la excepci?e rollback
                DBMS_OUTPUT.PUT_LINE('Rollback ejecutado debido a un error.');
                ROLLBACK;
                RAISE; -- Re-levantar la excepci?ara propagarla
        END;
    ELSE
        -- Regresar un error controlado de que el usuario ya existe
        -- Aqu?eber? manejar el error, lanzar una excepci?etc.
        DBMS_OUTPUT.PUT_LINE('Error: El usuario ya existe.');
        p_ID_USUARIO := -3;
        RAISE EXISTE_USUARIO;
    END IF;
    -- Asignar el ID_USUARIO al par?tro de salida
    p_ID_USUARIO := ID_USUARIO;
EXCEPTION
    WHEN EXISTE_USUARIO THEN
        -- Puedes manejar la excepci?spec?ca aqu?i es necesario
        DBMS_OUTPUT.PUT_LINE('Manejo de excepci?Usuario ya existe.');
    WHEN ROLLBACK_EXCEPTION THEN
        -- Puedes manejar la excepci?e rollback aqu?i es necesario
        DBMS_OUTPUT.PUT_LINE('Manejo de excepci?Rollback ejecutado.');
    WHEN OTHERS THEN
        -- Manejar otras excepciones fuera del bloque BEGIN
        DBMS_OUTPUT.PUT_LINE('Error general: ' || SQLERRM);
        -- Puedes decidir hacer un rollback o realizar otras acciones seg?n tus necesidades
        RAISE;
END FECI_INSERTA_USUARIO_PR;
/
