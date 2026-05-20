CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_NMLSTMOV" (ws_nom_rep IN VARCHAR2,   ws_ide_pcc IN VARCHAR2,
					 wn_key_usu IN NUMBER, ws_key_men IN VARCHAR2,
					 ws_hor_reg IN VARCHAR2,   wn_key_pro IN NUMBER,
					 ws_key_per IN VARCHAR2,   wn_tip_rep NUMBER,
					 ws_nom_rp1 IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la Tabla de Movimientos
    ws_key_cia VARCHAR2(5) := '..';
    -- Variables para las restricciones de despliegue
    wn_dsp_001 NUMBER(5) := LABCONF.sp_glgetdsp1 ('nmwkmovt', 'mov_cantid', ws_key_men);
    wn_dsp_002 NUMBER(5) := LABCONF.sp_glgetdsp1 ('nmwkmovt', 'mov_import', ws_key_men);
    -- Variables para el corte de Procesos
    wn_ant_emp NUMBER(10) := -0000;
    ws_ant_con VARCHAR2(3)    := '@@@';
    -- Variables para el reporte de avance
    wn_tot_reg NUMBER(10) := -1;
    wn_num_reg NUMBER(10) := 0;
    wn_pct_reg NUMBER(10,2);
    wn_pct_act NUMBER(10) := 1;
    wn_can_ti2 LABCONF.glwkcrys.cry_dec003%TYPE := NULL;
    wn_can_tid LABCONF.glwkcrys.cry_dec001%TYPE;
    wn_imp_or2 LABCONF.glwkcrys.cry_dec004%TYPE := NULL;
    wn_imp_ort LABCONF.glwkcrys.cry_dec002%TYPE;
    ws_des_co2 LABCONF.glwkcrys.cry_chr004%TYPE := NULL;
    ws_des_con LABCONF.glwkcrys.cry_chr003%TYPE;
    ws_des_cor LABCONF.glwkcrys.cry_chr001%TYPE := 'CORPORATIVO NO REGISTRADO ...';
    ws_des_lis LABCONF.glwkcrys.cry_chr005%TYPE := LABCONF.sp_glgetrep (ws_nom_rp1, 'No existe nombre del reporte...', 40);
    ws_dia_act LABCONF.glwkcrys.cry_dat001%TYPE := LABCONF.sp_glgetfec;
    ws_etq_001 LABCONF.glwkcrys.cry_chr020%TYPE := LABCONF.sp_glgetdsc ('nmwkmovt', 'mov_keyemp', '........', NULL);
    ws_etq_002 LABCONF.glwkcrys.cry_chr021%TYPE := LABCONF.sp_glgetdsc ('nmcoempl', 'emp_nomemp', '........', NULL);
    ws_etq_003 LABCONF.glwkcrys.cry_chr006%TYPE := LABCONF.sp_glgetdsl ('nmwkmovt', 'mov_keycon', '........', NULL);
    ws_etq_004 LABCONF.glwkcrys.cry_chr007%TYPE := LABCONF.sp_glgetdsl ('nmloconc', 'con_descon', '........', NULL);
    ws_etq_005 LABCONF.glwkcrys.cry_chr008%TYPE := LABCONF.sp_glgetdsl ('nmwkmovt', 'mov_cantid', '........', 20);
    ws_etq_006 LABCONF.glwkcrys.cry_chr009%TYPE := LABCONF.sp_glgetdsl ('nmwkmovt', 'mov_import', '........', 20);
    ws_hor_act LABCONF.glwkcrys.cry_chr024%TYPE := LABCONF.sp_glgethor;
    ws_key_co2 LABCONF.glwkcrys.cry_chr025%TYPE := NULL;
    ws_key_con LABCONF.glwkcrys.cry_chr017%TYPE;
    ws_nom_emp LABCONF.glwkcrys.cry_chr002%TYPE;
    wn_con_reg NUMBER(3) := 0;
    wn_lim_ite NUMBER(3) := 100;
BEGIN
    -- Inserta registro de resultados.
    INSERT INTO LABCONF.glcoresu
	     (res_idepro, res_idepcc, res_keyusu, res_fecini,
	      res_horini, res_horreg, res_totreg, res_status)
      VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, sp_glgetfec,
	      ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
    -- Borra la tabla de trabajo del Crystal Report
    DELETE FROM LABCONF.glwkcrys
      WHERE cry_nomrep = ws_nom_rep AND
	    cry_idepcc = ws_ide_pcc AND
	    cry_keyusu = wn_key_usu;
    -- Extrae el nombre de la Compania Corporativa.
    FOR c_descor IN (SELECT pro_keycia
		       FROM LABCONF.nmloproc
			 WHERE pro_keypro = wn_key_pro) LOOP
	ws_key_cia := c_descor.pro_keycia;
    END LOOP;
    FOR c_descia IN (SELECT cia_descia
		       FROM LABCONF.nmlocias
			 WHERE cia_keycia = ws_key_cia) LOOP
	ws_des_cor := c_descia.cia_descia;
    END LOOP;
    -- Inicializa variables de trabajo para realizar Cortes y Monitoreo
    wn_pct_reg := wn_tot_reg / 10.0 ;
    COMMIT;
    -- Cursor Principal.
    FOR c_mov IN (SELECT mov_keyemp, mov_keycon, mov_cantid, mov_import, mov_codimp
		    FROM LABCONF.nmwkmovt
		      WHERE mov_keypro = wn_key_pro AND
			    mov_keyper = ws_key_per AND
			    mov_keycon IN (SELECT ran_keycon
					     FROM LABCONF.glwkrang
					       WHERE ran_nomrep = ws_nom_rep AND
						     ran_idepcc = ws_ide_pcc AND
						     ran_keyusu = wn_key_usu AND
						     ran_keycon IS NOT NULL) AND
			    mov_keyemp IN (SELECT ran_keyemp
					     FROM LABCONF.glwkrang
					       WHERE ran_nomrep = ws_nom_rep AND
						     ran_idepcc = ws_ide_pcc AND
						     ran_keyusu = wn_key_usu AND
						     ran_keyemp IS NOT NULL)
		      ORDER BY mov_keyemp, mov_keycon) LOOP
	ws_key_con := c_mov.mov_keycon;
	wn_can_tid := c_mov.mov_cantid;
	wn_imp_ort := c_mov.mov_import;
	-- Actualiza el registro de monitoreo
	wn_num_reg := wn_num_reg + 1;
	IF wn_num_reg >= (wn_pct_reg * wn_pct_act) THEN
	    UPDATE LABCONF.glcoresu
	      SET res_numreg = wn_num_reg
		WHERE res_idepro = ws_nom_rep  AND
		      res_idepcc = ws_ide_pcc  AND
		      res_keyusu = wn_key_usu  AND
		      res_fecini = sp_glgetfec AND
		      res_horreg = ws_hor_reg;
	    wn_pct_act := wn_pct_act + 1;
	END IF;
	-- Obtenemos el Nombre del Empleado.
	IF c_mov.mov_keyemp IS NULL THEN
	    ws_nom_emp := 'Empleado No existe...';
	ELSE
	    IF wn_ant_emp <> c_mov.mov_keyemp THEN
		ws_nom_emp := 'Empleado No existe...';
		FOR c_keyemp IN (SELECT emp_nomemp
				   FROM LABCONF.nmcoempl
				     WHERE emp_keyemp = c_mov.mov_keyemp) LOOP
		    ws_nom_emp := c_keyemp.emp_nomemp;
		END LOOP;
		wn_ant_emp := c_mov.mov_keyemp;
	    END IF;
	END IF;
	-- Obtenemos el Nombre del Concepto.
	IF ws_key_con IS NULL THEN
	    ws_des_con := 'Concepto No existe...';
	ELSE
	    IF ws_ant_con <> ws_key_con THEN
		ws_des_con := 'Concepto No existe...';
		FOR c_keycon IN (SELECT con_descon
				   FROM LABCONF.nmloconc
				     WHERE con_keycon = ws_key_con) LOOP
		    ws_des_con := c_keycon.con_descon;
		END LOOP;
		ws_ant_con := SUBSTR (ws_key_con, 1, 3);
	    END IF;
	END IF;
	-- Deduccion.
	IF c_mov.mov_codimp = '02' THEN
	    wn_imp_ort := wn_imp_ort * -1;
	END IF;
	-- Concepto auxiliar.
	IF c_mov.mov_codimp = '03' AND wn_tip_rep = 1 THEN
	    ws_key_co2 := ws_key_con;
	    ws_des_co2 := ws_des_con;
	    wn_can_ti2 := wn_can_tid;
	    wn_imp_or2 := wn_imp_ort;
	    ws_key_con := NULL;
	    ws_des_con := NULL;
	    wn_imp_ort := NULL;
	    wn_can_tid := NULL;
	END IF;
	-- Aplica Restricciones de despliegue de Campos.
	IF wn_dsp_001 = 1 THEN
	    wn_can_tid := NULL;
	END IF;
	IF wn_dsp_002 = 1 THEN
	    wn_imp_ort := NULL;
	END IF;
	-- Inserta en la tabla de Trabajo del Crystal Report
	INSERT INTO LABCONF.glwkcrys
		 (cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr017, cry_chr003,
		  cry_dec006, cry_chr002, cry_dec001, cry_dec002, cry_chr006, cry_chr007,
		  cry_chr020, cry_chr021, cry_chr008, cry_chr009 ,cry_dat001, cry_chr024,
		  cry_chr025, cry_chr004, cry_dec003, cry_dec004, cry_chr005)
	  VALUES (ws_nom_rep,       ws_ide_pcc, wn_key_usu, ws_des_cor, ws_key_con, ws_des_con,
		  c_mov.mov_keyemp, ws_nom_emp, wn_can_tid, wn_imp_ort, ws_etq_003, ws_etq_004,
		  ws_etq_001,       ws_etq_002, ws_etq_005, ws_etq_006, ws_dia_act, ws_hor_act,
		  ws_key_co2,       ws_des_co2, wn_can_ti2, wn_imp_or2, ws_des_lis);
	    COMMIT;
	ws_key_co2 := NULL;
	ws_des_co2 := NULL;
	wn_can_ti2 := NULL;
	wn_imp_or2 := NULL;
    END LOOP;
    -- Actualiza la tabla de monitoreo la finalizacion del proceso.
    UPDATE LABCONF.glcoresu
      SET res_numreg = wn_num_reg,
	  res_fecfin = sp_glgetfec,
	  res_horfin = ws_hor_act,
	  res_status = 'T'
	WHERE res_idepro = ws_nom_rep  AND
	      res_idepcc = ws_ide_pcc  AND
	      res_keyusu = wn_key_usu  AND
	      res_fecini = sp_glgetfec AND
	      res_horreg = ws_hor_reg;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        LABCONF.sp_glGenErr (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_hor_reg, SQLCODE, 0,
		     SUBSTR (SQLERRM, 1, 60));
END;
/
