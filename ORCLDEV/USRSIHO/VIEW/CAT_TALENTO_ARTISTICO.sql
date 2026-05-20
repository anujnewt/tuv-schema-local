CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."CAT_TALENTO_ARTISTICO" ("EMP_NOMEMP", "EMP_NOMCOR") AS 
  SELECT emp_nomemp,emp_nomcor FROM usrsiho.nmcoempl WHERE emp_keypro =138 AND emp_status = 1 AND emp_ca2aux NOT IN('009','010','012');
