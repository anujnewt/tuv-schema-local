CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_OBTENER_REPORTE_RCBS_MANUALES_PR" 
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor     SYS_REFCURSOR;
BEGIN
    OPEN feci_cursor FOR
        SELECT  R.COD_EMPRESA || ' - ' || E.DES_EMPRESA Empresa, R.FEC_OPERATIVA Fecha,
                R.METODO_PAGO AS Metodo, R.REF_CLIENTE Referencia_Cliente,
                R.NOM_CLIENTE AS Nombre_Cliente, R.FOLIO_RECIBO_MANUAL Numero_Recibo,
                R.NUM_OPERACION AS Codigo_Operacion, R.COD_MONEDA Moneda,
                R.IMPORTE, R.COD_ESTADO_RECIBO Estado_Recibo
        FROM FECXC.FECI_RECIBO_MANUAL_TAB R
        INNER JOIN FECXC.FECI_EMPRESA_CAT E ON R.COD_EMPRESA = E.COD_EMPRESA
        INNER JOIN FECXC.FECI_MONEDA_CAT M ON R.COD_MONEDA = M.COD_MONEDA;
    DBMS_SQL.RETURN_RESULT(feci_cursor);
    EXCEPTION
          WHEN NO_DATA_FOUND THEN
           DBMS_OUTPUT.PUT_LINE('feci_cursor ');
END FECI_OBTENER_REPORTE_RCBS_MANUALES_PR;
/
