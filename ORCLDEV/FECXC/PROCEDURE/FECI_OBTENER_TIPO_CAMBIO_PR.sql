CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_OBTENER_TIPO_CAMBIO_PR" 
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor SYS_REFCURSOR;
BEGIN
   open feci_cursor for
        SELECT * FROM FECXC.FECI_TIPO_CAMBIO_CAT WHERE IND_ESTADO =1 ;
    DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_OBTENER_TIPO_CAMBIO_PR ;
/
