CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_VALNUMCAP" (    cadena IN VARCHAR2, conta OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
longitud NUMBER;
i NUMBER;
x CHAR(1);
BEGIN
      longitud := LENGTH(cadena);
      conta := 0;
      FOR i IN 1..longitud LOOP
         x := SUBSTR(cadena, i, i);
        IF x = ',' THEN
           conta := conta + 1;
        END IF;
        IF i=longitud THEN
           conta := conta + 1;
        END IF;
      END LOOP;
END;
/
