CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMLSTCXP" (ws_nom_rep IN VARCHAR2,   ws_ide_pcc IN VARCHAR2,
					 wn_key_usu IN NUMBER, ws_key_men IN VARCHAR2,
					 ws_hor_reg IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_lee_dfc VARCHAR2(1);
    wn_pro_ant NUMBER(5) := -32760;
    wn_nom_ant NUMBER(5) := -32760;
    -- Variables para las restricciones de despliegue.
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
    wn_dsp_015 NUMBER(5);
    wn_dsp_016 NUMBER(5);
    wn_dsp_017 NUMBER(5);
    wn_dsp_018 NUMBER(5);
    wn_dsp_019 NUMBER(5);  --RDD
	wn_dsp_020 NUMBER(5);  --RDD
    -- Variables para la carga de las descripciones de las Claves.
    ws_des_cor glwkcrys.cry_chr001%TYPE;
    ws_des_pro glwkcrys.cry_chr003%TYPE;
    ws_des_nom glwkcrys.cry_chr004%TYPE;
    ws_des_con glwkcrys.cry_chr005%TYPE;
    ws_key_con glwkcrys.cry_chr008%TYPE;
    ws_key_for glwkcrys.cry_chr009%TYPE;
	ws_for_val glwkcrys.cry_chr038%TYPE; --RDD
    ws_lee_inc glwkcrys.cry_chr010%TYPE;
    ws_lee_dfi glwkcrys.cry_chr011%TYPE;
    ws_lee_pre glwkcrys.cry_chr012%TYPE;
    ws_lee_acu glwkcrys.cry_chr013%TYPE;
    ws_lee_aus glwkcrys.cry_chr038%TYPE; --RDD
    ws_cod_acu glwkcrys.cry_chr014%TYPE;
    ws_cod_imp glwkcrys.cry_chr015%TYPE;
    ws_cod_val glwkcrys.cry_chr016%TYPE;
    wn_key_pro glwkcrys.cry_dec006%TYPE;
    wn_key_nom glwkcrys.cry_dec007%TYPE;
    wn_uni_ini glwkcrys.cry_dec003%TYPE;
    wn_uni_fin glwkcrys.cry_dec004%TYPE;
    wn_imp_ini glwkcrys.cry_dec005%TYPE;
    wn_imp_fin glwkcrys.cry_dec001%TYPE;
    wn_num_sec glwkcrys.cry_dec008%TYPE;
    wn_por_cen glwkcrys.cry_dec002%TYPE;
    ws_des_lis glwkcrys.cry_chr002%TYPE := sp_glgetrep ('nmrspcxp', 'No existe Nombre del Reporte...', NULL);
    ws_etq_001 glwkcrys.cry_chr020%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_keypro', '........', NULL);
    ws_etq_002 glwkcrys.cry_chr021%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_keynom', '........', NULL);
    ws_etq_003 glwkcrys.cry_chr022%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_numsec', '........', NULL);
    ws_etq_004 glwkcrys.cry_chr023%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_keycon', '........', NULL);
    ws_etq_005 glwkcrys.cry_chr024%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_keyfor', '........', NULL);
    ws_etq_006 glwkcrys.cry_chr025%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_leeinc', '........', NULL);
    ws_etq_007 glwkcrys.cry_chr026%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_leedfi', '........', NULL);
    ws_etq_008 glwkcrys.cry_chr027%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_leepre', '........', NULL);
    ws_etq_009 glwkcrys.cry_chr028%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_leeacu', '........', NULL);
    ws_etq_010 glwkcrys.cry_chr029%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_codacu', '........', NULL);
    ws_etq_011 glwkcrys.cry_chr030%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_codimp', '........', NULL);
    ws_etq_012 glwkcrys.cry_chr031%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_codval', '........', NULL);
    ws_etq_013 glwkcrys.cry_chr032%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_uniini', '........', NULL);
    ws_etq_014 glwkcrys.cry_chr033%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_unifin', '........', NULL);
    ws_etq_015 glwkcrys.cry_chr034%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_impini', '........', NULL);
    ws_etq_016 glwkcrys.cry_chr035%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_impfin', '........', NULL);
    ws_etq_017 glwkcrys.cry_chr006%TYPE := sp_glgetdsc ('nmloconc', 'con_descon', '........', NULL);
    ws_etq_018 glwkcrys.cry_chr037%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_porcen', '........', NULL);
    ws_etq_019 glwkcrys.cry_chr019%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_leedfc', '........', NULL);
    ws_etq_020 glwkcrys.cry_chr036%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_forval', '........', NULL); --RDD
    ws_etq_021 glwkcrys.cry_chr036%TYPE := sp_glgetdsc ('nmlocxpr', 'cxp_leeaus', '........', NULL); --RDD
    wd_fec_act glwkcrys.cry_dat001%TYPE;
    -- Variables para el reporte de avance.
    wn_tot_reg NUMBER(10);
    wn_num_reg NUMBER(10)  := 0;
    wn_pct_reg NUMBER(6,2);
    wn_pct_act NUMBER(5)   := 1;
    ws_hor_act VARCHAR2(8);
    wn_con_reg NUMBER(3) := 0;
    wn_lim_ite NUMBER(3) := 100;
BEGIN
	sp_glfechor(wd_fec_act,ws_hor_act);
	sp_glNewDsp('nmlobene','ben_keyben',ws_key_men,wn_dsp_002);
	sp_glnewdsp ('nmlocxpr', 'cxp_keypro', ws_key_men,wn_dsp_001);
    sp_glnewdsp ('nmlocxpr', 'cxp_keynom', ws_key_men,wn_dsp_002);
    sp_glnewdsp ('nmlocxpr', 'cxp_numsec', ws_key_men,wn_dsp_003);
    sp_glnewdsp ('nmlocxpr', 'cxp_keycon', ws_key_men,wn_dsp_004);
    sp_glnewdsp ('nmlocxpr', 'cxp_keyfor', ws_key_men,wn_dsp_005);
    sp_glnewdsp ('nmlocxpr', 'cxp_leeinc', ws_key_men,wn_dsp_006);
    sp_glnewdsp ('nmlocxpr', 'cxp_leedfi', ws_key_men,wn_dsp_007);
    sp_glnewdsp ('nmlocxpr', 'cxp_leepre', ws_key_men,wn_dsp_008);
    sp_glnewdsp ('nmlocxpr', 'cxp_leeacu', ws_key_men,wn_dsp_009);
    sp_glnewdsp ('nmlocxpr', 'cxp_codacu', ws_key_men,wn_dsp_010);
    sp_glnewdsp ('nmlocxpr', 'cxp_codimp', ws_key_men,wn_dsp_011);
    sp_glnewdsp ('nmlocxpr', 'cxp_codval', ws_key_men,wn_dsp_012);
    sp_glnewdsp ('nmlocxpr', 'cxp_uniini', ws_key_men,wn_dsp_013);
    sp_glnewdsp ('nmlocxpr', 'cxp_unifin', ws_key_men,wn_dsp_014);
    sp_glnewdsp ('nmlocxpr', 'cxp_impini', ws_key_men,wn_dsp_015);
    sp_glnewdsp ('nmlocxpr', 'cxp_impfin', ws_key_men,wn_dsp_016);
    sp_glnewdsp ('nmlocxpr', 'cxp_porcen', ws_key_men,wn_dsp_017);
    sp_glnewdsp ('nmlocxpr', 'cxp_leedfc', ws_key_men,wn_dsp_018);
    sp_glnewdsp ('nmlocxpr', 'cxp_forval', ws_key_men,wn_dsp_019);
    sp_glnewdsp ('nmlocxpr', 'cxp_leeaus', ws_key_men,wn_dsp_020);
	ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
	SELECT cor_razsoc INTO ws_des_cor
	FROM glcocorp;
    -- Realiza el conteo de registros a procesar.
    SELECT COUNT(*)
      INTO wn_tot_reg
	FROM nmlocxpr
	  WHERE cxp_keypro IN (SELECT ran_keypro
				 FROM glwkrang
				   WHERE ran_nomrep = ws_nom_rep AND
					 ran_idepcc = ws_ide_pcc AND
					 ran_keyusu = wn_key_usu AND
					 ran_keypro IS NOT NULL) AND
		cxp_keynom IN (SELECT ran_keynom
				 FROM glwkrang
				   WHERE ran_nomrep = ws_nom_rep AND
					 ran_idepcc = ws_ide_pcc AND
					 ran_keyusu = wn_key_usu AND
					 ran_keynom IS NOT NULL);
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
    COMMIT;
    -- Inicializa variables de trabajo para realizar Cortes y Monit.
    wn_pct_reg := wn_tot_reg / 10.0;
    -- Define cursor principal.
    FOR c_nmlstcxp IN (SELECT cxp_keypro, cxp_keynom, cxp_numsec, cxp_keycon, cxp_keyfor,
			      cxp_leeinc, cxp_leedfi, cxp_leepre, cxp_leeacu, cxp_codacu,
			      cxp_codimp, cxp_codval, cxp_uniini, cxp_unifin, cxp_impini,
			      cxp_impfin, cxp_porcen, cxp_leedfc, cxp_forval, cxp_leeaus -- RDD
			 FROM nmlocxpr
			   WHERE cxp_keypro IN (SELECT ran_keypro
						  FROM glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keypro IS NOT NULL) AND
				 cxp_keynom IN (SELECT ran_keynom
						  FROM glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keynom IS NOT NULL)
			   ORDER BY cxp_keypro, cxp_keynom) LOOP
	-- Asignaci"n de valores.
	wn_key_pro := c_nmlstcxp.cxp_keypro;
	wn_key_nom := c_nmlstcxp.cxp_keynom;
	wn_num_sec := c_nmlstcxp.cxp_numsec;
	ws_key_con := c_nmlstcxp.cxp_keycon;
	ws_key_for := c_nmlstcxp.cxp_keyfor;
	ws_lee_inc := c_nmlstcxp.cxp_leeinc;
	ws_lee_dfi := c_nmlstcxp.cxp_leedfi;
	ws_lee_pre := c_nmlstcxp.cxp_leepre;
	ws_lee_acu := c_nmlstcxp.cxp_leeacu;
	ws_cod_acu := c_nmlstcxp.cxp_codacu;
	ws_cod_imp := c_nmlstcxp.cxp_codimp;
	ws_cod_val := c_nmlstcxp.cxp_codval;
	wn_uni_ini := c_nmlstcxp.cxp_uniini;
	wn_uni_fin := c_nmlstcxp.cxp_unifin;
	wn_imp_ini := c_nmlstcxp.cxp_impini;
	wn_imp_fin := c_nmlstcxp.cxp_impfin;
	wn_por_cen := c_nmlstcxp.cxp_porcen;
	ws_lee_dfc := c_nmlstcxp.cxp_leedfc;
	ws_for_val := c_nmlstcxp.cxp_forval; --RDD
	ws_lee_aus := c_nmlstcxp.cxp_leeaus; --RDD
	IF rtrim(ws_lee_aus) = '' OR ws_lee_aus IS NULL THEN --RDD
	   ws_lee_aus := 'N';
	END IF;
	-- Actualiza registro de monitoreo.
	wn_num_reg := wn_num_reg + 1;
	IF wn_num_reg >= (wn_pct_reg * wn_pct_act) THEN
	    UPDATE glcoresu
	      SET res_numreg = wn_num_reg
		WHERE res_idepro = ws_nom_rep  AND
		      res_idepcc = ws_ide_pcc  AND
		      res_keyusu = wn_key_usu  AND
		      res_fecini = wd_fec_act AND
		      res_horreg = ws_hor_reg;
	    wn_pct_act := wn_pct_act + 1;
 	    wn_con_reg := wn_con_reg + 1;
	END IF;
	-- Extrae descripciones de concepto, proceso y tipo de Nomina.
	ws_des_con := 'CONCEPTO NO EXISTE ...';
	FOR c_descon IN (SELECT con_descon
			   FROM nmloconc
			     WHERE con_keycon = ws_key_con) LOOP
	    ws_des_con := c_descon.con_descon;
	END LOOP;
	IF wn_key_pro IS NULL THEN
	    ws_des_pro := 'PROCESO NO EXISTE ...';
	ELSE
	    IF wn_key_pro <> wn_pro_ant THEN
		ws_des_pro := 'PROCESO NO EXISTE ...';
		FOR c_despro IN (SELECT pro_despro
				   FROM nmloproc
				     WHERE pro_keypro = wn_key_pro) LOOP
		    ws_des_pro := c_despro.pro_despro;
		END LOOP;
		wn_pro_ant := wn_key_pro;
	    END IF;
	END IF;
	IF wn_key_nom IS NULL THEN
	    ws_des_nom := 'TIPO DE NOMINA NO EXISTE ..';
	ELSE
	    IF wn_key_nom <> wn_nom_ant THEN
		ws_des_nom := 'TIPO DE NOMINA NO EXISTE ...';
		FOR c_desnom IN (SELECT nom_destip
				   FROM nmlonomi
				     WHERE nom_keynom = wn_key_nom) LOOP
		    ws_des_nom := c_desnom.nom_destip;
		END LOOP;
		wn_nom_ant := wn_key_nom;
	    END IF;
	END IF;
	-- Aplica restricciones de despliegue de Campos.
	IF wn_dsp_001 = 1 THEN
	    wn_key_pro := NULL;
	    ws_des_pro := NULL;
	END IF;
	IF wn_dsp_002 = 1 THEN
	    wn_key_nom := NULL;
	    ws_des_nom := NULL;
	END IF;
	IF wn_dsp_004 = 1 THEN
	    ws_key_con := NULL;
	    ws_des_con := NULL;
	END IF;
	IF wn_dsp_003 = 1 THEN
	    wn_num_sec := NULL;
	END IF;
	IF wn_dsp_005 = 1 THEN
	    ws_key_for := NULL;
	END IF;
	IF wn_dsp_006 = 1 THEN
	    ws_lee_inc := NULL;
	END IF;
	IF wn_dsp_007 = 1 THEN
	    ws_lee_dfi := NULL;
	END IF;
	IF wn_dsp_008 = 1 THEN
	    ws_lee_pre := NULL;
	END IF;
	IF wn_dsp_009 = 1 THEN
	    ws_lee_acu := NULL;
	END IF;
	IF wn_dsp_010 = 1 THEN
	    ws_cod_acu := NULL;
	END IF;
	IF wn_dsp_011 = 1 THEN
	    ws_cod_imp := NULL;
	END IF;
	IF wn_dsp_012 = 1 THEN
	    ws_cod_val := NULL;
	END IF;
	IF wn_dsp_013 = 1 THEN
	    wn_uni_ini := NULL;
	END IF;
	IF wn_dsp_014 = 1 THEN
	    wn_uni_fin := NULL;
	END IF;
	IF wn_dsp_015 = 1 THEN
	    wn_imp_ini := NULL;
	END IF;
	IF wn_dsp_016 = 1 THEN
	    wn_imp_fin := NULL;
	END IF;
	IF wn_dsp_017 = 1 THEN
	    wn_por_cen := NULL;
	END IF;
	IF wn_dsp_018 = 1 THEN
	    ws_lee_dfc := NULL;
	END IF;
	IF wn_dsp_019 = 1 THEN --RDD
	    ws_for_val := NULL;
	END IF;
	IF wn_dsp_020 = 1 THEN --RDD
	    ws_lee_aus := NULL;
	END IF;
	-- Inserta en la tabla de trabajo del Crystal Report.
	INSERT INTO glwkcrys
		 (cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr003, cry_chr004,
		  cry_chr005, cry_chr008, cry_chr009, cry_chr010, cry_chr011, cry_chr012,
		  cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_dec006, cry_dec007,
		  cry_dec003, cry_dec004, cry_dec005, cry_dec001, cry_dec008, cry_dec002,
		  cry_chr002, cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr024,
		  cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_chr029, cry_chr030,
		  cry_chr031, cry_chr032, cry_chr033, cry_chr034, cry_chr035, cry_chr006,
		  cry_dat001, cry_chr017, cry_chr037, cry_chr018, cry_chr019,
		  cry_chr036, cry_chr038, cry_chr039, cry_chr040) --RDD cry_chr36,cry_chr038
	  VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_des_pro, ws_des_nom,
		  ws_des_con, ws_key_con, ws_key_for, ws_lee_inc, ws_lee_dfi, ws_lee_pre,
		  ws_lee_acu, ws_cod_acu, ws_cod_imp, ws_cod_val, wn_key_pro, wn_key_nom,
		  wn_uni_ini, wn_uni_fin, wn_imp_ini, wn_imp_fin, wn_num_sec, wn_por_cen,
		  ws_des_lis, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
		  ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009, ws_etq_010, ws_etq_011,
		  ws_etq_012, ws_etq_013, ws_etq_014, ws_etq_015, ws_etq_016, ws_etq_017,
		  wd_fec_act, ws_hor_act, ws_etq_018, ws_lee_dfc, ws_etq_019,
		  ws_etq_020, ws_for_val, ws_etq_021, ws_lee_aus); --RDD ws_etq_020
        wn_con_reg := wn_con_reg + 1;
        IF wn_con_reg = wn_lim_ite THEN
 	   COMMIT;
	   wn_con_reg := 0;
	END IF;
    END LOOP;
    -- Actualiza la tabla de monitoreo indicando la finalizacion del proceso.
	sp_glfechor(wd_fec_act,ws_hor_act);
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
