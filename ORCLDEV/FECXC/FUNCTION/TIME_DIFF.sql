CREATE OR REPLACE EDITIONABLE FUNCTION "FECXC"."TIME_DIFF" (
	METRICA IN VARCHAR2 DEFAULT ('S'),
	FECHA_1 IN DATE,
	FECHA_2 IN DATE
) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	NFECHA_1 NUMBER;
	NFECHA_2 NUMBER;
	NSEGUNDOS_1 NUMBER(5,0);
	NSEGUNDOS_2 NUMBER(5,0);
	TIEMPO NUMBER;
BEGIN
	-- Toma el # de la Fecha Juliana de la Primera Fecha
	NFECHA_1 := TO_NUMBER(TO_CHAR(FECHA_1, 'J'));
	-- Toma el # de la Fecha Juliana de la Segunda Fecha
	NFECHA_2 := TO_NUMBER(TO_CHAR(FECHA_2, 'J'));
	-- Toma segundos desde la medianoche de la Primera Fecha
	NSEGUNDOS_1 := TO_NUMBER(TO_CHAR(FECHA_1, 'SSSSS'));
	-- Toma segundos desde la medianoche de la Segunda Fecha
	NSEGUNDOS_2 := TO_NUMBER(TO_CHAR(FECHA_2, 'SSSSS'));
	TIEMPO:= ((NFECHA_2 - NFECHA_1) * 86400)+(NSEGUNDOS_2 - NSEGUNDOS_1);
	-- Define la respuesta en funcion de la metrica
	TIEMPO:= FLOOR (TIEMPO / CASE UPPER (METRICA)
			 WHEN 'Y' THEN (12 * 30.4167 * 60 * 60 * 24)
			 WHEN 'M' THEN (30.4167 * 60 * 60 * 24)
			 WHEN 'D' THEN (60 * 60 * 24)
			 WHEN 'H' THEN (60 * 60)
			 WHEN 'MI' THEN 60
			 ELSE 1 END);
	RETURN (TIEMPO);
END TIME_DIFF;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "FECXC"."TIME_DIFF" (
	METRICA IN VARCHAR2 DEFAULT ('S'),
	FECHA_1 IN DATE,
	FECHA_2 IN DATE
) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	NFECHA_1 NUMBER;
	NFECHA_2 NUMBER;
	NSEGUNDOS_1 NUMBER(5,0);
	NSEGUNDOS_2 NUMBER(5,0);
	TIEMPO NUMBER;
BEGIN
	-- Toma el # de la Fecha Juliana de la Primera Fecha
	NFECHA_1 := TO_NUMBER(TO_CHAR(FECHA_1, 'J'));
	-- Toma el # de la Fecha Juliana de la Segunda Fecha
	NFECHA_2 := TO_NUMBER(TO_CHAR(FECHA_2, 'J'));
	-- Toma segundos desde la medianoche de la Primera Fecha
	NSEGUNDOS_1 := TO_NUMBER(TO_CHAR(FECHA_1, 'SSSSS'));
	-- Toma segundos desde la medianoche de la Segunda Fecha
	NSEGUNDOS_2 := TO_NUMBER(TO_CHAR(FECHA_2, 'SSSSS'));
	TIEMPO:= ((NFECHA_2 - NFECHA_1) * 86400)+(NSEGUNDOS_2 - NSEGUNDOS_1);
	-- Define la respuesta en funcion de la metrica
	TIEMPO:= FLOOR (TIEMPO / CASE UPPER (METRICA)
			 WHEN 'Y' THEN (12 * 30.4167 * 60 * 60 * 24)
			 WHEN 'M' THEN (30.4167 * 60 * 60 * 24)
			 WHEN 'D' THEN (60 * 60 * 24)
			 WHEN 'H' THEN (60 * 60)
			 WHEN 'MI' THEN 60
			 ELSE 1 END);
	RETURN (TIEMPO);
END TIME_DIFF;
/
