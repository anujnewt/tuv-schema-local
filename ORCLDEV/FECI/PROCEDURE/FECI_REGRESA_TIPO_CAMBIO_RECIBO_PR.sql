CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_REGRESA_TIPO_CAMBIO_RECIBO_PR" 
                    (
                        p_RECIBO IN VARCHAR2,
                        p_Tipo IN VARCHAR2
                        )
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  feci_cursors SYS_REFCURSOR;
    BEGIN
        open feci_cursors for
        SELECT TIPO_CAMBIO_ORIGEN,TIPO_CAMBIO_DOLAR
        FROM FECI_RECIBOS_VW
        WHERE FOLIO_RECIBO = p_RECIBO AND TIPO_RECIBO = p_Tipo;
        DBMS_SQL.RETURN_RESULT(feci_cursors);
    END;
/
