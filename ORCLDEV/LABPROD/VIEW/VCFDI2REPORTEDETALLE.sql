CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "LABPROD"."VCFDI2REPORTEDETALLE" ("IDCOMPROBANTEEMP", "IDNOMINA", "COM_KEYPRO", "COM_KEYPER", "NUMROW", "COM_KEYEMP", "COM_CODIMP", "TIPO", "DESCTIPO", "CLAVE", "CONCEPTO", "IMPORTEGRAVADO", "IMPORTEEXENTO") AS 
  SELECT Nom.idComprobanteEmp,Nom.idNomina,Nom.com_keypro,Nom.com_keyper,ROW_NUMBER() OVER(PARTITION BY Nom.idComprobanteEmp,Nom.idNomina ORDER BY clave) AS NumRow,
  Nom.com_keyemp,'01' com_codimp,TipoPercepcion Tipo,pam_nompar DescTipo,Clave,Concepto,ImporteGravado,ImporteExento
  FROM  cfdi2Nomina Nom
  INNER JOIN cfdi2PercepcionesDetalle Det ON Det.idNomina = Nom.idNomina
  INNER JOIN cfdi2ComprobanteEmp Emp ON Emp.idComprobanteEmp = Nom.idComprobanteEmp
  INNER JOIN glcopams ON pam_keypar = 'CPER' AND pam_cvesec = TipoPercepcion
  UNION ALL
  SELECT Nom.idComprobanteEmp,Nom.idNomina,Nom.com_keypro,Nom.com_keyper,ROW_NUMBER() OVER(PARTITION BY Nom.idComprobanteEmp,Nom.idNomina ORDER BY clave) AS NumRow,
  Nom.com_keyemp,'02' com_codimp,TipoDeduccion Tipo,pam_nompar DescTipo,Clave,Concepto,ImporteGravado,ImporteExento
  FROM  cfdi2Nomina Nom
  INNER JOIN cfdi2DeduccionesDetalle Det ON Det.idNomina = Nom.idNomina
  INNER JOIN cfdi2ComprobanteEmp Emp ON Emp.idComprobanteEmp = Nom.idComprobanteEmp
  INNER JOIN glcopams ON pam_keypar = 'CDED' AND pam_cvesec = TipoDeduccion
  UNION ALL
  SELECT Nom.idComprobanteEmp,Nom.idNomina,Nom.com_keypro,Nom.com_keyper,99 + ROW_NUMBER() OVER(PARTITION BY Nom.idComprobanteEmp,Nom.idNomina ORDER BY clave) AS NumRow,
  Nom.com_keyemp,'01' com_codimp,TipoOtroPago Tipo,pam_nompar DescTipo,Clave,Concepto,0 ImporteGravado,Importe ImporteExento
  FROM  cfdi2Nomina Nom
  INNER JOIN cfdi2OtrosPagos Det ON Det.idNomina = Nom.idNomina
  INNER JOIN cfdi2ComprobanteEmp Emp ON Emp.idComprobanteEmp = Nom.idComprobanteEmp
  INNER JOIN glcopams ON pam_keypar = 'COTR' AND pam_cvesec = TipoOtroPago
;
