CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HOCALCTIEXTSIAS" (Pi_Entrada in INTEGER,
 Pi_Salida in INTEGER,
 Pi_Comida in INTEGER,
 Pi_CapIni in INTEGER,
 Pi_CapFin in INTEGER,
 Ps_Programa VARCHAR2,
 Pl_KeyFol in INTEGER,
 Pl_KeyPue VARCHAR2,
 Pd_Costo DECIMAL,
 pi_keytco in INTEGER,
 pi_KeyEmp in INTEGER, Li_TieExtR OUT DECIMAL)
--RETURNING DECIMAL(10,2);
-- -----------------------------------------------------------------
-- sp_hocalctiext: Este stored procedure es el que utiliza en el
-- reporte de trabajo del modulo de llamado de Actores de Honorarios
-- para obtener las horas y minutos de Tiempo Extra en relaci? la
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
 -- Definimos variables para los Tipos de jornadas
 Pc_JorNocturna VARCHAR2(1);
 Pc_JorDiurna VARCHAR2(1);
 Pc_JorMixta VARCHAR2(1);
 Pc_JorX VARCHAR2(1);
 -- Definimos variables de Trabajo
 Li_MinEnt INTEGER;
 Li_MinSal INTEGER;
 Li_MinDif INTEGER;
 Li_MinExt INTEGER;
 Ls_TipoJornada VARCHAR2(1);
 Li_NumCap INTEGER;
 Li_PerTra INTEGER;
 Li_TipEmp INTEGER;
 Li_TipPro INTEGER;
 Li_TipPro1 INTEGER;
 Ld_NFactor DECIMAL(13,2);
 Ld_NMinJornada60 DECIMAL(13,2);
 Ld_NMinJornada30 DECIMAL(13,2);
 Ld_NMinJornada15 DECIMAL(13,2);
 Ld_MinJor DECIMAL(13,2);
 Li_TieExt DECIMAL(10,2);
BEGIN
 Ld_NMinJornada60 := 0;
 Ld_NMinJornada30 := 0;
 Ld_NMinJornada15 := 0;
--insert into borra(sec,campo1,campo2,campo3) VALUES(0,"Ld_NMinJornada60",0,Ld_NMinJornada60);
--insert into borra(sec,campo1,campo2,campo3) VALUES(1,"Pi_Entrada",Pi_Entrada,"");
--insert into borra(sec,campo1,campo2,campo3) VALUES(2,"Pi_Salida",Pi_Salida,"");
--insert into borra(sec,campo1,campo2,campo3) VALUES(3,"Pi_CapIni",Pi_CapIni,"");
--insert into borra(sec,campo1,campo2,campo3) VALUES(4,"Pi_CapFin",Pi_CapFin,"");
--insert into borra(sec,campo1,campo2,campo3) VALUES(5,"Pl_KeyPue",Pl_KeyPue,"");
--insert into borra(sec,campo1,campo2,campo3) VALUES(6,"Pd_Costo",Pd_Costo,"");
--insert into borra(sec,campo1,campo2,campo3) VALUES(2,"Pi_Salida",Pi_Salida,"");
-- IF Pi_Entrada = 0 OR Pi_Salida = 0 OR Pi_CapIni = 0 OR Pi_CapFin = 0 OR Pl_KeyPue = "X" OR Pd_Costo = 0 THEN
-- RETURN 0;
-- END IF;
 IF Pi_Entrada = 0 THEN
 Li_TieExt := 0;
 --RETURN 0;
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
--insert into borra(sec,campo1,campo2,campo3) VALUES(7,"Li_MinDif",Li_MinDif,"");
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
--insert into borra(sec,campo1,campo2,campo3) VALUES(8,"Ls_TipoJornada",0,Ls_TipoJornada);
 -- -----------------------------
 -- Evaluamos el n?mero de capitulos
 -- -----------------------------
 Li_NumCap := Pi_CapFin - Pi_CapIni + 1; -- + Pf_ObtenTotCapitulos(Pl_KeyFol, Ps_KeyEmp, Pl_KeyPue, Pd_Costo, Pi_Entrada, Pi_Salida, Pi_Comida, Pl_FolioRPH)
--insert into borra(sec,campo1,campo2,campo3) VALUES(9,"Li_NumCap",Li_NumCap,"");
 -- ---------------------------------------------------
 -- Leemos el periodo de transmision y tipo de programa
 -- ---------------------------------------------------
 Li_PerTra := 0;
 Li_TipPro := 0;
BEGIN
    Select nvl(con_pertra,0)
      Into Li_PerTra
      From holocont
     Where con_keyemp = pi_KeyEmp
       And con_keyfol = Pl_KeyFol
       And con_keytco = pi_keytco;
    EXCEPTION WHEN no_data_found THEN Li_PerTra := 0;
END;
--insert into borra(sec,campo1,campo2,campo3) VALUES(10,"Li_PerTra",Li_PerTra,"");
 IF Li_PerTra <> 0 THEN
    Li_TipPro := 0;
    BEGIN
            Select nvl(ALD_KEYTPR,0)
            Into   Li_TipPro
            From NMLOALDE
            Where ALD_KEYDEP = Trim(Ps_Programa);
            EXCEPTION WHEN no_data_found THEN Li_TipPro := 0;
    END;
     IF Li_TipPro = 0 THEN
        BEGIN
            Select ALD_PERTRA,ALD_KEYTPR
            Into Li_PerTra, Li_TipPro
            From NMLOALDE
            Where ALD_KEYDEP = Trim(Ps_Programa);
            EXCEPTION WHEN no_data_found THEN Li_PerTra := 0; Li_TipPro := 0;
        END;
     End If;
 ELSE
         BEGIN
             Select ALD_PERTRA,ALD_KEYTPR
             Into Li_PerTra, Li_TipPro
             From NMLOALDE
             Where ALD_KEYDEP = Trim(Ps_Programa);
             EXCEPTION WHEN no_data_found THEN Li_PerTra := 0; Li_TipPro := 0;
         END;
 End If;
--insert into borra(sec,campo1,campo2,campo3) VALUES(11,"Li_TipPro",Li_TipPro,"");
 -- --------------------------
 -- Leemos el tipo de empleado
 -- --------------------------
 Li_TipEmp := 0;
BEGIN
    Select substr(Pue_ca4aux,9,1)
      Into Li_TipEmp
      From NMCOPUES
     Where Pue_KeyPue = Pl_KeyPue;
    EXCEPTION WHEN no_data_found THEN Li_TipEmp := 0;
END;
--insert into borra(sec,campo1,campo2,campo3) VALUES(12,"Li_TipEmp",Li_TipEmp,"");
 -- -----------------------------------------------
 -- Valuaci?e Ld_NFactor y Ld_NMinJornada60
 -- -----------------------------------------------
 If Li_PerTra > 59 Or Li_NumCap > 1 Or Li_TipEmp = 1 Then
     Ld_NFactor := 0;
     Ld_NMinJornada60 := 0;
     BEGIN
         Select HOE_JORCOS,HOE_JORTIE
           Into Ld_NFactor, Ld_NMinJornada60
           From HOLOHOEX
          Where HOE_PERTRA = '60'
            And HOE_JORNAD = Ls_TipoJornada;
         EXCEPTION WHEN no_data_found THEN Ld_NFactor := 0;
                                           Ld_NMinJornada60 := 0;
     END;
 End If;
 -- -------------------------------------------
 -- Valuaci?e Ld_NFactor y Ld_NMinJornada30
 -- -------------------------------------------
If Li_PerTra = 30 And Li_TipEmp <> 1 Then
     Ld_NFactor := 0;
     Ld_NMinJornada30 := 0;
     IF Li_TipPro = 1 THEN
        Li_TipPro1 := Li_TipPro;
     ELSE
        Li_TipPro1 := 0;
     END IF;
     BEGIN
         Select HOE_JORCOS,HOE_JORTIE
           Into Ld_NFactor, Ld_NMinJornada30
           From HOLOHOEX
          Where HOE_PERTRA = '30'
            And HOE_KEYTPR = Li_TipPro1;
         EXCEPTION WHEN no_data_found THEN Ld_NFactor := 0; Ld_NMinJornada30 := 0;
     END;
End If;
 -- -------------------------------------------
 -- Valuaci?e Ld_NFactor y Ld_NMinJornada15
 -- -------------------------------------------
 If Li_PerTra = 15 And Li_TipEmp <> 1 Then
 Ld_NFactor := 0;
 Ld_NMinJornada15 := 0;
BEGIN
     Select HOE_JORCOS,HOE_JORTIE
     Into Ld_NFactor, Ld_NMinJornada15
     From HOLOHOEX
     Where HOE_PERTRA = '15';
     EXCEPTION WHEN no_data_found THEN Ld_NFactor := 0; Ld_NMinJornada15 := 0;
END;
 End If;
--insert into borra(sec,campo1,campo2,campo3) VALUES(13,"Ld_NFactor",Ld_NFactor,"");
--insert into borra(sec,campo1,campo2,campo3) VALUES(14,"Ld_NMinJornada60",0,Ld_NMinJornada60);
--insert into borra(sec,campo1,campo2,campo3) VALUES(15,"Ld_NMinJornada30",0,Ld_NMinJornada30);
--insert into borra(sec,campo1,campo2,campo3) VALUES(16,"Ld_NMinJornada15",0,Ld_NMinJornada15);
 -- -------------------------
 -- Asignaci?e Ld_MinJor
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
--insert into borra(sec,campo1,campo2,campo3) VALUES(17,"Ld_MinJor",Ld_MinJor,"");
--insert into borra(sec,campo1,campo2,campo3) VALUES(18,"Li_MinExt",Li_MinExt,"");
 -- ----------------------------------------
 -- Evaluaci?e tiempo extra
 -- ----------------------------------------
 -- Obtenemos el Importe de las horas Extras
 -- Li_TieExt = Pd_Costo * Li_NumCap * Li_MinExt * 2 / Ld_NFactor;
 -- Obtenemos el Numero de horas Extras
 Li_TieExt := ((Li_MinExt/60) * 2);
 Li_TieExtR := Li_TieExt;
--insert into borra(sec,campo1,campo2,campo3) VALUES(19,"Li_MinExt",Li_MinExt,"");
 --RETURN Li_TieExt ;
-- ------------------------------------------------------------------------------------------------
END;
/
