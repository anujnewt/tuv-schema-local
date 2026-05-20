CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_OBTENER_REPORTE_COBRANZA_VS_PRESUPUESTO" 
(
    p_dia  NUMBER,
    p_mes  NUMBER,
    p_anio NUMBER
 )
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  feci_cursor SYS_REFCURSOR;
  v_fechaOperativa DATE;
  v_fechaMes DATE;
  v_fechaAnio DATE;
  v_fechaAnioAnteriorEnero Date;
  v_fechaAnioAnteriorOperativa Date;
BEGIN
  v_fechaOperativa := TO_DATE(p_dia || '/' || p_mes || '/' || p_anio, 'DD/MM/YYYY');
  v_fechaMes := TO_DATE('01' || '/' || p_mes || '/' || p_anio, 'DD/MM/YYYY');
  v_fechaAnio := TO_DATE('01' || '/' || '01' || '/' || p_anio, 'DD/MM/YYYY');
  v_fechaAnioAnteriorEnero := TO_DATE('01' || '/' || '01' || '/' || TO_CHAR(TO_NUMBER(p_anio) - 1), 'DD/MM/YYYY') ;
  v_fechaAnioAnteriorOperativa := TO_DATE('01' || '/' || p_mes || '/' || TO_CHAR(TO_NUMBER(p_anio) - 1), 'DD/MM/YYYY')  ;
open feci_cursor for
WITH PeriodoActual AS (
    SELECT
        s.COD_MONEDA,
        c.COD_GRUPO_FORECAST,
        g.DES_GRUPO_FORECAST,
        c.COD_SEGMENTO,
        s.DES_SEGMENTO,
        c.COD_CONCEPTO,
        concepto.DES_CONCEPTO,
        r.FEC_OPERATIVA,
        c.MONTO_BASE_MXN,
        c.MONTO_BASE_USD
    FROM FECI_CLASIFICACION_TAB c
    JOIN FECI_RECIBOS_REP_VW r ON c.FOLIO_RECIBO = r.FOLIO_RECIBO
    JOIN FECI_SEGMENTO_CAT s ON c.COD_SEGMENTO = s.COD_SEGMENTO
    JOIN FECI_GRUPO_FORECAST_CAT g ON c.COD_GRUPO_FORECAST = g.COD_GRUPO_FORECAST
    JOIN FECI_CONCEPTO_CAT concepto ON c.COD_CONCEPTO = concepto.COD_CONCEPTO
    WHERE r.FEC_OPERATIVA BETWEEN v_fechaAnio AND v_fechaOperativa
    OR  r.FEC_OPERATIVA BETWEEN v_fechaAnioAnteriorEnero AND v_fechaAnioAnteriorOperativa
)
SELECT
    pa.COD_SEGMENTO,
    pa.DES_SEGMENTO,
    pa.COD_GRUPO_FORECAST,
    pa.DES_GRUPO_FORECAST,
    pa.COD_CONCEPTO,
    pa.DES_CONCEPTO,
    pa.COD_MONEDA,
    SUM(CASE WHEN pa.FEC_OPERATIVA = v_fechaOperativa
             THEN
             CASE WHEN pa.COD_MONEDA = 'MXN' THEN pa.MONTO_BASE_MXN ELSE pa.MONTO_BASE_USD END
             ELSE 0 END) AS COBRANZA_DIA,
    SUM(CASE WHEN pa.FEC_OPERATIVA BETWEEN v_fechaMes AND v_fechaOperativa THEN
            CASE WHEN pa.COD_MONEDA = 'MXN' THEN pa.MONTO_BASE_MXN ELSE pa.MONTO_BASE_USD END
        ELSE 0 END) AS COBRANZA_MES,
   (
        SELECT SUM (NUM_IMPORTE)
        FROM FECI_PRESUPUESTO_TAB p
        WHERE  p.COD_SEGMENTO =pa.COD_SEGMENTO
        AND  p.COD_CONCEPTO = pa.COD_CONCEPTO
        AND p.FEC_PRESUPUESTO BETWEEN v_fechaMes AND v_fechaOperativa
        AND p.COD_MONEDA = pa.COD_MONEDA
    ) PRESUPUESTO_MES,
     SUM(CASE WHEN pa.FEC_OPERATIVA BETWEEN v_fechaAnio AND v_fechaOperativa THEN
            CASE WHEN pa.COD_MONEDA = 'MXN' THEN pa.MONTO_BASE_MXN ELSE pa.MONTO_BASE_USD END
        ELSE 0 END) AS COBRANZA_A_LA_FECHA,
    (
        SELECT SUM (NUM_IMPORTE)
        FROM FECI_PRESUPUESTO_TAB p
        WHERE  p.COD_SEGMENTO =pa.COD_SEGMENTO
        AND  p.COD_CONCEPTO = pa.COD_CONCEPTO
        AND p.FEC_PRESUPUESTO BETWEEN v_fechaAnio AND v_fechaOperativa
        AND p.COD_MONEDA = pa.COD_MONEDA
    ) PRESUPUESTO_A_LA_FECHA,
    SUM(CASE WHEN pa.FEC_OPERATIVA BETWEEN v_fechaAnioAnteriorEnero AND v_fechaAnioAnteriorOperativa THEN
            CASE WHEN pa.COD_MONEDA = 'MXN' THEN pa.MONTO_BASE_MXN ELSE pa.MONTO_BASE_USD END
        ELSE 0 END) AS COBRANZA_ANIO_ANTERIOR
FROM PeriodoActual pa
GROUP BY
    pa.COD_SEGMENTO,
    pa.DES_SEGMENTO,
    pa.COD_GRUPO_FORECAST,
    pa.DES_GRUPO_FORECAST,
    pa.COD_CONCEPTO,
    pa.DES_CONCEPTO,
    pa.COD_MONEDA;
  DBMS_OUTPUT.PUT_LINE('Fecha Operativa: ' || v_fechaOperativa);
  DBMS_OUTPUT.PUT_LINE('Fecha Mes: ' || v_fechaMes);
  DBMS_OUTPUT.PUT_LINE('Fecha A?' || v_fechaAnio);
  DBMS_OUTPUT.PUT_LINE('Fecha A?nterior Mes: ' || v_fechaAnioAnteriorEnero);
  DBMS_OUTPUT.PUT_LINE('Fecha A?nterior Operativa: ' || v_fechaAnioAnteriorOperativa);
    DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_OBTENER_REPORTE_COBRANZA_VS_PRESUPUESTO;
/
