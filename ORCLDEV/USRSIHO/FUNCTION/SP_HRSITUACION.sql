CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HRSITUACION" 
                            (vn_keypro   IN INTEGER,
                             vs_keyper   IN VARCHAR2,
                             vn_keyemp   IN INTEGER) RETURN INTEGER
  -- Original : SIPROS, S. A. DE C. V.
  -- Cambio   : Software and Tech sa de cv
  --
  -- Sistema  : RH-2000  C/S
  -- Modulo   : Reportes Fiscales
  -- Programa : sp_hrsituacion
  --            Determinar la situacion fiscal del empleado para un periodo de nomina
  -- Autor    : Armando Villegas Barba
  -- Fecha    : 11 de Junio de 2004
  -- Cambio   : 01 de septiembre de 2017
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   vn_regimen     INTEGER;
BEGIN
-- INICIALIZA VARIABLES
   vn_regimen := 0;
-- OBTIENE EL REGIMEN DEL EMPLEADO
	SELECT nvl(SUM(his_import),0)
	 INTO vn_regimen
	 FROM nmlohism
	WHERE his_keypro = vn_keypro
	  AND his_keyper = vs_keyper
	  AND his_keyemp = vn_keyemp
	  AND his_keycon = 'H87';
   RETURN vn_regimen;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HRSITUACION" 
                            (vn_keypro   IN INTEGER,
                             vs_keyper   IN VARCHAR2,
                             vn_keyemp   IN INTEGER) RETURN INTEGER
  -- Original : SIPROS, S. A. DE C. V.
  -- Cambio   : Software and Tech sa de cv
  --
  -- Sistema  : RH-2000  C/S
  -- Modulo   : Reportes Fiscales
  -- Programa : sp_hrsituacion
  --            Determinar la situacion fiscal del empleado para un periodo de nomina
  -- Autor    : Armando Villegas Barba
  -- Fecha    : 11 de Junio de 2004
  -- Cambio   : 01 de septiembre de 2017
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   vn_regimen     INTEGER;
BEGIN
-- INICIALIZA VARIABLES
   vn_regimen := 0;
-- OBTIENE EL REGIMEN DEL EMPLEADO
	SELECT nvl(SUM(his_import),0)
	 INTO vn_regimen
	 FROM nmlohism
	WHERE his_keypro = vn_keypro
	  AND his_keyper = vs_keyper
	  AND his_keyemp = vn_keyemp
	  AND his_keycon = 'H87';
   RETURN vn_regimen;
END;
/
