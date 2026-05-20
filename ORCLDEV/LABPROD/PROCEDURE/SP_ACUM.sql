CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_ACUM" (empleado IN INTEGER, acumulado OUT NUMBER )
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
      wd_impsal         NUMBER(14,2);
      ws_num_mes    INTEGER;
BEGIN
-----------------------------------------------
IF month(sysdate) > 1 THEN
      ws_num_mes := month(sysdate) - 1;
ELSE
      ws_num_mes := 12;
END IF;
IF ws_num_mes = 1 THEN
select nvl(sum(acu_impuno), 0) into wd_impsal from (
SELECT acu_impuno FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_impuno > 0
AND acu_anioac = year(sysdate)
);
END IF;
   IF ws_num_mes = 2 THEN
select nvl(sum(acu_impdos), 0) into wd_impsal from (
SELECT acu_impdos FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_impdos > 0
AND acu_anioac = year(sysdate)
);
   END IF;
   IF ws_num_mes = 3 THEN
select nvl(sum(acu_imptre), 0) into wd_impsal from (
SELECT acu_imptre FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_imptre > 0
AND acu_anioac = year(sysdate)
);
   END IF;
   IF ws_num_mes = 4 THEN
select nvl(sum(acu_impcua), 0) into wd_impsal from (
SELECT acu_impcua FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_impcua > 0
AND acu_anioac = year(sysdate)
);
   END IF;
   IF ws_num_mes = 5 THEN
select nvl(sum(acu_impcin), 0) into wd_impsal from (
SELECT acu_impcin FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_impcin > 0
AND acu_anioac = year(sysdate)
);
   END IF;
   IF ws_num_mes = 6 THEN
select nvl(sum(acu_impsei), 0) into wd_impsal from (
SELECT acu_impsei FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_impsei > 0
AND acu_anioac = year(sysdate)
);
    END IF;
   IF ws_num_mes = 7 THEN
select nvl(sum(acu_impsie), 0) into wd_impsal from (
SELECT acu_impsie FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_impsie > 0
AND acu_anioac = year(sysdate)
);
  END IF;
   IF ws_num_mes = 8 THEN
select nvl(sum(acu_impoch), 0) into wd_impsal from (
SELECT acu_impoch FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_impoch > 0
AND acu_anioac = year(sysdate)
);
   END IF;
   IF ws_num_mes = 9 THEN
select nvl(sum(acu_impnue), 0) into wd_impsal from (
SELECT acu_impnue FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_impnue > 0
AND acu_anioac = year(sysdate)
);
   END IF;
   IF ws_num_mes = 10 THEN
select nvl(sum(acu_impdie), 0) into wd_impsal from (
SELECT acu_impdie FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_impdie > 0
AND acu_anioac = year(sysdate)
);
   END IF;
   IF ws_num_mes = 11 THEN
select nvl(sum(acu_imponc), 0) into wd_impsal from (
SELECT acu_imponc FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_imponc > 0
AND acu_anioac = year(sysdate)
);
   END IF;
   IF ws_num_mes = 12 THEN
select nvl(sum(acu_impdoc), 0) into wd_impsal from (
SELECT acu_impdoc FROM nmloacum,nmloconc
WHERE acu_keyemp = empleado
AND acu_keycon IN (SELECT pam_cvesec
    FROM glcopams
    WHERE pam_keypar = 'DFI')
AND acu_keycon = con_keycon
AND acu_impdoc > 0
AND acu_anioac = year(sysdate)-1
);
   END IF;
   acumulado := wd_impsal;
END;
/
