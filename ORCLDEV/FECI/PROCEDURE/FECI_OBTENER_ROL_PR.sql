CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_OBTENER_ROL_PR" 
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor SYS_REFCURSOR;
BEGIN
   open feci_cursor for
        SELECT ID_ROL,COD_ROL,NOM_ROL FROM FECI_ROL_TAB WHERE IND_ESTADO =1 ;
    DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_OBTENER_ROL_PR ;
/
