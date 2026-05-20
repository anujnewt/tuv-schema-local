CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."SIASA_HOLODETTRA" ("DET_NUM_ID", "DET_KEYDEP", "DET_FECGRA", "DET_KEYTCO", "DET_SINDKTO", "DET_KEYFOL", "DET_KEYEMP", "DET_NOMCOR", "DET_PERSON", "DET_KEYPUE", "DET_NOFORO", "DET_HRALLA", "DET_HRAENT", "DET_HRASAL", "DET_CAPGRA", "DET_STSREG", "DET_INANDA", "DET_CAPINI", "DET_CAPFIN", "DET_TIPINC", "DET_COSUNI") AS 
  SELECT
det_num_id,det_keydep,det_fecgra,det_keytco,det_sindkto,det_keyfol,det_keyemp,det_nomcor,det_person,det_keypue,det_noforo,
det_hralla,det_hraent,det_hrasal,det_capgra,det_stsreg,det_inanda,det_capini,det_capfin,det_tipinc,det_cosuni FROM holodettra;
