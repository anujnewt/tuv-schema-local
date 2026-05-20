CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_NMLSTDIC" (ws_nom_rep IN VARCHAR2,   ws_ide_pcc IN VARCHAR2,
					 wn_key_usu IN NUMBER, ws_key_men IN VARCHAR2,
					 ws_hor_reg IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   -- Variable para la carga de las descripciones de las Claves.
    ws_des_aux VARCHAR2(40);
    ws_tab_ant glwkcrys.cry_chr002%TYPE := '@@@';
    wn_row_ide NUMBER(10);
    -- Variable para la carga de las descripciones de las Etiquetas.
    ws_des_etq VARCHAR2(10);
    -- Variables para las restricciones de despliegue.
    ws_dsp_cam VARCHAR2(20);
    wn_dsp_001 NUMBER(5);
    wn_dsp_002 NUMBER(5);
    wn_dsp_003 NUMBER(5);
    wn_dsp_004 NUMBER(5);
    wn_dsp_005 NUMBER(5);
    wn_dsp_006 NUMBER(5);
    wn_dsp_007 NUMBER(5);
    -- Variables para el reporte de avance.
    wn_tot_reg NUMBER(10);
    wn_num_reg NUMBER(10)  := 0;
    wn_pct_reg NUMBER(6,2);
    wn_pct_act NUMBER(5)   := 1;
    ws_hor_act VARCHAR2(8);
    ws_des_cor glwkcrys.cry_chr001%TYPE;
    ws_key_tab glwkcrys.cry_chr004%TYPE;
    ws_des_tab glwkcrys.cry_chr003%TYPE;
    ws_key_cam glwkcrys.cry_chr005%TYPE;
    ws_des_cam glwkcrys.cry_chr006%TYPE;
    ws_dau_cam glwkcrys.cry_chr007%TYPE;
    ws_dco_cam glwkcrys.cry_chr008%TYPE;
    ws_etq_001 glwkcrys.cry_chr029%TYPE := sp_glgetdsc ('glcotabl', 'tab_keytab', '....', NULL);
    ws_etq_002 glwkcrys.cry_chr010%TYPE := sp_glgetdsl ('glcocamp', 'cam_keytab', '....', 20);
    ws_etq_003 glwkcrys.cry_chr011%TYPE := sp_glgetdsl ('glcocamp', 'cam_keycam', '....', 20);
    ws_etq_004 glwkcrys.cry_chr012%TYPE := sp_glgetdsl ('glcocamp', 'cam_descam', '....', 16);
    ws_etq_005 glwkcrys.cry_chr013%TYPE := sp_glgetdsl ('glcocamp', 'cam_desaux', '....', 16);
    ws_etq_006 glwkcrys.cry_chr014%TYPE := sp_glgetdsl ('glcocamp', 'cam_descor', '....', 16);
    ws_etq_007 glwkcrys.cry_chr030%TYPE := sp_glgetdsc ('glcotabl', 'tab_destab', '....', NULL);
    wd_dia_act glwkcrys.cry_dat001%TYPE;
    ws_des_lis glwkcrys.cry_chr002%TYPE := sp_glgetrep (ws_nom_rep, 'No Existe Nombre del Reporte', 40);
    wn_con_reg NUMBER(3) := 0;
    wn_lim_ite NUMBER(3) := 100;
BEGIN
	sp_glfechor(wd_dia_act,ws_hor_act);
	ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
	SELECT cor_razsoc INTO ws_des_cor	FROM glcocorp;
	sp_glnewdsp ('glcotabl', 'tab_keytab', ws_key_men, wn_dsp_001);
  	sp_glnewdsp ('glcotabl', 'tab_destab', ws_key_men, wn_dsp_002);
  	sp_glnewdsp ('glcocamp', 'cam_keytab', ws_key_men, wn_dsp_003);
 	sp_glnewdsp ('glcocamp', 'cam_keycam', ws_key_men, wn_dsp_004);
  	sp_glnewdsp ('glcocamp', 'cam_descam', ws_key_men, wn_dsp_005);
  	sp_glnewdsp ('glcocamp', 'cam_desaux', ws_key_men, wn_dsp_006);
  	sp_glnewdsp ('glcocamp', 'cam_descor', ws_key_men, wn_dsp_007);
    -- Realiza el conteo de registros a procesar.
    SELECT NVL(COUNT(*), 0)
      INTO wn_tot_reg
	FROM glcocamp
	  WHERE cam_keytab IN (SELECT ran_keydep
				 FROM glwkrang
				   WHERE ran_nomrep = ws_nom_rep AND
					 ran_idepcc = ws_ide_pcc AND
					 ran_keyusu = wn_key_usu AND
					 ran_keydep IS NOT NULL);
    -- Inserta registro de resultados.
    INSERT INTO glcoresu
	     (res_idepro, res_idepcc, res_keyusu, res_fecini,
	      res_horini, res_horreg, res_totreg, res_status)
      VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, wd_dia_act,
	      ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
    -- Borra la tabla de trabajo del Crystal Report.
    DELETE FROM glwkcrys
      WHERE cry_nomrep = ws_nom_rep AND
	    cry_idepcc = ws_ide_pcc AND
	    cry_keyusu = wn_key_usu;
    -- Inicializa variables de trabajo para realizar Cortes y Monitoreo.
    wn_pct_reg := wn_tot_reg / 10.0 ;
    COMMIT;
    -- Cursor Principal.
    FOR c_nmlstdic IN (SELECT cam_keytab, cam_keycam, cam_descam, cam_desaux, cam_descor
			 FROM glcocamp
			   WHERE cam_keytab IN (SELECT ran_keydep
						  FROM glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keydep IS NOT NULL)
			   ORDER BY cam_keytab, cam_keycam) LOOP
	ws_key_cam := c_nmlstdic.cam_keycam;
	ws_des_cam := c_nmlstdic.cam_descam;
	ws_dau_cam := c_nmlstdic.cam_desaux;
	ws_dco_cam := c_nmlstdic.cam_descor;
	-- Actualiza el registro de monitoreo.
	wn_num_reg := wn_num_reg + 1;
	wn_con_reg := wn_con_reg + 1;
	IF wn_num_reg >= (wn_pct_reg * wn_pct_act) THEN
	    UPDATE glcoresu
	      SET res_numreg = wn_num_reg
		WHERE res_idepro = ws_nom_rep  AND
		      res_idepcc = ws_ide_pcc  AND
		      res_keyusu = wn_key_usu  AND
		      res_fecini = wd_dia_act AND
		      res_horreg = ws_hor_reg;
	    wn_pct_act := wn_pct_act + 1;
 	    wn_con_reg := wn_con_reg + 1;
	END IF;
	-- Substr a?adido para el buen funcionamiento.
	IF ws_tab_ant <> c_nmlstdic.cam_keytab THEN
	    FOR c_tab IN (SELECT tab_keytab, tab_destab
			    FROM  glcotabl
			      WHERE tab_keytab = rtrim (c_nmlstdic.cam_keytab)) LOOP
		ws_key_tab := c_tab.tab_keytab;
		ws_des_tab := substr(c_tab.tab_destab, 1, 40);
	    END LOOP;
	    ws_tab_ant := ws_key_tab;
	END IF;
	-- Aplica Restricciones de despliegue de Campos.
	IF wn_dsp_001 = 1 THEN
	    ws_key_tab := NULL;
	END IF;
	IF wn_dsp_002 = 1 THEN
	    ws_des_tab := NULL;
	END IF;
	IF wn_dsp_003 = 1 THEN
	    ws_key_tab := NULL;
	END IF;
	IF wn_dsp_004 = 1 THEN
	    ws_key_cam := NULL;
	END IF;
	IF wn_dsp_005 = 1 THEN
	    ws_des_cam := NULL;
	END IF;
	IF wn_dsp_006 = 1 THEN
	    ws_dau_cam := NULL;
	END IF;
	IF wn_dsp_007 = 1 THEN
	    ws_dco_cam := NULL;
	END IF;
	-- Inserta en la tabla de Trabajo del Crystal Report.
	INSERT INTO glwkcrys
		 (cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr004,
		  cry_chr003, cry_chr005, cry_chr006, cry_chr007, cry_chr008,
		  cry_chr029, cry_chr010, cry_chr011, cry_chr012, cry_chr013,
		  cry_chr014, cry_chr030, cry_chr016, cry_dat001, cry_chr002)
	  VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_key_tab,
		  ws_des_tab, ws_key_cam, ws_des_cam, ws_dau_cam, ws_dco_cam,
		  ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
		  ws_etq_006, ws_etq_007, ws_hor_act, wd_dia_act, ws_des_lis);
	IF wn_con_reg >= wn_lim_ite THEN
 	   COMMIT;
	   wn_con_reg := 0;
	END IF;
    END LOOP;
		sp_glfechor(wd_dia_act,ws_hor_act);
    -- Actualiza la tabla de monitoreo la finalizacion Del proceso
    UPDATE glcoresu
      SET res_numreg = wn_num_reg,
	  res_fecfin = wd_dia_act,
	  res_horfin = ws_hor_act,
	  res_status = 'T'
	WHERE res_idepro = ws_nom_rep  AND
	      res_idepcc = ws_ide_pcc  AND
	      res_keyusu = wn_key_usu  AND
	      res_fecini = wd_dia_act AND
	      res_horreg = ws_hor_reg;
    COMMIT;
END;
/
