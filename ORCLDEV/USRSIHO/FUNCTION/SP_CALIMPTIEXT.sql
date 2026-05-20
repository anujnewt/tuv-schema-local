CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_CALIMPTIEXT" (Pi_Entrada NUMBER,
                                Pi_Salida NUMBER,
                                Pi_Comida NUMBER,
                                Pi_CapIni NUMBER,
                                Pi_CapFin NUMBER,
                                Ps_Programa VARCHAR2,
                                Pl_KeyFol NUMBER,
                                Pl_KeyPue VARCHAR2,
                                Pd_CostoPar NUMBER,
                                pi_keytco NUMBER,
                                pi_KeyEmp NUMBER,
                                Pd_FecGra DATE,
                                Pi_DetSerial NUMBER,
                                pi_hojatrab NUMBER)
RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- -----------------------------------------------------------------
-- sp_hocalctiext: Este stored procedure es el que utiliza en el
-- reporte de trabajo del modulo de llamado de Actores de Honorarios
-- para obtener las horas y minutos de Tiempo Extra en relaci?? la
-- Hora de Entrada y Salida que se captura en el Llamado.
-- Devuelve un Decimal con el numero de horas y minutos
-- Realizado el 29 de Septiembre de 2007
-- Juan Carlos Reyes Olivera
-- MODIFICO:                    COMENTARIO:				FECHA:
-- Juan Carlos Reyes O.         Se agrego la consulta y validaci??7/09/2011
--                              del calculo de la edad del actor.
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
   Ls_FecGra VARCHAR2(10);
   Li_DiaFes NUMBER(10);
   Li_MarDiaF NUMBER(10);
--Declaramos la variable para el calculo de la edad (JCRO)
  Ld_Anios NUMBER;
  Ld_MenorEdad NUMBER;
  Ls_Nacionalidad VARCHAR2(2);
  Li_CodigoAnda NUMBER(10);
  Pd_Costo NUMBER(10);
  Ls_regrfc VARCHAR2(13);
BEGIN
  Ld_NMinJornada60 := 0;
  Ld_NMinJornada30 := 0;
  Ld_NMinJornada15 := 0;
  Ld_Anios := 0;
  Ld_MenorEdad := 0;
  Ls_Nacionalidad := '';
  Li_CodigoAnda := 0;
  Li_DiaFes := 0;
  Li_MarDiaF := 0;
  Pd_Costo := Pd_CostoPar;
--insert into borra(sec,campo1,campo2,campo3) VALUES(0,'Ld_NMinJornada60',0,Ld_NMinJornada60);
--insert into borra(sec,campo1,campo2,campo3) VALUES(1,'Pi_Entrada',Pi_Entrada,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(2,'Pi_Salida',Pi_Salida,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(3,'Pi_CapIni',Pi_CapIni,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(4,'Pi_CapFin',Pi_CapFin,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(5,'Pl_KeyPue',Pl_KeyPue,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(6,'Pd_Costo',Pd_Costo,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(2,'Pi_Salida',Pi_Salida,'');
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
--insert into borra(sec,campo1,campo2,campo3) VALUES(7,'Li_MinDif',Li_MinDif,'');
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
--insert into borra(sec,campo1,campo2,campo3) VALUES(8,'Ls_TipoJornada',0,Ls_TipoJornada);
   -- -----------------------------
   -- Evaluamos el n??o de capitulos
   -- -----------------------------
   Li_NumCap := Pi_CapFin - Pi_CapIni + 1;    -- + Pf_ObtenTotCapitulos(Pl_KeyFol, Ps_KeyEmp, Pl_KeyPue, Pd_Costo, Pi_Entrada, Pi_Salida, Pi_Comida, Pl_FolioRPH)
--insert into borra(sec,campo1,campo2,campo3) VALUES(9,'Li_NumCap',Li_NumCap,'');
   -- ---------------------------------------------------
   -- Leemos el periodo de transmision y tipo de programa
   -- ---------------------------------------------------
   Li_PerTra := 0;
   Li_TipPro := 0;
   Select nvl(con_pertra,0)
     Into Li_PerTra
    From holocont
   Where con_keyemp = pi_KeyEmp
     And con_keyfol = Pl_KeyFol
     And con_keytco = pi_keytco;
--insert into borra(sec,campo1,campo2,campo3) VALUES(10,'Li_PerTra',Li_PerTra,'');
   IF Li_PerTra <> 0 THEN
      Li_TipPro := 0;
      Select nvl(ALD_KEYTPR,0)
        Into Li_TipPro
       From NMLOALDE
      Where ALD_KEYDEP = Trim(Ps_Programa);
      IF Li_TipPro = 0 THEN
         Select ALD_PERTRA,ALD_KEYTPR
           Into Li_PerTra,Li_TipPro
           From NMLOALDE
          Where ALD_KEYDEP =  Trim(Ps_Programa);
      End If;
   Else
      Select ALD_PERTRA,ALD_KEYTPR
        Into Li_PerTra,Li_TipPro
        From NMLOALDE
       Where ALD_KEYDEP =  Trim(Ps_Programa);
   End If;
--insert into borra(sec,campo1,campo2,campo3) VALUES(11,'Li_TipPro',Li_TipPro,'');
   -- --------------------------
   -- Leemos el tipo de empleado
   -- --------------------------
   Li_TipEmp := 0;
   Select Substr(Pue_ca4aux,9, 1)
     Into Li_TipEmp
     From NMCOPUES
    Where Pue_KeyPue = Pl_KeyPue;
--insert into borra(sec,campo1,campo2,campo3) VALUES(12,'Pi_Comida',Pi_Comida,'Antes de validar');
   -- //INICIO CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 07/09/2011
   -- -----------------------------------------------------
   -- Obtenemos los a??considerados para el menor de edad
   -- -----------------------------------------------------
   SELECT NVL(PAM_FOLINI,0)
     INTO Ld_MenorEdad
     FROM GLCOPAMS
    WHERE PAM_KEYPAR = 'TEME';
   -- -----------------------------------------------------
   -- Obtenemos la nacionalidad del empleado
   -- -----------------------------------------------------
    SELECT EMP_CA3AUX
      INTO Ls_Nacionalidad
      FROM NMCOEMPL
     WHERE EMP_KEYEMP = pi_KeyEmp;
   -- -----------------------------------------------------
   -- Obtenemos el codigo de la ANDA
   -- -----------------------------------------------------
    SELECT to_number(PAM_FOLINI)
      INTO Li_CodigoAnda
      FROM GLCOPAMS
     WHERE PAM_KEYPAR = 'ACP'
       AND PAM_FOLFIN= 'CODIGO ANDA';
   -- --------------------------------------------------------------------
   -- Calculamos la edad del empleado para determinar si es menor de edad
   -- --------------------------------------------------------------------
   IF ls_Nacionalidad = '02' THEN
       SELECT to_number((Pd_FecGra - ALE_FECNAC)/365.25)
         INTO Ld_Anios
         FROM HOLOALEM
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
   -- Valuaci??e Ld_NFactor y Ld_NMinJornada60
   -- -----------------------------------------------
   IF Li_PerTra > 59 Or Li_NumCap > 1 Or Li_TipEmp = 1 Then
       Ld_NFactor := 0;
      Ld_NMinJornada60 := 0;
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada60
        From HOLOHOEX
       Where HOE_PERTRA = '60'
         And HOE_JORNAD = Ls_TipoJornada;
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
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada30
        From HOLOHOEX
       Where HOE_PERTRA = '30'
         And HOE_KEYTPR = Li_TipPro1;
   End If;
   -- -------------------------------------------
   -- Valuaci??e Ld_NFactor y Ld_NMinJornada15
   -- -------------------------------------------
   IF Li_PerTra = 15 And Li_TipEmp <> 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada15 := 0;
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada15
        From HOLOHOEX
       Where HOE_PERTRA = '15';
   End If;
--insert into borra(sec,campo1,campo2,campo3) VALUES(13,'Ld_NFactor',Ld_NFactor,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(14,'Ld_NMinJornada60',0,Ld_NMinJornada60);
--insert into borra(sec,campo1,campo2,campo3) VALUES(15,'Ld_NMinJornada30',0,Ld_NMinJornada30);
--insert into borra(sec,campo1,campo2,campo3) VALUES(16,'Ld_NMinJornada15',0,Ld_NMinJornada15);
   -- -------------------------
   -- Asignaci??e Ld_MinJor
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
   -- Si el tipo es 1 (Telenovela) el n??o de capitulos siempre es uno
   If Li_TipPro <> 1 And Li_NumCap > 1 Then
      Li_NumCap := 1;
   End If;
--insert into borra(sec,campo1,campo2,campo3) VALUES(17,'Ld_MinJor',Ld_MinJor,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(18,'Li_MinExt',Li_MinExt,'');
   --Buscamos si es dia festivo
   Ls_FecGra := Pd_FecGra;
--insert into borra(sec,campo1,campo2,campo3) VALUES(18,'Pd_FecGra',0,Pd_FecGra);
   Ls_FecGra := SUBSTR(Ls_FecGra,4,2)||'/'||SUBSTR(Ls_FecGra,1,2)||'/'||SUBSTR(Ls_FecGra,7,4);
--insert into borra(sec,campo1,campo2,campo3) VALUES(18,'Ls_FecGra',0,Ls_FecGra);
SELECT COUNT(*)
  INTO Li_DiaFes
  FROM glcopams
 WHERE pam_keypar='CDF'
   AND pam_folfin=Ls_FecGra;
--insert into borra(sec,campo1,campo2,campo3) VALUES(1,'Li_DiaFes',Li_DiaFes,'');
   --
   -- ----------------------------------------
   -- Evaluaci??e tiempo extra
   -- ----------------------------------------
   IF Li_DiaFes > 0 THEN
   		SELECT CASE WHEN nvl(to_number(substr(det_auxca2,8,1)),0)=1 THEN 1 ELSE 0 END
        INTO Li_MarDiaF
        FROM holodettra
       WHERE det_num_id=pi_hojatrab
         AND det_keyemp=pi_KeyEmp
         AND det_stsreg='V'
         AND det_keyfol=Pl_KeyFol;
      IF  Li_MarDiaF > 0 THEN
       Pd_Costo := Pd_Costo * 3;
      END IF;
   END IF;
   -- Obtenemos el Importe de las horas Extras
    Li_TieExt := Pd_Costo * Li_NumCap * Li_MinExt * 2 / Ld_NFactor;
   -- Obtenemos el Numero de horas Extras
   --LET Li_TieExt = ((Li_MinExt/60) * 2);
--insert into borra(sec,Char1,num1,char2) VALUES(pi_KeyEmp,'Li_TieExt',Li_TieExt,Li_TieExt);
   RETURN Li_TieExt ;
-- ------------------------------------------------------------------------------------------------
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_CALIMPTIEXT" (Pi_Entrada NUMBER,
                                Pi_Salida NUMBER,
                                Pi_Comida NUMBER,
                                Pi_CapIni NUMBER,
                                Pi_CapFin NUMBER,
                                Ps_Programa VARCHAR2,
                                Pl_KeyFol NUMBER,
                                Pl_KeyPue VARCHAR2,
                                Pd_CostoPar NUMBER,
                                pi_keytco NUMBER,
                                pi_KeyEmp NUMBER,
                                Pd_FecGra DATE,
                                Pi_DetSerial NUMBER,
                                pi_hojatrab NUMBER)
RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- -----------------------------------------------------------------
-- sp_hocalctiext: Este stored procedure es el que utiliza en el
-- reporte de trabajo del modulo de llamado de Actores de Honorarios
-- para obtener las horas y minutos de Tiempo Extra en relaci?? la
-- Hora de Entrada y Salida que se captura en el Llamado.
-- Devuelve un Decimal con el numero de horas y minutos
-- Realizado el 29 de Septiembre de 2007
-- Juan Carlos Reyes Olivera
-- MODIFICO:                    COMENTARIO:				FECHA:
-- Juan Carlos Reyes O.         Se agrego la consulta y validaci??7/09/2011
--                              del calculo de la edad del actor.
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
   Ls_FecGra VARCHAR2(10);
   Li_DiaFes NUMBER(10);
   Li_MarDiaF NUMBER(10);
--Declaramos la variable para el calculo de la edad (JCRO)
  Ld_Anios NUMBER;
  Ld_MenorEdad NUMBER;
  Ls_Nacionalidad VARCHAR2(2);
  Li_CodigoAnda NUMBER(10);
  Pd_Costo NUMBER(10);
  Ls_regrfc VARCHAR2(13);
BEGIN
  Ld_NMinJornada60 := 0;
  Ld_NMinJornada30 := 0;
  Ld_NMinJornada15 := 0;
  Ld_Anios := 0;
  Ld_MenorEdad := 0;
  Ls_Nacionalidad := '';
  Li_CodigoAnda := 0;
  Li_DiaFes := 0;
  Li_MarDiaF := 0;
  Pd_Costo := Pd_CostoPar;
--insert into borra(sec,campo1,campo2,campo3) VALUES(0,'Ld_NMinJornada60',0,Ld_NMinJornada60);
--insert into borra(sec,campo1,campo2,campo3) VALUES(1,'Pi_Entrada',Pi_Entrada,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(2,'Pi_Salida',Pi_Salida,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(3,'Pi_CapIni',Pi_CapIni,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(4,'Pi_CapFin',Pi_CapFin,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(5,'Pl_KeyPue',Pl_KeyPue,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(6,'Pd_Costo',Pd_Costo,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(2,'Pi_Salida',Pi_Salida,'');
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
--insert into borra(sec,campo1,campo2,campo3) VALUES(7,'Li_MinDif',Li_MinDif,'');
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
--insert into borra(sec,campo1,campo2,campo3) VALUES(8,'Ls_TipoJornada',0,Ls_TipoJornada);
   -- -----------------------------
   -- Evaluamos el n??o de capitulos
   -- -----------------------------
   Li_NumCap := Pi_CapFin - Pi_CapIni + 1;    -- + Pf_ObtenTotCapitulos(Pl_KeyFol, Ps_KeyEmp, Pl_KeyPue, Pd_Costo, Pi_Entrada, Pi_Salida, Pi_Comida, Pl_FolioRPH)
--insert into borra(sec,campo1,campo2,campo3) VALUES(9,'Li_NumCap',Li_NumCap,'');
   -- ---------------------------------------------------
   -- Leemos el periodo de transmision y tipo de programa
   -- ---------------------------------------------------
   Li_PerTra := 0;
   Li_TipPro := 0;
   Select nvl(con_pertra,0)
     Into Li_PerTra
    From holocont
   Where con_keyemp = pi_KeyEmp
     And con_keyfol = Pl_KeyFol
     And con_keytco = pi_keytco;
--insert into borra(sec,campo1,campo2,campo3) VALUES(10,'Li_PerTra',Li_PerTra,'');
   IF Li_PerTra <> 0 THEN
      Li_TipPro := 0;
      Select nvl(ALD_KEYTPR,0)
        Into Li_TipPro
       From NMLOALDE
      Where ALD_KEYDEP = Trim(Ps_Programa);
      IF Li_TipPro = 0 THEN
         Select ALD_PERTRA,ALD_KEYTPR
           Into Li_PerTra,Li_TipPro
           From NMLOALDE
          Where ALD_KEYDEP =  Trim(Ps_Programa);
      End If;
   Else
      Select ALD_PERTRA,ALD_KEYTPR
        Into Li_PerTra,Li_TipPro
        From NMLOALDE
       Where ALD_KEYDEP =  Trim(Ps_Programa);
   End If;
--insert into borra(sec,campo1,campo2,campo3) VALUES(11,'Li_TipPro',Li_TipPro,'');
   -- --------------------------
   -- Leemos el tipo de empleado
   -- --------------------------
   Li_TipEmp := 0;
   Select Substr(Pue_ca4aux,9, 1)
     Into Li_TipEmp
     From NMCOPUES
    Where Pue_KeyPue = Pl_KeyPue;
--insert into borra(sec,campo1,campo2,campo3) VALUES(12,'Pi_Comida',Pi_Comida,'Antes de validar');
   -- //INICIO CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 07/09/2011
   -- -----------------------------------------------------
   -- Obtenemos los a??considerados para el menor de edad
   -- -----------------------------------------------------
   SELECT NVL(PAM_FOLINI,0)
     INTO Ld_MenorEdad
     FROM GLCOPAMS
    WHERE PAM_KEYPAR = 'TEME';
   -- -----------------------------------------------------
   -- Obtenemos la nacionalidad del empleado
   -- -----------------------------------------------------
    SELECT EMP_CA3AUX
      INTO Ls_Nacionalidad
      FROM NMCOEMPL
     WHERE EMP_KEYEMP = pi_KeyEmp;
   -- -----------------------------------------------------
   -- Obtenemos el codigo de la ANDA
   -- -----------------------------------------------------
    SELECT to_number(PAM_FOLINI)
      INTO Li_CodigoAnda
      FROM GLCOPAMS
     WHERE PAM_KEYPAR = 'ACP'
       AND PAM_FOLFIN= 'CODIGO ANDA';
   -- --------------------------------------------------------------------
   -- Calculamos la edad del empleado para determinar si es menor de edad
   -- --------------------------------------------------------------------
   IF ls_Nacionalidad = '02' THEN
       SELECT to_number((Pd_FecGra - ALE_FECNAC)/365.25)
         INTO Ld_Anios
         FROM HOLOALEM
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
   -- Valuaci??e Ld_NFactor y Ld_NMinJornada60
   -- -----------------------------------------------
   IF Li_PerTra > 59 Or Li_NumCap > 1 Or Li_TipEmp = 1 Then
       Ld_NFactor := 0;
      Ld_NMinJornada60 := 0;
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada60
        From HOLOHOEX
       Where HOE_PERTRA = '60'
         And HOE_JORNAD = Ls_TipoJornada;
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
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada30
        From HOLOHOEX
       Where HOE_PERTRA = '30'
         And HOE_KEYTPR = Li_TipPro1;
   End If;
   -- -------------------------------------------
   -- Valuaci??e Ld_NFactor y Ld_NMinJornada15
   -- -------------------------------------------
   IF Li_PerTra = 15 And Li_TipEmp <> 1 Then
      Ld_NFactor := 0;
      Ld_NMinJornada15 := 0;
      Select HOE_JORCOS,HOE_JORTIE
        Into Ld_NFactor,Ld_NMinJornada15
        From HOLOHOEX
       Where HOE_PERTRA = '15';
   End If;
--insert into borra(sec,campo1,campo2,campo3) VALUES(13,'Ld_NFactor',Ld_NFactor,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(14,'Ld_NMinJornada60',0,Ld_NMinJornada60);
--insert into borra(sec,campo1,campo2,campo3) VALUES(15,'Ld_NMinJornada30',0,Ld_NMinJornada30);
--insert into borra(sec,campo1,campo2,campo3) VALUES(16,'Ld_NMinJornada15',0,Ld_NMinJornada15);
   -- -------------------------
   -- Asignaci??e Ld_MinJor
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
   -- Si el tipo es 1 (Telenovela) el n??o de capitulos siempre es uno
   If Li_TipPro <> 1 And Li_NumCap > 1 Then
      Li_NumCap := 1;
   End If;
--insert into borra(sec,campo1,campo2,campo3) VALUES(17,'Ld_MinJor',Ld_MinJor,'');
--insert into borra(sec,campo1,campo2,campo3) VALUES(18,'Li_MinExt',Li_MinExt,'');
   --Buscamos si es dia festivo
   Ls_FecGra := Pd_FecGra;
--insert into borra(sec,campo1,campo2,campo3) VALUES(18,'Pd_FecGra',0,Pd_FecGra);
   Ls_FecGra := SUBSTR(Ls_FecGra,4,2)||'/'||SUBSTR(Ls_FecGra,1,2)||'/'||SUBSTR(Ls_FecGra,7,4);
--insert into borra(sec,campo1,campo2,campo3) VALUES(18,'Ls_FecGra',0,Ls_FecGra);
SELECT COUNT(*)
  INTO Li_DiaFes
  FROM glcopams
 WHERE pam_keypar='CDF'
   AND pam_folfin=Ls_FecGra;
--insert into borra(sec,campo1,campo2,campo3) VALUES(1,'Li_DiaFes',Li_DiaFes,'');
   --
   -- ----------------------------------------
   -- Evaluaci??e tiempo extra
   -- ----------------------------------------
   IF Li_DiaFes > 0 THEN
   		SELECT CASE WHEN nvl(to_number(substr(det_auxca2,8,1)),0)=1 THEN 1 ELSE 0 END
        INTO Li_MarDiaF
        FROM holodettra
       WHERE det_num_id=pi_hojatrab
         AND det_keyemp=pi_KeyEmp
         AND det_stsreg='V'
         AND det_keyfol=Pl_KeyFol;
      IF  Li_MarDiaF > 0 THEN
       Pd_Costo := Pd_Costo * 3;
      END IF;
   END IF;
   -- Obtenemos el Importe de las horas Extras
    Li_TieExt := Pd_Costo * Li_NumCap * Li_MinExt * 2 / Ld_NFactor;
   -- Obtenemos el Numero de horas Extras
   --LET Li_TieExt = ((Li_MinExt/60) * 2);
--insert into borra(sec,Char1,num1,char2) VALUES(pi_KeyEmp,'Li_TieExt',Li_TieExt,Li_TieExt);
   RETURN Li_TieExt ;
-- ------------------------------------------------------------------------------------------------
END;
/
