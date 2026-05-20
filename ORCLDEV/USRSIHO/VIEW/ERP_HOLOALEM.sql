CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."ERP_HOLOALEM" ("ALE_KEYEMP", "ALE_KEYTCO", "ALE_NUMEXT", "ALE_NUMINT", "ALE_PAISRS", "ALE_ORIGEN") AS 
  SELECT ale_keyemp,ale_keytco,ale_numext,ale_numint,ale_paisrs,ale_origen  FROM usrsiho.holoalem;
