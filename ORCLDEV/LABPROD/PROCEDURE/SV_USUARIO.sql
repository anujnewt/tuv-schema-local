CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_USUARIO" (
    usuarios_object OUT SYS_REFCURSOR)
  --  nombre OUT CHAR,
  --status OUT CHAR,
  --numero OUT NUMBER)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN usuarios_object FOR
  SELECT usuario, plz_fe1aux
  FROM MAIL, EOCOPLZA
  WHERE MAIL.emp_keyemp = EOCOPLZA.plz_keyemp
  AND usuario IS NOT NULL
  AND emp_keyemp IS NOT NULL
  AND plz_fe1aux IS NOT NULL
  AND plz_fe1aux <> '';
 -- RETURN usuarios_object;
END;
/
