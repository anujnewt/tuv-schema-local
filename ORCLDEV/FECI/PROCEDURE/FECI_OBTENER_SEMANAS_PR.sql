CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_OBTENER_SEMANAS_PR" 
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
            SELECT
           ID_SEMANAS_ESTIMACION ,
            NUM_ANIO ,
            NUM_MES,
            FEC_INICIO_SEMANA_1,
            FEC_FIN_SEMANA_1,
            FEC_INICIO_SEMANA_2,
            FEC_FIN_SEMANA_2,
            FEC_INICIO_SEMANA_3,
            FEC_FIN_SEMANA_3,
            FEC_INICIO_SEMANA_4,
            FEC_FIN_SEMANA_4,
            FEC_INICIO_SEMANA_5,
            FEC_FIN_SEMANA_5
            FROM FECI_SEMANAS_ESTIMACION_TAB
            WHERE NUM_ANIO = p_ANIO AND NUM_MES = p_MES;
       DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_OBTENER_SEMANAS_PR ;
/
