CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."DRM_NMCOEMPL" ("EMP_KEYEMP", "EMP_NOMEMP", "EMP_NOMCOR", "EMP_REGRFC", "EMP_FECING") AS 
  SELECT emp_keyemp,emp_nomemp,emp_nomcor,emp_regrfc,emp_fecing FROM nmcoempl;
