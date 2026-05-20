CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_DAT_PER" (
    num IN INTEGER,
    dat_per OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN dat_per FOR
  SELECT vac_period,
      vac_antigu,
      vac_fecini,
      vac_fecfin,
      vac_fecpre,
      vac_diavac,
      vac_dtomad,
      vac_salper,
      vac_status
    FROM NMCOCVAC
    WHERE vac_status = 'V'
    AND vac_keyemp   = num;
END;
/
