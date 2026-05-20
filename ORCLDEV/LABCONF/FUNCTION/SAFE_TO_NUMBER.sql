CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."SAFE_TO_NUMBER" (p varchar2) RETURN NUMBER is
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    v number;
  BEGIN
    v := to_number(p);
    return v;
  exception when others then return 0;
  END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."SAFE_TO_NUMBER" (p varchar2) RETURN NUMBER is
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    v number;
  BEGIN
    v := to_number(p);
    return v;
  exception when others then return 0;
  END;
/
