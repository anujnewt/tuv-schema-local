CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_OBTENER_CLASIFICACIONES_PR" 
(
    p_EMPRESA VARCHAR2 DEFAULT NULL,
    p_SEGMENTO VARCHAR2 DEFAULT NULL,
    p_FECHA_INICIO DATE,
    p_FECHA_FIN DATE,
    p_TIPO_RECIBO VARCHAR2 DEFAULT NULL
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  feci_cursor SYS_REFCURSOR;
  v_query VARCHAR2(10000);
BEGIN
  -- Este procedimiento obtiene los recibos seg?n el estado especificado.
  -- Construir la consulta din?ca
  v_query := 'SELECT * FROM FECXC.FECI_CLASIFICACIONES_VW WHERE
  FEC_OPERATIVA >= TO_DATE(''' || TO_CHAR(p_FECHA_INICIO, 'YYYY-MM-DD') || ''', ''YYYY-MM-DD'')
  AND FEC_OPERATIVA <= TO_DATE(''' || TO_CHAR(p_FECHA_FIN, 'YYYY-MM-DD') || ''', ''YYYY-MM-DD'')';
    IF p_TIPO_RECIBO IS NOT NULL THEN
        v_query := v_query || ' AND TIPO_RECIBO IN (' || p_TIPO_RECIBO || ')';
    END IF;
    IF p_EMPRESA IS NOT NULL THEN
        v_query := v_query || ' AND COD_EMPRESA IN (' || p_EMPRESA || ')';
    END IF;
    IF p_SEGMENTO IS NOT NULL THEN
        v_query := v_query || ' AND COD_SEGMENTO IN (' || p_SEGMENTO || ')';
    END IF;
  -- Abre un cursor para ejecutar la consulta din?ca
  OPEN feci_cursor FOR v_query;
  DBMS_SQL.RETURN_RESULT(feci_cursor);
  DBMS_OUTPUT.PUT_LINE(v_query);
   --DBMS_OUTPUT.PUT_LINE('Consulta generada: ' || v_query );
  -- Puedes agregar aqu?l manejo de excepciones, por ejemplo:
  -- EXCEPTION
  --   WHEN NO_DATA_FOUND THEN
  --     DBMS_OUTPUT.PUT_LINE('No se encontraron datos.');
  --   WHEN OTHERS THEN
  --     DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END FECI_OBTENER_CLASIFICACIONES_PR;
/
