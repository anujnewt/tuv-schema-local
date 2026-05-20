CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMLSTTAN" (ws_nom_rep IN VARCHAR2,   ws_ide_pcc IN VARCHAR2,
					 wn_key_usu IN NUMBER, ws_key_men IN VARCHAR2,
					 ws_hor_reg IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
----------------------------------------------------------------------------
-- IGNEOS, S.A. DE C.V.
--
-- Sistema  : RH-2000    C/S
-- Modulo   : Administracion de Remuneraciones (nm)
--
-- Programa : sp_nmlsttan
--            Reporte de tablas Numericas
--
-- Autor    : Pedro Perez Gutierrez
-- Fecha    : 28 de febrero de 1997
-- Correcci??n Oracle por: Orlando Olgu??n Olvera.	11:11 AM 16/07/1998
----------------------------------------------------------------------------
    -- Variables para la carga de la Tablas Numericas.
    ws_tab_key VARCHAR2(3);
    -- Variable para la carga de las especificaciones de las Claves.
    ws_des_tan VARCHAR2(40);
    ws_des_tab VARCHAR2(40);
    ws_tab_ant VARCHAR2(3) := '@@@';
    wn_row_ide NUMBER(10);
    -- Variable para la carga de las descripciones de las Etiquetas.
    ws_key_cam VARCHAR2(40);
    ws_des_etq VARCHAR2(40);
    -- Variables para las restricciones de despliegue.
    ws_dsp_cam VARCHAR2(20);
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
    -- Variables para el reporte de avance.
    wn_tot_reg NUMBER(10);
    wn_num_reg NUMBER(10) := 0;
    wn_pct_reg NUMBER(6,2);
    wn_pct_act NUMBER(5)  := 1;
    ws_des_cor glwkcrys.cry_chr001%TYPE;
    ws_des_lis glwkcrys.cry_chr002%TYPE := LABPROD.sp_glgetrep (ws_nom_rep, 'No existe Nombre del Reporte ...', NULL);
    ws_tan_de1 glwkcrys.cry_chr003%TYPE;
    ws_tan_de2 glwkcrys.cry_chr004%TYPE;
    ws_tan_de3 glwkcrys.cry_chr005%TYPE;
    wn_tab_sec glwkcrys.cry_dec001%TYPE;
    wn_tab_uno glwkcrys.cry_dec002%TYPE;
    wn_tab_dos glwkcrys.cry_dec003%TYPE;
    wn_tab_tre glwkcrys.cry_dec004%TYPE;
    wn_tab_cua glwkcrys.cry_dec005%TYPE;
    wd_dia_act glwkcrys.cry_dat001%TYPE;
    ws_tan_key glwkcrys.cry_chr017%TYPE;
    ws_etq_001 glwkcrys.cry_chr011%TYPE := LABPROD.sp_glgetdsl ('nmlotanu', 'tan_keytab', '....', 20);
    ws_etq_002 glwkcrys.cry_chr012%TYPE := LABPROD.sp_glgetdsl ('nmlotanu', 'tan_de1tab', '....', 16);
    ws_etq_003 glwkcrys.cry_chr013%TYPE := LABPROD.sp_glgetdsl ('nmlotanu', 'tan_de2tab', '....', 16);
    ws_etq_004 glwkcrys.cry_chr014%TYPE := LABPROD.sp_glgetdsl ('nmlotanu', 'tan_de3tab', '....', 16);
    ws_etq_005 glwkcrys.cry_chr015%TYPE := LABPROD.sp_glgetdsl ('nmlotabn', 'tab_keytab', '....', 16);
    ws_etq_006 glwkcrys.cry_chr007%TYPE := LABPROD.sp_glgetdsl ('nmlotabn', 'tab_sectab', '....', NULL);
    ws_etq_007 glwkcrys.cry_chr008%TYPE := LABPROD.sp_glgetdsl ('nmlotabn', 'tab_eleuno', '....', 20);
    ws_etq_008 glwkcrys.cry_chr009%TYPE := LABPROD.sp_glgetdsl ('nmlotabn', 'tab_eledos', '....', 20);
    ws_etq_009 glwkcrys.cry_chr010%TYPE := LABPROD.sp_glgetdsl ('nmlotabn', 'tab_eletre', '....', 20);
    ws_etq_010 glwkcrys.cry_chr006%TYPE := LABPROD.sp_glgetdsl ('nmlotabn', 'tab_elecua', '....', NULL);
    ws_hor_act glwkcrys.cry_chr021%TYPE;
    wn_con_reg NUMBER(3) := 0;
    wn_lim_ite NUMBER(3) := 100;
BEGIN
    LABPROD.sp_glfechor(wd_dia_act,ws_hor_act);
	LABPROD.sp_glnewdsp ('nmlotanu', 'tan_keytab', ws_key_men, wn_dsp_001);
    LABPROD.sp_glnewdsp ('nmlotanu', 'tan_de1tab', ws_key_men, wn_dsp_002);
    LABPROD.sp_glnewdsp ('nmlotanu', 'tan_de2tab', ws_key_men, wn_dsp_003);
    LABPROD.sp_glnewdsp ('nmlotanu', 'tan_de3tab', ws_key_men, wn_dsp_004);
    LABPROD.sp_glnewdsp ('nmlotabn', 'tab_keytab', ws_key_men, wn_dsp_005);
    LABPROD.sp_glnewdsp ('nmlotabn', 'tan_keytab', ws_key_men, wn_dsp_006);
    LABPROD.sp_glnewdsp ('nmlotabn', 'tan_de2tab', ws_key_men, wn_dsp_007);
    LABPROD.sp_glnewdsp ('nmlotabn', 'tan_de3tab', ws_key_men, wn_dsp_008);
    LABPROD.sp_glnewdsp ('nmlotabn', 'tan_de3tab', ws_key_men, wn_dsp_009);
    LABPROD.sp_glnewdsp ('nmlotabn', 'tan_de3tab', ws_key_men, wn_dsp_010);
	ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
	SELECT cor_razsoc
	INTO ws_des_cor
	FROM LABPROD.glcocorp;
	-- Realiza el conteo de registros a procesar.
    SELECT NVL (COUNT (*), 0)
      INTO wn_tot_reg
	FROM LABPROD.nmlotabn
	  WHERE tab_keytab IN (SELECT ran_keydep
				 FROM LABPROD.glwkrang
				   WHERE ran_nomrep = ws_nom_rep AND
					 ran_idepcc = ws_ide_pcc AND
					 ran_keyusu = wn_key_usu AND
					 ran_keydep IS NOT NULL);
	-- Inicializa variables de trabajo para realizar Cortes y Monitoreo
    wn_pct_reg := wn_tot_reg / 10.0 ;
	-- Inserta registro de resultados.
    INSERT INTO LABPROD.glcoresu
	     (res_idepro, res_idepcc, res_keyusu, res_fecini,
	      res_horini, res_horreg, res_totreg, res_status)
      VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, wd_dia_act,
	      ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
	-- Borra la tabla de trabajo del Crystal Report.
    DELETE FROM LABPROD.glwkcrys
      WHERE cry_nomrep = ws_nom_rep AND
	    cry_idepcc = ws_ide_pcc AND
	    cry_keyusu = wn_key_usu;
    COMMIT;
    -- Cursor Principal.
    FOR c_nmlsttan IN (SELECT tab_keytab, tab_sectab, tab_eleuno,
			      tab_eledos, tab_eletre, tab_elecua
			 FROM LABPROD.nmlotabn
			   WHERE tab_keytab IN (SELECT ran_keydep
						  FROM LABPROD.glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keydep IS NOT NULL)
			   ORDER BY tab_keytab, tab_sectab) LOOP
		-- Contador para realizar el COMMIT
		wn_con_reg := wn_con_reg + 1;
		ws_tab_key := c_nmlsttan.tab_keytab;
		wn_tab_sec := c_nmlsttan.tab_sectab;
		wn_tab_uno := c_nmlsttan.tab_eleuno;
		wn_tab_dos := c_nmlsttan.tab_eledos;
		wn_tab_tre := c_nmlsttan.tab_eletre;
		wn_tab_cua := c_nmlsttan.tab_elecua;
		-- Actualiza el registro de monitoreo.
		wn_num_reg := wn_num_reg + 1;
		IF wn_num_reg >= (wn_pct_reg * wn_pct_act) THEN
			UPDATE LABPROD.glcoresu
			  SET res_numreg = wn_num_reg
			WHERE res_idepro = ws_nom_rep  AND
				  res_idepcc = ws_ide_pcc  AND
				  res_keyusu = wn_key_usu  AND
				  res_fecini = wd_dia_act AND
				  res_horreg = ws_hor_reg;
				  wn_pct_act := wn_pct_act + 1;
				  wn_con_reg := wn_con_reg + 1;
		END IF;
		IF ws_tab_ant <> ws_tab_key THEN
			FOR c_nmlotanu IN (SELECT tan_keytab, tan_de1tab, tan_de2tab, tan_de3tab
					 FROM LABPROD.nmlotanu
					   WHERE tan_keytab = ws_tab_key ) LOOP
			ws_tan_key := c_nmlotanu.tan_keytab;
			ws_tan_de1 := c_nmlotanu.tan_de1tab;
			ws_tan_de2 := c_nmlotanu.tan_de2tab;
			ws_tan_de3 := c_nmlotanu.tan_de3tab;
			END LOOP;
			ws_tab_ant := ws_tab_key;
		END IF;
			-- Aplica Restricciones de despliegue de Campos.
		IF wn_dsp_001 = 1 THEN
			ws_tan_key := NULL;
		END IF;
		IF wn_dsp_002 = 1 THEN
			ws_tan_de1 := NULL;
		END IF;
		IF wn_dsp_003 = 1 THEN
			ws_tan_de2 := NULL;
		END IF;
		IF wn_dsp_004 = 1 THEN
			ws_tan_de3 := NULL;
		END IF;
		IF wn_dsp_005 = 1 THEN
			ws_tab_key := NULL;
		END IF;
		IF wn_dsp_006 = 1 THEN
			wn_tab_sec := NULL;
		END IF;
		IF wn_dsp_007 = 1 THEN
			wn_tab_uno := NULL;
		END IF;
		IF wn_dsp_008 = 1 THEN
			wn_tab_dos := NULL;
		END IF;
		IF wn_dsp_009 = 1 THEN
			wn_tab_tre := NULL;
		END IF;
		IF wn_dsp_010 = 1 THEN
			wn_tab_cua := NULL;
		END IF;
		-- Inserta en la tabla de Trabajo del Crystal Report.
		INSERT INTO LABPROD.glwkcrys
			 (cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr002, cry_chr003,
			  cry_chr004, cry_chr005, cry_dec001, cry_dec002, cry_dec003, cry_dec004,
			  cry_dec005, cry_dat001, cry_chr017, cry_chr011, cry_chr012, cry_chr013,
			  cry_chr014, cry_chr015, cry_chr007, cry_chr008, cry_chr009, cry_chr010,
			  cry_chr006, cry_chr021)
		  VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_des_lis, ws_tan_de1,
			  ws_tan_de2, ws_tan_de3, wn_tab_sec, wn_tab_uno, wn_tab_dos, wn_tab_tre,
			  wn_tab_cua, wd_dia_act, ws_tan_key, ws_etq_001, ws_etq_002, ws_etq_003,
			  ws_etq_004, ws_etq_005, ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009,
			  ws_etq_010, ws_hor_act);
		IF wn_con_reg >= wn_lim_ite THEN
			COMMIT;
			wn_con_reg := 0;
		END IF;
    END LOOP;
    -- Actualiza la tabla de monitoreo la finalizacion del Proceso
	LABPROD.sp_glfechor(wd_dia_act,ws_hor_act);
    UPDATE LABPROD.glcoresu
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
