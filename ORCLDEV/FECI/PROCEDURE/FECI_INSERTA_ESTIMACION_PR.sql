CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_INSERTA_ESTIMACION_PR" 
(
        p_ANIO         NUMBER,
        p_MES               NUMBER,
        p_SEMANA              NUMBER,
        p_FORECAST        VARCHAR2,
        p_SEGMENTO               VARCHAR2,
        p_MONTO_MXN               NUMBER ,
        p_MONTO_USD         NUMBER,
        p_USUARIO                NUMBER,
        p_RESPUESTA  OUT NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ID_EST NUMBER;
    CONTADOR NUMBER;
    RESPUESTA    NUMBER;
    CONTADOR_EST    NUMBER;
BEGIN
    SELECT COUNT(ID_SEMANAS_ESTIMACION) INTO CONTADOR FROM FECI_SEMANAS_ESTIMACION_TAB WHERE NUM_ANIO=p_ANIO AND NUM_MES = p_MES;
    IF  CONTADOR > 0 THEN
        SELECT COUNT(ID_ESTIMACION) INTO CONTADOR_EST
        FROM FECI_ESTIMACION_TAB WHERE
        NUM_ANIO = p_ANIO AND NUM_MES = p_MES AND
        NUM_SEMANA = p_SEMANA AND
        COD_GRUPO_FORECAST =   p_FORECAST AND
        COD_SEGMENTO = p_SEGMENTO;
        IF CONTADOR_EST = 0 THEN
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
            RESPUESTA := ID_EST;
        ELSE
            RESPUESTA := -4;
        END IF;
    ELSE
        RESPUESTA := -3;
    END IF;
    p_RESPUESTA := RESPUESTA;
END FECI_INSERTA_ESTIMACION_PR ;
/
