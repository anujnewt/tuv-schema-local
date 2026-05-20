CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_OBTENER_OPERACIONES_PR" 
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor SYS_REFCURSOR;
BEGIN
   open feci_cursor for
        SELECT
        ID_OPERACION,
        DES_AGRUPADOR,
        COD_OPERACION,
        DES_NOMBRE,
        DES_NOMBRE,
        COD_TIPO_OPERACION
        FROM feci_Operacion_tab WHERE IND_ESTADO =1 ;
    DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_OBTENER_OPERACIONES_PR  ;
/
