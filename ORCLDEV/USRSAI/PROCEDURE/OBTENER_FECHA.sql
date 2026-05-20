CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."OBTENER_FECHA" (P_TEXTO OUT VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  P_TEXTO := 'La fecha actual es ' || TO_CHAR(SYSDATE,'DD/MM/YYYY');
END;
/
