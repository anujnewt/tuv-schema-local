CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_MAIL_RYC" (
    num IN INTEGER,
    ubicacion IN VARCHAR2,
    mail_ryc OUT SYS_REFCURSOR)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  BEGIN
  OPEN mail_ryc FOR
  SELECT t3.email ,t1.emp_keyloc
  FROM autryc t1, nmcoempl t2, mail t3
  WHERE t1.emp_keyloc = ubicacion
  AND t1.emp_keyemp =t3.emp_keyemp
  AND t2.emp_keyemp = num;
END;
/
