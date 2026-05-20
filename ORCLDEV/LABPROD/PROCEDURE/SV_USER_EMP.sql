CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_USER_EMP" (
    num IN INTEGER,
    user_emp OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN user_emp FOR
  SELECT DISTINCT usuario FROM MAIL WHERE emp_keyemp = num;
END;
/
