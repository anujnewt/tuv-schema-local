CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HOCALCTIEXT1" (Pi_Entrada NUMBER,
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
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- -----------------------------------------------------------------
-- sp_hocalctiext: Este stored procedure es el que utiliza en el
-- reporte de trabajo del modulo de llamado de Actores de Honorarios
-- para obtener las horas y minutos de Tiempo Extra en relaci?n a la
-- Hora de Entrada y Salida que se captura en el Llamado.
-- Devuelve un VARCHAR2 con el importe y el numero de horas y minutos
-- Realizado el 26 de Octubre de 2016
-- Paul Henderson Marin
-- MODIFICO:                    COMENTARIO:				FECHA:
-- 					  Se genera a partir de 		26/10/2016
--                              sp_hocalctiext para obtener
--					  tanto el importe como las
--					  horas de tiempo extra
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
   Li_TieExtHrs NUMBER(10,2);
   Li_TieExtImp NUMBER(10,2);
   Ls_TieExtMix VARCHAR2(20);
--Declaramos la variable para el calculo de la edad (JCRO)
  Ld_Anios NUMBER;
  Ld_MenorEdad NUMBER;
  Ls_Nacionalidad VARCHAR2(2);
  Li_CodigoAnda NUMBER(10);
  Li_TieExt NUMBER(10,2);
  Ls_regrfc VARCHAR2(13);
BEGIN
  Ld_NMinJornada60 := 0;
  Ld_NMinJornada30 := 0;
  Ld_NMinJornada15 := 0;
  Ld_Anios := 0;
  Ld_MenorEdad := 0;
  Ls_Nacionalidad := '';
  Li_CodigoAnda := 0;
    Li_TieExt := 0;
   IF Pi_Entrada = 0  THEN
      RETURN  Li_TieExt;
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
   Else -- Salio al d?a siguiente de que entro
      Li_MinDif := 1440 + Li_MinSal - Li_MinEnt;
   End If;
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
   -- -----------------------------
   -- Evaluamos el n?mero de capitulos
   -- -----------------------------
   Li_NumCap := Pi_CapFin - Pi_CapIni + 1;    -- + Pf_ObtenTotCapitulos(Pl_KeyFol, Ps_KeyEmp, Pl_KeyPue, Pd_Costo, Pi_Entrada, Pi_Salida, Pi_Comida, Pl_FolioRPH)
   -- ---------------------------------------------------
   -- Leemos el periodo de transmision y tipo de programa
   -- ---------------------------------------------------
   Li_PerTra := 0;
   Li_TipPro := 0;
   Select nvl(con_pertra,0)
     Into Li_PerTra
    From USRSIHO.holocont
   Where con_keyemp = pi_KeyEmp
     And con_keyfol = Pl_KeyFol
     And con_keytco = pi_keytco;
   IF Li_PerTra <> 0 THEN
      Li_TipPro := 0;
      Select nvl(ALD_KEYTPR,0)
        Into Li_TipPro
       From USRSIHO.NMLOALDE
      Where ALD_KEYDEP = Trim(Ps_Programa);
      IF Li_TipPro = 0 THEN
         Select ALD_PERTRA,ALD_KEYTPR
           Into Li_PerTra,Li_TipPro
           From USRSIHO.NMLOALDE
          Where ALD_KEYDEP =  Trim(Ps_Programa);
      End If;
   Else
      Select ALD_PERTRA,ALD_KEYTPR
        Into Li_PerTra,Li_TipPro
        From USRSIHO.NMLOALDE
       Where ALD_KEYDEP =  Trim(Ps_Programa);
   End If;
   -- --------------------------
   -- Leemos el tipo de empleado
   -- --------------------------
   Li_TipEmp := 0;
   Select Substr(Pue_ca4aux,9, 1)
     Into Li_TipEmp
     From USRSIHO.NMCOPUES
    Where Pue_KeyPue = Pl_KeyPue;
   -- //INICIO CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 07/09/2011
   -- -----------------------------------------------------
   -- Obtenemos los a?os considerados para el menor de edad
   -- -----------------------------------------------------
   SELECT NVL(PAM_FOLINI,0)
     INTO Ld_MenorEdad
     FROM USRSIHO.GLCOPAMS
    WHERE PAM_KEYPAR = 'TEME';
   -- -----------------------------------------------------
   -- Obtenemos la nacionalidad del empleado
   -- -----------------------------------------------------
    SELECT EMP_CA3AUX
      INTO Ls_Nacionalidad
      FROM USRSIHO.NMCOEMPL
     WHERE EMP_KEYEMP = pi_KeyEmp;
   -- -----------------------------------------------------
   -- Obtenemos el codigo de la ANDA
   -- -----------------------------------------------------
    SELECT to_number(PAM_FOLINI)
      INTO Li_CodigoAnda
      FROM USRSIHO.GLCOPAMS
     WHERE PAM_KEYPAR = 'ACP'
       AND PAM_FOLFIN= 'CODIGO ANDA';
   -- --------------------------------------------------------------------
   -- Calculamos la edad del empleado para determinar si es menor de edad
   -- --------------------------------------------------------------------
   IF ls_Nacionalidad = '02' THEN
       SELECT to_number((Pd_FecGra - ALE_FECNAC)/365.25)
         INTO Ld_Anios
         FROM USRSIHO.HOLOALEM
        WHERE ALE_KEYEMP= pi_KeyEmp;
   ELSE
       IF Li_CodigoAnda <> pi_KeyEmp THEN
          SELECT EMP_REGRFC INTO Ls_regrfc
          FROM USRSIHO.NMCOEMPL
          WHERE EMP_KEYEMP = pi_KeyEmp;
          IF to_number(SUBSTR(Ls_regrfc,7,2)) > 0 AND to_number(SUBSTR(Ls_regrfc,9,2)) > 0 AND to_number(SUBSTR(Ls_regrfc,5,2)) >= 0 THEN
            IF substr(Ls_regrfc,5,2) > SUBSTR(year(sysdate) + 5, 3,2) THEN
              Ld_Anios := (Pd_FecGra - to_date('19'||substr(Ls_regrfc,5,2)||'/'||substr(Ls_regrfc,7,2)||'/'||substr(Ls_regrfc,9,2),'yyyy/mm/dd')) /365.25;
            ELSE
              Ld_Anios := (Pd_FecGra - to_date('20'||substr(Ls_regrfc,5,2)||'/'||substr(Ls_regrfc,7,2)||'/'||substr(Ls_regrfc,9,2),'yyyy/mm/dd')) /365.25;
            END IF;
          ELSE
            Ld_Anios := 99;
          END IF;
          /*  SELECT CASE WHEN to_number(SUBSTR(EMP_REGRFC,7,2)) > 0 AND to_number(SUBSTR(EMP_REGRFC,9,2)) > 0 AND to_number(SUBSTR(EMP_REGRFC,5,2)) >= 0 THEN
              (Pd_FecGra - to_date(substr(emp_regrfc,5,2)||'/'||substr(emp_regrfc,7,2)||'/'||substr(emp_regrfc,9,2),'RR/mm/dd')) /365.25
                   ELSE
                         99
                   END
              INTO Ld_Anios
              FROM USRSIHO.NMCOEMPL
             WHERE EMP_KEYEMP = pi_KeyEmp;*/
       ELSE
            Ld_Anios := 99;
       END IF;
   END IF;
   -- ---------------------------------------------------------------------------------
   -- Evaluamos y reasignamos el valor del tipo de jornada en caso de ser menor de edad
   -- ---------------------------------------------------------------------------------
   IF Ld_Anios < Ld_MenorEdad THEN
      Ls_TipoJornada := 'M' || Ls_TipoJornada;
   END IF;
   -- //FIN CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 07/09/2011
--insert into borra(sec,campo1,campo2,campo3) VALUES(12,'Li_TipEmp',Li_TipEmp,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(12,'Pi_Comida',Pi_Comida,'Despues de validar');
   -- -----------------------------------------------
   -- Valuaci?n de Ld_NFactor y Ld_NMinJornada60
   -- -----------------------------------------------
   IF Li_PerTra > 59 Or Li_NumCap > 1 Or Li_TipEmp = 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada60 := 0;
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada60
        From USRSIHO.HOLOHOEX
       Where HOE_PERTRA = '60'
         And HOE_JORNAD = Ls_TipoJornada;
   End If;
   -- -------------------------------------------
   -- Valuaci?n de Ld_NFactor y Ld_NMinJornada30
   -- -------------------------------------------
   IF Li_PerTra = 30 And Li_TipEmp <> 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada30 := 0;
      IF Li_TipPro = 1 THEN
         Li_TipPro1 := Li_TipPro;
      ELSE
         Li_TipPro1 := 0;
      END IF;
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada30
        From USRSIHO.HOLOHOEX
       Where HOE_PERTRA = '30'
         And HOE_KEYTPR = Li_TipPro1;
   End If;
   -- -------------------------------------------
   -- Valuaci?n de Ld_NFactor y Ld_NMinJornada15
   -- -------------------------------------------
   IF Li_PerTra = 15 And Li_TipEmp <> 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada15 := 0;
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada15
        From USRSIHO.HOLOHOEX
       Where HOE_PERTRA = '15';
   End If;
   -- -------------------------
   -- Asignaci?n de Ld_MinJor
   -- -------------------------
   Ld_MinJor := Ld_NMinJornada60;
   If Li_PerTra = 30 And Li_NumCap = 1 Then
      Ld_MinJor := Ld_NMinJornada30;
   End If;
   If Li_PerTra = 15 Then
      Ld_MinJor := Ld_NMinJornada15;
   End If;
   If Li_TipEmp = 1 Then
      Ld_MinJor := Ld_NMinJornada60;
   End If;
   Li_MinExt := 0;
   Ld_MinJor := Ld_MinJor + Pi_Comida;
   If Li_MinDif > Ld_MinJor Then
      Li_MinExt := Li_MinDif - Ld_MinJor;
   End If;
   -- Si el tipo es 1 (Telenovela) el n?mero de capitulos siempre es uno
   If Li_TipPro <> 1 And Li_NumCap > 1 Then
      Li_NumCap := 1;
   End If;
   -- ----------------------------------------
   -- Evaluaci?n de tiempo extra
   -- ----------------------------------------
   -- Obtenemos el Importe de las horas Extras
   Li_TieExtImp := Pd_Costo * Li_NumCap * Li_MinExt * 2 / Ld_NFactor;
   -- Obtenemos el Numero de horas Extras
   Li_TieExtHrs := ((Li_MinExt/60) * 2);
   Ls_TieExtMix := Li_TieExtImp || 'H' || Li_TieExtHrs;
   RETURN Ls_TieExtMix ;
-- ------------------------------------------------------------------------------------------------
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HOCALCTIEXT1" (Pi_Entrada NUMBER,
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
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- -----------------------------------------------------------------
-- sp_hocalctiext: Este stored procedure es el que utiliza en el
-- reporte de trabajo del modulo de llamado de Actores de Honorarios
-- para obtener las horas y minutos de Tiempo Extra en relaci?n a la
-- Hora de Entrada y Salida que se captura en el Llamado.
-- Devuelve un VARCHAR2 con el importe y el numero de horas y minutos
-- Realizado el 26 de Octubre de 2016
-- Paul Henderson Marin
-- MODIFICO:                    COMENTARIO:				FECHA:
-- 					  Se genera a partir de 		26/10/2016
--                              sp_hocalctiext para obtener
--					  tanto el importe como las
--					  horas de tiempo extra
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
   Li_TieExtHrs NUMBER(10,2);
   Li_TieExtImp NUMBER(10,2);
   Ls_TieExtMix VARCHAR2(20);
--Declaramos la variable para el calculo de la edad (JCRO)
  Ld_Anios NUMBER;
  Ld_MenorEdad NUMBER;
  Ls_Nacionalidad VARCHAR2(2);
  Li_CodigoAnda NUMBER(10);
  Li_TieExt NUMBER(10,2);
  Ls_regrfc VARCHAR2(13);
BEGIN
  Ld_NMinJornada60 := 0;
  Ld_NMinJornada30 := 0;
  Ld_NMinJornada15 := 0;
  Ld_Anios := 0;
  Ld_MenorEdad := 0;
  Ls_Nacionalidad := '';
  Li_CodigoAnda := 0;
    Li_TieExt := 0;
   IF Pi_Entrada = 0  THEN
      RETURN  Li_TieExt;
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
   Else -- Salio al d?a siguiente de que entro
      Li_MinDif := 1440 + Li_MinSal - Li_MinEnt;
   End If;
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
   -- -----------------------------
   -- Evaluamos el n?mero de capitulos
   -- -----------------------------
   Li_NumCap := Pi_CapFin - Pi_CapIni + 1;    -- + Pf_ObtenTotCapitulos(Pl_KeyFol, Ps_KeyEmp, Pl_KeyPue, Pd_Costo, Pi_Entrada, Pi_Salida, Pi_Comida, Pl_FolioRPH)
   -- ---------------------------------------------------
   -- Leemos el periodo de transmision y tipo de programa
   -- ---------------------------------------------------
   Li_PerTra := 0;
   Li_TipPro := 0;
   Select nvl(con_pertra,0)
     Into Li_PerTra
    From USRSIHO.holocont
   Where con_keyemp = pi_KeyEmp
     And con_keyfol = Pl_KeyFol
     And con_keytco = pi_keytco;
   IF Li_PerTra <> 0 THEN
      Li_TipPro := 0;
      Select nvl(ALD_KEYTPR,0)
        Into Li_TipPro
       From USRSIHO.NMLOALDE
      Where ALD_KEYDEP = Trim(Ps_Programa);
      IF Li_TipPro = 0 THEN
         Select ALD_PERTRA,ALD_KEYTPR
           Into Li_PerTra,Li_TipPro
           From USRSIHO.NMLOALDE
          Where ALD_KEYDEP =  Trim(Ps_Programa);
      End If;
   Else
      Select ALD_PERTRA,ALD_KEYTPR
        Into Li_PerTra,Li_TipPro
        From USRSIHO.NMLOALDE
       Where ALD_KEYDEP =  Trim(Ps_Programa);
   End If;
   -- --------------------------
   -- Leemos el tipo de empleado
   -- --------------------------
   Li_TipEmp := 0;
   Select Substr(Pue_ca4aux,9, 1)
     Into Li_TipEmp
     From USRSIHO.NMCOPUES
    Where Pue_KeyPue = Pl_KeyPue;
   -- //INICIO CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 07/09/2011
   -- -----------------------------------------------------
   -- Obtenemos los a?os considerados para el menor de edad
   -- -----------------------------------------------------
   SELECT NVL(PAM_FOLINI,0)
     INTO Ld_MenorEdad
     FROM USRSIHO.GLCOPAMS
    WHERE PAM_KEYPAR = 'TEME';
   -- -----------------------------------------------------
   -- Obtenemos la nacionalidad del empleado
   -- -----------------------------------------------------
    SELECT EMP_CA3AUX
      INTO Ls_Nacionalidad
      FROM USRSIHO.NMCOEMPL
     WHERE EMP_KEYEMP = pi_KeyEmp;
   -- -----------------------------------------------------
   -- Obtenemos el codigo de la ANDA
   -- -----------------------------------------------------
    SELECT to_number(PAM_FOLINI)
      INTO Li_CodigoAnda
      FROM USRSIHO.GLCOPAMS
     WHERE PAM_KEYPAR = 'ACP'
       AND PAM_FOLFIN= 'CODIGO ANDA';
   -- --------------------------------------------------------------------
   -- Calculamos la edad del empleado para determinar si es menor de edad
   -- --------------------------------------------------------------------
   IF ls_Nacionalidad = '02' THEN
       SELECT to_number((Pd_FecGra - ALE_FECNAC)/365.25)
         INTO Ld_Anios
         FROM USRSIHO.HOLOALEM
        WHERE ALE_KEYEMP= pi_KeyEmp;
   ELSE
       IF Li_CodigoAnda <> pi_KeyEmp THEN
          SELECT EMP_REGRFC INTO Ls_regrfc
          FROM USRSIHO.NMCOEMPL
          WHERE EMP_KEYEMP = pi_KeyEmp;
          IF to_number(SUBSTR(Ls_regrfc,7,2)) > 0 AND to_number(SUBSTR(Ls_regrfc,9,2)) > 0 AND to_number(SUBSTR(Ls_regrfc,5,2)) >= 0 THEN
            IF substr(Ls_regrfc,5,2) > SUBSTR(year(sysdate) + 5, 3,2) THEN
              Ld_Anios := (Pd_FecGra - to_date('19'||substr(Ls_regrfc,5,2)||'/'||substr(Ls_regrfc,7,2)||'/'||substr(Ls_regrfc,9,2),'yyyy/mm/dd')) /365.25;
            ELSE
              Ld_Anios := (Pd_FecGra - to_date('20'||substr(Ls_regrfc,5,2)||'/'||substr(Ls_regrfc,7,2)||'/'||substr(Ls_regrfc,9,2),'yyyy/mm/dd')) /365.25;
            END IF;
          ELSE
            Ld_Anios := 99;
          END IF;
          /*  SELECT CASE WHEN to_number(SUBSTR(EMP_REGRFC,7,2)) > 0 AND to_number(SUBSTR(EMP_REGRFC,9,2)) > 0 AND to_number(SUBSTR(EMP_REGRFC,5,2)) >= 0 THEN
              (Pd_FecGra - to_date(substr(emp_regrfc,5,2)||'/'||substr(emp_regrfc,7,2)||'/'||substr(emp_regrfc,9,2),'RR/mm/dd')) /365.25
                   ELSE
                         99
                   END
              INTO Ld_Anios
              FROM USRSIHO.NMCOEMPL
             WHERE EMP_KEYEMP = pi_KeyEmp;*/
       ELSE
            Ld_Anios := 99;
       END IF;
   END IF;
   -- ---------------------------------------------------------------------------------
   -- Evaluamos y reasignamos el valor del tipo de jornada en caso de ser menor de edad
   -- ---------------------------------------------------------------------------------
   IF Ld_Anios < Ld_MenorEdad THEN
      Ls_TipoJornada := 'M' || Ls_TipoJornada;
   END IF;
   -- //FIN CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 07/09/2011
--insert into borra(sec,campo1,campo2,campo3) VALUES(12,'Li_TipEmp',Li_TipEmp,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(12,'Pi_Comida',Pi_Comida,'Despues de validar');
   -- -----------------------------------------------
   -- Valuaci?n de Ld_NFactor y Ld_NMinJornada60
   -- -----------------------------------------------
   IF Li_PerTra > 59 Or Li_NumCap > 1 Or Li_TipEmp = 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada60 := 0;
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada60
        From USRSIHO.HOLOHOEX
       Where HOE_PERTRA = '60'
         And HOE_JORNAD = Ls_TipoJornada;
   End If;
   -- -------------------------------------------
   -- Valuaci?n de Ld_NFactor y Ld_NMinJornada30
   -- -------------------------------------------
   IF Li_PerTra = 30 And Li_TipEmp <> 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada30 := 0;
      IF Li_TipPro = 1 THEN
         Li_TipPro1 := Li_TipPro;
      ELSE
         Li_TipPro1 := 0;
      END IF;
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada30
        From USRSIHO.HOLOHOEX
       Where HOE_PERTRA = '30'
         And HOE_KEYTPR = Li_TipPro1;
   End If;
   -- -------------------------------------------
   -- Valuaci?n de Ld_NFactor y Ld_NMinJornada15
   -- -------------------------------------------
   IF Li_PerTra = 15 And Li_TipEmp <> 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada15 := 0;
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada15
        From USRSIHO.HOLOHOEX
       Where HOE_PERTRA = '15';
   End If;
   -- -------------------------
   -- Asignaci?n de Ld_MinJor
   -- -------------------------
   Ld_MinJor := Ld_NMinJornada60;
   If Li_PerTra = 30 And Li_NumCap = 1 Then
      Ld_MinJor := Ld_NMinJornada30;
   End If;
   If Li_PerTra = 15 Then
      Ld_MinJor := Ld_NMinJornada15;
   End If;
   If Li_TipEmp = 1 Then
      Ld_MinJor := Ld_NMinJornada60;
   End If;
   Li_MinExt := 0;
   Ld_MinJor := Ld_MinJor + Pi_Comida;
   If Li_MinDif > Ld_MinJor Then
      Li_MinExt := Li_MinDif - Ld_MinJor;
   End If;
   -- Si el tipo es 1 (Telenovela) el n?mero de capitulos siempre es uno
   If Li_TipPro <> 1 And Li_NumCap > 1 Then
      Li_NumCap := 1;
   End If;
   -- ----------------------------------------
   -- Evaluaci?n de tiempo extra
   -- ----------------------------------------
   -- Obtenemos el Importe de las horas Extras
   Li_TieExtImp := Pd_Costo * Li_NumCap * Li_MinExt * 2 / Ld_NFactor;
   -- Obtenemos el Numero de horas Extras
   Li_TieExtHrs := ((Li_MinExt/60) * 2);
   Ls_TieExtMix := Li_TieExtImp || 'H' || Li_TieExtHrs;
   RETURN Ls_TieExtMix ;
-- ------------------------------------------------------------------------------------------------
END;
/
