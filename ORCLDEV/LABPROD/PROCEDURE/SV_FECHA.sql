CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_FECHA" (
    fec OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN fec FOR
  SELECT to_char(SYSDATE,'yyyy-MM-dd'), MIN(vac_keyemp) FROM NMCOCVAC;
END;
/
