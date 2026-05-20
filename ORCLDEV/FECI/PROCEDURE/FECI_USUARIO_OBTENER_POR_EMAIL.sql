CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_USUARIO_OBTENER_POR_EMAIL" 
(
EMAIL IN VARCHAR2
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor SYS_REFCURSOR;
ROLID NUMBER;
BEGIN
    SELECT ID_ROL INTO ROLID FROM feci_usuario_tab WHERE des_email = email;
    open feci_cursor for
        SELECT  ID_OPERACION  ,DES_AGRUPADOR,COD_OPERACION,DES_NOMBRE,COD_TIPO_OPERACION
        FROM feci_Operacion_tab
        WHERE IND_ESTADO = 1 and id_operacion in(SELECT id_operacion FROM feci_Rol_Operacion_tab where id_rol = ROLID and IND_ESTADO = 1) ;
    dbms_sql.return_result(feci_cursor);
END;
/
