CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_NMMNEPYN" (ws_nom_rep IN VARCHAR2,   ws_ide_pcc IN VARCHAR2,
					 wn_key_usu IN NUMBER,     ws_key_men IN VARCHAR2,
					 ws_hor_reg IN VARCHAR2,   wn_key_pro IN NUMBER,
					 ws_des_pro IN VARCHAR2,   wn_key_nom IN NUMBER,
					 ws_des_nom IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de formulas y mnemonico.
    ws_key_mne VARCHAR2(16);
    ws_key_for VARCHAR2(4);
    wn_num_ins NUMBER(5);
    ws_ope_uno VARCHAR2(16);
    ws_ope_dos VARCHAR2(16);
    ws_res_for VARCHAR2(16);
    ws_uso_mne VARCHAR2(15);
    ws_uso_op1 VARCHAR2(5);
    ws_uso_op2 VARCHAR2(5);
    ws_uso_res VARCHAR2(5);
    -- Variables para la carga de las descripciones de las Etiquetas.
    ws_etq_001 VARCHAR2(8)  := sp_glgetdsc ('nmloform', 'for_keyfor', '........',    NULL);
    ws_etq_002 VARCHAR2(40) := sp_glgetdsl ('nmloform', 'for_numins', '........',    NULL);
    ws_etq_003 VARCHAR2(40) := sp_glgetdsl ('nmloenfm', 'enf_de1for', 'DESCRIPCION', NULL);
    ws_etq_004 VARCHAR2(8)  := sp_glgetdsc ('nmlomnem', 'mne_keynem', 'MNEMONIC',    NULL);
    ws_etq_005 VARCHAR2(8)  := sp_glgetdsc ('nmlocxpr', 'cxp_keypro', 'PROCESO',     NULL);
    ws_etq_006 VARCHAR2(8)  := sp_glgetdsc ('nmlocxpr', 'cxp_keynom', 'NOMINA',      NULL);
    ws_des_cor VARCHAR2(60);
    -- Variables para las descrip. de proceso y tipo de nomina y descripcion 1 de la formula.                                                             --
    ws_des_for VARCHAR2(40);
    ws_for_cxp VARCHAR2(4);
    -- Variables para el reporte de avance.
    wn_tot_reg NUMBER(10);
    wn_num_reg NUMBER(10)  := 0;
    wn_pct_reg NUMBER(6,2);
    wn_pct_act NUMBER(5)   := 1;
    ws_hor_act VARCHAR2(8);
    ws_fec_act DATE;
    ws_hor_fin VARCHAR2(8);
    ws_des_lis VARCHAR2(50)    := sp_glgetrep (ws_nom_rep, 'No existe nombre del Reporte', NULL);
    wn_con_reg NUMBER(3) := 0;
    wn_lim_ite NUMBER(3) := 100;
BEGIN
    sp_glfechor(ws_fec_act,ws_hor_act);
		ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
	  SELECT cor_razsoc INTO ws_des_cor
  	FROM glcocorp;
    -- Realiza el conteo de registros a procesar.
    SELECT NVL (COUNT (*), 0)  INTO wn_tot_reg 	FROM nmlomnem
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
    -- Inicializa variables de trabajo para realizar Monitoreo.
    wn_pct_reg := wn_tot_reg / 10.0;
    -- Define cursor principal.
    FOR c_nmlstmne IN (SELECT mne_keynem
			 FROM nmlomnem
			   WHERE mne_keynem IN (SELECT ran_keydep
						  FROM glwkrang
						    WHERE ran_nomrep = ws_nom_rep AND
							  ran_idepcc = ws_ide_pcc AND
							  ran_keyusu = wn_key_usu AND
							  ran_keydep IS NOT NULL)
			   ORDER BY mne_keynem) LOOP
	ws_key_mne := c_nmlstmne.mne_keynem;
	FOR cc_nmlstmne IN (SELECT DISTINCT cxp_keyfor
			      FROM nmlocxpr
				WHERE cxp_keypro = wn_key_pro AND
				      cxp_keynom = wn_key_nom) LOOP
	    ws_for_cxp := cc_nmlstmne.cxp_keyfor;
	    FOR ccc_cxp IN (SELECT for_keyfor, for_opera1, for_opera2, for_result, for_numins
			      FROM nmloform
				WHERE for_keyfor = ws_for_cxp AND
				     (for_opera1 = ws_key_mne OR
				      for_opera2 = ws_key_mne OR
				      for_result = ws_key_mne)
				ORDER BY for_keyfor, for_numins) LOOP
		ws_key_for := ccc_cxp.for_keyfor;
		ws_ope_uno := ccc_cxp.for_opera1;
		ws_ope_dos := ccc_cxp.for_opera2;
		ws_res_for := ccc_cxp.for_result;
		wn_num_ins := ccc_cxp.for_numins;
		ws_des_for := 'FORMULA NO EXISTE';
		FOR c_desfor in (SELECT enf_de1for
				   FROM nmloenfm
				     WHERE enf_keyfor = ws_key_for) LOOP
		    ws_des_for := c_desfor.enf_de1for;
		END LOOP;
		ws_uso_op1 := ' ';
		ws_uso_op2 := ' ';
		ws_uso_res := ' ';
		IF ws_ope_uno = ws_key_mne THEN
		    ws_uso_op1 := 'OP1';
		END IF;
		IF ws_ope_dos = ws_key_mne THEN
		    ws_uso_op2 := 'OP2';
		END IF;
		IF ws_res_for = ws_key_mne THEN
		    ws_uso_res := 'RES';
		END IF;
		ws_uso_mne := ws_uso_op1 || ws_uso_op2 || ws_uso_res;
		wn_tot_reg := wn_tot_reg + 1;
		-- Inserta en la tabla de trabajo del Crystal Report.
		INSERT INTO glwkcrys
			 (cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr008,
			  cry_chr017, cry_chr003, cry_chr009, cry_dec006, cry_dec007,
			  cry_dec008, cry_chr019, cry_chr005, cry_chr006, cry_chr022,
			  cry_chr023, cry_chr024, cry_chr025, cry_dat001, cry_chr010,
			  cry_chr004, cry_chr002)
		  VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_key_mne,
			  ws_key_for, ws_des_for, ws_uso_mne, wn_num_ins, wn_key_pro,
			  wn_key_nom, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004,
			  ws_etq_005, ws_etq_006, ws_hor_act, ws_fec_act, ws_des_pro,
			  ws_des_nom, ws_des_lis);
                wn_con_reg := wn_con_reg + 1;
                IF wn_con_reg = wn_lim_ite THEN
 	          COMMIT;
	          wn_con_reg := 0;
 	        END IF;
	    END LOOP;
	END LOOP;
        -- Actualiza registro de monitoreo.
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
