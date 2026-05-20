CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_DIA_FESTIVO" (
    fec IN VARCHAR,
    ct OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN ct FOR
  SELECT COUNT(*) FROM DIAS_FESTIVOS WHERE fecha = to_date(fec,'yyyy/MM/dd');
END;
/
