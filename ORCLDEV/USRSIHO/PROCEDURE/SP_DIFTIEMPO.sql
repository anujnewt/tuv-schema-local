CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_DIFTIEMPO" (Li_MinEnt in INTEGER, Li_MinSal in INTEGER, Ls_TiempoDif OUT VARCHAR2)
--RETURNING CHAR(6);
--RETURNING DECIMAL(10,2);
-- -----------------------------------------------------------------
-- sp_diftiempo: Este stored procedure es el que utiliza en el
-- reporte de trabajo del modulo de llamado de Actores de Honorarios
-- para obtener las la diferencia en horas y minutos entre la
-- Hora de Entrada y Salida que se captura en el Llamado.
-- Devuelve un Decimal con el numero de horas y minutos
-- Realizado el 29 de Septiembre de 2005
-- Emilio Pulido Rangel
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
      Li_DifTie := '0.0';
	  --RETURN "0.0";
   END IF;
   IF Li_MinEnt = 0 THEN
      Li_DifTie := '0.0';
	  --RETURN "0.0";
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
   Li_MinDif := Li_MinDif / 60;
   Ls_MinDif := Li_MinDif;
   Ls_ResMin := Li_ResMin;
   Li_DifTie := Ls_MinDif || '.' || Ls_ResMin ;
   Ls_TiempoDif := Li_DifTie ;
   --RETURN Ls_MinDif || "." || Ls_ResMin ;
   -- Regresamos en un decimal las horas y minutos
   --LET Li_DifTie = Li_MinDif/60;
   --RETURN Li_DifTie;
END;
/
