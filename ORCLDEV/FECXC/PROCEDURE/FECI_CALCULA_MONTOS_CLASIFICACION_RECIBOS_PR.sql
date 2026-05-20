CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_CALCULA_MONTOS_CLASIFICACION_RECIBOS_PR" (
    p_RECIBO   NUMBER,
    p_USUARIO  NUMBER
) AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    v_fecha_actual DATE;
BEGIN
    -- Obtenemos la fecha actual del sistema
    SELECT SYSDATE INTO v_fecha_actual FROM DUAL;
    -- Realiza tus c?ulos o acciones con la fecha actual
    -- Por ejemplo:
    -- INSERT INTO una_tabla (recibo_id, fecha_registro, usuario_id)
    -- VALUES (p_RECIBO, v_fecha_actual, p_USUARIO);
    -- Tambi?puedes mostrar la fecha en la salida
    DBMS_OUTPUT.PUT_LINE('Fecha actual del sistema: ' || TO_CHAR(v_fecha_actual, 'DD-MON-YYYY HH24:MI:SS'));
END FECI_CALCULA_MONTOS_CLASIFICACION_RECIBOS_PR;
/
