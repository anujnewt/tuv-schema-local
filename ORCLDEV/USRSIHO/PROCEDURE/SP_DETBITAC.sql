CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_DETBITAC" (wn_key_usu IN NUMBER, ws_ide_pcc IN VARCHAR2,
					 ws_key_tab IN VARCHAR2,   ws_key_cam IN VARCHAR2,
					 ws_val_ant IN VARCHAR2,   ws_val_act IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_fec_mov DATE     := "USRSIHO".sp_glgetfec;
    ws_hor_mov VARCHAR2(16) := "USRSIHO".sp_glgethor;
    ws_ide_bit VARCHAR2(10) := '_BITACORA_';
BEGIN
    FOR c_glwkcrys IN (
            -- BEGIN
                  SELECT cry_dat001, cry_chr012
                  FROM "USRSIHO".glwkcrys
                  WHERE cry_nomrep = ws_ide_bit AND
                        cry_idepcc = ws_ide_pcc AND
                        cry_keyusu = wn_key_usu
              --    EXCEPTION WHEN no_data_found THEN cry_dat001 := '', cry_chr012 := '';
            -- END;
            ) LOOP
          ws_fec_mov := c_glwkcrys.cry_dat001;
          ws_hor_mov := c_glwkcrys.cry_chr012;
    END LOOP;
    INSERT INTO "USRSIHO".glcodetb
	     (det_keyusu, det_fecmov, det_hormov, det_keytab,
	      det_keycam, det_valant, det_valact)
      VALUES (wn_key_usu, ws_fec_mov, SUBSTR (ws_hor_mov, 1, 8), ws_key_tab,
	      ws_key_cam, ws_val_ant, ws_val_act);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        "USRSIHO".sp_glGenErr ('DETBITAC', ws_ide_pcc, wn_key_usu, sp_glgethor,
		     SQLCODE, 0, SUBSTR (SQLERRM, 1, 60));
END;
/
