CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_BORRA_DIA" (
    numero IN NUMBER)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  DELETE FROM SVTEMPDIA WHERE num_emp = numero;
END;
/
