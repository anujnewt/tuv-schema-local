CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_USUARIOS" (wn_key_usu IN NUMBER, ws_nom_usu IN VARCHAR2,
					 ws_key_est IN VARCHAR2,   ws_key_dep IN VARCHAR2,
					 ws_cve_usu IN VARCHAR2,   ws_key_men IN VARCHAR2,
					 ws_mas_opc IN VARCHAR2,   ws_sta_tus IN VARCHAR2,
					 wn_fec_dur IN NUMBER, ws_tip_usu IN VARCHAR2,
					 ws_per_men IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_fec_mov DATE    := sp_glgetfec;
    ws_hor_mov VARCHAR2(5) := SUBSTR (sp_glgethor, 1, 5);
BEGIN
    INSERT INTO glcousua
	     (usu_keyusu, usu_nomusu, usu_keyest, usu_keydep, usu_fecalt,
	      usu_horalt, usu_cveusu, usu_keymen, usu_masopc, usu_status,
	      usu_acceso, usu_passwd, usu_fecdur, usu_tipusu, usu_permen)
      VALUES (wn_key_usu, ws_nom_usu, ws_key_est, ws_key_dep, ws_fec_mov,
	      ws_hor_mov, ws_cve_usu, ws_key_men, ws_mas_opc, ws_sta_tus,
	      ws_fec_mov, ws_fec_mov, wn_fec_dur, ws_tip_usu, ws_per_men);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        sp_glGenErr ('USUARIOS', 'ID DE PC', 0, sp_glgethor, SQLCODE, 0, SUBSTR (SQLERRM, 1, 60));
END;
/
