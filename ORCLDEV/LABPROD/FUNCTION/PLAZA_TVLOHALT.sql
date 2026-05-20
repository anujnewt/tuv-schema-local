CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."PLAZA_TVLOHALT" (wn_key_emp in number,ws_key_dep in varchar2)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    wn_key_plz integer;
BEGIN
  SELECT plz_keyplz INTO wn_key_plz from (select plz_keyplz from eocoplza
                              where plz_keyemp = wn_key_emp
                                AND plz_keydep = ws_key_dep
                            order by plz_keyplz
            ) where ROWNUM = 1;
	RETURN wn_key_plz;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."PLAZA_TVLOHALT" (wn_key_emp in number,ws_key_dep in varchar2)
RETURN integer IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    wn_key_plz integer;
BEGIN
  SELECT plz_keyplz INTO wn_key_plz from (select plz_keyplz from eocoplza
                              where plz_keyemp = wn_key_emp
                                AND plz_keydep = ws_key_dep
                            order by plz_keyplz
            ) where ROWNUM = 1;
	RETURN wn_key_plz;
END;
/
