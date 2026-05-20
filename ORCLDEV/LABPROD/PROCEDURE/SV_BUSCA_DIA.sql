CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_BUSCA_DIA" (
    numero IN INTEGER,
    busca_dia OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN busca_dia FOR
      SELECT num_dia, is_medio, per_vac FROM SVTEMPDIA WHERE num_emp = numero;
END;
/
