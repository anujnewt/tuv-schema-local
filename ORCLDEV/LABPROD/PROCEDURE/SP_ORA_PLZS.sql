CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_ORA_PLZS" AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
ln_ctvo INTEGER;
CURSOR namedCursor IS
  SELECT ora_noctvo FROM com_orac_sips_plzs WHERE ora_status is null ORDER BY ora_noctvo;
BEGIN
OPEN namedCursor;
    LOOP
		FETCH namedCursor INTO ln_ctvo;
	EXIT WHEN namedCursor%NOTFOUND;
            sp_orac_sips_plzs(ln_ctvo);
            UPDATE com_orac_sips_plzs SET ora_status ='SI' WHERE ora_noctvo = ln_ctvo;
    END LOOP;
CLOSE namedCursor;
END sp_ora_plzs;
/
