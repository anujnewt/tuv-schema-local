CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_MODIFICA_CONFI_SEMANAS_PR" 
(
        p_ID                     NUMBER,
        p_ANIO                   NUMBER,
        p_MES                    NUMBER,
        p_FECHA_INICIO_SEM_1     DATE,
        p_FECHA_FIN_SEM_1        DATE,
        p_FECHA_INICIO_SEM_2     DATE,
        p_FECHA_FIN_SEM_2        DATE,
        p_FECHA_INICIO_SEM_3     DATE,
        p_FECHA_FIN_SEM_3        DATE,
        p_FECHA_INICIO_SEM_4     DATE,
        p_FECHA_FIN_SEM_4        DATE,
        p_FECHA_INICIO_SEM_5     DATE,
        p_FECHA_FIN_SEM_5        DATE,
        p_USUARIO                NUMBER
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
    UPDATE FECI_SEMANAS_ESTIMACION_TAB
    SET
        FEC_INICIO_SEMANA_1 = TO_DATE(TO_CHAR(p_FECHA_INICIO_SEM_1, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        FEC_FIN_SEMANA_1 = TO_DATE(TO_CHAR(p_FECHA_FIN_SEM_1, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        FEC_INICIO_SEMANA_2 = TO_DATE(TO_CHAR(p_FECHA_INICIO_SEM_2, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        FEC_FIN_SEMANA_2 = TO_DATE(TO_CHAR(p_FECHA_FIN_SEM_2, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        FEC_INICIO_SEMANA_3 = TO_DATE(TO_CHAR(p_FECHA_INICIO_SEM_3, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        FEC_FIN_SEMANA_3 = TO_DATE(TO_CHAR(p_FECHA_FIN_SEM_3, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        FEC_INICIO_SEMANA_4 = TO_DATE(TO_CHAR(p_FECHA_INICIO_SEM_4, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        FEC_FIN_SEMANA_4 = TO_DATE(TO_CHAR(p_FECHA_FIN_SEM_4, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        FEC_INICIO_SEMANA_5 = TO_DATE(TO_CHAR(p_FECHA_INICIO_SEM_5, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        FEC_FIN_SEMANA_5 = TO_DATE(TO_CHAR(p_FECHA_FIN_SEM_5, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        FEC_ULT_MODIFICACION = SYSDATE,
        ID_USUARIO_ULT_MODIF = p_USUARIO
    WHERE
        ID_SEMANAS_ESTIMACION = p_ID;
END FECI_MODIFICA_CONFI_SEMANAS_PR;
/
