CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."SP_TODECIMAL2" (ws_cadena IN VARCHAR2)
RETURN decimal IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   wd_valor decimal(12,2);
BEGIN
   wd_valor := ws_cadena;
   RETURN wd_valor;
EXCEPTION
    WHEN OTHERS THEN
	return 0;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."SP_TODECIMAL2" (ws_cadena IN VARCHAR2)
RETURN decimal IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   wd_valor decimal(12,2);
BEGIN
   wd_valor := ws_cadena;
   RETURN wd_valor;
EXCEPTION
    WHEN OTHERS THEN
	return 0;
END;
/
