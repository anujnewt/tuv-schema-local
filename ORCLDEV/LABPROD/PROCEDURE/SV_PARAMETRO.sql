CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_PARAMETRO" (
    nom IN VARCHAR2,
    parametro OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN parametro FOR
  SELECT VAL_PARAM FROM SVCONFIG WHERE NOM_PARAM = nom;
END;
/
