CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."PROC_CONSULTA" 
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    CURSOR cursor_resultados IS
         SELECT FOLIO_RECIBO, TIPO_RECIBO
        FROM FECXC.FECI_RECIBOS_VW
        WHERE TIPO_CAMBIO_ORIGEN IS NULL AND TIPO_RECIBO = 'BATCH';
    v_valor1 FECXC.FECI_RECIBOS_VW.FOLIO_RECIBO%TYPE;
    v_valor2 FECXC.FECI_RECIBOS_VW.TIPO_RECIBO%TYPE;
BEGIN
    FOR registro IN cursor_resultados LOOP
        v_valor1 := registro.FOLIO_RECIBO;
        v_valor2 := registro.TIPO_RECIBO;
        DBMS_OUTPUT.PUT_LINE('Valor de FOLIO_RECIBO: ' || v_valor1);
        DBMS_OUTPUT.PUT_LINE('Valor de TIPO_RECIBO: ' || v_valor2);
        -- Llama al procedimiento PROC_ACCION con los valores del registro
        --PROC_ACCION(v_valor1, v_valor2);
    END LOOP;
END PROC_CONSULTA;
/
