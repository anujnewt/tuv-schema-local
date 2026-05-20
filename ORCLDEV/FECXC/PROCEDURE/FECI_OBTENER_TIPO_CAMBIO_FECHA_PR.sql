CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_OBTENER_TIPO_CAMBIO_FECHA_PR" 
(
    p_FECHA       DATE
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor SYS_REFCURSOR;
BEGIN
   open feci_cursor for
        SELECT * FROM FECXC.FECI_TIPO_CAMBIO_CAT
        WHERE
        FEC_FECHA_TC = TO_DATE(TO_CHAR(p_FECHA, 'yyyy-MM-dd'), 'yyyy-MM-dd')
        AND IND_ESTADO =1 ;
    DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_OBTENER_TIPO_CAMBIO_FECHA_PR ;
/
