CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."PON_VALOR" (ws_cadena VARCHAR2,
                                      wi_posicion INTEGER,
                                      ws_valor VARCHAR2)
RETURN VARCHAR2
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_resultado VARCHAR2(10) := '';
    wi_contador INTEGER := 0;
    wi_longitud INTEGER :=0;
BEGIN
    wi_longitud := LENGTH(ws_cadena);
    FOR wi_contador IN 1 .. 10 LOOP
        IF wi_contador = wi_posicion THEN
            ws_resultado := ws_resultado || ws_valor;
        ELSE
            IF wi_contador > wi_longitud THEN
                ws_resultado := ws_resultado || ' ';
            ELSE
                ws_resultado := ws_resultado || SUBSTR(ws_cadena, wi_contador, 1);
            END IF;
        END IF;
    END LOOP;
    -- ws_resultado := ws_cadena || ' MUNDO';
    RETURN (ws_resultado);
END PON_VALOR;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."PON_VALOR" (ws_cadena VARCHAR2,
                                      wi_posicion INTEGER,
                                      ws_valor VARCHAR2)
RETURN VARCHAR2
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_resultado VARCHAR2(10) := '';
    wi_contador INTEGER := 0;
    wi_longitud INTEGER :=0;
BEGIN
    wi_longitud := LENGTH(ws_cadena);
    FOR wi_contador IN 1 .. 10 LOOP
        IF wi_contador = wi_posicion THEN
            ws_resultado := ws_resultado || ws_valor;
        ELSE
            IF wi_contador > wi_longitud THEN
                ws_resultado := ws_resultado || ' ';
            ELSE
                ws_resultado := ws_resultado || SUBSTR(ws_cadena, wi_contador, 1);
            END IF;
        END IF;
    END LOOP;
    -- ws_resultado := ws_cadena || ' MUNDO';
    RETURN (ws_resultado);
END PON_VALOR;
/
