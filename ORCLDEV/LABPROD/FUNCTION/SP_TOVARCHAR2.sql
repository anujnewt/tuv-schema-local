CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."SP_TOVARCHAR2" (importe IN nmlohism.his_import%TYPE)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   wd_valor VARCHAR2(9);
   wd_decimales VARCHAR2(2);
BEGIN
    wd_valor := floor(importe);
    wd_decimales := floor(importe * 100) mod 100;
   if length(wd_decimales) = 1 then
      RETURN wd_valor || '.' || '0' || wd_decimales;
   else
      RETURN wd_valor || '.' || wd_decimales;
   end if;
   --wd_valor := to_char(importe, '999999.99');
   --select to_char(importe, '999999.99') into wd_valor from dual;
EXCEPTION
    WHEN OTHERS THEN
	RETURN '0';
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."SP_TOVARCHAR2" (importe IN nmlohism.his_import%TYPE)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   wd_valor VARCHAR2(9);
   wd_decimales VARCHAR2(2);
BEGIN
    wd_valor := floor(importe);
    wd_decimales := floor(importe * 100) mod 100;
   if length(wd_decimales) = 1 then
      RETURN wd_valor || '.' || '0' || wd_decimales;
   else
      RETURN wd_valor || '.' || wd_decimales;
   end if;
   --wd_valor := to_char(importe, '999999.99');
   --select to_char(importe, '999999.99') into wd_valor from dual;
EXCEPTION
    WHEN OTHERS THEN
	RETURN '0';
END;
/
