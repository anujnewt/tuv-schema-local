-- dmap_object_gen_tag : type : view name : vcfdi2reportedetalle
set search_path = labconf,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "vcfdi2reportedetalle"  ("idcomprobanteemp", "idnomina", "com_keypro", "com_keyper", "numrow", "com_keyemp", "com_codimp", "tipo", "desctipo", "clave", "concepto", "importegravado", "importeexento") as select nom.idcomprobanteemp, nom.idnomina, nom.com_keypro, nom.com_keyper, row_number() over (partition by nom.idcomprobanteemp, nom.idnomina  order by  clave) as numrow,
nom.com_keyemp, '01' com_codimp, tipopercepcion tipo, pam_nompar desctipo, clave, concepto, importegravado, importeexento
from  cfdi2nomina nom
inner join cfdi2percepcionesdetalle det on det.idnomina = nom.idnomina
inner join cfdi2comprobanteemp emp on emp.idcomprobanteemp = nom.idcomprobanteemp
inner join glcopams on pam_keypar = 'CPER' and pam_cvesec = tipopercepcion
union all
select nom.idcomprobanteemp,nom.idnomina,nom.com_keypro,nom.com_keyper,row_number() over (partition by nom.idcomprobanteemp,nom.idnomina  order by  clave) as numrow,
nom.com_keyemp,'02' com_codimp,tipodeduccion tipo,pam_nompar desctipo,clave,concepto,importegravado,importeexento
from  cfdi2nomina nom
inner join cfdi2deduccionesdetalle det on det.idnomina = nom.idnomina
inner join cfdi2comprobanteemp emp on emp.idcomprobanteemp = nom.idcomprobanteemp
inner join glcopams on pam_keypar = 'CDED' and pam_cvesec = tipodeduccion
union all
select nom.idcomprobanteemp,nom.idnomina,nom.com_keypro,nom.com_keyper,99 + row_number() over (partition by nom.idcomprobanteemp,nom.idnomina order by clave) as numrow,
nom.com_keyemp,'01' com_codimp,tipootropago tipo,pam_nompar desctipo,clave,concepto,0 importegravado,importe importeexento
from  cfdi2nomina nom
inner join cfdi2otrospagos det on det.idnomina = nom.idnomina
inner join cfdi2comprobanteemp emp on emp.idcomprobanteemp = nom.idcomprobanteemp
inner join glcopams on pam_keypar = 'COTR' and pam_cvesec = tipootropago;/* dmap converted statement end */
-- estimed cost of view [ vcfdi2reportedetalle ]: 1.00;
