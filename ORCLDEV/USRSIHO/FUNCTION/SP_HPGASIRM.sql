CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HPGASIRM" (vn_sts_con NUMBER)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
IF vn_sts_con = 1 THEN
   RETURN 'FIRMADO';
ELSIF vn_sts_con = 2 THEN
   RETURN 'NO FIRMADO';
ELSE
   RETURN 'SIN CONTRATO';
END IF;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HPGASIRM" (vn_sts_con NUMBER)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
IF vn_sts_con = 1 THEN
   RETURN 'FIRMADO';
ELSIF vn_sts_con = 2 THEN
   RETURN 'NO FIRMADO';
ELSE
   RETURN 'SIN CONTRATO';
END IF;
END;
/
