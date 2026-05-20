CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSAI"."CATACTORES" ("CDA_KEYEMP", "CDA_NOMEMP", "CDA_NOMART", "CDA_KEYPRO", "CDA_ORIGEN", "CDA_SINDICATO", "CDA_CALSIN", "CDA_DOCFIS", "CDA_REGRFC") AS 
  select x0.emp_keyemp ,x0.emp_nomemp ,x0.emp_nomcor ,x0.emp_keypro
        ,x1.ale_origen ,x2.pam_nompar ,x1.ale_calsin ,x0.emp_ca2aux
        ,x0.emp_regrfc from usrsiho.nmcoempl x0 ,
        usrsiho.holoalem x1 ,usrsiho.glcopams x2 where
        (((((x0.emp_keyemp = x1.ALE_KEYEMP )
        AND (x1.ale_keytco =cast(x2.pam_cvesec as integer)) ) AND
       (x2.pam_keypar = 'H3' ) ) AND (x0.emp_keypro = 138 ) ) AND
       (x0.emp_status = 1 ) );
