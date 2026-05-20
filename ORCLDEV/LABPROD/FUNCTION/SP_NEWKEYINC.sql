CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."SP_NEWKEYINC" RETURN number IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 num_sec integer;
BEGIN
     SELECT LABPROD.NMCOINCI_SEQ.NEXTVAL INTO num_sec FROM DUAL;
     RETURN num_sec;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."SP_NEWKEYINC" RETURN number IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 num_sec integer;
BEGIN
     SELECT LABPROD.NMCOINCI_SEQ.NEXTVAL INTO num_sec FROM DUAL;
     RETURN num_sec;
END;
/
