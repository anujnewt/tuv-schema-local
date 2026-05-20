CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."FN_DIFTIEMPO" (Li_MinEnt in INTEGER, Li_MinSal in INTEGER) RETURN VARCHAR2
-- -----------------------------------------------------------------
-- sp_diftiempo: Esta Funcion es la que utiliza en el
-- reporte de trabajo del modulo de llamado de Actores de Honorarios
-- para obtener las la diferencia en horas y minutos entre la
-- Hora de Entrada y Salida que se captura en el Llamado.
-- Devuelve un Decimal con el numero de horas y minutos
-- -----------------------------------------------------------------
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   Li_MinDif INTEGER;
   Li_ResMin INTEGER;
   Ls_MinDif VARCHAR2(2);
   Ls_ResMin VARCHAR2(2);
   Li_DifTie VARCHAR2(5);
BEGIN
   Li_MinDif := 0;
   Li_ResMin := 0;
   Ls_MinDif := '';
   Ls_ResMin := '';
   IF Li_MinEnt IS NULL OR Li_MinSal IS NULL THEN
	    RETURN '0.0';
   END IF;
   IF Li_MinEnt = 0 THEN
      RETURN '0.0';
   END IF;
   -- ---------------------------------------------------------
   -- Obtenemos la diferencia entre minutos de entrada y salida
   -- ---------------------------------------------------------
   If Li_MinSal >= Li_MinEnt Then
      Li_MinDif := Li_MinSal - Li_MinEnt;
   Else -- Salio al dia siguiente de que entro
      Li_MinDif := 1440 + Li_MinSal - Li_MinEnt;
   End If;
   Li_ResMin := MOD(Li_MinDif,60);
   Li_MinDif := TRUNC(Li_MinDif / 60);
   Ls_MinDif := Li_MinDif;
   Ls_ResMin := Li_ResMin;
   RETURN Ls_MinDif || '.' || Ls_ResMin ;
 END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."FN_DIFTIEMPO" (Li_MinEnt in INTEGER, Li_MinSal in INTEGER) RETURN VARCHAR2
-- -----------------------------------------------------------------
-- sp_diftiempo: Esta Funcion es la que utiliza en el
-- reporte de trabajo del modulo de llamado de Actores de Honorarios
-- para obtener las la diferencia en horas y minutos entre la
-- Hora de Entrada y Salida que se captura en el Llamado.
-- Devuelve un Decimal con el numero de horas y minutos
-- -----------------------------------------------------------------
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   Li_MinDif INTEGER;
   Li_ResMin INTEGER;
   Ls_MinDif VARCHAR2(2);
   Ls_ResMin VARCHAR2(2);
   Li_DifTie VARCHAR2(5);
BEGIN
   Li_MinDif := 0;
   Li_ResMin := 0;
   Ls_MinDif := '';
   Ls_ResMin := '';
   IF Li_MinEnt IS NULL OR Li_MinSal IS NULL THEN
	    RETURN '0.0';
   END IF;
   IF Li_MinEnt = 0 THEN
      RETURN '0.0';
   END IF;
   -- ---------------------------------------------------------
   -- Obtenemos la diferencia entre minutos de entrada y salida
   -- ---------------------------------------------------------
   If Li_MinSal >= Li_MinEnt Then
      Li_MinDif := Li_MinSal - Li_MinEnt;
   Else -- Salio al dia siguiente de que entro
      Li_MinDif := 1440 + Li_MinSal - Li_MinEnt;
   End If;
   Li_ResMin := MOD(Li_MinDif,60);
   Li_MinDif := TRUNC(Li_MinDif / 60);
   Ls_MinDif := Li_MinDif;
   Ls_ResMin := Li_ResMin;
   RETURN Ls_MinDif || '.' || Ls_ResMin ;
 END;
/
