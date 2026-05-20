CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."YEAR" (ws_dat in date)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Conceptos por Proceso.
    wn_year integer;
BEGIN
    SELECT extract(year from ws_dat)
      INTO wn_year
	FROM dual;
	RETURN wn_year;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."YEAR" (ws_dat in date)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Conceptos por Proceso.
    wn_year integer;
BEGIN
    SELECT extract(year from ws_dat)
      INTO wn_year
	FROM dual;
	RETURN wn_year;
END;
/
