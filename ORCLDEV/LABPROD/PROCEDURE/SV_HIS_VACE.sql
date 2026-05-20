CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_HIS_VACE" (
    num IN INTEGER,
    his_vace OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN his_vace FOR SELECT vac_keyemp, emp_nomemp, SUM(vac_salper) FROM NMCOCVAC, NMCOEMPL WHERE NMCOEMPL.emp_keyemp = NMCOCVAC.vac_keyemp AND NMCOCVAC.vac_keyemp = num AND NMCOCVAC.vac_status = 'V' GROUP BY emp_nomemp, vac_keyemp;
END;
/
