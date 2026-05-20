CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."FN_VAC_FECINIPER" 
(
  KEYEMP IN NUMBER
, FECSOL IN DATE
, FECING IN DATE
) RETURN DATE AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
NUMANI INTEGER;
FECINI DATE;
ANIO_PER INTEGER;
STR_FECINI VARCHAR2(10);
BEGIN
    --A partir del n?mero de empleado y la fecha de solicitud
    --busca cual ser?a la fecha de inicio del siguiente periodo vacacional
  ANIO_PER := YEAR(FECSOL);
  STR_FECINI := DAY(FECING)||'/'||MONTH(FECING)||'/'||ANIO_PER;
  FECINI := TO_DATE(STR_FECINI,'dd/mm/yyyy');
  IF FECINI < FECSOL THEN
    ANIO_PER := ANIO_PER + 1;
    STR_FECINI := DAY(FECING)||'/'||MONTH(FECING)||'/'||ANIO_PER;
    FECINI := TO_DATE(STR_FECINI,'dd/mm/yyyy');
  END IF;
  RETURN FECINI;
END FN_VAC_FECINIPER;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."FN_VAC_FECINIPER" 
(
  KEYEMP IN NUMBER
, FECSOL IN DATE
, FECING IN DATE
) RETURN DATE AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
NUMANI INTEGER;
FECINI DATE;
ANIO_PER INTEGER;
STR_FECINI VARCHAR2(10);
BEGIN
    --A partir del n?mero de empleado y la fecha de solicitud
    --busca cual ser?a la fecha de inicio del siguiente periodo vacacional
  ANIO_PER := YEAR(FECSOL);
  STR_FECINI := DAY(FECING)||'/'||MONTH(FECING)||'/'||ANIO_PER;
  FECINI := TO_DATE(STR_FECINI,'dd/mm/yyyy');
  IF FECINI < FECSOL THEN
    ANIO_PER := ANIO_PER + 1;
    STR_FECINI := DAY(FECING)||'/'||MONTH(FECING)||'/'||ANIO_PER;
    FECINI := TO_DATE(STR_FECINI,'dd/mm/yyyy');
  END IF;
  RETURN FECINI;
END FN_VAC_FECINIPER;
/
