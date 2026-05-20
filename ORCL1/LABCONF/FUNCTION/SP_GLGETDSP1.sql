CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABCONF"."SP_GLGETDSP1" (ws_key_tab IN VARCHAR2, ws_key_cam IN VARCHAR2,
					ws_key_men IN VARCHAR2)
RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_dsp_cam VARCHAR2(1) := 'S';
    wn_val_dsp NUMBER(5);
BEGIN
    SELECT rec_despli
      INTO ws_dsp_cam
	FROM glcoreca
	  WHERE rec_keytab = ws_key_tab AND
		rec_keycam = ws_key_cam AND
		rec_keymen = ws_key_men;
    IF ws_dsp_cam = 'N' THEN
	wn_val_dsp := 1;
    ELSE
	wn_val_dsp := 0;
    END IF;
    RETURN wn_val_dsp;
EXCEPTION
    WHEN OTHERS THEN
	return 0;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABCONF"."SP_GLGETDSP1" (ws_key_tab IN VARCHAR2, ws_key_cam IN VARCHAR2,
					ws_key_men IN VARCHAR2)
RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_dsp_cam VARCHAR2(1) := 'S';
    wn_val_dsp NUMBER(5);
BEGIN
    SELECT rec_despli
      INTO ws_dsp_cam
	FROM glcoreca
	  WHERE rec_keytab = ws_key_tab AND
		rec_keycam = ws_key_cam AND
		rec_keymen = ws_key_men;
    IF ws_dsp_cam = 'N' THEN
	wn_val_dsp := 1;
    ELSE
	wn_val_dsp := 0;
    END IF;
    RETURN wn_val_dsp;
EXCEPTION
    WHEN OTHERS THEN
	return 0;
END;
/
