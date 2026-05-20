CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."FNJUBILACIONNOACUMULABLE" 
(
  p_import number,
  p_salmes number
)
RETURN number
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  Noacumulable number(12,2);
BEGIN
  Noacumulable := p_salmes;
  IF Noacumulable > p_import THEN
    Noacumulable := 0;
  END IF;
  RETURN Noacumulable;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."FNJUBILACIONNOACUMULABLE" 
(
  p_import number,
  p_salmes number
)
RETURN number
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  Noacumulable number(12,2);
BEGIN
  Noacumulable := p_salmes;
  IF Noacumulable > p_import THEN
    Noacumulable := 0;
  END IF;
  RETURN Noacumulable;
END;
/
