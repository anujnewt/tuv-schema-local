CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_REP_CAN" (
    num IN INTEGER,
    ini IN VARCHAR2,
    fin IN VARCHAR2,
    reporte OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN reporte FOR
   SELECT RVA_FECINI,
      RVA_FECFIN,
      RVA_DIADIS
    FROM NMCORVAC,
      NMCOCVAC
    WHERE NMCOCVAC.vac_keyemp = NMCORVAC.rva_keyemp
    AND trim(NMCOCVAC.vac_period)   = trim(NMCORVAC.rva_period)
    AND NMCOCVAC.vac_status   = 'V'
    AND (NMCORVAC.rva_fecini BETWEEN to_date(ini,'yyyy/MM/dd') AND to_date(fin,'yyyy/MM/dd'))
    AND NMCORVAC.rva_keyemp = num;
END;
/
