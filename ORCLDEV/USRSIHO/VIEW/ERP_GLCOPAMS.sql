CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."ERP_GLCOPAMS" ("PAM_KEYPAR", "PAM_CVESEC", "PAM_NOMPAR", "PAM_FOLINI", "PAM_FOLFIN") AS 
  SELECT pam_keypar,pam_cvesec,pam_nompar,pam_folini,pam_folfin FROM usrsiho.glcopams WHERE pam_keypar IN('CIAO','H45');
