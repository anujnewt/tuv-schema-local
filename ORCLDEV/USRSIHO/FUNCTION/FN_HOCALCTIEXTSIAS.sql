CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."FN_HOCALCTIEXTSIAS" (Pi_Entrada in INTEGER,
 Pi_Salida in INTEGER,
 Pi_Comida in INTEGER,
 Pi_CapIni in INTEGER,
 Pi_CapFin in INTEGER,
 Ps_Programa VARCHAR2,
 Pl_KeyFol in INTEGER,
 Pl_KeyPue VARCHAR2,
 Pd_Costo DECIMAL,
 pi_keytco in INTEGER,
 pi_KeyEmp in INTEGER) RETURN DECIMAL
-- -----------------------------------------------------------------
-- fn_hocalctiext: Esta funcion es la que utiliza en el
-- reporte de trabajo del modulo de llamado de Actores de Honorarios
-- para obtener las horas y minutos de Tiempo Extra en relaci? la
-- Hora de Entrada y Salida que se captura en el Llamado.
-- Devuelve un Decimal con el numero de horas y minutos
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
 IF Pi_Entrada = 0 THEN
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
 Li_NumCap := Pi_CapFin - Pi_CapIni + 1; -- + Pf_ObtenTotCapitulos(Pl_KeyFol, Ps_KeyEmp, Pl_KeyPue, Pd_Costo, Pi_Entrada, Pi_Salida, Pi_Comida, Pl_FolioRPH)
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
 Where ALD_KEYDEP = Trim(Ps_Programa);
 End If;
 ELSE
 Select ALD_PERTRA,ALD_KEYTPR
 Into Li_PerTra,Li_TipPro
 From NMLOALDE
 Where ALD_KEYDEP = Trim(Ps_Programa);
 End If;
 -- --------------------------
 -- Leemos el tipo de empleado
 -- --------------------------
 Li_TipEmp := 0;
 Select substr(Pue_ca4aux,9,1)
 Into Li_TipEmp
 From NMCOPUES
 Where Pue_KeyPue = Pl_KeyPue;
 -- -----------------------------------------------
 -- Valuaci?e Ld_NFactor y Ld_NMinJornada60
 -- -----------------------------------------------
 If Li_PerTra > 59 Or Li_NumCap > 1 Or Li_TipEmp = 1 Then
 Ld_NFactor := 0;
 Ld_NMinJornada60 := 0;
 Select HOE_JORCOS,HOE_JORTIE
 Into Ld_NFactor,Ld_NMinJornada60
 From HOLOHOEX
 Where HOE_PERTRA = '60'
 And HOE_JORNAD = Ls_TipoJornada;
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
 Select HOE_JORCOS,HOE_JORTIE
 Into Ld_NFactor,Ld_NMinJornada30
 From HOLOHOEX
 Where HOE_PERTRA = '30'
 And HOE_KEYTPR = Li_TipPro1;
 End If;
 -- -------------------------------------------
 -- Valuaci?e Ld_NFactor y Ld_NMinJornada15
 -- -------------------------------------------
 If Li_PerTra = 15 And Li_TipEmp <> 1 Then
 Ld_NFactor := 0;
 Ld_NMinJornada15 := 0;
 Select HOE_JORCOS,HOE_JORTIE
 Into Ld_NFactor,Ld_NMinJornada15
 From HOLOHOEX
 Where HOE_PERTRA = '15';
 End If;
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
 -- ----------------------------------------
 -- Evaluaci?e tiempo extra
 -- ----------------------------------------
 -- Obtenemos el Numero de horas Extras
 Li_TieExt := ((Li_MinExt/60) * 2);
 RETURN Li_TieExt ;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."FN_HOCALCTIEXTSIAS" (Pi_Entrada in INTEGER,
 Pi_Salida in INTEGER,
 Pi_Comida in INTEGER,
 Pi_CapIni in INTEGER,
 Pi_CapFin in INTEGER,
 Ps_Programa VARCHAR2,
 Pl_KeyFol in INTEGER,
 Pl_KeyPue VARCHAR2,
 Pd_Costo DECIMAL,
 pi_keytco in INTEGER,
 pi_KeyEmp in INTEGER) RETURN DECIMAL
-- -----------------------------------------------------------------
-- fn_hocalctiext: Esta funcion es la que utiliza en el
-- reporte de trabajo del modulo de llamado de Actores de Honorarios
-- para obtener las horas y minutos de Tiempo Extra en relaci? la
-- Hora de Entrada y Salida que se captura en el Llamado.
-- Devuelve un Decimal con el numero de horas y minutos
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
 IF Pi_Entrada = 0 THEN
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
 Li_NumCap := Pi_CapFin - Pi_CapIni + 1; -- + Pf_ObtenTotCapitulos(Pl_KeyFol, Ps_KeyEmp, Pl_KeyPue, Pd_Costo, Pi_Entrada, Pi_Salida, Pi_Comida, Pl_FolioRPH)
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
 Where ALD_KEYDEP = Trim(Ps_Programa);
 End If;
 ELSE
 Select ALD_PERTRA,ALD_KEYTPR
 Into Li_PerTra,Li_TipPro
 From NMLOALDE
 Where ALD_KEYDEP = Trim(Ps_Programa);
 End If;
 -- --------------------------
 -- Leemos el tipo de empleado
 -- --------------------------
 Li_TipEmp := 0;
 Select substr(Pue_ca4aux,9,1)
 Into Li_TipEmp
 From NMCOPUES
 Where Pue_KeyPue = Pl_KeyPue;
 -- -----------------------------------------------
 -- Valuaci?e Ld_NFactor y Ld_NMinJornada60
 -- -----------------------------------------------
 If Li_PerTra > 59 Or Li_NumCap > 1 Or Li_TipEmp = 1 Then
 Ld_NFactor := 0;
 Ld_NMinJornada60 := 0;
 Select HOE_JORCOS,HOE_JORTIE
 Into Ld_NFactor,Ld_NMinJornada60
 From HOLOHOEX
 Where HOE_PERTRA = '60'
 And HOE_JORNAD = Ls_TipoJornada;
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
 Select HOE_JORCOS,HOE_JORTIE
 Into Ld_NFactor,Ld_NMinJornada30
 From HOLOHOEX
 Where HOE_PERTRA = '30'
 And HOE_KEYTPR = Li_TipPro1;
 End If;
 -- -------------------------------------------
 -- Valuaci?e Ld_NFactor y Ld_NMinJornada15
 -- -------------------------------------------
 If Li_PerTra = 15 And Li_TipEmp <> 1 Then
 Ld_NFactor := 0;
 Ld_NMinJornada15 := 0;
 Select HOE_JORCOS,HOE_JORTIE
 Into Ld_NFactor,Ld_NMinJornada15
 From HOLOHOEX
 Where HOE_PERTRA = '15';
 End If;
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
 -- ----------------------------------------
 -- Evaluaci?e tiempo extra
 -- ----------------------------------------
 -- Obtenemos el Numero de horas Extras
 Li_TieExt := ((Li_MinExt/60) * 2);
 RETURN Li_TieExt ;
END;
/
