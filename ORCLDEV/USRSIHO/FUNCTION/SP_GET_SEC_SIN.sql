CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_GET_SEC_SIN" ( pistKey VARCHAR2)
	RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 linCont  NUMBER(10);
 linOut	VARCHAR2(50);
BEGIN
	linCont := 0;
	SELECT COUNT(*) INTO linCont
	FROM glcopams
	WHERE 	pam_keypar = 'SSPS'
	AND		pam_nompar = pistKey;
	IF linCont = 0 THEN
		linOut := 'NS';
	ELSE
		SELECT	trim(pistKey)||' - '||trim(pam_folfin)||' - '||trim(con_descon) INTO linOut
		FROM 	nmloconc,glcopams
		WHERE 	con_keycon = pam_nompar
		AND 	con_keycon = pistKey;
	END IF;
	RETURN linOut;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_GET_SEC_SIN" ( pistKey VARCHAR2)
	RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 linCont  NUMBER(10);
 linOut	VARCHAR2(50);
BEGIN
	linCont := 0;
	SELECT COUNT(*) INTO linCont
	FROM glcopams
	WHERE 	pam_keypar = 'SSPS'
	AND		pam_nompar = pistKey;
	IF linCont = 0 THEN
		linOut := 'NS';
	ELSE
		SELECT	trim(pistKey)||' - '||trim(pam_folfin)||' - '||trim(con_descon) INTO linOut
		FROM 	nmloconc,glcopams
		WHERE 	con_keycon = pam_nompar
		AND 	con_keycon = pistKey;
	END IF;
	RETURN linOut;
END;
/
