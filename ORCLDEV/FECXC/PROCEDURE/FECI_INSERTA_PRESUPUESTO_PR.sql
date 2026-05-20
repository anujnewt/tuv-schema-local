CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_INSERTA_PRESUPUESTO_PR" 
(
        p_CODIGO_SEGMENTO               VARCHAR2,
        p_CODIGO_CONCEPTO               VARCHAR2,
        p_CODIGO_REGION                 VARCHAR2,
        p_CONDIGO_MONEDA                VARCHAR2 ,
        p_FECHA_PRESUPUESTO             DATE,
        p_NUM_GESTION                   NUMBER,
        p_NUM_IMPORTE                   NUMBER ,
        p_USUARIO                       NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    REGISTRO NUMBER;
    feci_cursors SYS_REFCURSOR;
    INSERT_NECESARIO NUMBER := 0;
BEGIN
-- Verificar si ya existe un registro con la fecha especificada
    SELECT COUNT(*) INTO INSERT_NECESARIO
    FROM FECI_PRESUPUESTO_TAB
    WHERE FEC_PRESUPUESTO = TO_DATE(TO_CHAR(p_FECHA_PRESUPUESTO, 'YYYY-MM-DD'), 'YYYY-MM-DD')
    AND COD_SEGMENTO = p_CODIGO_SEGMENTO
    AND COD_CONCEPTO = p_CODIGO_CONCEPTO
    AND COD_REGION = p_CODIGO_REGION;
    IF (INSERT_NECESARIO=0) THEN
       INSERT INTO FECI_PRESUPUESTO_TAB
                (COD_SEGMENTO,COD_CONCEPTO,COD_REGION,COD_MONEDA,FEC_PRESUPUESTO,NUM_GESTION,NUM_IMPORTE,
                FEC_CREACION,FEC_ULT_MODIFICACION,ID_USUARIO_CREACION,ID_USUARIO_ULT_MODIF,IND_ESTADO)
                VALUES (
                p_CODIGO_SEGMENTO,
                p_CODIGO_CONCEPTO,
                p_CODIGO_REGION,
                p_CONDIGO_MONEDA,
                TO_DATE(TO_CHAR(p_FECHA_PRESUPUESTO, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
                p_NUM_GESTION,
                p_NUM_IMPORTE,
                SYSDATE,
                SYSDATE,
                p_USUARIO,
                0,
                1
                ) returning ID_PRESUPUESTO INTO REGISTRO;
    END IF;
open feci_cursors for
               SELECT ID_PRESUPUESTO FROM FECI_PRESUPUESTO_TAB WHERE ID_PRESUPUESTO =  REGISTRO;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_INSERTA_PRESUPUESTO_PR ;
/
