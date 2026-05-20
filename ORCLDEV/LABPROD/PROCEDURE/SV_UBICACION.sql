CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_UBICACION" (num in integer, ubi out nvarchar2)
as
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
begin
SELECT emp_keyloc into ubi FROM NMCOEMPL WHERE emp_keyemp = num;
end;
/
