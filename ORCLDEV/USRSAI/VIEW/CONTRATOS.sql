CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSAI"."CONTRATOS" ("CCO_KEYEMP", "CCO_NOMEMP", "CCO_NOMART", "CCO_KEYDEP", "CCO_KEYFOL", "CCO_FECINI", "CCO_STSPAG", "CCO_NUMCAP", "CCO_NUMCDI", "CCO_DESCAP", "CCO_KEYTIC", "CCO_KEYPLZ", "CCO_KEYTCO", "CCO_KEYPUE", "CCO_FECOTO") AS 
  select x0.con_keyemp ,x1.emp_nomemp ,x1.emp_nomcor ,x0.con_keydep
    ,x0.con_keyfol ,x0.con_fecini ,x0.con_stspag ,x0.con_numcap
    ,x0.con_numcdi ,x0.con_descap ,x0.con_keytic ,x0.con_keyplz
    ,x0.con_keytco ,x0.con_keypue ,x0.con_fecoto from usrsiho.holocont x0 ,
    usrsiho.nmcoempl x1 where
    ((x0.con_keyemp = x1.emp_keyemp ) AND (x1.emp_keypro = 138
    ) ) ;
