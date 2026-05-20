CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_OBTIENE_CANTIDAD_RECIBOS_CLASIFICADOS_PR" 
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor SYS_REFCURSOR;
BEGIN
    -- Utiliza la variable p_contador para almacenar el conteo
   OPEN feci_cursor FOR
    SELECT COUNT(*) AS CANTIDAD
    FROM FECXC.FECI_RECIBOS_VW
    WHERE COD_ESTADO_RECIBO = 'CLSF';
    DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_OBTIENE_CANTIDAD_RECIBOS_CLASIFICADOS_PR;
/
