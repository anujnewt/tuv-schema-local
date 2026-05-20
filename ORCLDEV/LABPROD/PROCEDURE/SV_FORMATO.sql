CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_FORMATO" (
    num IN NUMBER,
    formato OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN formato FOR SELECT TO_CHAR(dia_ini, 'dd'), TO_CHAR(dia_ini, 'Month'), TO_CHAR(dia_ini, 'yyyy'), TO_CHAR(dia_fin, 'dd'), TO_CHAR(dia_fin, 'Month'), TO_CHAR(dia_fin, 'yyyy'), num_dia, sta_sol
  FROM SVTEMPSC
  WHERE (SVTEMPSC.sta_sol = 'P' OR SVTEMPSC.sta_sol = 'A') AND SVTEMPSC.num_emp = num;
END;
/
