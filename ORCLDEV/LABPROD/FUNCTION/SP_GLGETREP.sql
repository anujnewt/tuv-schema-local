CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."SP_GLGETREP" (ws_nom_rep IN VARCHAR2, ws_des_def IN VARCHAR2,
					wn_lon_max IN NUMBER)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_des_lis glcolist.lis_deslis%TYPE := SUBSTR (ws_des_def, 1, 50);
BEGIN
    FOR c_deslis IN ( SELECT lis_deslis FROM glcolist
				 	  WHERE lis_keylis = ws_nom_rep) LOOP
	   ws_des_lis := c_deslis.lis_deslis;
	END LOOP;
    IF wn_lon_max IS NOT NULL THEN
	RETURN SUBSTR (ws_des_lis, 1, wn_lon_max);
    ELSE
	RETURN ws_des_lis;
    END IF;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."SP_GLGETREP" (ws_nom_rep IN VARCHAR2, ws_des_def IN VARCHAR2,
					wn_lon_max IN NUMBER)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_des_lis glcolist.lis_deslis%TYPE := SUBSTR (ws_des_def, 1, 50);
BEGIN
    FOR c_deslis IN ( SELECT lis_deslis FROM glcolist
				 	  WHERE lis_keylis = ws_nom_rep) LOOP
	   ws_des_lis := c_deslis.lis_deslis;
	END LOOP;
    IF wn_lon_max IS NOT NULL THEN
	RETURN SUBSTR (ws_des_lis, 1, wn_lon_max);
    ELSE
	RETURN ws_des_lis;
    END IF;
END;
/
