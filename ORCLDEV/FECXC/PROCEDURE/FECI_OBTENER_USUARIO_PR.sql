CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_OBTENER_USUARIO_PR" 
(
EMAIL IN VARCHAR2
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursors SYS_REFCURSOR;
BEGIN
   open feci_cursors for
        SELECT
         U.ID_USUARIO
         ,U.ID_ROL
         ,U.DES_NOMBRES
         ,U.DES_APELLIDOS
         ,U.DES_EMAIL
         ,R.NOM_ROL
         ,R.COD_ROL
         FROM FECXC.FECI_USUARIO_TAB U
         JOIN FECXC.FECI_ROL_TAB R ON U.ID_ROL = R.ID_ROL
         WHERE U.DES_EMAIL = EMAIL AND U.IND_ESTADO=1;
        DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_OBTENER_USUARIO_PR ;
/
