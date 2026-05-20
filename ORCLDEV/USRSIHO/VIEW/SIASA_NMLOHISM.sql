CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."SIASA_NMLOHISM" ("HIS_KEYEMP", "HIS_KEYCON", "HIS_KEYPRO", "HIS_KEYDEP", "HIS_KEYPUE", "HIS_IMPORT", "HIS_FECMOV", "HIS_KEYPER", "HIS_KEYNOM", "HIS_CA1AUX", "HIS_CA2AUX") AS 
  SELECT his_keyemp,his_keycon,his_keypro,his_keydep,his_keypue,his_import,his_fecmov,his_keyper,his_keynom,his_ca1aux,his_ca2aux FROM nmlohism;
