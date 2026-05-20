CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_OBTENER_USUARIO_LISTA_TODOS_PR" 
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursors SYS_REFCURSOR;
BEGIN
   open feci_cursors for
        SELECT
         USR.ID_USUARIO
         ,USR.ID_ROL
         ,USR.DES_NOMBRES
         ,USR.DES_APELLIDOS
         ,USR.DES_EMAIL
         ,USR.IND_ESTADO
         ,ROL.NOM_ROL
         ,ROL.COD_ROL
         ,ROL.ID_ROL
         FROM FECI_USUARIO_TAB USR
         JOIN FECI_ROL_TAB ROL ON USR.ID_ROL = ROL.ID_ROL;
        DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_OBTENER_USUARIO_LISTA_TODOS_PR ;
/
