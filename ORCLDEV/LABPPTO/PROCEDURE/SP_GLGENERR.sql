CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPPTO"."SP_GLGENERR" (ws_nom_rep IN VARCHAR2,   ws_ide_pcc IN VARCHAR2,
					 wn_key_usu IN NUMBER, ws_hor_reg IN VARCHAR2,
					 wn_sql_err IN NUMBER, wn_isa_err IN NUMBER,
					 ws_des_err IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_hor_act VARCHAR2(8) := sp_glgethor;
    wn_num_fil NUMBER;
BEGIN
    SELECT NVL (COUNT (*), 0)
      INTO wn_num_fil
	FROM glcoresu
	  WHERE res_idepro 			   = ws_nom_rep  AND
		res_idepcc			   = ws_ide_pcc  AND
		res_keyusu 			   = wn_key_usu  AND
		TO_DATE (res_fecini, 'mm/dd/yyyy') = sp_glgetfec AND
		res_horreg                         = ws_hor_reg;
    IF wn_num_fil = 0 THEN
	INSERT INTO glcoresu
		 (res_idepro, res_idepcc, res_keyusu, res_fecini,
		  res_horini, res_horreg, res_status, res_deserr)
	  VALUES (ws_nom_rep, ws_ide_pcc, wn_key_usu, sp_glgetfec,
		  ws_hor_act, ws_hor_reg, 'E',        ws_des_err);
    ELSE
	UPDATE glcoresu
	  SET res_sqlerr = wn_sql_err,
	      res_isaerr = wn_isa_err,
	      res_deserr = ws_des_err,
	      res_status = 'E'
	    WHERE res_idepro			     = ws_nom_rep  AND
		  res_idepcc			     = ws_ide_pcc  AND
		  res_keyusu 			     = wn_key_usu  AND
		  TO_DATE (res_fecini, 'mm/dd/yyyy') = sp_glgetfec AND
		  res_horreg                         = ws_hor_reg;
    END IF;
    COMMIT;
END;
/
