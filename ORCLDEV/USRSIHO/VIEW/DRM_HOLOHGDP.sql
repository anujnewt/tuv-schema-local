CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."DRM_HOLOHGDP" ("HGD_KEYRPH", "HGD_KEYEMP", "HGD_KEYPUE", "HGD_NUMCAP", "HGD_CAPINI", "HGD_CAPFIN", "HGD_KEYFOL", "HGD_KEYTCO", "HGD_COSTOG") AS 
  SELECT hgd_keyrph,hgd_keyemp,hgd_keypue,hgd_numcap,hgd_capini,hgd_capfin,hgd_keyfol,hgd_keytco,hgd_costog FROM holohgdp;
