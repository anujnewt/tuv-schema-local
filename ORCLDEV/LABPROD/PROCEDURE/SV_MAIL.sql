CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_MAIL" (
    num IN INTEGER,
    mail_emp OUT SYS_REFCURSOR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN mail_emp FOR
  SELECT DISTINCT email FROM MAIL WHERE emp_keyemp = num;
END;
/
