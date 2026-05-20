CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_REP_EMP" (
    num IN INTEGER,
    reporte OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  BEGIN
    OPEN reporte FOR
    SELECT rva_fecini,
      rva_fecfin,
      rva_diadis,
      rva_period
    FROM NMCORVAC
    WHERE NMCORVAC.rva_keyemp = num
  UNION
  SELECT dia_ini,
    dia_fin,
    num_dia,
    per_vac
  FROM SVTEMPSC
  WHERE SVTEMPSC.sta_sol = 'P'
  AND SVTEMPSC.num_emp   = num;
  END;
/
