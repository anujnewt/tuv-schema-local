CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_OBTENER_CLASE_CLIENTE_PR" 
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursors SYS_REFCURSOR;
BEGIN
   open feci_cursors for
        SELECT * FROM FECXC.FECI_CLASE_CLIENTE_CAT WHERE  IND_ESTADO =1 ;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_OBTENER_CLASE_CLIENTE_PR ;
/
