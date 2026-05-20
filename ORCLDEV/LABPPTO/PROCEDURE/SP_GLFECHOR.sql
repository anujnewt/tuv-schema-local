CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPPTO"."SP_GLFECHOR" (wd_fecha OUT VARCHAR2,ws_hora OUT  VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
	 wd_fecha := TO_CHAR (SYSDATE, 'mm/dd/yyyy');
	 ws_hora  := TO_CHAR (SYSDATE, 'HH24:MI:SS');
END;
/
