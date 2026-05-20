CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIASA"."GLCOPAMS_SIHO" ("PAM_KEYPAR", "PAM_CVESEC", "PAM_NOMPAR", "PAM_FOLINI", "PAM_FOLFIN") AS 
  SELECT pam_keypar,pam_cvesec,pam_nompar,pam_folini,pam_folfin FROM glcopams WHERE pam_keypar  IN ('H1' ,'H3' ,'H5' ,'H6' ,'PT' ,'PM');
