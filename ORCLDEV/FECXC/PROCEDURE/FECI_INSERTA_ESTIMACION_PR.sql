CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_INSERTA_ESTIMACION_PR" 
(
        p_ANIO         NUMBER,
        p_MES               NUMBER,
        p_SEMANA              NUMBER,
        p_FORECAST        VARCHAR2,
        p_SEGMENTO               VARCHAR2,
        p_MONTO_MXN               NUMBER ,
        p_MONTO_USD         NUMBER,
        p_USUARIO                NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ID_EST NUMBER;
    feci_cursors SYS_REFCURSOR;
BEGIN
            INSERT INTO FECI_ESTIMACION_TAB
            (COD_GRUPO_FORECAST,COD_SEGMENTO,NUM_ANIO,NUM_MES,NUM_SEMANA,NUM_IMPORTE_MXN,NUM_IMPORTE_USD
            ,FEC_CREACION,FEC_ULT_MODIFICACION,ID_USUARIO_CREACION,ID_USUARIO_ULT_MODIF,IND_ESTADO)
            VALUES (
            p_FORECAST,
            p_SEGMENTO,
            p_ANIO,
            p_MES,
            p_SEMANA,
            p_MONTO_MXN,
            p_MONTO_USD,
            SYSDATE,
            SYSDATE,
            p_USUARIO,
            0,
            1
            ) returning ID_ESTIMACION INTO ID_EST;
open feci_cursors for
               SELECT ID_ESTIMACION FROM FECI_ESTIMACION_TAB WHERE ID_ESTIMACION =  ID_EST;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_INSERTA_ESTIMACION_PR ;
/
