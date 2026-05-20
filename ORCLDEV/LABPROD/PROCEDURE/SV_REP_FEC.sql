CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_REP_FEC" (
    ini IN VARCHAR2,
    fin IN VARCHAR2,
    reporte OUT SYS_REFCURSOR)
    --nom_emp OUT CHAR,
    --fec_ini OUT DATE,
    --fec_fin OUT DATE,
    --dia_tom OUT DECIMAL,
    --per_tom OUT CHAR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  BEGIN
    OPEN reporte FOR
    SELECT emp_nomemp,
      rva_fecini,
      rva_fecfin,
      rva_diadis,
      vac_status
    FROM NMCOEMPL,
      NMCORVAC,
      NMCOCVAC
    WHERE NMCOEMPL.emp_keyemp = NMCORVAC.rva_keyemp
    AND NMCOCVAC.vac_keyemp   = NMCORVAC.rva_keyemp
    AND NMCOCVAC.vac_period   = NMCORVAC.rva_period
    AND (NMCORVAC.rva_fecini BETWEEN ini AND fin)
UNION
  SELECT emp_nomemp,
    dia_ini,
    dia_fin,
    num_dia,
    sta_sol
  FROM SVTEMPSC,
    NMCOEMPL
  WHERE NMCOEMPL.emp_keyemp = SVTEMPSC.num_emp
  AND (SVTEMPSC.dia_ini BETWEEN ini AND fin)
  AND (SVTEMPSC.sta_sol = 'P'
  OR SVTEMPSC.sta_sol   = 'A');
  END;
/
