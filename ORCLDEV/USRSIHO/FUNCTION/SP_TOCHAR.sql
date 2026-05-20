CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_TOCHAR" (ws_valor integer DEFAULT NULL)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  wn_valcer VARCHAR2(20);
  wn_valint VARCHAR2(20);
  ws_ValRespuesta VARCHAR2 (20);
/*ON EXCEPTION IN  (-1213)
 LET wn_valcer = '';
  RETURN wn_valcer;
END EXCEPTION;
 LET wn_valint = ws_valor;*/
BEGIN
  ws_ValRespuesta := '';
--  IF ws_valor is null THEN
--    ws_ValRespuesta := '';
--  ELSE
    ws_ValRespuesta := TO_CHAR (ws_valor);
--  END IF;
  RETURN ws_ValRespuesta;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_TOCHAR" (ws_valor integer DEFAULT NULL)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  wn_valcer VARCHAR2(20);
  wn_valint VARCHAR2(20);
  ws_ValRespuesta VARCHAR2 (20);
/*ON EXCEPTION IN  (-1213)
 LET wn_valcer = '';
  RETURN wn_valcer;
END EXCEPTION;
 LET wn_valint = ws_valor;*/
BEGIN
  ws_ValRespuesta := '';
--  IF ws_valor is null THEN
--    ws_ValRespuesta := '';
--  ELSE
    ws_ValRespuesta := TO_CHAR (ws_valor);
--  END IF;
  RETURN ws_ValRespuesta;
END;
/
