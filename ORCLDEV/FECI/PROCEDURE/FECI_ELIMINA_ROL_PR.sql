CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_ELIMINA_ROL_PR" 
(
        p_ID         NUMBER,
        p_USUARIO        NUMBER
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
        feci_cursors SYS_REFCURSOR;
BEGIN
        UPDATE FECI_ROL_TAB ROL
        SET ROL.IND_ESTADO = 0,
            ROL.ID_USUARIO_ULT_MODIF = p_USUARIO,
            FEC_ULT_MODIFICACION = SYSDATE
        WHERE ROL.ID_ROL = p_ID
        AND NOT EXISTS (
            SELECT 1
            FROM FECI_USUARIO_TAB USR
            WHERE USR.ID_ROL = ROL.ID_ROL
        ) ;
        open feci_cursors for
               SELECT ID_ROL FROM FECI_USUARIO_TAB WHERE ID_ROL =  p_ID;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_ELIMINA_ROL_PR;
/
