CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMINDI02" (ws_nom_rep IN VARCHAR2,   ws_ide_pcc IN VARCHAR2,
					 wn_key_usu IN NUMBER, ws_key_men IN VARCHAR2,
					 ws_hor_reg IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Claves, fecha inicial y final del periodo, corporacion, nombre del empleado.
    wn_pro_ant NUMBER(10) := -32760;
    ws_per_ant VARCHAR2(7)    := '@@@@@@@';
    ws_dep_ant VARCHAR2(16)   := '@@@@@@@@@@@@@@@@';
    wn_emp_ant NUMBER(10) := -999999999;
    ws_con_ant VARCHAR2(8)    := '@@@@@@@@';
    ws_key_cia VARCHAR2(5);
    wn_pri_mer NUMBER(10) := 0;
    -- Variables para la carga de las descripciones de las Etiquetas.
    ws_key_cam VARCHAR2(20);
    ws_des_etq VARCHAR2(8);
    -- Variables para las restricciones de despliegue.
    ws_dsp_cam VARCHAR2(1);
    wn_dsp_001 NUMBER(5);
    wn_dsp_002 NUMBER(5);
    wn_dsp_003 NUMBER(5);
    wn_dsp_004 NUMBER(5);
    wn_dsp_005 NUMBER(5);
    wn_dsp_006 NUMBER(5);
    wn_dsp_007 NUMBER(5);
    wn_dsp_008 NUMBER(5);
    wn_dsp_009 NUMBER(5);
    wn_dsp_010 NUMBER(5);
    wn_dsp_011 NUMBER(5);
    wn_dsp_012 NUMBER(5);
    wn_dsp_013 NUMBER(5);
    wn_dsp_014 NUMBER(5);
    -- Variables para el reporte de avance.
    wn_tot_reg NUMBER(10);
    wn_num_reg NUMBER(10) := 0;
    wn_pct_reg NUMBER(6,2);
    wn_pct_act NUMBER(5)  := 1;
    ws_des_cor glwkcrys.cry_chr001%TYPE;
    wn_key_emp glwkcrys.cry_dec006%TYPE;
    ws_key_con glwkcrys.cry_chr017%TYPE;
    wn_dia_uno glwkcrys.cry_dec001%TYPE;
    wn_dia_dos glwkcrys.cry_dec002%TYPE;
    wd_fec_mov glwkcrys.cry_dat001%TYPE;
    ws_key_dep glwkcrys.cry_chr008%TYPE;
    ws_key_pue glwkcrys.cry_chr009%TYPE;
    wn_key_pro glwkcrys.cry_dec007%TYPE;
    ws_key_per glwkcrys.cry_chr018%TYPE;
    ws_des_con glwkcrys.cry_chr003%TYPE;
    ws_nom_emp glwkcrys.cry_chr002%TYPE;
    ws_des_pro glwkcrys.cry_chr010%TYPE;
    wd_fec_ini glwkcrys.cry_dat002%TYPE;
    wd_fec_fin glwkcrys.cry_dat003%TYPE;
    wd_fec_act glwkcrys.cry_dat004%TYPE;
    ws_hor_act glwkcrys.cry_chr019%TYPE;
    wn_dia_tre glwkcrys.cry_dec003%TYPE;
    wn_dia_cua glwkcrys.cry_dec004%TYPE;
    wn_dia_cin glwkcrys.cry_dec005%TYPE;
    wn_dia_sei glwkcrys.cry_dec011%TYPE;
    wn_dia_sie glwkcrys.cry_dec012%TYPE;
    ws_etq_001 glwkcrys.cry_chr020%TYPE := sp_glgetdsc ('nmcoinci', 'inc_keyemp', '........', NULL);
    ws_etq_002 glwkcrys.cry_chr021%TYPE := sp_glgetdsc ('nmcoinci', 'inc_keycon', '........', NULL);
    ws_etq_003 glwkcrys.cry_chr022%TYPE := sp_glgetdsc ('nmcoinci', 'inc_diauno', '........', NULL);
    ws_etq_004 glwkcrys.cry_chr023%TYPE := sp_glgetdsc ('nmcoinci', 'inc_diados', '........', NULL);
    ws_etq_005 glwkcrys.cry_chr024%TYPE := sp_glgetdsc ('nmcoinci', 'inc_fecmov', '........', NULL);
    ws_etq_006 glwkcrys.cry_chr025%TYPE := sp_glgetdsc ('nmcoinci', 'inc_keydep', '........', NULL);
    ws_etq_007 glwkcrys.cry_chr026%TYPE := sp_glgetdsc ('nmcoinci', 'inc_keypue', '........', NULL);
    ws_etq_008 glwkcrys.cry_chr027%TYPE := sp_glgetdsc ('nmcoinci', 'inc_keypro', '........', NULL);
    ws_etq_009 glwkcrys.cry_chr028%TYPE := sp_glgetdsc ('nmcoinci', 'inc_keyper', '........', NULL);
    ws_etq_010 glwkcrys.cry_chr029%TYPE := sp_glgetdsc ('nmcoempl', 'emp_nomemp', 'Nombre',   NULL);
    ws_etq_011 glwkcrys.cry_chr030%TYPE := sp_glgetdsc ('nmloconc', 'con_descon', 'Descripcion', NULL);
    ws_etq_012 glwkcrys.cry_chr031%TYPE := sp_glgetdsc ('nmcoinci', 'inc_diatre', '........', NULL);
    ws_etq_013 glwkcrys.cry_chr032%TYPE := sp_glgetdsc ('nmcoinci', 'inc_diacua', '........', NULL);
    ws_etq_014 glwkcrys.cry_chr033%TYPE := sp_glgetdsc ('nmcoinci', 'inc_diacin', '........', NULL);
    ws_etq_015 glwkcrys.cry_chr034%TYPE := sp_glgetdsc ('nmcoinci', 'inc_diasei', '........', NULL);
    ws_etq_016 glwkcrys.cry_chr035%TYPE := sp_glgetdsc ('nmcoinci', 'inc_diasie', '........', NULL);
    ws_des_dep glwkcrys.cry_chr004%TYPE;
    wn_tot_dia glwkcrys.cry_dec013%TYPE;
    ws_des_lis glwkcrys.cry_chr005%TYPE := sp_glgetrep (ws_nom_rep, 'No existe nombre del Reporte', 40);
    wn_con_reg NUMBER(3) := 0;
    wn_lim_ite NUMBER(3) := 100;
BEGIN
	sp_glgetdsp ('nmcoinci', 'inc_keypro', ws_key_men, wn_dsp_001);
    sp_glgetdsp ('nmcoinci', 'inc_keyper', ws_key_men, wn_dsp_002);
    sp_glgetdsp ('nmcoinci', 'inc_keyemp', ws_key_men, wn_dsp_003);
    sp_glgetdsp ('nmcoinci', 'inc_keycon', ws_key_men, wn_dsp_004);
    sp_glgetdsp ('nmcoinci', 'inc_diauno', ws_key_men, wn_dsp_005);
    sp_glgetdsp ('nmcoinci', 'inc_diados', ws_key_men, wn_dsp_006);
    sp_glgetdsp ('nmcoinci', 'inc_fecmov', ws_key_men, wn_dsp_007);
    sp_glgetdsp ('nmcoinci', 'inc_keydep', ws_key_men, wn_dsp_008);
    sp_glgetdsp ('nmcoinci', 'inc_keypue', ws_key_men, wn_dsp_009);
    sp_glgetdsp ('nmcoinci', 'inc_diatre', ws_key_men, wn_dsp_010);
    sp_glgetdsp ('nmcoinci', 'inc_diacua', ws_key_men, wn_dsp_011);
    sp_glgetdsp ('nmcoinci', 'inc_diacin', ws_key_men, wn_dsp_012);
    sp_glgetdsp ('nmcoinci', 'inc_diasei', ws_key_men, wn_dsp_013);
    sp_glgetdsp ('nmcoinci', 'inc_diasie', ws_key_men, wn_dsp_014);
	sp_glfechor(wd_fec_act,ws_hor_act);
	ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
	SELECT cor_razsoc INTO ws_des_cor
	FROM LABPROD.glcocorp;
    -- Realiza el conteo de registros a procesar.
    SELECT NVL (COUNT(*), 0)
      INTO wn_tot_reg
	FROM LABPROD.nmcoinci
	  WHERE inc_keypro IN (SELECT ran_keypro
				 FROM LABPROD.glwkrang
				   WHERE ran_nomrep = ws_nom_rep AND
					 ran_idepcc = ws_ide_pcc AND
					 ran_keyusu = wn_key_usu AND
					 ran_keypro IS NOT NULL) AND
		inc_keyper IN (SELECT ran_keyper
				 FROM LABPROD.glwkrang
				   WHERE ran_nomrep = ws_nom_rep AND
					 ran_idepcc = ws_ide_pcc AND
					 ran_keyusu = wn_key_usu AND
					 ran_keyper IS NOT NULL) AND
		inc_keycon IN (SELECT ran_keycon
				 FROM LABPROD.glwkrang
				   WHERE ran_nomrep = ws_nom_rep AND
					 ran_idepcc = ws_ide_pcc AND
					 ran_keyusu = wn_key_usu AND
					 ran_keycon IS NOT NULL) AND
		inc_keyemp IN (SELECT ran_keyemp
				 FROM LABPROD.glwkrang
				   WHERE ran_nomrep = ws_nom_rep AND
					 ran_idepcc = ws_ide_pcc AND
					 ran_keyusu = wn_key_usu AND
					 ran_keyemp IS NOT NULL) AND
		inc_keydep IN (SELECT ran_keydep
				 FROM LABPROD.glwkrang
				   WHERE ran_nomrep = ws_nom_rep AND
					 ran_idepcc = ws_ide_pcc AND
					 ran_keyusu = wn_key_usu AND
					 ran_keydep IS NOT NULL);
    wn_pct_reg := wn_tot_reg / 10.0;
    INSERT INTO LABPROD.glcoresu
	     (res_idepro, res_idepcc, res_keyusu, res_fecini,
	      res_horini, res_horreg, res_totreg, res_status)
      VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, wd_fec_act,
	      ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
    -- Borra la tabla de trabajo del Crystal Report.
    DELETE FROM LABPROD.glwkcrys
      WHERE cry_nomrep = ws_nom_rep AND
	    cry_idepcc = ws_ide_pcc AND
	    cry_keyusu = wn_key_usu;
    COMMIT;
    -- Cursor principal.
    FOR c_nmindi02 IN (SELECT inc_keyemp, inc_keycon, inc_diauno, inc_diados, inc_fecmov,
			      inc_keydep, inc_keypue, inc_keypro, inc_keyper, inc_diatre,
			      inc_diacua, inc_diacin, inc_diasei, inc_diasie
			 FROM LABPROD.nmcoinci
			   WHERE inc_keypro IN (SELECT ran_keypro
						  FROM LABPROD.glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keypro IS NOT NULL) AND
				 inc_keyper IN (SELECT ran_keyper
						  FROM LABPROD.glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keyper IS NOT NULL) AND
				 inc_keycon IN (SELECT ran_keycon
						  FROM LABPROD.glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keycon IS NOT NULL) AND
				 inc_keyemp IN (SELECT ran_keyemp
						  FROM LABPROD.glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keyemp IS NOT NULL) AND
				 inc_keydep IN (SELECT ran_keydep
						  FROM LABPROD.glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keydep IS NOT NULL)
			   ORDER BY inc_keypro, inc_keyper, inc_keydep,
				    inc_keyemp, inc_keycon) LOOP
	wn_key_emp := c_nmindi02.inc_keyemp;
	ws_key_con := c_nmindi02.inc_keycon;
	wn_dia_uno := c_nmindi02.inc_diauno;
	wn_dia_dos := c_nmindi02.inc_diados;
	wd_fec_mov := c_nmindi02.inc_fecmov;
	ws_key_dep := c_nmindi02.inc_keydep;
	ws_key_pue := c_nmindi02.inc_keypue;
	wn_key_pro := c_nmindi02.inc_keypro;
	ws_key_per := c_nmindi02.inc_keyper;
	wn_dia_tre := c_nmindi02.inc_diatre;
	wn_dia_cua := c_nmindi02.inc_diacua;
	wn_dia_cin := c_nmindi02.inc_diacin;
	wn_dia_sei := c_nmindi02.inc_diasei;
	wn_dia_sie := c_nmindi02.inc_diasie;
	IF wn_pri_mer = 0 THEN
	    -- Extrae el nombre de la Compania Corporativa
	    ws_key_cia := '..';
	    FOR c_descor IN (SELECT pro_keycia
			       FROM LABPROD.nmloproc
				 WHERE pro_keypro = wn_key_pro) LOOP
		ws_key_cia := c_descor.pro_keycia;
	    END LOOP;
	    ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
	    FOR c_descia IN (SELECT cia_descia
			       FROM LABPROD.nmlocias
				 WHERE cia_keycia = ws_key_cia) LOOP
		ws_des_cor := c_descia.cia_descia;
	    END LOOP;
	    wn_pri_mer := wn_pri_mer +1;
	END IF;
	-- Actualiza registro de monitoreo.
	wn_num_reg := wn_num_reg + 1;
	IF wn_num_reg >= (wn_pct_reg * wn_pct_act) THEN
	    UPDATE LABPROD.glcoresu
	      SET res_numreg = wn_num_reg
		WHERE res_idepro = ws_nom_rep  AND
		      res_idepcc = ws_ide_pcc  AND
		      res_keyusu = wn_key_usu  AND
		      res_fecini = wd_fec_act AND
		      res_horreg = ws_hor_reg;
	    wn_pct_act := wn_pct_act + 1;
            wn_con_reg := wn_con_reg + 1;
	END IF;
	-- Suma incidencias.
	wn_tot_dia := 0;
	IF wn_dia_uno IS NOT NULL THEN
	    wn_tot_dia := wn_tot_dia + wn_dia_uno;
	END IF;
	IF wn_dia_dos IS NOT NULL THEN
	    wn_tot_dia := wn_tot_dia + wn_dia_dos;
	END IF;
	IF wn_dia_tre IS NOT NULL THEN
	    wn_tot_dia := wn_tot_dia + wn_dia_tre;
	END IF;
	IF wn_dia_cua IS NOT NULL THEN
	    wn_tot_dia := wn_tot_dia + wn_dia_cua;
	END IF;
	IF wn_dia_cin IS NOT NULL THEN
	    wn_tot_dia := wn_tot_dia + wn_dia_cin;
	END IF;
	IF wn_dia_sei IS NOT NULL THEN
	    wn_tot_dia := wn_tot_dia + wn_dia_sei;
	END IF;
	IF wn_dia_sie IS NOT NULL THEN
	    wn_tot_dia := wn_tot_dia + wn_dia_sie;
	END IF;
	-- Descrip. de concepto, proceso, nombre del empl., fecha inicial y final del periodo.
	IF ws_key_con IS NULL THEN
	    ws_des_con := 'CONCEPTO NO EXISTE ...';
	ELSE
	    IF ws_key_con <> ws_con_ant THEN
		ws_des_con := 'CONCEPTO NO EXISTE ...';
		FOR c_descon IN (SELECT con_descon
				   FROM LABPROD.nmloconc
				     WHERE con_keycon = ws_key_con) LOOP
		    ws_des_con := c_descon.con_descon;
		END LOOP;
		ws_con_ant := ws_key_con;
	    END IF;
	END IF;
	IF wn_key_emp IS NULL THEN
	    ws_nom_emp := 'EMPLEADO NO EXISTE ...';
	ELSE
	    IF wn_key_emp <> wn_emp_ant THEN
		ws_nom_emp := 'EMPLEADO NO EXISTE ...';
		FOR c_desemp IN (SELECT emp_nomemp
				   FROM LABPROD.nmcoempl
				     WHERE emp_keyemp = wn_key_emp) LOOP
		    ws_nom_emp := c_desemp.emp_nomemp;
		END LOOP;
		wn_emp_ant := wn_key_emp;
	    END IF;
	END IF;
	IF ws_key_dep IS NULL THEN
	    ws_des_dep := 'DEPTO. NO EXISTE...';
	ELSE
	    IF ws_key_dep <> ws_dep_ant THEN
		ws_des_dep := 'DEPTO. NO EXISTE...';
		FOR c_desdep IN (SELECT dep_desdep
				   FROM LABPROD.nmcodeps
				     WHERE dep_keydep = ws_key_dep) LOOP
		    ws_des_dep := c_desdep.dep_desdep;
		END LOOP;
		ws_dep_ant := SUBSTR (ws_key_dep, 1, 16);
	    END IF;
	END IF;
	IF wn_key_pro IS NULL THEN
	    ws_des_pro := 'PROCESO NO EXISTE...';
	ELSE
	    IF wn_key_pro <> wn_pro_ant THEN
		ws_des_pro := 'PROCESO NO EXISTE...';
		FOR c_despro IN (SELECT pro_despro
				   FROM LABPROD.nmloproc
				     WHERE pro_keypro = wn_key_pro) LOOP
		    ws_des_pro := c_despro.pro_despro;
		END LOOP;
		wn_pro_ant := wn_key_pro;
	    END IF;
	END IF;
	IF ws_key_per IS NULL THEN
	    wd_fec_ini := NULL;
	    wd_fec_fin := NULL;
	ELSE
	    IF ws_key_per <> ws_per_ant THEN
		wd_fec_ini := NULL;
		wd_fec_fin := NULL;
		FOR c_desfec IN (SELECT per_fecini, per_fecfin
				   FROM LABPROD.nmloperi
				     WHERE per_keyper = ws_key_per AND
					   per_keypro = wn_key_pro) LOOP
		    wd_fec_ini := c_desfec.per_fecini;
		    wd_fec_fin := c_desfec.per_fecfin;
		END LOOP;
		ws_per_ant := SUBSTR (ws_key_per, 1, 7);
	    END IF;
	END IF;
        -- Aplica restricciones de despliegue de Campos.
	IF wn_dsp_001 = 1 THEN
	    wn_key_pro := NULL;
	    ws_des_pro := NULL;
	END IF;
	IF wn_dsp_002 = 1 THEN
	    ws_key_per := NULL;
	    wd_fec_ini := NULL;
	    wd_fec_fin := NULL;
	END IF;
	IF wn_dsp_003 = 1 THEN
	    wn_key_emp := NULL;
	    ws_nom_emp := NULL;
	END IF;
	IF wn_dsp_004 = 1 THEN
	    ws_key_con := NULL;
	    ws_des_con := NULL;
	END IF;
	IF wn_dsp_005 = 1 THEN
	    wn_dia_uno := NULL;
	END IF;
	IF wn_dsp_006 = 1 THEN
	    wn_dia_dos := NULL;
	END IF;
	IF wn_dsp_007 = 1 THEN
	    wd_fec_mov := NULL;
	END IF;
	IF wn_dsp_008 = 1 THEN
	    ws_key_dep := NULL;
	    ws_des_dep := NULL;
	END IF;
	IF wn_dsp_009 = 1 THEN
	    ws_key_pue := NULL;
	END IF;
	IF wn_dsp_010 = 1 THEN
	    wn_dia_tre := NULL;
	END IF;
	IF wn_dsp_011 = 1 THEN
	    wn_dia_cua := NULL;
	END IF;
	IF wn_dsp_012 = 1 THEN
	    wn_dia_cin := NULL;
	END IF;
	IF wn_dsp_013 = 1 THEN
	    wn_dia_sei := NULL;
	END IF;
	IF wn_dsp_014 = 1 THEN
	    wn_dia_sie := NULL;
	END IF;
	-- Inserta en la tabla de trabajo del Crystal Report.
	INSERT INTO LABPROD.glwkcrys
		 (cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006, cry_chr017,
		  cry_dec001, cry_dec002, cry_dat001, cry_chr008, cry_chr009, cry_dec007,
		  cry_chr018, cry_chr003, cry_chr002, cry_chr010, cry_dat002, cry_dat003,
		  cry_dat004, cry_chr019, cry_dec003, cry_dec004, cry_dec005, cry_dec011,
		  cry_dec012, cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr024,
		  cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_chr029, cry_chr030,
		  cry_chr031, cry_chr032, cry_chr033, cry_chr034, cry_chr035, cry_chr004,
		  cry_dec013, cry_chr005)
	  VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_emp, ws_key_con,
		  wn_dia_uno, wn_dia_dos, wd_fec_mov, ws_key_dep, ws_key_pue, wn_key_pro,
		  ws_key_per, ws_des_con, ws_nom_emp, ws_des_pro, wd_fec_ini, wd_fec_fin,
		  wd_fec_act, ws_hor_act, wn_dia_tre, wn_dia_cua, wn_dia_cin, wn_dia_sei,
		  wn_dia_sie, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
		  ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009, ws_etq_010, ws_etq_011,
		  ws_etq_012, ws_etq_013, ws_etq_014, ws_etq_015, ws_etq_016, ws_des_dep,
		  wn_tot_dia, ws_des_lis);
        wn_con_reg := wn_con_reg + 1;
        IF wn_con_reg = wn_lim_ite THEN
 	   COMMIT;
	   wn_con_reg := 0;
	END IF;
    END LOOP;
    -- Actualiza la tabla de monitoreo indicando la finalizacion del proceso.
	sp_glfechor(wd_fec_act,ws_hor_act);
    UPDATE LABPROD.glcoresu
      SET res_numreg = wn_num_reg,
	  res_fecfin = wd_fec_act,
	  res_horfin = ws_hor_act,
	  res_status = 'T'
	WHERE res_idepro = ws_nom_rep  AND
	      res_idepcc = ws_ide_pcc  AND
	      res_keyusu = wn_key_usu  AND
	      res_fecini = wd_fec_act AND
	      res_horreg = ws_hor_reg;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        sp_glGenErr (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_hor_reg, SQLCODE, 0,
		     SUBSTR (SQLERRM, 1, 60));
END;
/
