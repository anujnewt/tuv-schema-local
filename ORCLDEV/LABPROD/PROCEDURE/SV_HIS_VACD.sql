CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_HIS_VACD" (
    num IN INTEGER,
    his_vacd OUT SYS_REFCURSOR)
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
  OPEN his_vacd FOR SELECT RVA_FECINI, RVA_FECFIN, RVA_DIADIS, RVA_PERIOD FROM NMCORVAC WHERE rva_keyemp = num;
END;
/
