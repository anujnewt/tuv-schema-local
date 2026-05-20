CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_OBTENER_ACUMULADO_ESTIMACION_PR" 
(
        p_ANIO         NUMBER,
        p_MES        NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor SYS_REFCURSOR;
BEGIN
       OPEN feci_cursor FOR
            SELECT SUM(NUM_IMPORTE_MXN) AS ACUMULADO_MXN ,SUM(NUM_IMPORTE_USD) AS ACUMULADO_USD
            FROM FECI_Estimacion_tab
            WHERE NUM_ANIO = p_ANIO AND NUM_MES = p_MES;
       DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_OBTENER_ACUMULADO_ESTIMACION_PR ;
/
