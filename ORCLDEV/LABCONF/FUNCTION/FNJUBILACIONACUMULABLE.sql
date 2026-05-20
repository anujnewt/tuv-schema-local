CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."FNJUBILACIONACUMULABLE" 
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
  acumulable number(12,2);
BEGIN
  acumulable := p_import - p_salmes;
  IF acumulable < 0 THEN
    acumulable := 0;
  END IF;
  RETURN acumulable;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."FNJUBILACIONACUMULABLE" 
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
  acumulable number(12,2);
BEGIN
  acumulable := p_import - p_salmes;
  IF acumulable < 0 THEN
    acumulable := 0;
  END IF;
  RETURN acumulable;
END;
/
