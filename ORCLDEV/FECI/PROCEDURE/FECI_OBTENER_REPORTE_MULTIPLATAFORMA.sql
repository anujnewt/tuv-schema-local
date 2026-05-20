CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_OBTENER_REPORTE_MULTIPLATAFORMA" (
    p_ano1 IN NUMBER,
    p_mes IN NUMBER,
    p_dia IN NUMBER,
    p_MONEDA_COLUMN_NAME VARCHAR2,
    p_SEGMENTO IN VARCHAR2 DEFAULT NULL
    --p_SEGMENTO IN VARCHAR2 DEFAULT 'MULTF'
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    v_sql_query VARCHAR2(4000);
     feci_cursor SYS_REFCURSOR;
     v_segmento_condition VARCHAR2(1000);
BEGIN
     IF p_SEGMENTO IS NOT NULL THEN
        v_segmento_condition := 'AND COD_SEGMENTO IN (''' || p_SEGMENTO || ''')';
    ELSE
        v_segmento_condition := '';
    END IF;
    -- Construir la consulta din?ca
    v_sql_query :=
        'WITH PivotData AS (' ||
        '    SELECT' ||
        '        CLASE_CLIENTE,' ||
        '        COD_CONCEPTO,' ||
        '        DES_CONCEPTO,' ||
        '        COD_SEGMENTO,' ||
        '        DES_SEGMENTO,' ||
        '        TO_CHAR(FEC_OPERATIVA, ''YYYY-MM'') AS ANIO_MES,' ||
        '        TO_CHAR(FEC_OPERATIVA, ''YYYY'') AS ANIO,' ||
                  p_MONEDA_COLUMN_NAME  ||
        '    FROM' ||
        '        FECI_CLASIFICACIONES_REP_VW' ||
        '    WHERE' ||
        '        TRUNC(FEC_OPERATIVA) BETWEEN TO_DATE(TO_CHAR(' ||p_ano1 ||  ' || ''-01-01''), ''YYYY-MM-DD'') AND TO_DATE(TO_CHAR(' ||p_ano1 ||  ' || ''-'' || ' ||p_mes|| ' || ''-'' || ' || p_dia||  '), ''YYYY-MM-DD'')' ||
        v_segmento_condition ||
        ')' ||
        'SELECT' ||
        '    CLASE_CLIENTE,' ||
        '    COD_CONCEPTO,' ||
        '    DES_CONCEPTO,' ||
        '    COD_SEGMENTO,' ||
        '    DES_SEGMENTO,' ||
        '    ANIO,' ||
        '    NVL("'||p_ano1||'-01", 0) AS ENERO,' ||
        '    NVL("'||p_ano1||'-02", 0) AS FEBRERO,' ||
        '    NVL("'||p_ano1||'-03", 0) AS MARZO,' ||
        '    NVL("'||p_ano1||'-04", 0) AS ABRIL,' ||
        '    NVL("'||p_ano1||'-05", 0) AS MAYO,' ||
        '    NVL("'||p_ano1||'-06", 0) AS JUNIO,' ||
        '    NVL("'||p_ano1||'-07", 0) AS JULIO,' ||
        '    NVL("'||p_ano1||'-08", 0) AS AGOSTO,' ||
        '    NVL("'||p_ano1||'-09", 0) AS SEPTIEMBRE,' ||
        '    NVL("'||p_ano1||'-10", 0) AS OCTUBRE,' ||
        '    NVL("'||p_ano1||'-11", 0) AS NOVIEMBRE,' ||
        '    NVL("'||p_ano1||'-12", 0) AS DICIEMBRE,' ||
        '    NVL("'||p_ano1||'-01", 0) + NVL("'||p_ano1||'-02", 0) + NVL("'||p_ano1||'-03", 0) +' ||
        '    NVL("'||p_ano1||'-04", 0) + NVL("'||p_ano1||'-05", 0) + NVL("'||p_ano1||'-06", 0) +' ||
        '    NVL("'||p_ano1||'-07", 0) + NVL("'||p_ano1||'-08", 0) + NVL("'||p_ano1||'-09", 0) +' ||
        '    NVL("'||p_ano1||'-10", 0) + NVL("'||p_ano1||'-11", 0) + NVL("'||p_ano1||'-12", 0) AS SUMA_TOTAL' ||
        ' FROM PivotData' ||
        ' PIVOT (' ||
        '    SUM(' || p_MONEDA_COLUMN_NAME || ')' ||
        '    FOR ANIO_MES IN (' ||
        '        '''||p_ano1||'-01'' AS "'||p_ano1||'-01",' ||
        '        '''||p_ano1||'-02'' AS "'||p_ano1||'-02",' ||
        '        '''||p_ano1||'-03'' AS "'||p_ano1||'-03",' ||
        '        '''||p_ano1||'-04'' AS "'||p_ano1||'-04",' ||
        '        '''||p_ano1||'-05'' AS "'||p_ano1||'-05",' ||
        '        '''||p_ano1||'-06'' AS "'||p_ano1||'-06",' ||
        '        '''||p_ano1||'-07'' AS "'||p_ano1||'-07",' ||
        '        '''||p_ano1||'-08'' AS "'||p_ano1||'-08",' ||
        '        '''||p_ano1||'-09'' AS "'||p_ano1||'-09",' ||
        '        '''||p_ano1||'-10'' AS "'||p_ano1||'-10",' ||
        '        '''||p_ano1||'-11'' AS "'||p_ano1||'-11",' ||
        '        '''||p_ano1||'-12'' AS "'||p_ano1||'-12"' ||
        '    )' ||
        ')' ||
        'ORDER BY ANIO';
    -- Ejecutar la consulta din?ca
    OPEN feci_cursor FOR v_sql_query;
    DBMS_SQL.RETURN_RESULT(feci_cursor);
   -- OPEN p_resultado FOR v_sql_query;
     --DBMS_OUTPUT.PUT_LINE('Consulta din?ca: ' || v_sql_query);
END FECI_OBTENER_REPORTE_MULTIPLATAFORMA;
/
