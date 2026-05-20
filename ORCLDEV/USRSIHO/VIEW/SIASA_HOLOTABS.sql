CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."SIASA_HOLOTABS" ("TAB_KEYPRO", "TAB_KEYTAB", "TAB_KEYPUE", "TAB_PERTRA", "TAB_IDIOMA", "TAB_KEYNAC", "TAB_IMPORT", "TAB_FECINI", "TAB_FECFIN") AS 
  SELECT tab_keypro,tab_keytab,tab_keypue,tab_pertra,tab_idioma,tab_keynac,tab_import,tab_fecini,tab_fecfin FROM holotabs;
