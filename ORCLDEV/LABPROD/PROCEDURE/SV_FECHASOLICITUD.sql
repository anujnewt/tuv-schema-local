CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_FECHASOLICITUD" (
    num_empleado IN INTEGER,
    fec_s OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN fec_s FOR
  SELECT fec_sol   FROM svtempsc WHERE svtempsc.num_emp=num_empleado and svtempsc.sta_sol='P';
END;
/
