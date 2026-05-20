CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_HIS_COLA" (
    emp IN INTEGER,
    num IN INTEGER,
    his_cola OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  BEGIN
    OPEN his_cola FOR
    SELECT emp_nomemp,
      rva_fecini,
      rva_fecfin,
      rva_diadis,
      rva_period
    FROM NMCOEMPL,
      NMCORVAC,
      EOCOPLZA
    WHERE NMCOEMPL.emp_keyemp = NMCORVAC.rva_keyemp
    AND NMCORVAC.rva_fecini BETWEEN
      (SELECT MAX(dia_ini) FROM SVTEMPSC WHERE num_emp = emp AND sta_sol = 'P'
      )
  AND (SELECT MAX(dia_ini) FROM SVTEMPSC WHERE num_emp = emp AND sta_sol = 'P') + 10
  AND NMCORVAC.rva_keyemp = EOCOPLZA.plz_keyemp
  AND EOCOPLZA.plz_cverem = num
  AND NMCORVAC.rva_diadis > 0;
  END;
/
