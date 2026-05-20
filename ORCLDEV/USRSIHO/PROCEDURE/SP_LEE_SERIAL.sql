CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_LEE_SERIAL" (li_serial OUT NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
   SELECT MAX(rep_keyrep)
   INTO   li_serial
   FROM   usrsiho.holorepo;
   EXCEPTION WHEN no_data_found THEN li_serial := 0;
END;
/
