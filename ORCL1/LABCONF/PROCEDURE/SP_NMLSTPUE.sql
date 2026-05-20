CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_NMLSTPUE" (ws_nom_rep IN VARCHAR2,   ws_ide_pcc IN VARCHAR2,
					 wn_key_usu IN NUMBER, ws_key_men IN VARCHAR2,
					 ws_hor_reg IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Puestos.
    ws_key_pue VARCHAR2(16);
    ws_des_pue VARCHAR2(40);
    ws_are_pue VARCHAR2(6);
    ws_sub_are VARCHAR2(6);
    -- Variables para la carga de la tabla de Tabuladores --
    ws_key_sue VARCHAR2(4);
    ws_cob_ert VARCHAR2(2);
    ws_tip_tab VARCHAR2(2);
    wn_sue_niv NUMBER(10);
    wn_sub_niv NUMBER(10);
    wd_fec_cad DATE;
    wn_sue_min NUMBER(12,2);
    wn_sue_1qa NUMBER(12,2);
    wn_sue_med NUMBER(12,2);
    wn_sue_3qa NUMBER(12,2);
    wn_sue_max NUMBER(12,2);
    -- Variables para la carga de las descripciones de las Etiquetas.
    ws_key_est VARCHAR2(3)  := '???';
    ws_sue_ant VARCHAR2(4)  := '????';
    ws_pue_ant VARCHAR2(16) := '????';
    ws_key_cam VARCHAR2(20);
    ws_key_tab VARCHAR2(4);
    ws_fol_ini VARCHAR2(16);
    ws_tab_are VARCHAR2(4);
    ws_tab_sub VARCHAR2(4);
    ws_des_etq VARCHAR2(8);
    -- Variables para el reporte de avance.
    wn_tot_reg NUMBER(10) := -1;
    wn_num_reg NUMBER(10) := 0;
    wn_pct_reg NUMBER(6,2);
    wn_pct_act NUMBER(5)  := 1;
    ws_des_cor glwkcrys.cry_chr001%TYPE;
    ws_des_sue glwkcrys.cry_chr003%TYPE;
    ws_des_are glwkcrys.cry_chr004%TYPE;
    ws_des_sub glwkcrys.cry_chr005%TYPE;
    ws_des_lis glwkcrys.cry_chr002%TYPE := sp_glgetrep (ws_nom_rep, 'No existe Nombre del Reporte ...', NULL);
    wn_tot_per glwkcrys.cry_dec006%TYPE := 0;
    ws_des_zon glwkcrys.cry_chr007%TYPE;
    ws_etq_001 glwkcrys.cry_chr013%TYPE := sp_glgetdsl ('nmlotabs', 'tab_keysue', '........', 16);
    ws_etq_002 glwkcrys.cry_chr021%TYPE := sp_glgetdsl ('nmcopues', 'pue_arepue', '........', 8);
    ws_etq_003 glwkcrys.cry_chr022%TYPE := sp_glgetdsl ('nmcopues', 'pue_keypue', '........', 8);
    ws_etq_004 glwkcrys.cry_chr023%TYPE := sp_glgetdsl ('nmcopues', 'pue_despue', '........', 8);
    ws_etq_005 glwkcrys.cry_chr024%TYPE := 'Personal';
    ws_etq_006 glwkcrys.cry_chr025%TYPE := sp_glgetdsl ('nmlotabs', 'tab_sueniv', '........', 8);
    ws_etq_007 glwkcrys.cry_chr014%TYPE := sp_glgetdsl ('nmlotabs', 'tab_cobert', '........', 8);
    ws_etq_008 glwkcrys.cry_chr027%TYPE := sp_glgetdsl ('nmlotabs', 'tab_tiptab', '........', 8);
    ws_etq_009 glwkcrys.cry_chr015%TYPE := sp_glgetdsl ('nmlotabs', 'tab_feccad', '........', 16);
    ws_etq_010 glwkcrys.cry_chr029%TYPE := sp_glgetdsl ('nmlotabs', 'tab_subniv', '........', 8);
    ws_etq_011 glwkcrys.cry_chr030%TYPE := sp_glgetdsl ('nmcopues', 'pue_subare', '........', 8);
    ws_etq_min glwkcrys.cry_chr008%TYPE;
    ws_etq_1qa glwkcrys.cry_chr009%TYPE;
    ws_etq_med glwkcrys.cry_chr010%TYPE;
    ws_etq_3qa glwkcrys.cry_chr011%TYPE;
    ws_etq_max glwkcrys.cry_chr016%TYPE;
    wd_fec_act glwkcrys.cry_dat001%TYPE;
    ws_hor_act glwkcrys.cry_chr017%TYPE;
    wn_con_reg NUMBER(3) := 0;
    wn_lim_ite NUMBER(3) := 100;
BEGIN
	-- DESCRIPCI� COORPORATIVO
	ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
	SELECT cor_razsoc INTO ws_des_cor	FROM glcocorp;
		-- fecha y hora
		sp_glfechor(wd_fec_act,ws_hor_act);
		-- Opcis
		SELECT pam_folini INTO ws_key_tab FROM glcopams
	  WHERE pam_keypar = '00' AND
		pam_cvesec = 'abcpue';
   	SELECT pam_folini INTO ws_fol_ini FROM glcopams
	  WHERE pam_keypar = (	SELECT pam_folini FROM glcopams
	  								 	    WHERE pam_keypar = '00' AND
													pam_cvesec = 'glMDI')
		AND pam_cvesec = 'OPCI63';
		SELECT pam_folini INTO ws_tab_are FROM glcopams
		WHERE pam_keypar = ws_key_tab
		AND pam_cvesec = 'OPCI01';
		SELECT pam_folini INTO ws_tab_sub FROM glcopams
		WHERE pam_keypar = ws_key_tab
		AND pam_cvesec = 'OPCI02';
    INSERT INTO glcoresu
	     (res_idepro, res_idepcc, res_keyusu, res_fecini,
	      res_horini, res_horreg, res_totreg, res_status)
      VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, wd_fec_act,
	      ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
    -- Borra la tabla de trabajo del Crystal Report.
    DELETE FROM glwkcrys
      WHERE cry_nomrep = ws_nom_rep AND
	    cry_idepcc = ws_ide_pcc AND
	    cry_keyusu = wn_key_usu;
    -- Extrae la clave de la Estructura Operativa.
    FOR c_operat IN (SELECT des_keyest
		       FROM eolodest
			 WHERE des_tipest = '1') LOOP
	ws_key_est := c_operat.des_keyest;
    END LOOP;
    -- Inicializa variables de trabajo para realizar Cortes y Monit.
    wn_pct_reg := wn_tot_reg / 10.0;
    COMMIT;
    -- Cursor principal.
    FOR c_nmlstpue IN (SELECT pue_keypue, pue_despue, pue_arepue, pue_subare, tab_keysue,
			      tab_cobert, tab_tiptab, tab_sueniv, tab_subniv, tab_feccad,
			      tab_suemin, tab_sue1qa, tab_suemed, tab_sue3qa, tab_suemax
			 FROM nmcopues, nmlotabs
			   WHERE pue_keysue = tab_keysue AND
				 pue_sueniv = tab_sueniv AND
				 pue_subniv = tab_subniv AND
				 pue_tippue = '1'        AND
				 pue_arepue IN (SELECT ran_keypue
						  FROM glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keypue IS NOT NULL)
			   ORDER BY tab_keysue, pue_keypue, tab_cobert,
				    tab_tiptab, tab_feccad) LOOP
	-- Actualiza registro de monitoreo.
	wn_num_reg := wn_num_reg + 1;
	wn_pct_act := wn_pct_act + 1;
      wn_con_reg := wn_con_reg + 1;
	IF wn_pct_act > 50 THEN
	    UPDATE glcoresu
	      SET res_numreg = wn_num_reg
		WHERE res_idepro = ws_nom_rep  AND
		      res_idepcc = ws_ide_pcc  AND
		      res_keyusu = wn_key_usu  AND
		      res_fecini = wd_fec_act AND
		      res_horreg = ws_hor_reg;
	    wn_pct_act := 0;
	    wn_con_reg := wn_con_reg + 1;
	END IF;
	-- Extrae descripcion del Tabulador, Area, Subarea y cobertura.
	IF c_nmlstpue.tab_keysue != ws_sue_ant THEN
	    ws_des_sue := 'TABULADOR NO EXISTE ...';
	    FOR c_dessue IN (SELECT sue_dessue, sue_etqmin, sue_etq1qa,
				    sue_etqmed, sue_etq3qa, sue_etqmax
			       FROM nmlosuel
				 WHERE sue_keysue = c_nmlstpue.tab_keysue) LOOP
		ws_des_sue := c_dessue.sue_dessue;
		ws_etq_min := SUBSTR (c_dessue.sue_etqmin, 1, 20);
		ws_etq_1qa := SUBSTR (c_dessue.sue_etq1qa, 1, 20);
		ws_etq_med := SUBSTR (c_dessue.sue_etqmed, 1, 20);
		ws_etq_3qa := SUBSTR (c_dessue.sue_etq3qa, 1, 20);
		ws_etq_max := SUBSTR (c_dessue.sue_etqmax, 1, 16);
	    END LOOP;
	    ws_sue_ant := SUBSTR (c_nmlstpue.tab_keysue, 1, 4);
	END IF;
	IF (c_nmlstpue.pue_arepue IS NOT NULL) AND (c_nmlstpue.pue_arepue != ' ') THEN
			SELECT pam_nompar INTO ws_des_are FROM glcopams
	  	WHERE pam_keypar = ws_tab_are
			AND pam_cvesec = c_nmlstpue.pue_arepue;
	    ws_etq_002 := sp_glgetdsl ('nmcopues', 'pue_arepue', '........', 8);
	ELSE
	    ws_des_are := ' ';
	    ws_etq_002 := ' ';
	END IF;
	IF (c_nmlstpue.pue_subare IS NOT NULL) AND (c_nmlstpue.pue_subare != ' ') THEN
			SELECT pam_nompar INTO ws_des_sub FROM glcopams
	  	WHERE pam_keypar = ws_tab_sub
			AND pam_cvesec = c_nmlstpue.pue_subare;
	    ws_etq_011 := sp_glgetdsl ('nmcopues', 'pue_subare', '........', 8);
	ELSE
	    ws_des_sub := ' ';
	    ws_etq_011 := ' ';
	END IF;
  SELECT pam_nompar INTO ws_des_zon FROM glcopams
	WHERE pam_keypar = ws_fol_ini
	AND pam_cvesec = c_nmlstpue.tab_cobert;
	-- Realiza el conteo de personal de la Plantilla.
	IF c_nmlstpue.pue_keypue != ws_pue_ant THEN
	    SELECT NVL(SUM (sol_cantid), 0)
	      INTO wn_tot_per
		FROM eolosolc
		  WHERE sol_keyest = ws_key_est AND
			sol_keypue = c_nmlstpue.pue_keypue;
	    ws_pue_ant := c_nmlstpue.pue_keypue;
	END IF;
	-- Inserta en la tabla de trabajo del Crystal Report.
	INSERT INTO glwkcrys
		 (cry_nomrep, cry_idepcc, cry_keyusu,
		  cry_chr001, cry_chr003, cry_chr004,
		  cry_chr005, cry_chr006, cry_chr002,
		  cry_chr036, cry_chr037, cry_chr038,
		  cry_chr012, cry_dec006, cry_dec007,
		  cry_dec008, cry_chr039, cry_dec001,
		  cry_dec002, cry_dec003, cry_dec004,
		  cry_dec005, cry_chr045, cry_chr007,
		  cry_chr013, cry_chr021, cry_chr022,
		  cry_chr023, cry_chr024, cry_chr025,
		  cry_chr014, cry_chr027, cry_chr015,
		  cry_chr029, cry_chr030, cry_chr008,
		  cry_chr009, cry_chr010, cry_chr011,
		  cry_chr016, cry_dat001, cry_chr017,
		  cry_dat002)
	  VALUES (ws_nom_rep,            ws_ide_pcc,            wn_key_usu,
		  ws_des_cor,            ws_des_sue,            ws_des_are,
		  ws_des_sub,            c_nmlstpue.pue_despue, ws_des_lis,
		  c_nmlstpue.tab_keysue, c_nmlstpue.pue_arepue, c_nmlstpue.pue_subare,
		  c_nmlstpue.pue_keypue, wn_tot_per,            c_nmlstpue.tab_sueniv,
		  c_nmlstpue.tab_subniv, c_nmlstpue.tab_tiptab, c_nmlstpue.tab_suemin,
		  c_nmlstpue.tab_sue1qa, c_nmlstpue.tab_suemed, c_nmlstpue.tab_sue3qa,
		  c_nmlstpue.tab_suemax, c_nmlstpue.tab_cobert, ws_des_zon,
		  ws_etq_001,            ws_etq_002,            ws_etq_003,
		  ws_etq_004,            ws_etq_005,            ws_etq_006,
		  ws_etq_007,            ws_etq_008,            ws_etq_009,
		  ws_etq_010,            ws_etq_011,            ws_etq_min,
		  ws_etq_1qa,            ws_etq_med,            ws_etq_3qa,
		  ws_etq_max,            wd_fec_act,            ws_hor_act,
		  c_nmlstpue.tab_feccad);
	IF wn_con_reg >= wn_lim_ite THEN
	    COMMIT;
	    wn_con_reg := 0;
	END IF;
    END LOOP;
		sp_glfechor(wd_fec_act,ws_hor_act);
    -- Actualiza la tabla de monitoreo indicando la finalizacion del proceso.
    UPDATE glcoresu
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
END;
/
