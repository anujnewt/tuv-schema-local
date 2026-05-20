CREATE OR REPLACE EDITIONABLE FUNCTION "FECXC"."FECI_OBTIENE_CANTIDAD_RECIBOS_CLASIFICADOS_FUNC" 
RETURN NUMBER
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    v_contador NUMBER;
BEGIN
    -- Utiliza la variable v_contador para almacenar el conteo
    SELECT COUNT(*) INTO v_contador
    FROM FECXC.FECI_RECIBOS_VW
    WHERE COD_ESTADO_RECIBO = 'CLSF';
    -- Retorna el valor del contador
    RETURN v_contador;
END FECI_OBTIENE_CANTIDAD_RECIBOS_CLASIFICADOS_FUNC;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "FECXC"."FECI_OBTIENE_CANTIDAD_RECIBOS_CLASIFICADOS_FUNC" 
RETURN NUMBER
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    v_contador NUMBER;
BEGIN
    -- Utiliza la variable v_contador para almacenar el conteo
    SELECT COUNT(*) INTO v_contador
    FROM FECXC.FECI_RECIBOS_VW
    WHERE COD_ESTADO_RECIBO = 'CLSF';
    -- Retorna el valor del contador
    RETURN v_contador;
END FECI_OBTIENE_CANTIDAD_RECIBOS_CLASIFICADOS_FUNC;
/
