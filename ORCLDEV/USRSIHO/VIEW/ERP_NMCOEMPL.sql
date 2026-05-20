CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."ERP_NMCOEMPL" ("EMP_KEYEMP", "EMP_NOMEMP", "EMP_REGRFC", "EMP_RECURP", "EMP_DOMEMP", "EMP_MUNEMP", "EMP_CIDEMP", "EMP_CODEMP", "EMP_COLEMP", "EMP_POBEMP", "EMP_KEYPRO", "EMP_STATUS", "EMP_REFCON", "EMP_FECING", "EMP_PERING", "EMP_FECMOD") AS 
  SELECT emp_keyemp,emp_nomemp,emp_regrfc,emp_recurp,emp_domemp,emp_munemp,emp_cidemp,emp_codemp,emp_colemp,emp_pobemp,emp_keypro,emp_status,emp_refcon,emp_fecing,emp_pering,emp_fecmod
 FROM usrsiho.nmcoempl;
