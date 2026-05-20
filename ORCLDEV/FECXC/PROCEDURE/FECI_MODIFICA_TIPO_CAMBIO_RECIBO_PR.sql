CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_MODIFICA_TIPO_CAMBIO_RECIBO_PR" 
                    (
                        p_RECIBO IN NUMERIC,
                        p_Tipo IN VARCHAR2,
                        p_USUARIO NUMBER
                        )
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    MONEDA VARCHAR(50);
    FECHA_OPERATIVA DATE;
    CAMBIO_ORIGEN NUMBER;
    CAMBIO_DOLAR NUMBER;
    FECHA_TC_DOLAR DATE;
    FECHA_TC_ORIGEN DATE;
    CONTADOR NUMBER;
    BEGIN
        SELECT COD_MONEDA INTO MONEDA
        FROM FECI_RECIBOS_VW
        WHERE FOLIO_RECIBO = p_RECIBO AND TIPO_RECIBO = p_Tipo;
         --DBMS_OUTPUT.PUT_LINE('MONEDA: ' || MONEDA);
        SELECT FEC_OPERATIVA INTO FECHA_OPERATIVA
        FROM FECI_RECIBOS_VW
        WHERE FOLIO_RECIBO = p_RECIBO AND TIPO_RECIBO = p_Tipo;
                --DBMS_OUTPUT.PUT_LINE('FECHA_OPERATIVA: ' || FECHA_OPERATIVA);
       IF( MONEDA='MXN') THEN
            SELECT  COUNT (*) INTO  CONTADOR
						FROM FECI_TIPO_CAMBIO_CAT
						WHERE (FEC_FECHA_TC =  FECHA_OPERATIVA   AND COD_MONEDA = 'USD');
            if (CONTADOR > 0 ) then
                    SELECT NUM_VALOR, FEC_FECHA_TC INTO CAMBIO_DOLAR, FECHA_TC_DOLAR
                    FROM FECI_TIPO_CAMBIO_CAT
                    WHERE (FEC_FECHA_TC =  FECHA_OPERATIVA  AND COD_MONEDA = 'USD');
            else
                    SELECT NUM_VALOR, FEC_FECHA_TC INTO CAMBIO_DOLAR, FECHA_TC_DOLAR
                    FROM FECI_TIPO_CAMBIO_CAT
                    WHERE (COD_MONEDA = 'USD' AND FEC_FECHA_TC = (
                        SELECT MAX(FEC_FECHA_TC)
                        FROM FECI_TIPO_CAMBIO_CAT
                        WHERE COD_MONEDA = 'USD'));
            end if;
            IF(p_Tipo = 'BATCH'  )THEN
                UPDATE FECI_RECIBO_TAB SET
                TIPO_CAMBIO_ORIGEN = 1,
                FEC_TC_ORIGEN = FECHA_OPERATIVA ,
                TIPO_CAMBIO_DOLAR = CAMBIO_DOLAR,
                FEC_TC_DOLAR =  FECHA_TC_DOLAR
                WHERE FOLIO_RECIBO =  p_RECIBO;
            ELSE
                ---ESTA SECCION ES PARA LOS RECIBOS MANUALES
                UPDATE FECI_RECIBO_MANUAL_TAB SET
                TIPO_CAMBIO_ORIGEN = 1,
                FEC_TC_ORIGEN = FECHA_OPERATIVA,
                TIPO_CAMBIO_DOLAR = CAMBIO_DOLAR,
                FEC_TC_DOLAR =FECHA_TC_DOLAR
                WHERE FOLIO_RECIBO_MANUAL =  p_RECIBO;
            END IF;
       ELSE
            ----SELECT PARA TRAER LOS DATOS DE MONEDA ORIGEN
            SELECT  COUNT(*) INTO  CONTADOR
						FROM FECI_TIPO_CAMBIO_CAT
						WHERE (FEC_FECHA_TC = FECHA_OPERATIVA  AND COD_MONEDA = MONEDA);
            if (CONTADOR > 0 ) then
                    SELECT NUM_VALOR, FEC_FECHA_TC INTO CAMBIO_ORIGEN, FECHA_TC_ORIGEN
                    FROM FECI_TIPO_CAMBIO_CAT
                    WHERE (FEC_FECHA_TC =  FECHA_OPERATIVA   AND COD_MONEDA = MONEDA);
            else
                    SELECT NUM_VALOR, FEC_FECHA_TC INTO CAMBIO_ORIGEN, FECHA_TC_ORIGEN
                    FROM FECI_TIPO_CAMBIO_CAT
                    WHERE (COD_MONEDA = MONEDA AND FEC_FECHA_TC = (
                        SELECT MAX(FEC_FECHA_TC)
                        FROM FECI_TIPO_CAMBIO_CAT
                        WHERE COD_MONEDA = MONEDA));
            end if;
            ---SELECT PARA TRAER LOS DATOS MONEDA USD (DOLAR)
            SELECT  COUNT (*) INTO  CONTADOR
						FROM FECI_TIPO_CAMBIO_CAT
						WHERE (FEC_FECHA_TC = FECHA_OPERATIVA  AND COD_MONEDA = 'USD');
            if (CONTADOR > 0 ) then
                    SELECT NUM_VALOR, FEC_FECHA_TC INTO CAMBIO_DOLAR, FECHA_TC_DOLAR
                    FROM FECI_TIPO_CAMBIO_CAT
                    WHERE (FEC_FECHA_TC =  FECHA_OPERATIVA  AND COD_MONEDA = 'USD');
            else
                    SELECT NUM_VALOR, FEC_FECHA_TC INTO CAMBIO_DOLAR, FECHA_TC_DOLAR
                    FROM FECI_TIPO_CAMBIO_CAT
                    WHERE (COD_MONEDA = 'USD' AND FEC_FECHA_TC = (
                        SELECT MAX(FEC_FECHA_TC)
                        FROM FECI_TIPO_CAMBIO_CAT
                        WHERE COD_MONEDA = 'USD'));
            end if;
            IF(p_Tipo = 'BATCH'  )THEN
                UPDATE FECI_RECIBO_TAB SET
                TIPO_CAMBIO_ORIGEN = CAMBIO_ORIGEN,
                FEC_TC_ORIGEN = FECHA_TC_ORIGEN,
                TIPO_CAMBIO_DOLAR = CAMBIO_DOLAR,
                FEC_TC_DOLAR = FECHA_TC_DOLAR
                WHERE FOLIO_RECIBO =  p_RECIBO;
            ELSE
                ---ESTA SECCION ES PARA LOS RECIBOS MANUALES
                UPDATE FECI_RECIBO_MANUAL_TAB SET
                TIPO_CAMBIO_ORIGEN = CAMBIO_ORIGEN,
                FEC_TC_ORIGEN = FECHA_TC_ORIGEN,
                TIPO_CAMBIO_DOLAR = CAMBIO_DOLAR,
                FEC_TC_DOLAR = FECHA_TC_DOLAR
                WHERE FOLIO_RECIBO_MANUAL =  p_RECIBO;
            END IF;
        END IF;
    END FECI_MODIFICA_TIPO_CAMBIO_RECIBO_PR;
/
