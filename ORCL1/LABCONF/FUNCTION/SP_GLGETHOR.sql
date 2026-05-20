CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABCONF"."SP_GLGETHOR" 
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
    RETURN TO_CHAR (SYSDATE, 'HH24:MI:SS');
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABCONF"."SP_GLGETHOR" 
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
    RETURN TO_CHAR (SYSDATE, 'HH24:MI:SS');
END;
/
