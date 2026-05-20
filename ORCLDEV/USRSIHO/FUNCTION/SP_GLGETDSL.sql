CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_GLGETDSL" (ws_key_tab IN VARCHAR2, ws_key_cam IN VARCHAR2,
					ws_des_def IN VARCHAR2, wn_lon_max IN NUMBER)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_val_etq USRSIHO.glcocamp.cam_descam%TYPE := SUBSTR (ws_des_def, 1, 40);
BEGIN
    SELECT cam_descam
      INTO ws_val_etq
	FROM USRSIHO.glcocamp
	  WHERE cam_keytab = ws_key_tab AND
		cam_keycam = ws_key_cam;
    IF wn_lon_max IS NOT NULL THEN
	RETURN SUBSTR (ws_val_etq, 1, wn_lon_max);
    ELSE
	RETURN ws_val_etq;
    END IF;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_GLGETDSL" (ws_key_tab IN VARCHAR2, ws_key_cam IN VARCHAR2,
					ws_des_def IN VARCHAR2, wn_lon_max IN NUMBER)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_val_etq USRSIHO.glcocamp.cam_descam%TYPE := SUBSTR (ws_des_def, 1, 40);
BEGIN
    SELECT cam_descam
      INTO ws_val_etq
	FROM USRSIHO.glcocamp
	  WHERE cam_keytab = ws_key_tab AND
		cam_keycam = ws_key_cam;
    IF wn_lon_max IS NOT NULL THEN
	RETURN SUBSTR (ws_val_etq, 1, wn_lon_max);
    ELSE
	RETURN ws_val_etq;
    END IF;
END;
/
