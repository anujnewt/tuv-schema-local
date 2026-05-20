CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_REP_FLUJO_EFECTIVO_PR" 
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor SYS_REFCURSOR;
BEGIN
   open feci_cursor for
        SELECT
            DES_GRUPO_FORECAST      AS GRUPO_FORECAST
            ,DES_SEGMENTO           AS SEGMENTO
            ,CONCAT(CONCAT(COD_EMPRESA, ' - '), DES_EMPRESA) AS EMPRESA
            ,FEC_APLICACION         AS FECHA_APLICACION
            ,FEC_OPERATIVA          AS FECHA_OPERATIVA
            ,METODO_PAGO            AS METODO_PAGO
            ,FOLIO_RECIBO           AS FOLIO_RECIBO
            ,NOM_CLIENTE            AS NOMBRE_CLIENTE
            ,REF_CLIENTE            AS REFERENCIA_CLIENTE
            ,COD_CLIENTE            AS COD_CLIENTE
            ,CLASE_CLIENTE          AS CLASE_CLIENTE
            ,DESC_CPS               AS CPS
            ,DES_CONCEPTO           AS CONCEPTO
            ,DES_REGION             AS REGION
            ,DES_PAIS               AS PAIS
            ,COD_MONEDA             AS MONEDA
            ,TIPO_CAMBIO_ORIGEN     AS TC_ORIGEN
            ,TIPO_CAMBIO_DOLAR      AS TC_DOLAR
            ,MONTO_BASE_ORG         AS MONTO_BASE_ORG
            ,MONTO_IVA_ORG          AS MONTO_IVA_ORG
            ,IMPORTE_ORG            AS MONTO_ORG
            ,MONTO_BASE_MXN         AS MONTO_BASE_MXN
            ,MONTO_IVA_MXN          AS MONTO_IVA_MXN
            ,IMPORTE_MXN            AS MONTO_MXN
            ,MONTO_BASE_USD         AS MONTO_BASE_USD
            ,MONTO_IVA_USD          AS MONTO_IVA_USD
            ,IMPORTE_USD            AS MONTO_USD
        FROM FECXC.FECI_CLASIFICACIONES_VW
        ORDER BY DES_GRUPO_FORECAST, DES_SEGMENTO, FOLIO_RECIBO, ORDEN;
    DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_REP_FLUJO_EFECTIVO_PR ;
/
