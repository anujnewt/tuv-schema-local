create or replace procedure labprod."sp_cfdiportaltv"  ( keypro numeric, keyper varchar, keyemp numeric, cv_cfdi inout refcursor ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open cv_cfdi for
select cfdi2nomina.idcomprobanteemp,cfdi2nomina.idnomina, cfdi2comprobanteemp.serie, cfdi2comprobanteemp.folio, cfdi2comprobanteemisor.nombre,
cfdi2comprobanteemp.lugarexpedicion, cfdi2comprobanteemisor.rfc, cfdi2repositorioxml.uuid, cfdi2comprobanteemp.fecha, cfdi2nomina.fechainicialpago,
cfdi2nomina.fechafinalpago, cfdi2nominaemisor.registropatronal, cfdi2nominareceptor.curp, cfdi2nominareceptor.numseguridadsocial, cfdi2nominareceptor.tiporegimen,
cfdi2nominareceptor.numempleado, cfdi2nominareceptor.departamento, cfdi2nominareceptor.puesto, cfdi2nominareceptor.periodicidadpago, cfdi2comprobanteemisor.regimen,
cfdi2comprobantereceptor.rfc, cfdi2comprobantereceptor.nombre, nmloperi.per_despol, cfdi2reportedetalle.numrow, cfdi2reportedetalle.com_codimp, cfdi2reportedetalle.tipo,
cfdi2comprobanteemp.com_fectim, cfdi2comprobanteemp.sello, cfdi2comprobanteemp.formadepago, cfdi2comprobanteemp.nocertificado, cfdi2comprobanteemp.total,
cfdi2nomina.totalpercepciones, cfdi2nomina.totaldeducciones, cfdi2nomina.totalotrospagos, cfdi2repositorioxml.cadenaoriginal, cfdi2repositorioxml.sellosat,
cfdi2repositorioxml.nocertificadosat, cfdi2reportedetalle.clave, cfdi2reportedetalle.concepto, cfdi2reportedetalle.importegravado, cfdi2reportedetalle.importeexento,
vcfdi2totalletra.total total_letra, cfdi2comprobanteemp.tipodecomprobante, cfdi2qr.qrcode,cfdi2comprobanteemp.subtotal,cfdi2comprobanteemp.descuento
from labprod.cfdi2nomina cfdi2nomina
inner join labprod.cfdi2comprobanteemp cfdi2comprobanteemp on cfdi2nomina.idcomprobanteemp=cfdi2comprobanteemp.idcomprobanteemp
inner join labprod.cfdi2repositorioxml cfdi2repositorioxml on cfdi2nomina.idcomprobanteemp=cfdi2repositorioxml.idcomprobanteemp
inner join labprod.vcfdi2totalletra vcfdi2totalletra on cfdi2nomina.idcomprobanteemp=vcfdi2totalletra.idcomprobanteemp
inner join labprod.cfdi2comprobantereceptor cfdi2comprobantereceptor on cfdi2nomina.idcomprobanteemp=cfdi2comprobantereceptor.idcomprobanteemp
inner join labprod.cfdi2nominareceptor cfdi2nominareceptor on cfdi2nomina.idnomina=cfdi2nominareceptor.idnomina
inner join labprod.cfdi2comprobanteemisor cfdi2comprobanteemisor on cfdi2comprobanteemp.idcomprobantepro=cfdi2comprobanteemisor.idcomprobantepro
inner join labprod.cfdi2comprobantepro cfdi2comprobantepro on cfdi2comprobanteemp.idcomprobantepro=cfdi2comprobantepro.idcomprobantepro
inner join labprod.vcfdi2reportedetalle cfdi2reportedetalle on cfdi2nomina.idcomprobanteemp=cfdi2reportedetalle.idcomprobanteemp
inner join labprod.cfdi2nominaemisor cfdi2nominaemisor on cfdi2nomina.idcomprobanteemp=cfdi2nominaemisor.idcomprobanteemp
inner join labprod.nmloperi nmloperi on (cfdi2comprobantepro.com_keypro=nmloperi.per_keypro) and (cfdi2comprobantepro.com_keyper=nmloperi.per_keyper)
left join labprod.cfdi2qr cfdi2qr on cfdi2nomina.idcomprobanteemp=cfdi2qr.idcomprobanteemp
where cfdi2nomina.com_keypro = keypro
and cfdi2nomina.com_keyper = keyper
and cfdi2nomina.com_keyemp = keyemp
order by  cfdi2nomina.idnomina,cfdi2reportedetalle.numrow, cfdi2reportedetalle.com_codimp;end;
$body$
language plpgsql
;
