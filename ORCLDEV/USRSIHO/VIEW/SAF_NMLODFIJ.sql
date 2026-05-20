CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."SAF_NMLODFIJ" ("DFI_KEYEMP", "DFI_KEYCON", "DFI_KEYPRO", "DFI_PERINI", "DFI_PERFIN", "DFI_KEYDEP", "DFI_KEYPUE", "DFI_FECMOV", "DFI_CANTID", "DFI_IMPORT", "DFI_CA1AUX", "DFI_CA2AUX") AS 
  SELECT  dfi_keyemp,dfi_keycon,dfi_keypro,dfi_perini,dfi_perfin,dfi_keydep,dfi_keypue,dfi_fecmov,dfi_cantid,dfi_import,dfi_ca1aux,dfi_ca2aux FROM nmlodfij;
