CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."SIASA_HOLOENCTRA" ("ENC_NUM_ID", "ENC_KEYDEP", "ENC_FECGRA", "ENC_KEYTPR", "ENC_FECCAP", "ENC_KEYPRO", "ENC_STSREP", "ENC_DESSCC", "ENC_NUMLLA") AS 
  SELECT enc_num_id,enc_keydep,enc_fecgra,enc_keytpr,enc_feccap,enc_keypro,enc_stsrep,enc_desscc,enc_numlla FROM holoenctra;
