CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_INSERTA_CONFI_SEMANAS_PR" 
(
        p_ANIO         NUMBER,
        p_MES         NUMBER,
        p_FECHA_INICIO_SEM_1         DATE,
        p_FECHA_FIN_SEM_1       DATE,
        p_FECHA_INICIO_SEM_2       DATE,
        p_FECHA_FIN_SEM_2       DATE,
        p_FECHA_INICIO_SEM_3       DATE,
        p_FECHA_FIN_SEM_3       DATE,
        p_FECHA_INICIO_SEM_4       DATE,
        p_FECHA_FIN_SEM_4       DATE,
        p_FECHA_INICIO_SEM_5       DATE DEFAULT NULL,
        p_FECHA_FIN_SEM_5              DATE DEFAULT NULL,
        p_USUARIO       NUMBER
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ID_REGISTRO NUMBER;
    feci_cursors SYS_REFCURSOR;
BEGIN
     INSERT INTO FECI_SEMANAS_ESTIMACION_TAB
        (
            NUM_ANIO ,NUM_MES,
            FEC_INICIO_SEMANA_1,FEC_FIN_SEMANA_1,
            FEC_INICIO_SEMANA_2,FEC_FIN_SEMANA_2,
            FEC_INICIO_SEMANA_3,FEC_FIN_SEMANA_3,
            FEC_INICIO_SEMANA_4,FEC_FIN_SEMANA_4,
            FEC_INICIO_SEMANA_5,FEC_FIN_SEMANA_5,
            FEC_CREACION,FEC_ULT_MODIFICACION,ID_USUARIO_CREACION,
            ID_USUARIO_ULT_MODIF,IND_ESTADO)
             VALUES(
             p_ANIO,p_MES,
             TO_DATE(TO_CHAR(p_FECHA_INICIO_SEM_1, 'yyyy-MM-dd'), 'yyyy-MM-dd'),TO_DATE(TO_CHAR(p_FECHA_FIN_SEM_1, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
             TO_DATE(TO_CHAR(p_FECHA_INICIO_SEM_2, 'yyyy-MM-dd'), 'yyyy-MM-dd'),TO_DATE(TO_CHAR(p_FECHA_FIN_SEM_2, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
             TO_DATE(TO_CHAR(p_FECHA_INICIO_SEM_3, 'yyyy-MM-dd'), 'yyyy-MM-dd'),TO_DATE(TO_CHAR(p_FECHA_FIN_SEM_3, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
             TO_DATE(TO_CHAR(p_FECHA_INICIO_SEM_4, 'yyyy-MM-dd'), 'yyyy-MM-dd'),TO_DATE(TO_CHAR(p_FECHA_FIN_SEM_4, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
             TO_DATE(TO_CHAR(p_FECHA_INICIO_SEM_5, 'yyyy-MM-dd'), 'yyyy-MM-dd'),TO_DATE(TO_CHAR(p_FECHA_FIN_SEM_5, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
             SYSDATE,SYSDATE,p_USUARIO,0,1
             )
             returning ID_SEMANAS_ESTIMACION INTO ID_REGISTRO;
            open feci_cursors for
               SELECT ID_SEMANAS_ESTIMACION FROM FECI_SEMANAS_ESTIMACION_TAB WHERE ID_SEMANAS_ESTIMACION =  ID_REGISTRO;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_INSERTA_CONFI_SEMANAS_PR;
/
