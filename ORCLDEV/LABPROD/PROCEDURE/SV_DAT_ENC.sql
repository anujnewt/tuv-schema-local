CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_DAT_ENC" (
    num IN NUMBER,
    num_emp OUT NUMBER,
    nom_emp OUT CHAR,
    nom_jef OUT CHAR,
    pue_jef OUT CHAR)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
num_jef NUMBER;
BEGIN
  SELECT plz_keyemp,
    plz_cverem,
    emp_nomemp
  INTO num_emp,
    num_jef,
    nom_emp
  FROM EOCOPLZA,
    NMCOEMPL
  WHERE EOCOPLZA.plz_keyemp = NMCOEMPL.emp_keyemp
  AND EOCOPLZA.plz_keyemp   = num;
  SELECT emp_nomemp,
    pue_despue
  INTO nom_jef,
    pue_jef
  FROM NMCOEMPL,
    NMCOPUES,
    EOCOPLZA
  WHERE NMCOEMPL.emp_keyemp = num_jef
  AND NMCOEMPL.emp_keyemp   = EOCOPLZA.plz_keyemp
  AND NMCOPUES.pue_keypue   = EOCOPLZA.plz_keypue;
END;
/
