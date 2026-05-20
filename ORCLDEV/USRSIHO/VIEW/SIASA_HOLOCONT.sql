CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."SIASA_HOLOCONT" ("CON_KEYFOL", "CON_KEYTCO", "CON_KEYDEP", "CON_KEYPUE", "CON_KEYEMP", "CON_PERTRA", "CON_IDIOMA", "CON_KEYNAC", "CON_COSUNI") AS 
  SELECT con_keyfol,con_keytco,con_keydep,con_keypue,con_keyemp,con_pertra,con_idioma,con_keynac,con_cosuni FROM holocont;
