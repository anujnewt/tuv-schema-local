CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMLSTMNE" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,
					 wn_key_usu IN NUMBER  ,ws_key_men IN VARCHAR2,
					 ws_hor_reg IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
----------------------------------------------------------------------------
-- SIPROS, S.A. DE C.V.
--
-- Sistema  : RH-2000 C/S
-- Modulo   : Administracion de remuneraciones (nm)
--
-- Programa : sp_nmlstmne
--            Reporte de Mnemonicos por rangos.
--
-- Autor    : Joaquin Perez M.
-- Fecha    : 14 de Abril de 1997.
--
-- Conversion a Oracle : Luis F. C?ba S?hez.  30-jun-1998
----------------------------------------------------------------------------
-- MODIFICO 		FECHA		     COMENTARIO
----------------------------------------------------------------------------
-- Roman Diaz D. 	Marzo del 2001   Migracion Proy. VB6 Hrp
    -- Variables para la carga de la tabla de mnemonicos.
    ws_key_mne glwkcrys.cry_chr008%TYPE;
    ws_key_tab glwkcrys.cry_chr017%TYPE;
    ws_mne_cam glwkcrys.cry_chr009%TYPE;
    ws_mne_con glwkcrys.cry_chr010%TYPE;
    ws_tip_dat glwkcrys.cry_chr018%TYPE;
    ws_etq_001 glwkcrys.cry_chr003%TYPE := sp_glgetdsl ('nmlomnem', 'mne_keynem', '........', NULL);
    ws_etq_002 glwkcrys.cry_chr004%TYPE := sp_glgetdsl ('nmlomnem', 'mne_keytab', '........', NULL);
    ws_etq_003 glwkcrys.cry_chr005%TYPE := sp_glgetdsl ('nmlomnem', 'mne_keycam', '........', NULL);
    ws_etq_004 glwkcrys.cry_chr006%TYPE := sp_glgetdsl ('nmlomnem', 'mne_condic', '........', NULL);
    ws_etq_005 glwkcrys.cry_chr007%TYPE := sp_glgetdsl ('nmlomnem', 'mne_tipdat', '........', NULL);
    ws_des_cor glwkcrys.cry_chr001%TYPE;
    -- Variables para el reporte de avance.
    wn_tot_reg NUMBER(10);
    wn_num_reg NUMBER(10)  := 0;
    wn_pct_reg NUMBER(6,2);
    wn_pct_act NUMBER(5)   := 1;
    ws_hor_act glwkcrys.cry_chr019%TYPE;
    ws_fec_act glwkcrys.cry_dat001%TYPE;
    ws_des_lis glwkcrys.cry_chr002%TYPE := sp_glgetrep ('nmlstmne', 'No existe nombre del Reporte', NULL);
    wn_con_reg NUMBER(3) := 0;
    wn_lim_ite NUMBER(3) := 100;
BEGIN
		sp_glfechor(ws_fec_act,ws_hor_act);
		ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
	  SELECT cor_razsoc INTO ws_des_cor
	  FROM glcocorp;
    -- Realiza el conteo de registros a procesar.
    SELECT NVL (COUNT(*), 0)  INTO wn_tot_reg 	FROM nmlomnem
	  WHERE mne_keynem IN (
		SELECT ran_keydep
		 FROM glwkrang
		   WHERE ran_nomrep = ws_nom_rep AND
			 ran_idepcc = ws_ide_pcc AND
			 ran_keyusu = wn_key_usu AND
			 ran_keydep IS NOT NULL);
    INSERT INTO glcoresu
	     (res_idepro, res_idepcc, res_keyusu, res_fecini,
	      res_horini, res_horreg, res_totreg, res_status)
      VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_fec_act,
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
    FOR c_nmlstmne IN (SELECT mne_keynem, mne_keytab, mne_keycam, mne_condic, mne_tipdat
			 FROM nmlomnem
			   WHERE mne_keynem IN (SELECT ran_keydep
						  FROM glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keydep IS NOT NULL)
			   ORDER BY mne_keynem) LOOP
	ws_key_mne := c_nmlstmne.mne_keynem;
	ws_key_tab := c_nmlstmne.mne_keytab;
	ws_mne_cam := c_nmlstmne.mne_keycam;
	ws_mne_con := c_nmlstmne.mne_condic;
	ws_tip_dat := c_nmlstmne.mne_tipdat;
	wn_num_reg := wn_num_reg + 1;
	IF wn_num_reg >= (wn_pct_reg * wn_pct_act) THEN
	    UPDATE glcoresu
	      SET res_numreg = wn_num_reg
		WHERE res_idepro = ws_nom_rep  AND
		      res_idepcc = ws_ide_pcc  AND
		      res_keyusu = wn_key_usu  AND
		      res_fecini = ws_fec_act AND
		      res_horreg = ws_hor_reg;
	    wn_pct_act := wn_pct_act + 1;
 	    wn_con_reg := wn_con_reg + 1;
	END IF;
	-- Inserta en la tabla de trabajo del Crystal Report.
	INSERT INTO glwkcrys
		 (cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr008, cry_chr017,
		  cry_chr009, cry_chr010, cry_chr018, cry_chr019, cry_dat001, cry_chr003,
		  cry_chr004, cry_chr005, cry_chr006, cry_chr007, cry_chr002)
	  VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_key_mne, ws_key_tab,
		  ws_mne_cam, ws_mne_con, ws_tip_dat, ws_hor_act, ws_fec_act, ws_etq_001,
		  ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005, ws_des_lis);
	wn_con_reg := wn_con_reg + 1;
        IF wn_con_reg = wn_lim_ite THEN
 	   COMMIT;
	   wn_con_reg := 0;
	END IF;
    END LOOP;
		sp_glfechor(ws_fec_act,ws_hor_act);
    -- Actualiza la tabla de monitoreo indicando la finalizacion del proceso.
    UPDATE glcoresu
      SET res_numreg = wn_num_reg,
	  res_fecfin = ws_fec_act,
	  res_horfin = ws_hor_act,
	  res_status = 'T'
	WHERE res_idepro = ws_nom_rep  AND
	      res_idepcc = ws_ide_pcc  AND
	      res_keyusu = wn_key_usu  AND
	      res_fecini = ws_fec_act AND
	      res_horreg = ws_hor_reg;
    COMMIT;
END;
/
