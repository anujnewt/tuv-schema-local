CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_ORA_TRAY" AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
ln_ctvo INTEGER;
CURSOR namedCursor IS
  SELECT ora_noctvo FROM com_orac_sips_tray WHERE ora_status is null ORDER BY ora_noctvo;
BEGIN
OPEN namedCursor;
    LOOP
		FETCH namedCursor INTO ln_ctvo;
	EXIT WHEN namedCursor%NOTFOUND;
            sp_com_paso_tray(ln_ctvo);
            UPDATE com_orac_sips_tray SET ora_status ='SI' WHERE ora_noctvo = ln_ctvo;
    END LOOP;
CLOSE namedCursor;
END sp_ora_tray;
/
