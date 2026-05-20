CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_AUT_EMP" (
    num IN INTEGER,
    num_temp OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN num_temp FOR
  SELECT plz_cverem,plz_fe1aux FROM EOCOPLZA WHERE plz_keyemp = num;
END;
/
