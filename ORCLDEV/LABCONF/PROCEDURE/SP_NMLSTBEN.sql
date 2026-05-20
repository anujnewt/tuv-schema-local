CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_NMLSTBEN" ( ws_nom_rep IN VARCHAR2,	ws_ide_pcc IN VARCHAR2,
  					      wn_key_usu IN NUMBER,	ws_key_men IN VARCHAR2,
					      ws_hor_reg IN VARCHAR2,	vs_tip_ben IN VARCHAR2)
    IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    wn_key_emp glwkcrys.cry_dec006%TYPE;
    ws_nom_emp glwkcrys.cry_chr002%TYPE;
    ws_key_dep glwkcrys.cry_chr010%TYPE;
    ws_des_dep glwkcrys.cry_chr004%TYPE;
    wn_key_ben glwkcrys.cry_dec007%TYPE;
    ws_tip_ben glwkcrys.cry_chr042%TYPE;
    ws_des_ben glwkcrys.cry_chr006%TYPE;
    wn_com_fam glwkcrys.cry_dec008%TYPE;
    ws_nom_ben glwkcrys.cry_chr003%TYPE;
    ws_rfc_ben glwkcrys.cry_chr008%TYPE;
    wd_fec_nac glwkcrys.cry_dat001%TYPE;
    ws_cve_sex glwkcrys.cry_chr040%TYPE;
    ws_tip_par glwkcrys.cry_chr041%TYPE;
    wn_por_par glwkcrys.cry_dec001%TYPE;
    wd_fec_ven glwkcrys.cry_dat002%TYPE;
    ws_key_ban glwkcrys.cry_chr043%TYPE;
    ws_cta_ban glwkcrys.cry_chr009%TYPE;
    ws_key_cen glwkcrys.cry_chr011%TYPE;
    ws_des_cen glwkcrys.cry_chr005%TYPE;
    ws_for_pag glwkcrys.cry_chr044%TYPE;
    ws_ca1_aux glwkcrys.cry_chr012%TYPE;
    ws_ca2_aux glwkcrys.cry_chr013%TYPE;
    ws_key_con glwkcrys.cry_chr016%TYPE;
    ws_per_ini glwkcrys.cry_chr014%TYPE;
    ws_per_fin glwkcrys.cry_chr015%TYPE;
    -- Variables para la carga de las descripciones de las Etiquetas
    ws_key_cam VARCHAR2(20);
    ws_des_etq VARCHAR2(8);
    ws_etq_001 glwkcrys.cry_chr021%TYPE := sp_glgetdsc('nmlobene','ben_keyemp','........',NULL);
    ws_etq_002 glwkcrys.cry_chr018%TYPE := sp_glgetdsc('nmlobene','ben_keyben','........',NULL);
    ws_etq_003 glwkcrys.cry_chr019%TYPE := sp_glgetdsc('nmlobene','ben_comfam','........',NULL);
    ws_etq_004 glwkcrys.cry_chr020%TYPE := sp_glgetdsc('nmlobene','ben_rfcben','........',NULL);
    ws_etq_005 VARCHAR2(8)  := sp_glgetdsc('nmlobene','ben_nomben','........',NULL);
    ws_etq_006 glwkcrys.cry_chr022%TYPE := sp_glgetdsc('nmlobene','ben_fecnac','........',NULL);
    ws_etq_007 glwkcrys.cry_chr023%TYPE := sp_glgetdsc('nmlobene','ben_cvesex','........',NULL);
    ws_etq_008 glwkcrys.cry_chr024%TYPE := sp_glgetdsc('nmlobene','ben_tippar','........',NULL);
    ws_etq_009 glwkcrys.cry_chr025%TYPE := sp_glgetdsc('nmlobene','ben_nomben','........',NULL);
    ws_etq_010 glwkcrys.cry_chr026%TYPE := sp_glgetdsc('nmlobene','ben_keyban','........',NULL);
    ws_etq_011 glwkcrys.cry_chr027%TYPE := sp_glgetdsc('nmlobene','ben_ctaban','........',NULL);
    ws_etq_012 glwkcrys.cry_chr028%TYPE := sp_glgetdsc('nmlobene','ben_keydep','........',NULL);
    ws_etq_013 glwkcrys.cry_chr029%TYPE := sp_glgetdsc('nmlobene','ben_keycen','........',NULL);
    ws_etq_014 glwkcrys.cry_chr030%TYPE := sp_glgetdsc('nmlobene','ben_ca1aux','........',NULL);
    ws_etq_015 glwkcrys.cry_chr031%TYPE := sp_glgetdsc('nmlobene','ben_ca2aux','........',NULL);
    ws_etq_016 glwkcrys.cry_chr032%TYPE := sp_glgetdsc('nmlobebe','beb_tipben','........',NULL);
    ws_etq_017 glwkcrys.cry_chr033%TYPE := sp_glgetdsc('nmlobebe','beb_porpar','........',NULL);
    ws_etq_018 glwkcrys.cry_chr034%TYPE := sp_glgetdsc('nmlobebe','beb_fecven','........',NULL);
    ws_etq_019 glwkcrys.cry_chr035%TYPE := sp_glgetdsc('nmlobebe','beb_forpag','........',NULL);
    ws_etq_020 glwkcrys.cry_chr036%TYPE := sp_glgetdsc('nmlobebe','beb_keycon','........',NULL);
    ws_etq_021 glwkcrys.cry_chr037%TYPE := sp_glgetdsc('nmlobebe','beb_perini','........',NULL);
    ws_etq_022 glwkcrys.cry_chr038%TYPE := sp_glgetdsc('nmlobebe','beb_perfin','........',NULL);
    ws_etq_023 glwkcrys.cry_chr039%TYPE := 'NOMBRE';
    ws_etq_024 glwkcrys.cry_chr017%TYPE := sp_glgetdsc('nmcocenc','cen_descen','........',NULL);
    ws_etq_025 glwkcrys.cry_chr039%TYPE := sp_glgetdsc('nmcodeps','dep_desdep','........',NULL);
    ws_des_cor glwkcrys.cry_chr001%TYPE;
    ws_des_lis glwkcrys.cry_chr007%TYPE := sp_glgetrep(ws_nom_rep,'No existe nombre del Reporte',40);
    -- Variables para las restricciones de despliegue
    ws_dsp_cam VARCHAR2(1);
    wn_dsp_001 NUMBER(5) := 0;
    wn_dsp_002 NUMBER(5) := 0;
    wn_dsp_003 NUMBER(5) := 0;
    wn_dsp_004 NUMBER(5) := 0;
    wn_dsp_005 NUMBER(5) := 0;
    wn_dsp_006 NUMBER(5) := 0;
    wn_dsp_007 NUMBER(5) := 0;
    wn_dsp_008 NUMBER(5) := 0;
    wn_dsp_009 NUMBER(5) := 0;
    wn_dsp_010 NUMBER(5) := 0;
    wn_dsp_011 NUMBER(5) := 0;
    wn_dsp_012 NUMBER(5) := 0;
    wn_dsp_013 NUMBER(5) := 0;
    wn_dsp_014 NUMBER(5) := 0;
    wn_dsp_015 NUMBER(5) := 0;
    wn_dsp_016 NUMBER(5) := 0;
    wn_dsp_017 NUMBER(5) := 0;
    wn_dsp_018 NUMBER(5) := 0;
    wn_dsp_019 NUMBER(5) := 0;
    wn_dsp_020 NUMBER(5) := 0;
    wn_dsp_021 NUMBER(5) := 0;
    -- Variables para el reporte de avance
    wn_tot_reg NUMBER(10);
    wn_num_reg NUMBER(10)   := 0;
    wn_pct_reg NUMBER(6,2);
    wn_pct_act NUMBER(5)    := 1;
    ws_hor_act glwkcrys.cry_chr045%TYPE;
    ws_fec_act glwkcrys.cry_dat004%TYPE;
    -- variables para realizar cortes
    wn_emp_ant glwkcrys.cry_dec006%TYPE := -999999999;
    ws_dep_ant glwkcrys.cry_chr010%TYPE := '################';
    ws_cen_ant glwkcrys.cry_chr011%TYPE := '################';
    ws_ben_ant glwkcrys.cry_chr042%TYPE := '##';
    wn_con_tad NUMBER(5);
    wn_con_reg NUMBER(3) := 0;
    wn_lim_ite NUMBER(3) := 100;
BEGIN
		sp_glfechor(ws_fec_act,ws_hor_act);
    -- Realiza el conteo de registros a procesar
    SELECT COUNT(*) INTO wn_tot_reg FROM nmlobene
      WHERE ben_keyemp IN ( SELECT ran_keyemp FROM glwkrang
			      WHERE ran_nomrep = ws_nom_rep AND
				ran_idepcc = ws_ide_pcc AND
				ran_keyusu = wn_key_usu AND
				ran_keyemp IS NOT NULL )
	    AND ben_keyben IN ( SELECT ran_keynom FROM glwkrang
				  WHERE ran_nomrep = ws_nom_rep AND
					ran_idepcc = ws_ide_pcc AND
					ran_keyusu = wn_key_usu AND
					ran_keynom IS NOT NULL )
	    AND ben_comfam IN ( SELECT ran_keypro FROM glwkrang
				  WHERE ran_nomrep = ws_nom_rep AND
					ran_idepcc = ws_ide_pcc AND
					ran_keyusu = wn_key_usu AND
					ran_keypro IS NOT NULL );
    -- Inserta registro para monitoreo de resultados                --
    INSERT INTO glcoresu (
	res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
	res_horreg, res_totreg, res_status )
    VALUES (
	ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_fec_act, ws_hor_act,
	ws_hor_reg, wn_tot_reg, 'P');
    -- Borra la tabla de trabajo del Crystal Report                 --
    DELETE FROM glwkcrys
      WHERE cry_nomrep = ws_nom_rep AND
	    cry_idepcc = ws_ide_pcc AND
	    cry_keyusu = wn_key_usu;
	-- nombre del corporativo
	ws_des_cor:='CORPORATIVO NO REGISTRADO';
	SELECT cor_razsoc
	INTO ws_des_cor FROM glcocorp;
    -- extrae las restricciones de Despliegue                       --
    FOR c_desplieg IN ( SELECT rec_keycam, rec_despli FROM glcoreca
			  WHERE rec_keytab = 'nmlobene' AND
				rec_keymen = ws_key_men ) LOOP
	ws_key_cam := c_desplieg.rec_keycam;
	ws_dsp_cam := c_desplieg.rec_despli;
	IF ( ws_key_cam = 'ben_keyemp') AND ( ws_dsp_cam = 'N') THEN
	   sp_glNewDsp('nmlobene','ben_keyemp',ws_key_men, wn_dsp_001);
	END IF;
	IF ( ws_key_cam = 'ben_keyben') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_keyben',ws_key_men,wn_dsp_002);
	END IF;
	IF ( ws_key_cam = 'ben_comfam') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_comfam',ws_key_men,wn_dsp_003);
	END IF;
	IF ( ws_key_cam = 'ben_rfcben') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_rfcben',ws_key_men,wn_dsp_004);
	END IF;
	IF ( ws_key_cam = 'ben_nomben') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_nomben',ws_key_men,wn_dsp_005);
	END IF;
	IF ( ws_key_cam = 'ben_fecnac') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_fecnac',ws_key_men,wn_dsp_006);
	END IF;
	IF ( ws_key_cam = 'ben_cvesex') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_cvesex',ws_key_men,wn_dsp_007);
	END IF;
	IF ( ws_key_cam = 'ben_tippar') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_tippar',ws_key_men,wn_dsp_008);
	END IF;
	IF ( ws_key_cam = 'ben_keyban') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_keyban',ws_key_men,wn_dsp_009);
	END IF;
	IF ( ws_key_cam = 'ben_ctaban') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_ctaban',ws_key_men,wn_dsp_010);
	END IF;
	IF ( ws_key_cam = 'ben_keydep') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_keydep',ws_key_men,wn_dsp_011);
	END IF;
	IF ( ws_key_cam = 'ben_keycen') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_keycen',ws_key_men,wn_dsp_012);
	END IF;
	IF ( ws_key_cam = 'ben_ca1aux') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_ca1aux',ws_key_men,wn_dsp_013);
	END IF;
	IF ( ws_key_cam = 'ben_ca2aux') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobene','ben_ca2aux',ws_key_men,wn_dsp_014);
	END IF;
    END LOOP;
    FOR c_desplieg IN ( SELECT rec_keycam, rec_despli FROM glcoreca
      WHERE rec_keytab = 'nmlobebe'
        AND rec_keymen = ws_key_men ) LOOP
	ws_key_cam := c_desplieg.rec_keycam;
	ws_dsp_cam := c_desplieg.rec_despli;
	IF ( ws_key_cam = 'beb_tipben') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobebe','beb_tipben',ws_key_men,wn_dsp_015);
	END IF;
	IF ( ws_key_cam = 'beb_porpar') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobebe','beb_porpar',ws_key_men,wn_dsp_016);
	END IF;
	IF ( ws_key_cam = 'beb_fecven') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobebe','beb_fecven',ws_key_men,wn_dsp_017);
	END IF;
	IF ( ws_key_cam = 'beb_forpag') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobebe','beb_forpag',ws_key_men,wn_dsp_018);
	END IF;
	IF ( ws_key_cam = 'beb_keycon') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobebe','beb_keycon',ws_key_men,wn_dsp_019);
	END IF;
	IF ( ws_key_cam = 'beb_perini') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobebe','beb_perini',ws_key_men,wn_dsp_020);
	END IF;
	IF ( ws_key_cam = 'beb_perfin') AND ( ws_dsp_cam = 'N') THEN
	    sp_glNewDsp('nmlobebe','beb_perfin',ws_key_men,wn_dsp_021);
	END IF;
    END LOOP;
    -- Inicializa variables de trabajo para realizar Cortes y Monit --
    wn_pct_reg := wn_tot_reg / 10.0;
    -- cursor principal                                       --
    COMMIT;
    FOR c_nmlstben IN ( SELECT ben_keyemp, ben_keyben, ben_comfam, ben_rfcben, ben_nomben,
			       ben_fecnac, ben_cvesex, ben_tippar, ben_keyban, ben_ctaban,
		   	       ben_keydep, ben_keycen, ben_ca1aux, ben_ca2aux FROM nmlobene
		  	  WHERE ben_keyemp IN ( SELECT ran_keyemp FROM glwkrang
						  WHERE ran_nomrep = ws_nom_rep AND
				      			ran_idepcc = ws_ide_pcc AND
				      			ran_keyusu = wn_key_usu AND
							ran_keyemp IS NOT NULL )
	      		        AND ben_keyben IN ( SELECT ran_keynom FROM glwkrang
				    		      WHERE ran_nomrep = ws_nom_rep AND
							    ran_idepcc = ws_ide_pcc AND
							    ran_keyusu = wn_key_usu AND
							    ran_keynom IS NOT NULL )
		  	        AND ben_comfam IN ( SELECT ran_keypro FROM glwkrang
						      WHERE ran_nomrep = ws_nom_rep AND
							    ran_idepcc = ws_ide_pcc AND
		 					    ran_keyusu = wn_key_usu AND
		 					    ran_keypro IS NOT NULL )) LOOP
	-- Actualiza registro de monitoreo
	wn_key_emp := c_nmlstben.ben_keyemp;
	wn_key_ben := c_nmlstben.ben_keyben;
	wn_com_fam := c_nmlstben.ben_comfam;
	ws_rfc_ben := c_nmlstben.ben_rfcben;
	ws_nom_ben := RTRIM(c_nmlstben.ben_nomben);
	wd_fec_nac := c_nmlstben.ben_fecnac;
	ws_cve_sex := c_nmlstben.ben_cvesex;
	ws_tip_par := c_nmlstben.ben_tippar;
	ws_key_ban := c_nmlstben.ben_keyban;
	ws_cta_ban := c_nmlstben.ben_ctaban;
	ws_key_dep := c_nmlstben.ben_keydep;
	ws_key_cen := c_nmlstben.ben_keycen;
	ws_ca1_aux := c_nmlstben.ben_ca1aux;
	ws_ca2_aux := c_nmlstben.ben_ca2aux;
	wn_num_reg := wn_num_reg + 1;
	wn_con_reg := wn_con_reg + 1;
	IF wn_num_reg >= ( wn_pct_reg * wn_pct_act ) THEN
	    UPDATE glcoresu SET res_numreg = wn_num_reg
		WHERE res_idepro = ws_nom_rep AND
		      res_idepcc = ws_ide_pcc AND
		      res_keyusu = wn_key_usu AND
		      res_fecini = ws_fec_act AND
		      res_horreg = ws_hor_reg;
	    wn_pct_act := wn_pct_act + 1;
	    wn_con_reg := wn_con_reg + 1;
	END IF;
	-- Extrae descripciones del departamento, centro de costo y  --
	-- nombre del empleado.                                      --
	IF wn_key_emp IS NULL THEN
	    ws_nom_emp := 'EMPLEADO NO EXISTE ...';
	ELSE
	    IF wn_key_emp <> wn_emp_ant THEN
		ws_nom_emp := 'EMPLEADO NO EXISTE ...';
		FOR c_nomemp IN ( SELECT emp_nomemp FROM nmcoempl
		    		     WHERE emp_keyemp = wn_key_emp ) LOOP
		    ws_nom_emp := c_nomemp.emp_nomemp;
		END LOOP;
		wn_emp_ant := wn_key_emp;
	    END IF;
	END IF;
	IF ws_key_dep IS NULL THEN
	    ws_des_dep := 'DEPARTAMENTO NO EXISTE ...';
	ELSE
	    IF ws_key_dep <> ws_dep_ant THEN
		ws_des_dep := 'DEPARTAMENTO NO EXISTE ...';
		FOR c_desdep IN (SELECT dep_desdep FROM nmcodeps
				   WHERE dep_keydep = ws_key_dep ) LOOP
		    ws_des_dep := c_desdep.dep_desdep;
		END LOOP;
		ws_dep_ant := ws_key_dep;
	    END IF;
	END IF;
	IF ws_key_cen IS NULL THEN
	    ws_des_cen := 'CENTRO NO EXISTE ...';
	ELSE
	    IF ws_key_cen <> ws_cen_ant THEN
		ws_des_cen := 'CENTRO NO EXISTE ...';
		FOR c_descen IN ( SELECT cen_descen FROM nmlocenc
				    WHERE cen_keycen = ws_key_cen ) LOOP
		    ws_des_cen := c_descen.cen_descen;
		END LOOP;
		ws_cen_ant := ws_key_cen;
	    END IF;
	END IF;
	-- Cursor para extraer el detalle de los beneficios            --
	wn_con_tad := 0;
	FOR c_beneficios IN ( SELECT beb_tipben, beb_fecven, beb_porpar, beb_forpag, beb_keycon,
				 beb_perini, beb_perfin
		          FROM nmlobebe
			    WHERE beb_keyemp = wn_key_emp AND
				  beb_keyben = wn_key_ben AND
				  beb_comfam = wn_com_fam AND
			 	  beb_keyemp IN ( SELECT ran_keyemp FROM glwkrang
						     WHERE ran_nomrep = ws_nom_rep AND
							   ran_idepcc = ws_ide_pcc AND
							   ran_keyusu = wn_key_usu AND
							   ran_keyemp IS NOT NULL )
				  AND beb_keyben IN ( SELECT ran_keynom FROM glwkrang
							WHERE ran_nomrep = ws_nom_rep AND
							      ran_idepcc = ws_ide_pcc AND
							      ran_keyusu = wn_key_usu AND
							      ran_keynom IS NOT NULL )
			          AND beb_comfam IN ( SELECT ran_keypro FROM glwkrang
							WHERE ran_nomrep = ws_nom_rep AND
							      ran_idepcc = ws_ide_pcc AND
							      ran_keyusu = wn_key_usu AND
							      ran_keypro IS NOT NULL ) ) LOOP
	    -- Extrae la descripcion del tipo de beneficio                  --
	    ws_tip_ben := c_beneficios.beb_tipben;
	    wd_fec_ven := c_beneficios.beb_fecven;
	    wn_por_par := c_beneficios.beb_porpar;
 	    ws_for_pag := c_beneficios.beb_forpag;
	    ws_key_con := c_beneficios.beb_keycon;
	    ws_per_ini := c_beneficios.beb_perini;
	    ws_per_fin := c_beneficios.beb_perfin;
	    IF ws_tip_ben IS NULL THEN
		ws_des_ben := 'BENEFICIO NO EXISTE ...';
	    ELSE
		IF ws_tip_ben <> ws_ben_ant THEN
		    ws_des_ben := 'BENEFICIO NO EXISTE ...';
		    FOR c_desben IN ( SELECT pam_nompar FROM glcopams
					WHERE pam_keypar = vs_tip_ben AND
					      pam_cvesec = ws_tip_ben ) LOOP
			ws_des_ben := c_desben.pam_nompar;
		    END LOOP;
		    ws_ben_ant := ws_tip_ben;
		END IF;
	    END IF;
	    -- Aplica restricciones de despliegue de Campos                 --
	    IF wn_dsp_001 = 1 THEN
		wn_key_emp := NULL;
		ws_nom_emp := NULL;
	    END IF;
	    IF wn_dsp_002 = 1 THEN
		wn_key_ben := NULL;
	    END IF;
	    IF wn_dsp_003 = 1 THEN
		wn_com_fam := NULL;
	    END IF;
	    IF wn_dsp_004 = 1 THEN
		ws_rfc_ben := NULL;
	    END IF;
	    IF wn_dsp_005 = 1 THEN
		ws_nom_ben := NULL;
	    END IF;
	    IF wn_dsp_006 = 1 THEN
		wd_fec_nac := NULL;
	    END IF;
	    IF wn_dsp_007 = 1 THEN
		ws_cve_sex := NULL;
	    END IF;
	    IF wn_dsp_008 = 1 THEN
		ws_tip_par := NULL;
	    END IF;
	    IF wn_dsp_009 = 1 THEN
		ws_key_ban := NULL;
	    END IF;
	    IF wn_dsp_010 = 1 THEN
		ws_cta_ban := NULL;
	    END IF;
	    IF wn_dsp_011 = 1 THEN
		ws_key_dep := NULL;
		ws_des_dep := NULL;
	    END IF;
	    IF wn_dsp_012 = 1 THEN
		ws_key_cen := NULL;
		ws_des_cen := NULL;
	    END IF;
	    IF wn_dsp_013 = 1 THEN
		ws_ca1_aux := NULL;
	    END IF;
	    IF wn_dsp_014 = 1 THEN
		ws_ca2_aux := NULL;
	    END IF;
	    IF wn_dsp_015 = 1 THEN
		ws_tip_ben := NULL;
		ws_des_ben := NULL;
	    END IF;
	    IF wn_dsp_016 = 1 THEN
		wn_por_par := NULL;
	    END IF;
	    IF wn_dsp_017 = 1 THEN
		wd_fec_ven := NULL;
	    END IF;
	    IF wn_dsp_018 = 1 THEN
		ws_for_pag := NULL;
	    END IF;
	    IF wn_dsp_019 = 1 THEN
		ws_key_con := NULL;
	    END IF;
	    IF wn_dsp_020 = 1 THEN
		ws_per_ini := NULL;
	    END IF;
	    IF wn_dsp_021 = 1 THEN
		ws_per_fin := NULL;
	    END IF;
	    -- Inserta en la tabla de trabajo del Crystal Report            --
	    INSERT INTO glwkcrys (
		cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006,
		cry_dec007, cry_dec008, cry_chr008, cry_chr003, cry_dat001,
		cry_chr040, cry_chr041, cry_chr042, cry_dec001, cry_dat002,
		cry_chr043, cry_chr009, cry_chr010, cry_chr011, cry_chr044,
		cry_chr012, cry_chr013, cry_chr002, cry_chr004,
		cry_chr005, cry_chr017, cry_chr018, cry_chr019, cry_chr020,
		cry_chr021, cry_chr022, cry_chr023, cry_chr024, cry_chr025,
		cry_chr026, cry_chr027, cry_chr028, cry_chr029, cry_chr030,
		cry_chr031, cry_chr032, cry_chr033, cry_chr034, cry_chr035,
		cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr045,
		cry_dat004, cry_chr006, cry_chr007,
		cry_chr016, cry_chr014, cry_chr015)
	    VALUES (
 		ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_emp,
		wn_key_ben, wn_com_fam, ws_rfc_ben, ws_nom_ben, wd_fec_nac,
		ws_cve_sex, ws_tip_par, ws_tip_ben, wn_por_par, wd_fec_ven,
		ws_key_ban, ws_cta_ban, ws_key_dep, ws_key_cen, ws_for_pag,
		ws_ca1_aux, ws_ca2_aux, ws_nom_emp, ws_des_dep,
		ws_des_cen, ws_etq_024, ws_etq_002, ws_etq_003, ws_etq_004,
		ws_etq_001, ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009,
		ws_etq_010, ws_etq_011, ws_etq_012, ws_etq_013, ws_etq_014,
		ws_etq_015, ws_etq_016, ws_etq_017, ws_etq_018, ws_etq_019,
		ws_etq_020, ws_etq_021, ws_etq_022, ws_etq_025, ws_hor_act,
		ws_fec_act, ws_des_ben, ws_des_lis,
		ws_key_con, ws_per_ini, ws_per_fin);
	    wn_con_tad := wn_con_tad + 1;
	    wn_con_reg := wn_con_reg + 1;
	END LOOP;
	IF wn_con_tad = 0 THEN
	    -- Aplica restricciones de despliegue de Campos                 --
	    IF wn_dsp_001 = 1 THEN
		wn_key_emp := NULL;
		ws_nom_emp := NULL;
	    END IF;
	    IF wn_dsp_002 = 1 THEN
		wn_key_ben := NULL;
	    END IF;
	    IF wn_dsp_003 = 1 THEN
		wn_com_fam := NULL;
	    END IF;
	    IF wn_dsp_004 = 1 THEN
		ws_rfc_ben := NULL;
	    END IF;
	    IF wn_dsp_005 = 1 THEN
		ws_nom_ben := NULL;
	    END IF;
	    IF wn_dsp_006 = 1 THEN
		wd_fec_nac := NULL;
	    END IF;
	    IF wn_dsp_007 = 1 THEN
		ws_cve_sex := NULL;
	    END IF;
	    IF wn_dsp_008 = 1 THEN
		ws_tip_par := NULL;
	    END IF;
	    IF wn_dsp_009 = 1 THEN
		ws_key_ban := NULL;
	    END IF;
	    IF wn_dsp_010 = 1 THEN
		ws_cta_ban := NULL;
	    END IF;
	    IF wn_dsp_011 = 1 THEN
		ws_key_dep := NULL;
		ws_des_dep := NULL;
	    END IF;
	    IF wn_dsp_012 = 1 THEN
		ws_key_cen := NULL;
		ws_des_cen := NULL;
	    END IF;
	    IF wn_dsp_013 = 1 THEN
		ws_ca1_aux := NULL;
	    END IF;
	    IF wn_dsp_014 = 1 THEN
		ws_ca2_aux := NULL;
	    END IF;
	    -- Inserta en la tabla de trabajo del Crystal Report            --
	    INSERT INTO glwkcrys (
		cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006,
		cry_dec007, cry_dec008, cry_chr008, cry_chr003, cry_dat001,
		cry_chr040, cry_chr041, cry_chr043, cry_chr009, cry_chr010,
		cry_chr011, cry_chr012, cry_chr013, cry_chr002, cry_chr004,
		cry_chr005, cry_chr017, cry_chr018, cry_chr019, cry_chr020,
		cry_chr021, cry_chr022, cry_chr023, cry_chr024, cry_chr025,
		cry_chr026, cry_chr027, cry_chr028, cry_chr029, cry_chr030,
		cry_chr031, cry_chr032, cry_chr033, cry_chr034, cry_chr035,
		cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr045,
 		cry_dat004, cry_chr007 )
	    VALUES (
		ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_emp,
		wn_key_ben, wn_com_fam, ws_rfc_ben, ws_nom_ben, wd_fec_nac,
		ws_cve_sex, ws_tip_par, ws_key_ban, ws_cta_ban, ws_key_dep,
		ws_key_cen, ws_ca1_aux, ws_ca2_aux, ws_nom_emp, ws_des_dep,
		ws_des_cen, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004,
		ws_etq_001, ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009,
		ws_etq_010, ws_etq_011, ws_etq_012, ws_etq_013, ws_etq_014,
		ws_etq_015, ws_etq_016, ws_etq_017, ws_etq_018, ws_etq_019,
		ws_etq_020, ws_etq_021, ws_etq_022, ws_etq_023, ws_hor_act,
		ws_fec_act, ws_des_lis );
	    wn_con_reg := wn_con_reg + 1;
	END IF;
	If wn_con_reg >= wn_lim_ite THEN
	    COMMIT;
	    wn_con_reg := 0;
	END IF;
    END LOOP;
    -- Actualiza la tabla de monitoreo indicando la finalizacion    --
    -- del proceso.                                                 --
    sp_glfechor(ws_fec_act,ws_hor_act);
    UPDATE glcoresu SET res_numreg = wn_num_reg,
			res_fecfin = ws_fec_act,
			res_horfin = ws_hor_act,
			res_status = 'T'
    WHERE res_idepro = ws_nom_rep AND
	  res_idepcc = ws_ide_pcc AND
	  res_keyusu = wn_key_usu AND
	  res_fecini = ws_fec_act AND
	  res_horreg = ws_hor_reg;
    COMMIT;
END;
/
