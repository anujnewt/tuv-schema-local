CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "LABCONF"."PCB_NMCOEMPL" ("EMP_KEYEMP", "EMP_NOMEMP", "EMP_KEYPRO", "EMP_KEYPUE", "EMP_KEYDEP", "EMP_STATUS", "EMP_FECBAJ") AS 
  SELECT emp_keyemp,emp_nomemp,emp_keypro,emp_keypue,emp_keydep,emp_status,emp_fecbaj FROM labconf.nmcoempl WHERE emp_keypro IN(139,550) AND emp_status=1;
