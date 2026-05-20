CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_ORA_EMPL" AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
ln_ctvo INTEGER;
CURSOR namedCursor IS
  SELECT ora_noctvo FROM com_orac_sips_empl WHERE emp_est is null ORDER BY ora_noctvo;
BEGIN
OPEN namedCursor;
    LOOP
		FETCH namedCursor INTO ln_ctvo;
	EXIT WHEN namedCursor%NOTFOUND;
            sp_com_paso_empl(ln_ctvo);
            UPDATE com_orac_sips_empl SET emp_est ='SI' WHERE ora_noctvo = ln_ctvo;
    END LOOP;
CLOSE namedCursor;
END sp_ora_empl;
/
