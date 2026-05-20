CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_GLFECHOR" (wd_fecha OUT VARCHAR2,
                                           ws_hora OUT  VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
	 wd_fecha := TO_CHAR (SYSDATE, 'dd/mm/yyyy');
	 ws_hora  := TO_CHAR (SYSDATE, 'HH24:MI:SS');
END;
/
