CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_REP_MED" (
    val_num IN INTEGER,
    reporte OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN reporte FOR
  SELECT TO_CHAR(NUM_DIA, 'dd'),
      TO_CHAR(NUM_DIA, 'Month'),
      TO_CHAR(NUM_DIA, 'yyyy'),
      (
      CASE is_medio
        WHEN 0
        THEN 1.0
        WHEN 1
        THEN 0.5
      END)
    FROM SVTEMPDIA
    WHERE NUM_EMP= val_num;
END;
/
