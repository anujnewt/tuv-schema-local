CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_OBTENER_RECIBOS_PR" 
(
    p_VER VARCHAR2,
    p_FECHA_INICIO DATE,
    p_FECHA_FIN DATE,
    p_TIPO_RECIBO VARCHAR2 DEFAULT NULL,
    p_EMPRESA CLOB DEFAULT NULL,
    p_FOLIO_INICIAL VARCHAR2 DEFAULT NULL,
    p_FOLIO_FINAL VARCHAR2 DEFAULT NULL,
    p_CLASE_CLIENTE CLOB DEFAULT NULL
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
  v_query := 'SELECT
            FOLIO_RECIBO,TIPO_RECIBO,FEC_CONTABILIDAD,FEC_OPERATIVA,IMPORTE,COD_MONEDA,
            DES_MONEDA,COD_EMPRESA,DES_EMPRESA,COD_CLIENTE,REF_CLIENTE,NOM_CLIENTE,CLASE_CLIENTE,
            METODO_PAGO,NOM_BANCO_EMISOR,NUM_CHEQUERA,NUM_CHEQUE,NUM_OPERACION,TIPO_CAMBIO_ORIGEN,
            FEC_TC_ORIGEN,TIPO_CAMBIO_DOLAR,FEC_TC_DOLAR,ID_USUARIO_CLASIFICACION,FEC_CLASIFICACION,
            ID_USUARIO_APLICACION,FEC_APLICACION,COD_ESTADO_RECIBO,FEC_CREACION,FEC_ULT_MODIFICACION,
            ID_USUARIO_CREACION,ID_USUARIO_ULT_MODIF,IND_ESTADO,FEC_DEPOSITO
            FROM FECI_RECIBOS_VW WHERE COD_ESTADO_RECIBO IN (' || p_VER || ')';
    IF p_FECHA_INICIO IS NOT NULL THEN
        IF p_FECHA_FIN IS NOT NULL THEN
        v_query := v_query || '  AND FEC_OPERATIVA >= TO_DATE(''' || TO_CHAR(p_FECHA_INICIO, 'YYYY-MM-DD') || ''', ''YYYY-MM-DD'')
  AND FEC_OPERATIVA <= TO_DATE(''' || TO_CHAR(p_FECHA_FIN, 'YYYY-MM-DD') || ''', ''YYYY-MM-DD'')';
        END IF;
    END IF;
    IF p_TIPO_RECIBO IS NOT NULL THEN
        v_query := v_query || ' AND TIPO_RECIBO IN (' || p_TIPO_RECIBO || ')';
    END IF;
    IF p_EMPRESA IS NOT NULL THEN
        v_query := v_query || ' AND COD_EMPRESA IN (' || p_EMPRESA || ')';
    END IF;
    IF p_FOLIO_INICIAL IS NOT NULL  THEN
        IF  p_FOLIO_FINAL IS NOT NULL THEN
            IF p_FOLIO_INICIAL =  p_FOLIO_FINAL THEN
                 v_query := v_query || ' AND FOLIO_RECIBO =''' || p_FOLIO_INICIAL || '''';
            ELSE
                v_query := v_query || ' AND FOLIO_RECIBO BETWEEN ''' || p_FOLIO_INICIAL || ''' AND ''' || p_FOLIO_FINAL || '''';
            END IF;
        ELSE
            v_query := v_query || ' AND FOLIO_RECIBO =''' || p_FOLIO_INICIAL || '''';
        END IF;
    END IF;
    IF p_CLASE_CLIENTE IS NOT NULL  THEN
        v_query := v_query || ' AND CLASE_CLIENTE IN (' || p_CLASE_CLIENTE || ')';
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
END FECI_OBTENER_RECIBOS_PR;
/
