CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_OBTENER_CLASIFICACION_PR" 
(
        p_FOLIO_RECIBO         NUMBER,
        p_TIPO_RECIBO          VARCHAR2
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor SYS_REFCURSOR;
BEGIN
   open feci_cursor for
        select * from FECXC.FECI_CLASIFICACION_TAB
        WHERE FOLIO_RECIBO = p_FOLIO_RECIBO
        AND TIPO_RECIBO = p_TIPO_RECIBO
        AND IND_ESTADO = 1;
    DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_OBTENER_CLASIFICACION_PR ;
/
