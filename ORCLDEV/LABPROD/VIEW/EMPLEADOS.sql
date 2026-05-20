CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "LABPROD"."EMPLEADOS" ("EMP_KEYEMP", "EMP_NOMEMP", "EMP_KEYPRO", "EMAIL") AS 
  SELECT emp_keyemp,emp_nomemp,emp_keypro,email
FROM LABPROD.nmcoempl@rtelecom
LEFT JOIN LABPROD.wemail@rtelecom ON emp_keyemp = keyemp
UNION ALL
SELECT emp_keyemp,emp_nomemp,emp_keypro,email
FROM LABPROD.nmcoempl
LEFT JOIN LABPROD.wemail ON emp_keyemp = keyemp
;
