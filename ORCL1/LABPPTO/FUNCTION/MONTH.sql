CREATE OR REPLACE EDITIONABLE FUNCTION "LABPPTO"."MONTH" (ws_dat in date)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Conceptos por Proceso.
    wn_month integer;
BEGIN
    SELECT extract(month from ws_dat)
      INTO wn_month
	FROM dual;
	RETURN wn_month;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "LABPPTO"."MONTH" (ws_dat in date)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Conceptos por Proceso.
    wn_month integer;
BEGIN
    SELECT extract(month from ws_dat)
      INTO wn_month
	FROM dual;
	RETURN wn_month;
END;
/
