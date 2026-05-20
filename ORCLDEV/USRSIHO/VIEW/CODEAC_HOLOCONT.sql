CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."CODEAC_HOLOCONT" ("CON_STSPAG", "CON_FECCAN", "CON_KEYEMP", "CON_KEYFOL", "CON_FECVEN", "CON_KEYPLZ", "CON_FECOTO", "CON_KEYTCO", "CON_KEYPUE", "CON_FECINI") AS 
  SELECT con_stspag,con_feccan,con_keyemp,con_keyfol,con_fecven,con_keyplz,con_fecoto,con_keytco,con_keypue,con_fecini FROM holocont;
