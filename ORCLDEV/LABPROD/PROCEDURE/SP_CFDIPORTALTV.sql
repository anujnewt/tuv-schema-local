CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_CFDIPORTALTV" (
        KEYPRO IN NUMBER, KEYPER IN VARCHAR2, KEYEMP IN NUMBER,
        CV_CFDI OUT SYS_REFCURSOR )
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  OPEN CV_CFDI FOR
  SELECT cfdi2Nomina.IDCOMPROBANTEEMP,cfdi2Nomina.IDNOMINA, cfdi2ComprobanteEmp.SERIE, cfdi2ComprobanteEmp.FOLIO, cfdi2ComprobanteEmisor.NOMBRE,
  cfdi2ComprobanteEmp.LUGAREXPEDICION, cfdi2ComprobanteEmisor.RFC, cfdi2RepositorioXML.UUID, cfdi2ComprobanteEmp.FECHA, cfdi2Nomina.FECHAINICIALPAGO,
  cfdi2Nomina.FECHAFINALPAGO, cfdi2NominaEmisor.REGISTROPATRONAL, cfdi2NominaReceptor.CURP, cfdi2NominaReceptor.NUMSEGURIDADSOCIAL, cfdi2NominaReceptor.TIPOREGIMEN,
  cfdi2NominaReceptor.NUMEMPLEADO, cfdi2NominaReceptor.DEPARTAMENTO, cfdi2NominaReceptor.PUESTO, cfdi2NominaReceptor.PERIODICIDADPAGO, cfdi2ComprobanteEmisor.REGIMEN,
  cfdi2ComprobanteReceptor.RFC, cfdi2ComprobanteReceptor.NOMBRE, nmloperi.PER_DESPOL, cfdi2ReporteDetalle.NUMROW, cfdi2ReporteDetalle.COM_CODIMP, cfdi2ReporteDetalle.TIPO,
  cfdi2ComprobanteEmp.COM_FECTIM, cfdi2ComprobanteEmp.SELLO, cfdi2ComprobanteEmp.FORMADEPAGO, cfdi2ComprobanteEmp.NOCERTIFICADO, cfdi2ComprobanteEmp.TOTAL,
  cfdi2Nomina.TOTALPERCEPCIONES, cfdi2Nomina.TOTALDEDUCCIONES, cfdi2Nomina.TOTALOTROSPAGOS, cfdi2RepositorioXML.CADENAORIGINAL, cfdi2RepositorioXML.SELLOSAT,
  cfdi2RepositorioXML.NOCERTIFICADOSAT, cfdi2ReporteDetalle.CLAVE, cfdi2ReporteDetalle.CONCEPTO, cfdi2ReporteDetalle.IMPORTEGRAVADO, cfdi2ReporteDetalle.IMPORTEEXENTO,
  vcfdi2TotalLetra.TOTAL TOTAL_LETRA, cfdi2ComprobanteEmp.TIPODECOMPROBANTE, cfdi2QR.QRCODE,cfdi2ComprobanteEmp.SUBTOTAL,cfdi2ComprobanteEmp.DESCUENTO
  FROM LABPROD.CFDI2NOMINA cfdi2Nomina
  INNER JOIN LABPROD.CFDI2COMPROBANTEEMP cfdi2ComprobanteEmp ON cfdi2Nomina.IDCOMPROBANTEEMP=cfdi2ComprobanteEmp.IDCOMPROBANTEEMP
  INNER JOIN LABPROD.CFDI2REPOSITORIOXML cfdi2RepositorioXML ON cfdi2Nomina.IDCOMPROBANTEEMP=cfdi2RepositorioXML.IDCOMPROBANTEEMP
  INNER JOIN LABPROD.VCFDI2TOTALLETRA vcfdi2TotalLetra ON cfdi2Nomina.IDCOMPROBANTEEMP=vcfdi2TotalLetra.IDCOMPROBANTEEMP
  INNER JOIN LABPROD.CFDI2COMPROBANTERECEPTOR cfdi2ComprobanteReceptor ON cfdi2Nomina.IDCOMPROBANTEEMP=cfdi2ComprobanteReceptor.IDCOMPROBANTEEMP
  INNER JOIN LABPROD.CFDI2NOMINARECEPTOR cfdi2NominaReceptor ON cfdi2Nomina.IDNOMINA=cfdi2NominaReceptor.IDNOMINA
  INNER JOIN LABPROD.CFDI2COMPROBANTEEMISOR cfdi2ComprobanteEmisor ON cfdi2ComprobanteEmp.IDCOMPROBANTEPRO=cfdi2ComprobanteEmisor.IDCOMPROBANTEPRO
  INNER JOIN LABPROD.CFDI2COMPROBANTEPRO cfdi2ComprobantePro ON cfdi2ComprobanteEmp.IDCOMPROBANTEPRO=cfdi2ComprobantePro.IDCOMPROBANTEPRO
  INNER JOIN LABPROD.VCFDI2REPORTEDETALLE cfdi2ReporteDetalle ON cfdi2Nomina.IDCOMPROBANTEEMP=cfdi2ReporteDetalle.IDCOMPROBANTEEMP
  INNER JOIN LABPROD.CFDI2NOMINAEMISOR cfdi2NominaEmisor ON cfdi2Nomina.IDCOMPROBANTEEMP=cfdi2NominaEmisor.IDCOMPROBANTEEMP
  INNER JOIN LABPROD.NMLOPERI nmloperi ON (cfdi2ComprobantePro.COM_KEYPRO=nmloperi.PER_KEYPRO) AND (cfdi2ComprobantePro.COM_KEYPER=nmloperi.PER_KEYPER)
  LEFT JOIN LABPROD.CFDI2QR cfdi2QR ON cfdi2Nomina.IDCOMPROBANTEEMP=cfdi2QR.IDCOMPROBANTEEMP
  WHERE cfdi2Nomina.com_keypro = KEYPRO
    AND cfdi2Nomina.com_keyper = KEYPER
    AND cfdi2Nomina.com_keyemp = KEYEMP
  ORDER BY cfdi2Nomina.IDNOMINA,cfdi2ReporteDetalle.NUMROW, cfdi2ReporteDetalle.COM_CODIMP;
END SP_CFDIPORTALTV;
/
