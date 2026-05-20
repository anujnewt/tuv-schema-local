CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_OBTIENE_CANTIDAD_RECIBOS_CLASIFICADOS_PR" 
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor SYS_REFCURSOR;
BEGIN
    -- Utiliza la variable p_contador para almacenar el conteo
   OPEN feci_cursor FOR
    SELECT COUNT(*) AS CANTIDAD
    FROM FECI_RECIBOS_VW
    WHERE COD_ESTADO_RECIBO = 'CLSF';
    DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_OBTIENE_CANTIDAD_RECIBOS_CLASIFICADOS_PR;
/
