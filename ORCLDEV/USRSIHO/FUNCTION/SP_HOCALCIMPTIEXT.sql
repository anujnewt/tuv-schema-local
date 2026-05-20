CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HOCALCIMPTIEXT" (Pi_Entrada NUMBER,
                                Pi_Salida NUMBER,
                                Pi_Comida NUMBER,
                                Pi_CapIni NUMBER,
                                Pi_CapFin NUMBER,
                                Ps_Programa VARCHAR2,
                                Pl_KeyFol NUMBER,
                                Pl_KeyPue VARCHAR2,
                                Pd_Costo NUMBER,
                                pi_keytco NUMBER,
                                pi_KeyEmp NUMBER,
                                Pd_FecGra DATE)
RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- -----------------------------------------------------------------
-- CREACION: 			COMENTARIO:				FECHA:
-- Juan Carlos Reyes Olivera	sp_hocalcimptiext: Este stored procedure es el que utiliza en el					07/09/2011
-- 				reporte de trabajo del modulo de llamado de Actores de Honorarios
-- 				para obtener el importe de Tiempo Extra en relaci?? la
-- 				Hora de Entrada y Salida que se captura en el Llamado.
-- 				Devuelve un Decimal con el valor del importe
-- MODIFICO:                    COMENTARIO:				FECHA:
--
--
-- -----------------------------------------------------------------
   -- Definimos variables para los Tipos de jornadas
   Pc_JorNocturna VARCHAR2(1);
   Pc_JorDiurna   VARCHAR2(1);
   Pc_JorMixta    VARCHAR2(1);
   Pc_JorX  VARCHAR2(1);
   -- Definimos variables de Trabajo
   Li_MinEnt NUMBER(10);
   Li_MinSal NUMBER(10);
   Li_MinDif NUMBER(10);
   Li_MinExt NUMBER(10);
   Ls_TipoJornada VARCHAR2(2);
   Li_NumCap NUMBER(10);
   Li_PerTra NUMBER(10);
   Li_TipEmp NUMBER(10);
   Li_TipPro NUMBER(10);
   Li_TipPro1 NUMBER(10);
   Ld_NFactor NUMBER(13,2);
   Ld_NMinJornada60 NUMBER(13,2);
   Ld_NMinJornada30 NUMBER(13,2);
   Ld_NMinJornada15 NUMBER(13,2);
   Ld_MinJor NUMBER(13,2);
   Li_TieExt NUMBER(10,2);
--Declaramos la variable para el calculo de la edad (JCRO)
  Ld_Anios NUMBER;
  Ld_MenorEdad NUMBER;
  Ls_Nacionalidad VARCHAR2(2);
  Li_CodigoAnda NUMBER(10);
BEGIN
  Ld_NMinJornada60 := 0;
  Ld_NMinJornada30 := 0;
  Ld_NMinJornada15 := 0;
  Ld_Anios := 0;
  Ld_MenorEdad := 0;
  Ls_Nacionalidad := '';
  Li_CodigoAnda := 0;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(0,'Ld_NMinJornada60',0,Ld_NMinJornada60);
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(1,'Pi_Entrada',Pi_Entrada,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(2,'Pi_Salida',Pi_Salida,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(3,'Pi_CapIni',Pi_CapIni,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(4,'Pi_CapFin',Pi_CapFin,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(5,'Pl_KeyPue',Pl_KeyPue,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(6,'Pd_Costo',Pd_Costo,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(2,'Pi_Salida',Pi_Salida,'');
--   IF Pi_Entrada = 0 OR Pi_Salida = 0 OR Pi_CapIni = 0 OR Pi_CapFin = 0 OR Pl_KeyPue = 'X' OR Pd_Costo = 0 THEN
--      RETURN 0;
--   END IF;
   IF Pi_Entrada = 0  THEN
      RETURN 0;
   END IF;
   -- Aignamos valores a las variables para los tipos de Jornada
   Pc_JorNocturna := 'N';
   Pc_JorDiurna := 'D';
   Pc_JorMixta := 'M';
   Pc_JorX := 'X';
   -- Obtenemos el minuto de entrada y salida
   Li_MinEnt := Pi_Entrada;
   Li_MinSal := Pi_Salida;
   -- ---------------------------------------------------------
   -- Obtenemos la diferencia entre minutos de entrada y salida
   -- ---------------------------------------------------------
   Li_MinDif := 0;
   If Li_MinSal >= Li_MinEnt Then
      Li_MinDif := Li_MinSal - Li_MinEnt;
   Else -- Salio al d?siguiente de que entro
      Li_MinDif := 1440 + Li_MinSal - Li_MinEnt;
   End If;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(7,'Li_MinDif',Li_MinDif,'');
   -- ---------------------------------------------------------------
   -- Obtenemos el tipo de Jornada deacuerdo a los minutos de entrada
   -- ---------------------------------------------------------------
   If Li_MinEnt >= 0 And Li_MinEnt <= 149 Then
      Ls_TipoJornada := Pc_JorNocturna;
   end if;
   If Li_MinEnt >= 150 And Li_MinEnt <= 359 Then
      Ls_TipoJornada := Pc_JorX;
   end if;
   If Li_MinEnt >= 360 And Li_MinEnt <= 749 Then
      Ls_TipoJornada := Pc_JorDiurna;
   end if;
   If Li_MinEnt >= 750 And Li_MinEnt <= 989 Then
      Ls_TipoJornada := Pc_JorMixta;
   end if;
   If Li_MinEnt >= 990 Then
      Ls_TipoJornada := Pc_JorNocturna;
   End If;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(8,'Ls_TipoJornada',0,Ls_TipoJornada);
   -- -----------------------------
   -- Evaluamos el n??o de capitulos
   -- -----------------------------
   Li_NumCap := Pi_CapFin - Pi_CapIni + 1;    -- + Pf_ObtenTotCapitulos(Pl_KeyFol, Ps_KeyEmp, Pl_KeyPue, Pd_Costo, Pi_Entrada, Pi_Salida, Pi_Comida, Pl_FolioRPH)
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(9,'Li_NumCap',Li_NumCap,'');
   -- ---------------------------------------------------
   -- Leemos el periodo de transmision y tipo de programa
   -- ---------------------------------------------------
   Li_PerTra := 0;
   Li_TipPro := 0;
   SELECT nvl(con_pertra,0)
     INTO Li_PerTra
     FROM USRSIHO.holocont
    WHERE con_keyemp = pi_KeyEmp
      AND con_keyfol = Pl_KeyFol
      AND con_keytco = pi_keytco;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(10,'Li_PerTra',Li_PerTra,'');
   IF Li_PerTra <> 0 THEN
      Li_TipPro := 0;
      SELECT nvl(ALD_KEYTPR,0)
        INTO Li_TipPro
        FROM USRSIHO.NMLOALDE
       WHERE ALD_KEYDEP = Trim(Ps_Programa);
      IF Li_TipPro = 0 THEN
         SELECT ALD_PERTRA,ALD_KEYTPR
           INTO Li_PerTra,Li_TipPro
           FROM USRSIHO.NMLOALDE
          WHERE ALD_KEYDEP =  Trim(Ps_Programa);
      END IF;
   ELSE
      SELECT ALD_PERTRA,ALD_KEYTPR
        INTO Li_PerTra,Li_TipPro
        FROM USRSIHO.NMLOALDE
       WHERE ALD_KEYDEP =  Trim(Ps_Programa);
   END IF;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(11,'Li_TipPro',Li_TipPro,'');
   -- --------------------------
   -- Leemos el tipo de empleado
   -- --------------------------
   Li_TipEmp := 0;
   SELECT Substr(Pue_ca4aux,9, 1)
     INTO Li_TipEmp
     FROM USRSIHO.NMCOPUES
    WHERE Pue_KeyPue = Pl_KeyPue;
   -- -----------------------------------------------------
   -- Obtenemos los a??considerados para el menor de edad
   -- -----------------------------------------------------
   SELECT NVL(pam_folini,0)
     INTO Ld_MenorEdad
     FROM USRSIHO.GLCOPAMS
    WHERE pam_keypar = 'TEME';
   -- -----------------------------------------------------
   -- Obtenemos la nacionalidad del empleado
   -- -----------------------------------------------------
    SELECT emp_ca3aux
      INTO Ls_Nacionalidad
      FROM USRSIHO.NMCOEMPL
     WHERE emp_keyemp = pi_KeyEmp;
   -- -----------------------------------------------------
   -- Obtenemos el codigo de la ANDA
   -- -----------------------------------------------------
    SELECT to_number(pam_folini)
      INTO Li_CodigoAnda
      FROM USRSIHO.glcopams
     WHERE pam_keypar = 'ACP'
       AND pam_folfin = 'CODIGO ANDA';
   -- --------------------------------------------------------------------
   -- Calculamos la edad del empleado para determinar si es menor de edad
   -- --------------------------------------------------------------------
   IF ls_Nacionalidad = '02' THEN
       SELECT to_number((Pd_FecGra - ale_fecnac)/365.25)
         INTO Ld_Anios
         FROM USRSIHO.HOLOALEM
        WHERE ale_keyemp = pi_KeyEmp;
   ELSE
       IF Li_CodigoAnda <> pi_KeyEmp THEN
            SELECT CASE WHEN to_number(SUBSTR(EMP_REGRFC,7,2)) > 0 AND to_number(SUBSTR(EMP_REGRFC,9,2)) > 0 AND to_number(SUBSTR(EMP_REGRFC,5,2)) >= 0 THEN
                         nvl(to_number((Pd_FecGra - TO_DATE(SUBSTR(EMP_REGRFC,7,2) || '/' || SUBSTR(EMP_REGRFC,9,2) || '/' || case when to_number(SUBSTR(EMP_REGRFC,5,2)) >= (extract(year from Pd_FecGra)-2000) then '19' else '20' end || SUBSTR(EMP_REGRFC,5,2)))/365.25),0)
                   ELSE
                         99
                   END
              INTO Ld_Anios
              FROM USRSIHO.nmcoempl
             WHERE emp_keyemp = pi_KeyEmp;
       ELSE
            Ld_Anios := 99;
       END IF;
   END IF;
   -- ---------------------------------------------------------------------------------
   -- Evaluamos y reasignamos el valor del tipo de jornada en caso de ser menor de edad
   -- ---------------------------------------------------------------------------------
   if Ld_Anios < Ld_MenorEdad THEN
       Ls_TipoJornada := 'M' || Ls_TipoJornada;
   END IF;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(12,'Li_TipEmp',Li_TipEmp,'');
   -- -----------------------------------------------
   -- Valuaci??e Ld_NFactor y Ld_NMinJornada60
   -- -----------------------------------------------
   If Li_PerTra > 59 Or Li_NumCap > 1 Or Li_TipEmp = 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada60 := 0;
      SELECT HOE_JORCOS,HOE_JORTIE
        INTO Ld_NFactor,Ld_NMinJornada60
        FROM USRSIHO.HOLOHOEX
       WHERE HOE_PERTRA = '60'
         AND HOE_JORNAD = Ls_TipoJornada;
   End If;
   -- -------------------------------------------
   -- Valuaci??e Ld_NFactor y Ld_NMinJornada30
   -- -------------------------------------------
   IF Li_PerTra = 30 And Li_TipEmp <> 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada30 := 0;
      IF Li_TipPro = 1 THEN
         Li_TipPro1 := Li_TipPro;
      ELSE
         Li_TipPro1 := 0;
      END IF;
      SELECT HOE_JORCOS,HOE_JORTIE
        INTO Ld_NFactor,Ld_NMinJornada30
        FROM USRSIHO.HOLOHOEX
       WHERE HOE_PERTRA = '30'
         AND HOE_KEYTPR = Li_TipPro1;
   END IF;
   -- -------------------------------------------
   -- Valuaci??e Ld_NFactor y Ld_NMinJornada15
   -- -------------------------------------------
   IF Li_PerTra = 15 And Li_TipEmp <> 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada15 := 0;
      SELECT HOE_JORCOS,HOE_JORTIE
        INTO Ld_NFactor,Ld_NMinJornada15
        FROM USRSIHO.HOLOHOEX
       WHERE HOE_PERTRA = '15';
   END IF;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(13,'Ld_NFactor',Ld_NFactor,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(14,'Ld_NMinJornada60',0,Ld_NMinJornada60);
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(15,'Ld_NMinJornada30',0,Ld_NMinJornada30);
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(16,'Ld_NMinJornada15',0,Ld_NMinJornada15);
   -- -------------------------
   -- Asignaci??e Ld_MinJor
   -- -------------------------
   Ld_MinJor := Ld_NMinJornada60;
   IF Li_PerTra = 30 And Li_NumCap = 1 Then
      Ld_MinJor := Ld_NMinJornada30;
   END IF;
   IF Li_PerTra = 15 Then
      Ld_MinJor := Ld_NMinJornada15;
   END IF;
   IF Li_TipEmp = 1 Then
      Ld_MinJor := Ld_NMinJornada60;
   END IF;
   Li_MinExt := 0;
   Ld_MinJor := Ld_MinJor + Pi_Comida;
   IF Li_MinDif > Ld_MinJor Then
      Li_MinExt := Li_MinDif - Ld_MinJor;
   END IF;
   -- Si el tipo es 1 (Telenovela) el n??o de capitulos siempre es uno
   IF Li_TipPro <> 1 And Li_NumCap > 1 Then
      Li_NumCap := 1;
   END IF;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(17,'Ld_MinJor',Ld_MinJor,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(18,'Li_MinExt',Li_MinExt,'');
   -- ----------------------------------------
   -- Evaluaci??e tiempo extra
   -- ----------------------------------------
   -- Obtenemos el Importe de las horas Extras
    Li_TieExt := Pd_Costo * Li_NumCap * Li_MinExt * 2 / Ld_NFactor;
   -- Obtenemos el Numero de horas Extras
   --LET Li_TieExt = ((Li_MinExt/60) * 2);
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(19,'Li_MinExt',Li_MinExt,'');
   RETURN Li_TieExt ;
-- ------------------------------------------------------------------------------------------------
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HOCALCIMPTIEXT" (Pi_Entrada NUMBER,
                                Pi_Salida NUMBER,
                                Pi_Comida NUMBER,
                                Pi_CapIni NUMBER,
                                Pi_CapFin NUMBER,
                                Ps_Programa VARCHAR2,
                                Pl_KeyFol NUMBER,
                                Pl_KeyPue VARCHAR2,
                                Pd_Costo NUMBER,
                                pi_keytco NUMBER,
                                pi_KeyEmp NUMBER,
                                Pd_FecGra DATE)
RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- -----------------------------------------------------------------
-- CREACION: 			COMENTARIO:				FECHA:
-- Juan Carlos Reyes Olivera	sp_hocalcimptiext: Este stored procedure es el que utiliza en el					07/09/2011
-- 				reporte de trabajo del modulo de llamado de Actores de Honorarios
-- 				para obtener el importe de Tiempo Extra en relaci?? la
-- 				Hora de Entrada y Salida que se captura en el Llamado.
-- 				Devuelve un Decimal con el valor del importe
-- MODIFICO:                    COMENTARIO:				FECHA:
--
--
-- -----------------------------------------------------------------
   -- Definimos variables para los Tipos de jornadas
   Pc_JorNocturna VARCHAR2(1);
   Pc_JorDiurna   VARCHAR2(1);
   Pc_JorMixta    VARCHAR2(1);
   Pc_JorX  VARCHAR2(1);
   -- Definimos variables de Trabajo
   Li_MinEnt NUMBER(10);
   Li_MinSal NUMBER(10);
   Li_MinDif NUMBER(10);
   Li_MinExt NUMBER(10);
   Ls_TipoJornada VARCHAR2(2);
   Li_NumCap NUMBER(10);
   Li_PerTra NUMBER(10);
   Li_TipEmp NUMBER(10);
   Li_TipPro NUMBER(10);
   Li_TipPro1 NUMBER(10);
   Ld_NFactor NUMBER(13,2);
   Ld_NMinJornada60 NUMBER(13,2);
   Ld_NMinJornada30 NUMBER(13,2);
   Ld_NMinJornada15 NUMBER(13,2);
   Ld_MinJor NUMBER(13,2);
   Li_TieExt NUMBER(10,2);
--Declaramos la variable para el calculo de la edad (JCRO)
  Ld_Anios NUMBER;
  Ld_MenorEdad NUMBER;
  Ls_Nacionalidad VARCHAR2(2);
  Li_CodigoAnda NUMBER(10);
BEGIN
  Ld_NMinJornada60 := 0;
  Ld_NMinJornada30 := 0;
  Ld_NMinJornada15 := 0;
  Ld_Anios := 0;
  Ld_MenorEdad := 0;
  Ls_Nacionalidad := '';
  Li_CodigoAnda := 0;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(0,'Ld_NMinJornada60',0,Ld_NMinJornada60);
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(1,'Pi_Entrada',Pi_Entrada,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(2,'Pi_Salida',Pi_Salida,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(3,'Pi_CapIni',Pi_CapIni,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(4,'Pi_CapFin',Pi_CapFin,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(5,'Pl_KeyPue',Pl_KeyPue,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(6,'Pd_Costo',Pd_Costo,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(2,'Pi_Salida',Pi_Salida,'');
--   IF Pi_Entrada = 0 OR Pi_Salida = 0 OR Pi_CapIni = 0 OR Pi_CapFin = 0 OR Pl_KeyPue = 'X' OR Pd_Costo = 0 THEN
--      RETURN 0;
--   END IF;
   IF Pi_Entrada = 0  THEN
      RETURN 0;
   END IF;
   -- Aignamos valores a las variables para los tipos de Jornada
   Pc_JorNocturna := 'N';
   Pc_JorDiurna := 'D';
   Pc_JorMixta := 'M';
   Pc_JorX := 'X';
   -- Obtenemos el minuto de entrada y salida
   Li_MinEnt := Pi_Entrada;
   Li_MinSal := Pi_Salida;
   -- ---------------------------------------------------------
   -- Obtenemos la diferencia entre minutos de entrada y salida
   -- ---------------------------------------------------------
   Li_MinDif := 0;
   If Li_MinSal >= Li_MinEnt Then
      Li_MinDif := Li_MinSal - Li_MinEnt;
   Else -- Salio al d?siguiente de que entro
      Li_MinDif := 1440 + Li_MinSal - Li_MinEnt;
   End If;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(7,'Li_MinDif',Li_MinDif,'');
   -- ---------------------------------------------------------------
   -- Obtenemos el tipo de Jornada deacuerdo a los minutos de entrada
   -- ---------------------------------------------------------------
   If Li_MinEnt >= 0 And Li_MinEnt <= 149 Then
      Ls_TipoJornada := Pc_JorNocturna;
   end if;
   If Li_MinEnt >= 150 And Li_MinEnt <= 359 Then
      Ls_TipoJornada := Pc_JorX;
   end if;
   If Li_MinEnt >= 360 And Li_MinEnt <= 749 Then
      Ls_TipoJornada := Pc_JorDiurna;
   end if;
   If Li_MinEnt >= 750 And Li_MinEnt <= 989 Then
      Ls_TipoJornada := Pc_JorMixta;
   end if;
   If Li_MinEnt >= 990 Then
      Ls_TipoJornada := Pc_JorNocturna;
   End If;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(8,'Ls_TipoJornada',0,Ls_TipoJornada);
   -- -----------------------------
   -- Evaluamos el n??o de capitulos
   -- -----------------------------
   Li_NumCap := Pi_CapFin - Pi_CapIni + 1;    -- + Pf_ObtenTotCapitulos(Pl_KeyFol, Ps_KeyEmp, Pl_KeyPue, Pd_Costo, Pi_Entrada, Pi_Salida, Pi_Comida, Pl_FolioRPH)
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(9,'Li_NumCap',Li_NumCap,'');
   -- ---------------------------------------------------
   -- Leemos el periodo de transmision y tipo de programa
   -- ---------------------------------------------------
   Li_PerTra := 0;
   Li_TipPro := 0;
   SELECT nvl(con_pertra,0)
     INTO Li_PerTra
     FROM USRSIHO.holocont
    WHERE con_keyemp = pi_KeyEmp
      AND con_keyfol = Pl_KeyFol
      AND con_keytco = pi_keytco;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(10,'Li_PerTra',Li_PerTra,'');
   IF Li_PerTra <> 0 THEN
      Li_TipPro := 0;
      SELECT nvl(ALD_KEYTPR,0)
        INTO Li_TipPro
        FROM USRSIHO.NMLOALDE
       WHERE ALD_KEYDEP = Trim(Ps_Programa);
      IF Li_TipPro = 0 THEN
         SELECT ALD_PERTRA,ALD_KEYTPR
           INTO Li_PerTra,Li_TipPro
           FROM USRSIHO.NMLOALDE
          WHERE ALD_KEYDEP =  Trim(Ps_Programa);
      END IF;
   ELSE
      SELECT ALD_PERTRA,ALD_KEYTPR
        INTO Li_PerTra,Li_TipPro
        FROM USRSIHO.NMLOALDE
       WHERE ALD_KEYDEP =  Trim(Ps_Programa);
   END IF;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(11,'Li_TipPro',Li_TipPro,'');
   -- --------------------------
   -- Leemos el tipo de empleado
   -- --------------------------
   Li_TipEmp := 0;
   SELECT Substr(Pue_ca4aux,9, 1)
     INTO Li_TipEmp
     FROM USRSIHO.NMCOPUES
    WHERE Pue_KeyPue = Pl_KeyPue;
   -- -----------------------------------------------------
   -- Obtenemos los a??considerados para el menor de edad
   -- -----------------------------------------------------
   SELECT NVL(pam_folini,0)
     INTO Ld_MenorEdad
     FROM USRSIHO.GLCOPAMS
    WHERE pam_keypar = 'TEME';
   -- -----------------------------------------------------
   -- Obtenemos la nacionalidad del empleado
   -- -----------------------------------------------------
    SELECT emp_ca3aux
      INTO Ls_Nacionalidad
      FROM USRSIHO.NMCOEMPL
     WHERE emp_keyemp = pi_KeyEmp;
   -- -----------------------------------------------------
   -- Obtenemos el codigo de la ANDA
   -- -----------------------------------------------------
    SELECT to_number(pam_folini)
      INTO Li_CodigoAnda
      FROM USRSIHO.glcopams
     WHERE pam_keypar = 'ACP'
       AND pam_folfin = 'CODIGO ANDA';
   -- --------------------------------------------------------------------
   -- Calculamos la edad del empleado para determinar si es menor de edad
   -- --------------------------------------------------------------------
   IF ls_Nacionalidad = '02' THEN
       SELECT to_number((Pd_FecGra - ale_fecnac)/365.25)
         INTO Ld_Anios
         FROM USRSIHO.HOLOALEM
        WHERE ale_keyemp = pi_KeyEmp;
   ELSE
       IF Li_CodigoAnda <> pi_KeyEmp THEN
            SELECT CASE WHEN to_number(SUBSTR(EMP_REGRFC,7,2)) > 0 AND to_number(SUBSTR(EMP_REGRFC,9,2)) > 0 AND to_number(SUBSTR(EMP_REGRFC,5,2)) >= 0 THEN
                         nvl(to_number((Pd_FecGra - TO_DATE(SUBSTR(EMP_REGRFC,7,2) || '/' || SUBSTR(EMP_REGRFC,9,2) || '/' || case when to_number(SUBSTR(EMP_REGRFC,5,2)) >= (extract(year from Pd_FecGra)-2000) then '19' else '20' end || SUBSTR(EMP_REGRFC,5,2)))/365.25),0)
                   ELSE
                         99
                   END
              INTO Ld_Anios
              FROM USRSIHO.nmcoempl
             WHERE emp_keyemp = pi_KeyEmp;
       ELSE
            Ld_Anios := 99;
       END IF;
   END IF;
   -- ---------------------------------------------------------------------------------
   -- Evaluamos y reasignamos el valor del tipo de jornada en caso de ser menor de edad
   -- ---------------------------------------------------------------------------------
   if Ld_Anios < Ld_MenorEdad THEN
       Ls_TipoJornada := 'M' || Ls_TipoJornada;
   END IF;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(12,'Li_TipEmp',Li_TipEmp,'');
   -- -----------------------------------------------
   -- Valuaci??e Ld_NFactor y Ld_NMinJornada60
   -- -----------------------------------------------
   If Li_PerTra > 59 Or Li_NumCap > 1 Or Li_TipEmp = 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada60 := 0;
      SELECT HOE_JORCOS,HOE_JORTIE
        INTO Ld_NFactor,Ld_NMinJornada60
        FROM USRSIHO.HOLOHOEX
       WHERE HOE_PERTRA = '60'
         AND HOE_JORNAD = Ls_TipoJornada;
   End If;
   -- -------------------------------------------
   -- Valuaci??e Ld_NFactor y Ld_NMinJornada30
   -- -------------------------------------------
   IF Li_PerTra = 30 And Li_TipEmp <> 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada30 := 0;
      IF Li_TipPro = 1 THEN
         Li_TipPro1 := Li_TipPro;
      ELSE
         Li_TipPro1 := 0;
      END IF;
      SELECT HOE_JORCOS,HOE_JORTIE
        INTO Ld_NFactor,Ld_NMinJornada30
        FROM USRSIHO.HOLOHOEX
       WHERE HOE_PERTRA = '30'
         AND HOE_KEYTPR = Li_TipPro1;
   END IF;
   -- -------------------------------------------
   -- Valuaci??e Ld_NFactor y Ld_NMinJornada15
   -- -------------------------------------------
   IF Li_PerTra = 15 And Li_TipEmp <> 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada15 := 0;
      SELECT HOE_JORCOS,HOE_JORTIE
        INTO Ld_NFactor,Ld_NMinJornada15
        FROM USRSIHO.HOLOHOEX
       WHERE HOE_PERTRA = '15';
   END IF;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(13,'Ld_NFactor',Ld_NFactor,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(14,'Ld_NMinJornada60',0,Ld_NMinJornada60);
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(15,'Ld_NMinJornada30',0,Ld_NMinJornada30);
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(16,'Ld_NMinJornada15',0,Ld_NMinJornada15);
   -- -------------------------
   -- Asignaci??e Ld_MinJor
   -- -------------------------
   Ld_MinJor := Ld_NMinJornada60;
   IF Li_PerTra = 30 And Li_NumCap = 1 Then
      Ld_MinJor := Ld_NMinJornada30;
   END IF;
   IF Li_PerTra = 15 Then
      Ld_MinJor := Ld_NMinJornada15;
   END IF;
   IF Li_TipEmp = 1 Then
      Ld_MinJor := Ld_NMinJornada60;
   END IF;
   Li_MinExt := 0;
   Ld_MinJor := Ld_MinJor + Pi_Comida;
   IF Li_MinDif > Ld_MinJor Then
      Li_MinExt := Li_MinDif - Ld_MinJor;
   END IF;
   -- Si el tipo es 1 (Telenovela) el n??o de capitulos siempre es uno
   IF Li_TipPro <> 1 And Li_NumCap > 1 Then
      Li_NumCap := 1;
   END IF;
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(17,'Ld_MinJor',Ld_MinJor,'');
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(18,'Li_MinExt',Li_MinExt,'');
   -- ----------------------------------------
   -- Evaluaci??e tiempo extra
   -- ----------------------------------------
   -- Obtenemos el Importe de las horas Extras
    Li_TieExt := Pd_Costo * Li_NumCap * Li_MinExt * 2 / Ld_NFactor;
   -- Obtenemos el Numero de horas Extras
   --LET Li_TieExt = ((Li_MinExt/60) * 2);
--INSERT INTO borra(sec,campo1,campo2,campo3) VALUES(19,'Li_MinExt',Li_MinExt,'');
   RETURN Li_TieExt ;
-- ------------------------------------------------------------------------------------------------
END;
/
