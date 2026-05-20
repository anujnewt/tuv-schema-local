CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."DRM_HOLOCONT" ("CON_KEYFOL", "CON_KEYEMP", "CON_FECINI", "CON_NUMCAP", "CON_DIAPAG", "CON_TIPPAG") AS 
  SELECT con_keyfol,con_keyemp,con_fecini,con_numcap,con_diapag,con_tippag FROM holocont;
