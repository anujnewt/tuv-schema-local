CREATE OR REPLACE EDITIONABLE FUNCTION "LABPPTO"."DAY" (ws_dat in date)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Conceptos por Proceso.
    wn_day integer;
BEGIN
    SELECT extract(day from ws_dat)
      INTO wn_day
	FROM dual;
	RETURN wn_day;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "LABPPTO"."DAY" (ws_dat in date)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Conceptos por Proceso.
    wn_day integer;
BEGIN
    SELECT extract(day from ws_dat)
      INTO wn_day
	FROM dual;
	RETURN wn_day;
END;
/
