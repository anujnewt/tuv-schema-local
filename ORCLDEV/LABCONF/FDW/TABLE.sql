-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table ap_sipros (
soi_keyemp numeric(38),
soi_keycon varchar(3),
soi_refere varchar(20),
soi_tipope varchar(1),
soi_import decimal(11,2),
soi_fecope timestamp(0),
soi_tipmon varchar(1),
soi_tipcam decimal(11,4),
soi_tipreg varchar(1),
soi_keypre decimal(16,6),
soi_keypro numeric(38),
soi_status varchar(1),
soi_feccar timestamp(0),
soi_stacar varchar(1),
soi_refamo varchar(16),
soi_vennum varchar(30),
soi_vencod varchar(15)
) server  options(schema 'LABCONF', table 'AP_SIPROS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table aux_acum3 (
keyemp numeric(38) not null,
keycon char(16) not null,
cantid decimal(16,2),
import decimal(16,2),
keypro numeric(38),
keyper char(7)
) server  options(schema 'LABCONF', table 'AUX_ACUM3', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table borra (
field1 varchar(750),
field2 numeric(38),
field3 numeric(38),
field4 varchar(100)
) server  options(schema 'LABCONF', table 'BORRA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2cancelaciones (
idcomprobanteemp numeric(10) options (key 'true') not null,
can_keyemp numeric(10) not null,
can_keypro numeric(5) not null,
can_keyper varchar(7) not null,
can_uuid varchar(36),
can_estatus numeric(5),
can_xmlcancelado varchar(4000),
can_fechacancelacion timestamp,
can_pac varchar(10),
motivocancelacion varchar(2),
foliosustitucion varchar(36),
idcomprobanteempsustitucion numeric(38)
) server  options(schema 'LABCONF', table 'CFDI2CANCELACIONES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2comprobanteconceptos (
idcomprobanteemp numeric(10) options (key 'true') not null,
com_keyemp numeric(10) not null,
com_numsec numeric(10) not null,
cantidad decimal(18,6) not null,
unidad varchar(100) not null,
noidentificacion varchar(100),
descripcion varchar(100) not null,
valorunitario decimal(18,6) not null,
importe decimal(18,6) not null,
objetoimp varchar(2)
) server  options(schema 'LABCONF', table 'CFDI2COMPROBANTECONCEPTOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2comprobanteemisor (
idcomprobantepro numeric(10) options (key 'true') not null,
rfc varchar(13) not null,
nombre varchar(100),
calle varchar(100),
noexterior varchar(100),
nointerior varchar(100),
colonia varchar(100),
localidad varchar(100),
referencia varchar(100),
municipio varchar(100),
estado varchar(100),
pais varchar(100),
codigopostal varchar(5),
regimen varchar(4000) not null
) server  options(schema 'LABCONF', table 'CFDI2COMPROBANTEEMISOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2comprobanteemp (
idcomprobanteemp numeric(10) options (key 'true') not null,
idcomprobantepro numeric(10) not null,
com_keyemp numeric(10) not null,
com_status varchar(1) not null,
com_keyusu numeric(10) not null,
com_fecgen timestamp not null,
com_fectim timestamp,
version varchar(5),
serie varchar(25),
folio varchar(20),
fecha timestamp,
sello varchar(2000),
formadepago varchar(50),
nocertificado varchar(20),
certificado varchar(2000),
condicionesdepago varchar(20),
subtotal decimal(18,6) not null,
descuento decimal(18,6) not null,
motivodescuento varchar(50),
tipocambio varchar(50),
moneda varchar(50),
total decimal(18,6) not null,
tipodecomprobante varchar(20) not null,
metododepago varchar(20) not null,
lugarexpedicion varchar(50) not null,
totalimpuestosretenidos decimal(18,2),
exportacion varchar(2)
) server  options(schema 'LABCONF', table 'CFDI2COMPROBANTEEMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2comprobantepro (
idcomprobantepro numeric(10) options (key 'true') not null,
com_keypro numeric(5) not null,
com_keyper varchar(7) not null,
com_ejecut numeric(5) not null
) server  options(schema 'LABCONF', table 'CFDI2COMPROBANTEPRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2comprobantereceptor (
idcomprobanteemp numeric(10) options (key 'true') not null,
com_keyemp numeric(10) not null,
rfc varchar(13),
nombre varchar(100),
calle varchar(100),
noexterior varchar(100),
nointerior varchar(100),
colonia varchar(100),
localidad varchar(100),
referencia varchar(100),
municipio varchar(100),
estado varchar(100),
pais varchar(100),
codigopostal varchar(5),
domiciliofiscalreceptor varchar(5),
regimenfiscalreceptor varchar(5),
usocfdi varchar(5)
) server  options(schema 'LABCONF', table 'CFDI2COMPROBANTERECEPTOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2conf (
idconfig numeric(10) options (key 'true') not null,
con_keycia varchar(5) not null,
con_codimp varchar(2) not null,
con_keycon varchar(3) not null,
con_tipcon varchar(1) not null,
con_tipsat varchar(3) not null,
con_clave varchar(15),
con_descri varchar(100),
con_camexe varchar(6),
con_camgra varchar(6),
con_tipope varchar(1),
con_incdia varchar(6),
con_incdes varchar(6),
con_hexdia varchar(6),
con_hexhor varchar(6),
con_heximp varchar(6),
con_diapag varchar(6)
) server  options(schema 'LABCONF', table 'CFDI2CONF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2deduccionesdetalle (
iddeduccion numeric(10) options (key 'true') not null,
idnomina numeric(10) not null,
tipodeduccion varchar(3) not null,
clave varchar(15) not null,
concepto varchar(100) not null,
importe decimal(18,2) not null,
importegravado decimal(18,2) not null,
importeexento decimal(18,2) not null
) server  options(schema 'LABCONF', table 'CFDI2DEDUCCIONESDETALLE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2deduccionestotal (
idnomina numeric(10) options (key 'true') not null,
totalotrasdeducciones decimal(18,2),
totalimpuestosretenidos decimal(18,2)
) server  options(schema 'LABCONF', table 'CFDI2DEDUCCIONESTOTAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2errores (
iderror numeric(10) options (key 'true') not null,
idcomprobanteemp numeric(10) not null,
com_tiperr numeric(5) not null,
com_keyerr varchar(10),
com_descrip varchar(2000)
) server  options(schema 'LABCONF', table 'CFDI2ERRORES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2estatusrecibos (
idcomprobanteemp numeric(10) options (key 'true') not null,
est_feclec timestamp,
est_status numeric(5),
est_error varchar(4000)
) server  options(schema 'LABCONF', table 'CFDI2ESTATUSRECIBOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2horasextra (
idnomina numeric(10) not null,
idpercepcion numeric(10) not null,
dias numeric(10),
tipohoras varchar(2),
horasextra numeric(10),
importepagado decimal(18,2)
) server  options(schema 'LABCONF', table 'CFDI2HORASEXTRA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2incapacidades (
idnomina numeric(10) not null,
diasincapacidad numeric(10) not null,
tipoincapacidad varchar(2) not null,
importemonetario decimal(18,2)
) server  options(schema 'LABCONF', table 'CFDI2INCAPACIDADES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2nomina (
idnomina numeric(10) options (key 'true') not null,
idcomprobanteemp numeric(10) not null,
com_keyemp numeric(10) not null,
com_keypro numeric(10) not null,
com_keyper varchar(7) not null,
version varchar(5) not null,
tiponomina varchar(1) not null,
fechapago timestamp(0) not null,
fechainicialpago timestamp(0) not null,
fechafinalpago timestamp(0) not null,
numdiaspagados decimal(10,3) not null,
totalpercepciones decimal(18,2),
totaldeducciones decimal(18,2),
totalotrospagos decimal(18,2)
) server  options(schema 'LABCONF', table 'CFDI2NOMINA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2nominaemisor (
idcomprobanteemp numeric(10) options (key 'true') not null,
curp varchar(18),
registropatronal varchar(20),
rfcpatronorigen varchar(13),
origenrecurso varchar(2),
montorecursopropio decimal(18,2)
) server  options(schema 'LABCONF', table 'CFDI2NOMINAEMISOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2nominareceptor (
idnomina numeric(10) options (key 'true') not null,
curp varchar(18),
numseguridadsocial varchar(15),
fechainiciorellaboral timestamp(0),
antiguedad varchar(20),
tipocontrato varchar(2),
sindicalizado varchar(2),
tipojornada varchar(2),
tiporegimen varchar(2),
numempleado varchar(15),
departamento varchar(100),
puesto varchar(100),
riesgopuesto varchar(1),
periodicidadpago varchar(2),
banco varchar(3),
cuentabancaria varchar(18),
salariobasecotapor decimal(18,2),
salariodiariointegrado decimal(18,2),
claveentfed varchar(3)
) server  options(schema 'LABCONF', table 'CFDI2NOMINARECEPTOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2otrospagos (
idnomina numeric(10) not null,
tipootropago varchar(3) not null,
clave varchar(15) not null,
concepto varchar(100) not null,
importe decimal(18,2) not null,
subsidiocausado decimal(18,2),
saldoafavor decimal(18,2),
anio numeric(10),
remanentesalfav decimal(18,2)
) server  options(schema 'LABCONF', table 'CFDI2OTROSPAGOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2percepcionesdetalle (
idpercepcion numeric(10) options (key 'true') not null,
idnomina numeric(10) not null,
tipopercepcion varchar(3) not null,
clave varchar(15) not null,
concepto varchar(100) not null,
importegravado decimal(18,2) not null,
importeexento decimal(18,2) not null,
valormercado decimal(18,2),
precioalotorgarse decimal(18,2)
) server  options(schema 'LABCONF', table 'CFDI2PERCEPCIONESDETALLE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2percepcionesjubilacion (
idnomina numeric(10) options (key 'true') not null,
totalunaexhibicion decimal(18,2),
totalparcialidad decimal(18,2),
montodiario decimal(18,2),
ingresoacumulable decimal(18,2) not null,
ingresonoacumulable decimal(18,2) not null
) server  options(schema 'LABCONF', table 'CFDI2PERCEPCIONESJUBILACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2percepcionesseparacion (
idnomina numeric(10) options (key 'true') not null,
totalpagado decimal(18,2) not null,
numaniosservicio numeric(10) not null,
ultimosueldomensord decimal(18,2) not null,
ingresoacumulable decimal(18,2) not null,
ingresonoacumulable decimal(18,2) not null
) server  options(schema 'LABCONF', table 'CFDI2PERCEPCIONESSEPARACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2percepcionestotal (
idnomina numeric(10) options (key 'true') not null,
totalsueldos decimal(18,2),
totalseparacionindemnizacion decimal(18,2),
totaljubilacionpensionretiro decimal(18,2),
totalgravado decimal(18,2) not null,
totalexento decimal(18,2) not null
) server  options(schema 'LABCONF', table 'CFDI2PERCEPCIONESTOTAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2relacionados (
idcomprobanteemp numeric(10) not null,
rel_keypro numeric(5) not null,
rel_keyper varchar(7) not null,
rel_keyemp numeric(10) not null,
idcomprobanteemp_ori numeric(10) not null,
tiporelacion varchar(2) not null,
rel_uuid varchar(36)
) server  options(schema 'LABCONF', table 'CFDI2RELACIONADOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2reportecifras (
idnomina numeric(38) not null,
com_keyemp numeric(38) not null,
com_codimp varchar(2) not null,
com_keycon varchar(3) not null,
con_tipcon varchar(3) not null,
tipo varchar(3) not null,
desctipo varchar(100),
clave varchar(15) not null,
concepto varchar(100),
importegravado decimal(18,2) not null,
importeexento decimal(18,2) not null
) server  options(schema 'LABCONF', table 'CFDI2REPORTECIFRAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2repositorioxml (
idcomprobanteemp numeric(10) options (key 'true') not null,
xmlcfdi varchar(4000),
timbrado numeric(1),
cadenaoriginal varchar(4000),
pac varchar(100),
uuid varchar(36),
sellosat varchar(4000),
nocertificadosat varchar(50)
) server  options(schema 'LABCONF', table 'CFDI2REPOSITORIOXML', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdi2subcontratacion (
idnomina numeric(10) not null,
rfclabora varchar(13),
porcentajetiempo decimal(10,3)
) server  options(schema 'LABCONF', table 'CFDI2SUBCONTRATACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdicomprobanteconceptos (
idcomprobanteemp numeric(38) options (key 'true') not null,
com_keyemp numeric(38) not null,
com_numsec numeric(38) not null,
cantidad decimal(18,6) not null,
unidad varchar(100) not null,
noidentificacion varchar(100),
descripcion varchar(100) not null,
valorunitario decimal(18,6) not null,
importe decimal(18,6) not null
) server  options(schema 'LABCONF', table 'CFDICOMPROBANTECONCEPTOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdicomprobanteemisor (
idcomprobantepro numeric(38) options (key 'true') not null,
rfc varchar(13) not null,
nombre varchar(100),
calle varchar(100),
noexterior varchar(100),
nointerior varchar(100),
colonia varchar(100),
localidad varchar(100),
referencia varchar(100),
municipio varchar(100),
estado varchar(100),
pais varchar(100),
codigopostal varchar(5)
) server  options(schema 'LABCONF', table 'CFDICOMPROBANTEEMISOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdicomprobanteemp (
idcomprobanteemp numeric(38) options (key 'true') not null,
idcomprobantepro numeric(38) not null,
com_keyemp numeric(38) not null,
com_status varchar(1) not null,
com_keyusu numeric(38) not null,
com_fecgen timestamp(0) not null,
com_fectim timestamp(0),
version varchar(5),
serie varchar(25),
folio varchar(20),
fecha timestamp(0),
sello varchar(2000),
formadepago varchar(50),
nocertificado varchar(20),
certificado varchar(2000),
condicionesdepago varchar(20),
subtotal decimal(18,6) not null,
descuento decimal(18,6) not null,
motivodescuento varchar(50),
tipocambio varchar(50),
moneda varchar(50),
total decimal(18,6) not null,
tipodecomprobante varchar(20) not null,
metododepago varchar(20) not null,
lugarexpedicion varchar(50) not null,
numctapago varchar(18),
foliofiscalorig varchar(20),
seriefoliofiscalorig varchar(20),
fechafoliofiscalorig timestamp(0),
montofoliofiscalorig decimal(18,6),
totalimpuestosretenidos decimal(18,6)
) server  options(schema 'LABCONF', table 'CFDICOMPROBANTEEMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdicomprobantepro (
idcomprobantepro numeric(38) options (key 'true') not null,
com_keypro numeric(38) not null,
com_keyper varchar(7) not null,
com_ejecut numeric(38) not null
) server  options(schema 'LABCONF', table 'CFDICOMPROBANTEPRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdicomprobantereceptor (
idcomprobanteemp numeric(38) options (key 'true') not null,
com_keyemp numeric(38) not null,
rfc varchar(13) not null,
nombre varchar(100),
calle varchar(100),
noexterior varchar(100),
nointerior varchar(100),
colonia varchar(100),
localidad varchar(100),
referencia varchar(100),
municipio varchar(100),
estado varchar(100),
pais varchar(100),
codigopostal varchar(5)
) server  options(schema 'LABCONF', table 'CFDICOMPROBANTERECEPTOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdiconf (
idconfig numeric(38) options (key 'true') not null,
con_keycia varchar(2) not null,
con_codimp varchar(2) not null,
con_keycon varchar(3) not null,
con_tipcon varchar(1) not null,
con_tipsat varchar(3) not null,
con_clave varchar(15) not null,
con_descri varchar(100) not null,
con_camexe varchar(6),
con_camgra varchar(6),
con_tipope varchar(1),
con_incdia varchar(6),
con_incdes varchar(6),
con_hexdia varchar(6),
con_hexhor varchar(6),
con_heximp varchar(6),
con_diapag varchar(6)
) server  options(schema 'LABCONF', table 'CFDICONF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdideducciones (
idcomprobanteemp numeric(38) not null,
com_keyemp numeric(38) not null,
com_keycon varchar(3),
tipodeduccion varchar(3) not null,
clave varchar(6) not null,
concepto varchar(100) not null,
importegravado decimal(18,6),
importeexento decimal(18,6)
) server  options(schema 'LABCONF', table 'CFDIDEDUCCIONES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdierrores (
iderror numeric(38) options (key 'true') not null,
idcomprobanteemp numeric(38) not null,
com_tiperr numeric(38) not null,
com_keyerr varchar(10),
com_descrip varchar(250)
) server  options(schema 'LABCONF', table 'CFDIERRORES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdihorasextra (
idcomprobanteemp numeric(38) not null,
com_keyemp numeric(38) not null,
dias numeric(38) not null,
tipohoras varchar(10) not null,
horasextra decimal(18,6) not null,
importepagado decimal(18,6) not null
) server  options(schema 'LABCONF', table 'CFDIHORASEXTRA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdiincapacidades (
idcomprobanteemp numeric(38) not null,
com_keyemp numeric(38) not null,
diasincapacidad decimal(18,6) not null,
tipoincapacidad numeric(38) not null,
descuento decimal(18,6) not null
) server  options(schema 'LABCONF', table 'CFDIINCAPACIDADES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdinomina (
idcomprobanteemp numeric(38) options (key 'true') not null,
idcomprobantepro numeric(38),
com_keyemp numeric(38) not null,
version varchar(5) not null,
registropatronal varchar(20),
numempleado varchar(15) not null,
curp varchar(18),
tiporegimen numeric(38),
numseguridadsocial varchar(20),
fechapago timestamp(0) not null,
fechainicialpago timestamp(0) not null,
fechafinalpago timestamp(0) not null,
numdiaspagados decimal(18,6),
departamento varchar(100),
clabe varchar(20),
banco varchar(5),
fechainiciorellaboral timestamp(0),
antiguedad numeric(38),
puesto varchar(100),
tipocontrato varchar(50),
tipojornada varchar(50),
periodicidadpago varchar(100) not null,
salariobasecotapor decimal(18,6),
riesgopuesto numeric(38),
salariodiariointegrado decimal(18,6),
totalgravadopercepcion decimal(18,6),
totalexentopercepcion decimal(18,6),
totalgravadodeduccion decimal(18,6),
totalexentodeduccion decimal(18,6)
) server  options(schema 'LABCONF', table 'CFDINOMINA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdipercepciones (
idcomprobanteemp numeric(38) not null,
com_keyemp numeric(38) not null,
com_keycon varchar(3),
tipopercepcion varchar(3) not null,
clave varchar(6) not null,
concepto varchar(100) not null,
importegravado decimal(18,6) not null,
importeexento decimal(18,6) not null
) server  options(schema 'LABCONF', table 'CFDIPERCEPCIONES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdiregimen (
idcomprobantepro numeric(38) options (key 'true') not null,
regimen varchar(250)
) server  options(schema 'LABCONF', table 'CFDIREGIMEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cfdixpoliza (
keyfac varchar(30),
origen varchar(10),
mes numeric(38),
anio numeric(38),
uuid varchar(36),
orgid varchar(50),
rfc_emisor varchar(13),
rfc_receptor varchar(13),
importe decimal(18,6),
fecha_emision timestamp(0),
keyemp numeric(38),
idcomprobantemp numeric(38),
regimenfiscal varchar(100),
keypro numeric(38),
keyper varchar(7),
banco varchar(15),
status varchar(10),
des_benef varchar(300),
des_cta_dest varchar(50),
cve_bancodest varchar(3),
des_bancodest varchar(300),
des_moneda varchar(3),
num_tipo_cambio numeric,
attribute1 varchar(250),
attribute2 varchar(250),
attribute3 varchar(250),
attribute4 varchar(250),
attribute5 varchar(250),
attribute6 varchar(250),
attribute7 varchar(250),
attribute8 varchar(250),
attribute9 varchar(250),
attribute10 varchar(250),
attribute11 varchar(250),
attribute12 varchar(250),
attribute13 varchar(250),
attribute14 varchar(250),
attribute15 varchar(250)
) server  options(schema 'LABCONF', table 'CFDIXPOLIZA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table comcias (
numcia varchar(4) not null,
nomcia varchar(60) not null
) server  options(schema 'LABCONF', table 'COMCIAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table comparativo (
id_comp numeric(10),
cve_origen numeric(38),
cve_mes numeric(38),
cve_cia varchar(4),
cve_virh varchar(10),
cve_vicon varchar(10),
cve_tpreg varchar(2),
cve_ccrh varchar(16),
cve_dptrh varchar(16),
cve_dptcon varchar(16),
cve_proc numeric,
cve_empl numeric,
tipo_emp varchar(6),
cve_pue varchar(16),
status varchar(1),
cve_plaza numeric,
version numeric,
cve_anio numeric
) server  options(schema 'LABCONF', table 'COMPARATIVO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table comtporegistro (
numtporeg numeric(38) not null,
destporeg char(60) not null
) server  options(schema 'LABCONF', table 'COMTPOREGISTRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table com_orac_sips_bita (
eme_noctvo numeric(38) not null,
eme_status char(1) not null,
eme_object char(18) not null,
eme_menerr varchar(200) not null,
eme_fecmov timestamp(0) not null
) server  options(schema 'LABCONF', table 'COM_ORAC_SIPS_BITA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table com_orac_sips_camp (
cam_tablas varchar(18) not null,
cam_campos varchar(18) not null,
cam_activo char(1) not null
) server  options(schema 'LABCONF', table 'COM_ORAC_SIPS_CAMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table com_orac_sips_data (
ora_noctvo numeric(38) not null,
dat_keyemp numeric(38),
dat_keypar varchar(2),
dat_valpar varchar(30),
ora_status varchar(2)
) server  options(schema 'LABCONF', table 'COM_ORAC_SIPS_DATA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table com_orac_sips_deps (
ora_noctvo numeric(38),
dep_keydep varchar(16),
dep_desdep varchar(40),
dep_refcon varchar(20),
dep_keycen varchar(16),
dep_tipdep varchar(1),
dep_nu1aux varchar(10),
dep_nu2aux varchar(10),
dep_nu3aux varchar(10),
dep_nu4aux varchar(10),
dep_nu5aux varchar(10),
dep_ca1aux varchar(10),
dep_ca2aux varchar(10),
dep_ca3aux varchar(10),
dep_ca4aux varchar(10),
dep_ca5aux varchar(10)
) server  options(schema 'LABCONF', table 'COM_ORAC_SIPS_DEPS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table com_orac_sips_empl (
ora_noctvo numeric(38) not null,
emp_keyemp numeric(38),
emp_keydep varchar(16),
emp_keypue varchar(16),
emp_keycen varchar(16),
emp_keycat varchar(16),
emp_nomemp varchar(60),
emp_nomcor varchar(20),
emp_domemp varchar(60),
emp_colemp varchar(40),
emp_cidemp varchar(20),
emp_pobemp varchar(20),
emp_munemp varchar(6),
emp_entemp varchar(2),
emp_codemp varchar(5),
emp_telemp varchar(20),
emp_regrfc varchar(13),
emp_recurp varchar(18),
emp_regims varchar(12),
emp_reginf varchar(12),
emp_cvesex varchar(1),
emp_keyims varchar(5),
emp_cvezon numeric(38),
emp_keypro numeric(38),
emp_cvetur numeric(38),
emp_tipemp varchar(6),
emp_tipsal varchar(1),
emp_status numeric(38),
emp_salhor decimal(12,6),
emp_saldia decimal(12,6),
emp_salmes decimal(12,2),
emp_salint decimal(12,6),
emp_salivc decimal(12,6),
emp_salinf decimal(12,6),
emp_intsin decimal(12,6),
emp_infsin decimal(12,6),
emp_varims decimal(12,6),
emp_varinf decimal(12,6),
emp_anthor decimal(12,6),
emp_antdia decimal(12,6),
emp_antmes decimal(12,2),
emp_antint decimal(12,6),
emp_antivc decimal(12,6),
emp_antinf decimal(12,6),
emp_antits decimal(12,6),
emp_antifs decimal(12,6),
emp_refcon varchar(20),
emp_cveban varchar(7),
emp_ctaban varchar(18),
emp_forpag varchar(2),
emp_diades numeric(38),
emp_numliq varchar(6),
emp_keyloc varchar(16),
emp_fecing timestamp(0),
emp_fecrei timestamp(0),
emp_fecven timestamp(0),
emp_fecpla timestamp(0),
emp_fecaum timestamp(0),
emp_peraum varchar(7),
emp_fecbaj timestamp(0),
emp_cvebaj varchar(4),
emp_jorlab varchar(1),
emp_unijor decimal(4,2),
emp_pering varchar(7),
emp_perbaj varchar(7),
emp_perdep varchar(7),
emp_perpue varchar(7),
emp_percat varchar(7),
emp_perpro varchar(7),
emp_fecaux timestamp(0),
emp_ca1aux varchar(10),
emp_ca2aux varchar(10),
emp_ca3aux varchar(10),
emp_ca4aux varchar(10),
emp_pctbec decimal(5,2),
emp_fecmod timestamp(0),
emp_hormod varchar(8),
emp_fecalt timestamp(0),
emp_bajfec timestamp(0),
emp_fecsal timestamp(0),
emp_perpag varchar(7),
emp_inifec timestamp(0),
emp_finfec timestamp(0),
emp_cobert varchar(2),
emp_est varchar(2)
) server  options(schema 'LABCONF', table 'COM_ORAC_SIPS_EMPL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table com_orac_sips_plzs (
ora_noctvo numeric(38) not null,
plz_keyest varchar(3),
plz_keydep varchar(16),
plz_keypue varchar(16),
plz_keyplz numeric(38),
plz_keycat varchar(16),
plz_keyloc varchar(16),
plz_tippla varchar(2),
plz_fecini timestamp(0),
plz_fecfin timestamp(0),
plz_diavig numeric(38),
plz_turnop numeric(38),
plz_keyhor varchar(16),
plz_keyemp numeric(38),
plz_cveuoc numeric(38),
plz_cverem numeric(38),
plz_fecmov timestamp(0),
plz_submov varchar(2),
plz_cosplz decimal(14,2),
plz_ca1aux varchar(16),
plz_ca2aux varchar(16),
plz_ca3aux varchar(16),
plz_nu1aux varchar(10),
plz_nu2aux varchar(10),
plz_nu3aux varchar(10),
plz_fe1aux varchar(10),
plz_fe2aux varchar(10),
plz_fe3aux timestamp(0),
plz_co1aux decimal(14,2),
plz_co2aux decimal(14,2),
plz_co3aux decimal(14,2),
plz_co4aux decimal(14,2),
plz_co5aux decimal(14,2),
plz_keysue varchar(4),
plz_sueniv numeric(38),
plz_subniv numeric(38),
plz_cobert varchar(2),
plz_keypro numeric(38),
plz_keydpl decimal(16,6),
plz_fecocu timestamp(0),
plz_salplz decimal(12,2),
plz_titula numeric(38),
plz_origen varchar(2),
plz_valimp varchar(2),
plz_limocu timestamp(0),
plz_tiptab varchar(2),
ora_status varchar(2)
) server  options(schema 'LABCONF', table 'COM_ORAC_SIPS_PLZS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table com_orac_sips_pues (
ora_noctvo numeric(38) not null,
pue_keypue varchar(16),
pue_despue varchar(60),
pue_refcon varchar(20),
pue_nu1aux varchar(10),
pue_nu2aux varchar(10),
pue_nu3aux varchar(10),
pue_nu4aux varchar(10),
pue_nu5aux varchar(10),
pue_ca1aux varchar(10),
pue_ca2aux varchar(10),
pue_ca3aux varchar(10),
pue_ca4aux varchar(10),
pue_ca5aux varchar(10),
pue_sueniv numeric(38),
pue_subniv numeric(38),
pue_keysue varchar(4),
pue_cobert varchar(2),
pue_arepue varchar(6),
pue_subare varchar(6),
pue_nivpue numeric(38),
pue_grppue varchar(16),
pue_subgrp varchar(16),
pue_tippue varchar(2)
) server  options(schema 'LABCONF', table 'COM_ORAC_SIPS_PUES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table com_orac_sips_tray (
ora_noctvo numeric(38) not null,
tra_keyemp numeric(38),
tra_fecmov timestamp(0),
tra_tipmov varchar(2),
tra_keydep varchar(16),
tra_keypue varchar(16),
tra_keycat varchar(16),
tra_keycen varchar(16),
tra_saldia decimal(12,6),
tra_salmes decimal(12,2),
tra_salint decimal(12,6),
tra_salivc decimal(12,6),
tra_salinf decimal(12,6),
tra_intsin decimal(12,6),
tra_infsin decimal(12,6),
tra_keyims varchar(5),
tra_keyper varchar(7),
tra_codloc varchar(16),
tra_keypla numeric(38),
tra_keypro numeric(38),
tra_jorlab varchar(1),
tra_unijor decimal(4,2),
tra_submov varchar(6),
tra_ca1aux varchar(10),
tra_ca2aux varchar(10),
tra_fecmod timestamp(0),
tra_hormod varchar(8),
ora_status varchar(2)
) server  options(schema 'LABCONF', table 'COM_ORAC_SIPS_TRAY', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table com_sips_orac_bita (
bit_regist varchar(50),
bit_valant varchar(50),
bit_valnue varchar(50),
bit_keyemp numeric(38),
bit_fecmov timestamp(0),
bit_menerr varchar(200),
bit_noctvo numeric(10) not null,
bit_status varchar(1)
) server  options(schema 'LABCONF', table 'COM_SIPS_ORAC_BITA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table com_sips_orac_empl (
ora_ctvo numeric(10) not null,
ora_status varchar(1),
id_persona varchar(20),
apellidos varchar(150),
nombres varchar(150),
tipo_persona varchar(20),
sexo varchar(1),
rfc varchar(20),
curp varchar(20),
imss numeric(20),
fecha_alta timestamp(0),
fecha_nacimiento timestamp(0),
nacionalidad varchar(80),
business_group_id numeric(38),
email varchar(40),
end_date timestamp(0),
estado_empleado varchar(10)
) server  options(schema 'LABCONF', table 'COM_SIPS_ORAC_EMPL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table congelada_rh2000 (
mes_keyano char(4),
mes_keymes char(4) not null,
mes_keycia char(4) not null,
mes_keyper char(7) not null,
mes_keypro numeric(38) not null,
mes_keyemp numeric(38) not null,
mes_keypue char(16),
mes_status numeric(38),
mes_fecing timestamp(0),
mes_fecrei timestamp(0),
mes_fecbaj timestamp(0),
mes_fecaum timestamp(0),
mes_keyloc char(16),
mes_forpag char(2),
mes_numpza numeric(38),
mes_cveaum numeric(38),
mes_keydep char(16),
mes_keycen char(16),
mes_deprep numeric(38),
mes_ccdsup numeric(38),
mes_keyjfe numeric(38),
mes_keypuj char(16),
mes_salmes decimal(12,2),
mes_salhor decimal(12,6),
mes_saldia decimal(12,6),
mes_salint decimal(12,6),
mes_salivc decimal(12,6),
mes_salinf decimal(12,6),
mes_intsin decimal(12,6),
mes_infsin decimal(12,6),
mes_varims decimal(12,6),
mes_varinf decimal(12,6),
mes_keyvic numeric(38),
mes_keyest char(3),
mes_paddep char(16),
mes_hijdep char(16),
mes_codniv char(80),
mes_pesesp numeric(38),
mes_numniv numeric(38)
) server  options(schema 'LABCONF', table 'CONGELADA_RH2000', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table contratos (
keycia varchar(2),
giro1 varchar(200),
giro2 varchar(200),
dom varchar(200),
aux1 varchar(200),
aux2 varchar(200)
) server  options(schema 'LABCONF', table 'CONTRATOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table cuentas (
proceso numeric(38),
periodo varchar(7),
nomina numeric(38),
compania varchar(4),
concepto varchar(3),
cuenta varchar(20),
cuentacos varchar(20)
) server  options(schema 'LABCONF', table 'CUENTAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table datapaso (
dat_keyemp numeric(38) not null,
dat_keypar varchar(2) not null,
dat_valpar varchar(30) not null
) server  options(schema 'LABCONF', table 'DATAPASO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table det_capinc (
det_numid numeric(10) not null,
det_cvedia varchar(2) not null,
det_keyusu varchar(18) not null,
det_keyemp numeric(38) not null,
det_keysem numeric(38) not null,
det_ccosto varchar(18),
det_ent varchar(5),
det_sal varchar(5),
det_concep varchar(3),
det_fecha timestamp(0) not null,
det_horas decimal(10,2) not null,
det_impor decimal(16,2),
det_cveinc varchar(2),
det_xytech numeric(38)
) server  options(schema 'LABCONF', table 'DET_CAPINC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table det_compara (
id_comp numeric(38),
cve_cuenta varchar(20),
importe decimal(14,2)
) server  options(schema 'LABCONF', table 'DET_COMPARA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table edlotipe (
tip_keytip varchar(6),
tip_destip varchar(40)
) server  options(schema 'LABCONF', table 'EDLOTIPE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table emplpaso (
ora_noctvo numeric(38) not null,
ora_status varchar(2),
ora_fecmod varchar(8),
emp_keyemp numeric(38),
emp_keydep varchar(16),
emp_keypue varchar(16),
emp_keycen varchar(16),
emp_keycat varchar(16),
emp_nomemp varchar(60),
emp_nomcor varchar(20),
emp_domemp varchar(60),
emp_colemp varchar(40),
emp_cidemp varchar(20),
emp_pobemp varchar(20),
emp_munemp varchar(6),
emp_entemp varchar(2),
emp_codemp varchar(5),
emp_telemp varchar(60),
emp_regrfc varchar(13),
emp_recurp varchar(18),
emp_regims varchar(12),
emp_reginf varchar(12),
emp_cvesex varchar(1),
emp_keyims varchar(5),
emp_cvezon numeric(38),
emp_keypro numeric(38),
emp_cvetur numeric(38),
emp_tipemp varchar(6),
emp_tipsal varchar(1),
emp_status numeric(38),
emp_salhor decimal(12,6),
emp_saldia decimal(12,6),
emp_salmes decimal(12,2),
emp_salint decimal(12,6),
emp_salivc decimal(12,6),
emp_salinf decimal(12,6),
emp_intsin decimal(12,6),
emp_infsin decimal(12,6),
emp_varims decimal(12,6),
emp_varinf decimal(12,6),
emp_anthor decimal(12,6),
emp_antdia decimal(12,6),
emp_antmes decimal(12,2),
emp_antint decimal(12,6),
emp_antivc decimal(12,6),
emp_antinf decimal(12,6),
emp_antits decimal(12,6),
emp_antifs decimal(12,6),
emp_refcon varchar(20),
emp_cveban varchar(7),
emp_ctaban varchar(18),
emp_forpag varchar(2),
emp_diades numeric(38),
emp_numliq varchar(6),
emp_keyloc varchar(16),
emp_fecing timestamp(0),
emp_fecrei timestamp(0),
emp_fecven timestamp(0),
emp_fecpla timestamp(0),
emp_fecaum timestamp(0),
emp_peraum varchar(7),
emp_fecbaj timestamp(0),
emp_cvebaj varchar(4),
emp_jorlab varchar(1),
emp_unijor decimal(4,2),
emp_pering varchar(7),
emp_perbaj varchar(7),
emp_perdep varchar(7),
emp_perpue varchar(7),
emp_percat varchar(7),
emp_perpro varchar(7),
emp_fecaux timestamp(0),
emp_ca1aux varchar(10),
emp_ca2aux varchar(10),
emp_ca3aux varchar(10),
emp_ca4aux varchar(10),
emp_pctbec decimal(5,2),
emp_fecmod timestamp(0),
emp_hormod varchar(8),
emp_fecalt timestamp(0),
emp_bajfec timestamp(0),
emp_fecsal timestamp(0),
emp_perpag varchar(7),
emp_inifec timestamp(0),
emp_finfec timestamp(0),
emp_cobert varchar(2),
emp_est varchar(2)
) server  options(schema 'LABCONF', table 'EMPLPASO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eocodecp (
dcp_keydep varchar(16),
dcp_keypue varchar(16),
dcp_keycon varchar(3),
dcp_keyper varchar(7),
dcp_import decimal(14,2),
dcp_tippst varchar(1),
dcp_fecmov timestamp(0)
) server  options(schema 'LABCONF', table 'EOCODECP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eocoencp (
ecp_keydep varchar(16),
ecp_keypue varchar(16),
ecp_keycon varchar(3),
ecp_autori decimal(14,2),
ecp_modifi decimal(14,2),
ecp_compro decimal(14,2),
ecp_reserv decimal(14,2),
ecp_ejerci decimal(14,2),
ecp_dispon decimal(14,2),
ecp_fecini timestamp(0),
ecp_fecfin timestamp(0)
) server  options(schema 'LABCONF', table 'EOCOENCP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eocoplza (
plz_keyplz numeric(38) not null,
plz_keysol numeric(38) not null,
plz_keypro numeric(38) not null,
plz_keyest varchar(3) not null,
plz_keydep varchar(16) not null,
plz_keypue varchar(16) not null,
plz_keycen varchar(16),
plz_keycat varchar(16),
plz_keyloc varchar(16),
plz_keyims varchar(5),
plz_tipplz varchar(3),
plz_tipcon varchar(1),
plz_contra varchar(3),
plz_fecini timestamp(0),
plz_fecfin timestamp(0),
plz_turnop numeric(38),
plz_keyhor varchar(16),
plz_keyemp numeric(38),
plz_cveuoc numeric(38),
plz_titula numeric(38),
plz_cverem numeric(38),
plz_status varchar(1),
plz_keymot varchar(6),
plz_fecmov timestamp(0),
plz_hormov varchar(8),
plz_cosplz decimal(14,2),
plz_keysue varchar(4),
plz_tiptab varchar(2),
plz_sueniv numeric(38),
plz_subniv numeric(38),
plz_cobert varchar(2),
plz_fecocu timestamp(0),
plz_salplz decimal(14,2),
plz_origen varchar(6),
plz_codocu varchar(6),
plz_limocu timestamp(0),
plz_ca1aux varchar(100),
plz_ca2aux varchar(100),
plz_ca3aux varchar(100),
plz_ca4aux varchar(100),
plz_ca5aux varchar(100),
plz_ca6aux varchar(100),
plz_ca7aux varchar(100),
plz_ca8aux varchar(100)
) server  options(schema 'LABCONF', table 'EOCOPLZA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eocorede (
red_keyest varchar(3) not null,
red_paddep varchar(16),
red_hijdep varchar(16) not null,
red_codniv varchar(80) not null,
red_pesesp numeric(5),
red_numniv numeric(5)
) server  options(schema 'LABCONF', table 'EOCOREDE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eolodest (
des_keyest varchar(5) not null,
des_desest varchar(40),
des_tipest varchar(1) not null
) server  options(schema 'LABCONF', table 'EOLODEST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eolodpla (
dpl_keyest varchar(3),
dpl_keydep varchar(16),
dpl_keypue varchar(16),
dpl_tipplz varchar(2),
dpl_cantid numeric(38),
dpl_fecini timestamp(0),
dpl_fecfin timestamp(0),
dpl_fecaut timestamp(0),
dpl_keyusu numeric(38),
dpl_diavig numeric(38),
dpl_status varchar(1),
dpl_keydpl decimal(16,6),
dpl_saldop numeric(38),
dpl_diasal numeric(38),
dpl_ca1aux varchar(10),
dpl_ca2aux varchar(10),
dpl_keypro numeric(38),
dpl_tiptab varchar(2),
dpl_keysue varchar(4),
dpl_sueniv numeric(38),
dpl_subniv numeric(38),
dpl_cobert varchar(2),
dpl_cospla decimal(14,2),
dpl_co1aux decimal(14,2),
dpl_co2aux decimal(14,2),
dpl_co3aux decimal(14,2),
dpl_co4aux decimal(14,2),
dpl_co5aux decimal(14,2),
dpl_salimp decimal(14,2),
dpl_impaut decimal(14,2)
) server  options(schema 'LABCONF', table 'EOLODPLA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eolohplz (
hpl_keyplz numeric(10) not null,
hpl_keysol numeric(10) not null,
hpl_keypro numeric(5),
hpl_keyest varchar(3) not null,
hpl_keydep varchar(16) not null,
hpl_keypue varchar(16) not null,
hpl_keycen varchar(16),
hpl_keycat varchar(16),
hpl_keyloc varchar(16),
hpl_keyims varchar(5),
hpl_tipplz varchar(3) not null,
hpl_tipcon varchar(1) not null,
hpl_contra varchar(1) not null,
hpl_fecini timestamp(0),
hpl_fecfin timestamp(0),
hpl_turnop numeric(5),
hpl_keyhor varchar(16),
hpl_keyemp numeric(10),
hpl_cveuoc numeric(10),
hpl_titula numeric(10),
hpl_cverem numeric(10),
hpl_status varchar(1),
hpl_keymot varchar(6),
hpl_fecmov timestamp(0),
hpl_hormov varchar(8),
hpl_cosplz decimal(14,2),
hpl_keysue varchar(4),
hpl_tiptab varchar(2),
hpl_sueniv numeric(10),
hpl_subniv numeric(10),
hpl_cobert varchar(2),
hpl_fecocu timestamp(0),
hpl_salplz decimal(14,2),
hpl_origen varchar(6),
hpl_codocu varchar(6),
hpl_limocu timestamp(0),
hpl_tipope varchar(2),
hpl_ca1aux varchar(10),
hpl_ca2aux varchar(10),
hpl_ca3aux varchar(10),
hpl_ca4aux varchar(10),
hpl_ca5aux varchar(10),
hpl_ca6aux varchar(10),
hpl_ca7aux varchar(10),
hpl_ca8aux varchar(10)
) server  options(schema 'LABCONF', table 'EOLOHPLZ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eolomvpz (
mpz_keyplz numeric(10) not null,
mpz_keysol numeric(10) not null,
mpz_keyest varchar(3),
mpz_keydep varchar(16),
mpz_keypue varchar(16),
mpz_tipmov varchar(2),
mpz_desmov varchar(60),
mpz_fecmov timestamp(0),
mpz_ca1aux varchar(10),
mpz_ca2aux varchar(10),
mpz_ca3aux varchar(10),
mpz_ca4aux varchar(10)
) server  options(schema 'LABCONF', table 'EOLOMVPZ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eoloorgn (
org_keyorg varchar(3),
org_desorg varchar(40),
org_tiporg varchar(1)
) server  options(schema 'LABCONF', table 'EOLOORGN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eoloplan (
pla_keyest varchar(3),
pla_keydep varchar(16),
pla_keypue varchar(16),
pla_keysue varchar(4),
pla_sueniv numeric(38),
pla_subniv numeric(38),
pla_cobert varchar(2),
pla_plzocu numeric(38),
pla_tiptab varchar(2),
pla_cospla decimal(14,2),
pla_plz001 numeric(38),
pla_plz002 numeric(38),
pla_plz003 numeric(38),
pla_plz004 numeric(38),
pla_plz005 numeric(38),
pla_plz006 numeric(38),
pla_plz007 numeric(38),
pla_plz008 numeric(38),
pla_plz009 numeric(38),
pla_plz010 numeric(38),
pla_co1aux decimal(14,2),
pla_co2aux decimal(14,2),
pla_co3aux decimal(14,2),
pla_co4aux decimal(14,2),
pla_co5aux decimal(14,2),
pla_ca1aux varchar(10),
pla_ca2aux varchar(10),
pla_ca3aux varchar(10),
pla_ca4aux varchar(10),
pla_ca5aux varchar(10)
) server  options(schema 'LABCONF', table 'EOLOPLAN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eoloreca (
rec_keycat varchar(16),
rec_cvereq varchar(2),
rec_nu1aux varchar(10),
rec_nu2aux varchar(10),
rec_nu3aux varchar(10)
) server  options(schema 'LABCONF', table 'EOLORECA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eoloreor (
reo_keyorg varchar(3),
reo_keyplz numeric(10),
reo_keydep varchar(16),
reo_padplz numeric(10),
reo_paddep varchar(16),
reo_codniv varchar(80),
reo_pesesp numeric(5),
reo_numniv numeric(5),
reo_tipplz varchar(1),
reo_keypue varchar(16),
reo_claplz varchar(1),
reo_keysol numeric(10)
) server  options(schema 'LABCONF', table 'EOLOREOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eolosolc (
sol_keysol numeric(10) not null,
sol_keyest varchar(3) not null,
sol_keydep varchar(16) not null,
sol_keypue varchar(16),
sol_keypro numeric(5),
sol_keyusu numeric(10),
sol_tipplz varchar(3) not null,
sol_tipcon varchar(1) not null,
sol_contra varchar(3) not null,
sol_canpla numeric(5),
sol_cansol numeric(5),
sol_canaut numeric(5),
sol_fecini timestamp(0),
sol_fecfin timestamp(0),
sol_fecpla timestamp(0),
sol_fecsol timestamp(0),
sol_fecaut timestamp(0),
sol_status varchar(1),
sol_keysue varchar(4),
sol_tiptab varchar(2),
sol_sueniv numeric(10),
sol_subniv numeric(10),
sol_cobert varchar(2),
sol_unimed varchar(1),
sol_canmed decimal(14,2),
sol_estman varchar(1),
sol_ca1aux varchar(10),
sol_ca2aux varchar(10),
sol_ca3aux varchar(10),
sol_ca4aux varchar(10),
sol_ca5aux varchar(10),
sol_ca6aux varchar(10),
sol_ca7aux varchar(10),
sol_ca8aux varchar(10),
sol_cantid numeric(5)
) server  options(schema 'LABCONF', table 'EOLOSOLC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table eolotplz (
tpl_numsec numeric(5) not null,
tpl_tipplz varchar(2) not null,
tpl_descri varchar(40) not null,
tpl_dessec varchar(20),
tpl_catego varchar(1),
tpl_keypro numeric(5) not null
) server  options(schema 'LABCONF', table 'EOLOTPLZ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcoacar (
aca_keyusu numeric(38) options (key 'true') not null,
aca_keyapr varchar(6) options (key 'true') not null,
aca_keypro numeric(38) options (key 'true') not null,
aca_actual varchar(1)
) server  options(schema 'LABCONF', table 'GLCOACAR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcoargu (
arg_idepro varchar(10),
arg_idepcc varchar(15),
arg_keyusu numeric(10),
arg_fecini timestamp(0),
arg_horini varchar(8),
arg_pvalor varchar(100),
arg_keycam varchar(10),
arg_descam varchar(40)
) server  options(schema 'LABCONF', table 'GLCOARGU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcobatc (
bat_idepro varchar(10),
bat_idepcc varchar(15),
bat_keyusu numeric(10),
bat_fecini timestamp(0),
bat_horini varchar(8),
bat_logusu varchar(15),
bat_keymen varchar(4),
bat_status varchar(1),
bat_valpro varchar(5),
bat_keynom numeric(5)
) server  options(schema 'LABCONF', table 'GLCOBATC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcobiny (
bin_keybin varchar(8) not null,
bin_desbin varchar(40),
bin_idefun varchar(30),
bin_idever varchar(15),
bin_perfil varchar(50)
) server  options(schema 'LABCONF', table 'GLCOBINY', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcobita (
bit_keyusu numeric(10),
bit_logusu varchar(15),
bit_idepcc varchar(15),
bit_fecmov timestamp(0),
bit_hormov varchar(8),
bit_tipmov varchar(2),
bit_key001 varchar(18),
bit_key002 varchar(18),
bit_key003 varchar(18),
bit_val001 varchar(18),
bit_val002 varchar(18),
bit_val003 varchar(18),
bit_desmen varchar(43),
bit_ideniv numeric(5)
) server  options(schema 'LABCONF', table 'GLCOBITA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcocamp (
cam_keytab varchar(18),
cam_keycam varchar(18),
cam_descam varchar(46),
cam_desaux varchar(46),
cam_descor varchar(15),
cam_valcam varchar(12)
) server  options(schema 'LABCONF', table 'GLCOCAMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcocorp (
cor_razsoc varchar(60),
cor_licper numeric,
cor_idhost varchar(16),
cor_basdat varchar(20),
cor_sisope varchar(20),
cor_descri varchar(60)
) server  options(schema 'LABCONF', table 'GLCOCORP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcodats (
dat_keymen varchar(4),
dat_idecam varchar(6),
dat_valore varchar(10)
) server  options(schema 'LABCONF', table 'GLCODATS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcodeco (
dco_razsoc varchar(60),
dco_numlic numeric(38),
dco_idenpc varchar(16),
dco_sisope varchar(20),
dco_fecreg timestamp(0),
dco_cvelic varchar(25)
) server  options(schema 'LABCONF', table 'GLCODECO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcodetb (
det_keyusu numeric(10),
det_fecmov timestamp(0),
det_hormov varchar(8),
det_keytab varchar(18),
det_keycam varchar(18),
det_valant varchar(47),
det_valact varchar(46)
) server  options(schema 'LABCONF', table 'GLCODETB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcodocd (
dod_keydoc numeric(10),
dod_numsec numeric(5),
dod_descri varchar(100)
) server  options(schema 'LABCONF', table 'GLCODOCD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcodocu (
doc_keydoc numeric(10),
doc_keytab varchar(18),
doc_campo1 varchar(16),
doc_campo2 varchar(16),
doc_keyuno varchar(16),
doc_keydos varchar(16),
doc_fecact timestamp(0),
doc_keyusu numeric(10)
) server  options(schema 'LABCONF', table 'GLCODOCU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcoerro (
mer_keyerr varchar(16),
mer_tiperr varchar(3),
mer_dessis varchar(125),
mer_desusu varchar(125),
mer_ayuerr varchar(250),
mer_titmos varchar(25),
mer_botmos numeric(10),
mer_icomos numeric(10),
mer_arcayu varchar(20),
mer_contex varchar(16),
mer_valdev numeric(5)
) server  options(schema 'LABCONF', table 'GLCOERRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcoeven (
eve_ideper varchar(2),
eve_desper varchar(20),
eve_defaul varchar(2)
) server  options(schema 'LABCONF', table 'GLCOEVEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcofmts (
fmt_keyfmt varchar(10),
fmt_des001 varchar(40),
fmt_des002 varchar(40),
fmt_des003 varchar(40),
fmt_keytab varchar(18),
fmt_key001 varchar(18),
fmt_key002 varchar(18),
ftm_despl1 varchar(18),
fmt_despl2 varchar(18),
fmt_cam001 varchar(18),
fmt_val001 varchar(16),
fmt_cam002 varchar(18),
fmt_val002 varchar(16),
fmt_keycia varchar(2),
fmt_fecact timestamp(0),
fmt_keyusu numeric(10),
fmt_horact varchar(8),
fmt_idepcc varchar(15)
) server  options(schema 'LABCONF', table 'GLCOFMTS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcofval (
fva_keyfmt varchar(10),
fva_val001 varchar(16),
fva_val002 varchar(16),
fva_keyent varchar(14),
fva_valent varchar(255),
fva_numren numeric(5),
fva_numcol numeric(5)
) server  options(schema 'LABCONF', table 'GLCOFVAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcohipa (
hip_keyusu numeric(10) not null,
hip_numsec numeric(10),
hip_fecpas timestamp(0),
hip_cveusu varchar(10)
) server  options(schema 'LABCONF', table 'GLCOHIPA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcojoin (
joi_tabori varchar(18),
joi_cmpori varchar(18),
joi_tabdes varchar(18),
joi_cmpdes varchar(18)
) server  options(schema 'LABCONF', table 'GLCOJOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcolist (
lis_keylis varchar(12),
lis_deslis varchar(50)
) server  options(schema 'LABCONF', table 'GLCOLIST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcomage (
ima_keyemp numeric(10),
ima_keygen varchar(16),
ima_tipima varchar(3),
ima_imagen bytea,
ima_longit numeric(10),
ima_format varchar(5)
) server  options(schema 'LABCONF', table 'GLCOMAGE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcomenu (
men_keymen varchar(4) not null,
men_ideniv numeric(5),
men_numsec numeric(5),
men_gpomen varchar(4),
men_tipmen varchar(1),
men_permis numeric(5),
men_mengpo varchar(4),
men_keybin varchar(8),
men_perfil varchar(40),
men_descri varchar(35),
men_modulo varchar(2)
) server  options(schema 'LABCONF', table 'GLCOMENU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcomoti (
mot_keymot varchar(6) not null,
mot_desmot varchar(60),
mot_modulo varchar(16),
mot_motsup varchar(6),
mot_keyusu numeric(5),
mot_feccap timestamp(0),
mot_ca1aux varchar(10),
mot_ca2aux varchar(10)
) server  options(schema 'LABCONF', table 'GLCOMOTI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcopams (
pam_keypar varchar(4),
pam_cvesec varchar(6),
pam_nompar varchar(200),
pam_folini varchar(100),
pam_folfin varchar(100)
) server  options(schema 'LABCONF', table 'GLCOPAMS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcoreca (
rec_keymen varchar(4),
rec_keytab varchar(18),
rec_keycam varchar(18),
rec_actual varchar(1),
rec_despli varchar(1)
) server  options(schema 'LABCONF', table 'GLCORECA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcoresu (
res_idepro varchar(10),
res_idepcc varchar(15),
res_keyusu numeric(10),
res_fecini timestamp(0),
res_fecfin timestamp(0),
res_horini varchar(8),
res_horfin varchar(8),
res_horreg varchar(8),
res_numreg numeric(10),
res_totreg numeric(10),
res_status varchar(1),
res_sqlerr numeric(10),
res_isaerr numeric(10),
res_deserr varchar(2000)
) server  options(schema 'LABCONF', table 'GLCORESU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcoseda (
sed_col001 varchar(60),
sed_col002 varchar(60),
sed_col003 varchar(60),
sed_col004 varchar(60),
sed_col005 varchar(60),
sed_col006 varchar(60),
sed_col007 varchar(60),
sed_col008 varchar(60),
sed_col009 varchar(60),
sed_col010 varchar(60),
sed_col011 varchar(60),
sed_col012 varchar(60),
sed_col013 varchar(60),
sed_col014 varchar(60),
sed_col015 varchar(60),
sed_col016 varchar(60),
sed_col017 varchar(60),
sed_col018 varchar(60),
sed_col019 varchar(60),
sed_col020 varchar(60)
) server  options(schema 'LABCONF', table 'GLCOSEDA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcoswit (
swi_keytab varchar(18),
swi_keycam varchar(18),
swi_numsec numeric(5),
swi_deswsi varchar(40)
) server  options(schema 'LABCONF', table 'GLCOSWIT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcotabl (
tab_keytab varchar(18),
tab_destab varchar(50)
) server  options(schema 'LABCONF', table 'GLCOTABL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glcousua (
usu_keyusu numeric(10) not null,
usu_nomusu varchar(40) not null,
usu_keyest varchar(3),
usu_keydep varchar(16),
usu_fecalt timestamp(0),
usu_horalt varchar(5),
usu_cveusu varchar(64),
usu_keymen varchar(4),
usu_masopc varchar(10),
usu_status varchar(1),
usu_acceso timestamp(0),
usu_passwd timestamp(0),
usu_fecdur numeric(10),
usu_tipusu varchar(1),
usu_permen varchar(1)
) server  options(schema 'LABCONF', table 'GLCOUSUA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glwkcri (
cry_chr001 varchar(60),
cry_chr002 varchar(60),
cry_chr004 varchar(60),
cry_chr005 varchar(60),
cry_chr012 varchar(16),
cry_chr013 varchar(16),
cry_chr014 varchar(16),
cry_chr017 varchar(8),
cry_chr018 varchar(8),
cry_dec003 decimal(18,6),
cry_dec006 numeric(10),
cry_dec007 numeric(10),
cry_dec008 numeric(10),
c_hed numeric,
i_hed numeric,
c_het numeric,
i_het numeric,
c_do numeric,
i_do numeric,
c_dt numeric,
i_dt numeric,
c_pd numeric,
i_pd numeric,
i_ot numeric,
i_in numeric,
i_pa numeric,
i_vi numeric,
i_su numeric,
i_ay numeric,
i_ap numeric,
i_cu numeric,
i_co numeric,
i_at numeric,
i_ga numeric,
i_cr numeric,
i_ctnm numeric
) server  options(schema 'LABCONF', table 'GLWKCRI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glwkcrys (
cry_nomrep varchar(10),
cry_idepcc varchar(15),
cry_keyusu numeric(10),
cry_numsec numeric(10),
cry_chr001 varchar(60),
cry_chr002 varchar(60),
cry_chr003 varchar(60),
cry_chr004 varchar(60),
cry_chr005 varchar(60),
cry_chr006 varchar(60),
cry_chr007 varchar(60),
cry_chr008 varchar(60),
cry_chr009 varchar(60),
cry_chr010 varchar(60),
cry_chr011 varchar(60),
cry_chr012 varchar(16),
cry_chr013 varchar(16),
cry_chr014 varchar(16),
cry_chr015 varchar(16),
cry_chr016 varchar(16),
cry_chr017 varchar(8),
cry_chr018 varchar(8),
cry_chr019 varchar(8),
cry_chr020 varchar(8),
cry_chr021 varchar(8),
cry_chr022 varchar(8),
cry_chr023 varchar(8),
cry_chr024 varchar(8),
cry_chr025 varchar(8),
cry_chr026 varchar(8),
cry_chr027 varchar(8),
cry_chr028 varchar(8),
cry_chr029 varchar(8),
cry_chr030 varchar(8),
cry_chr031 varchar(8),
cry_chr032 varchar(8),
cry_chr033 varchar(8),
cry_chr034 varchar(8),
cry_chr035 varchar(8),
cry_chr036 varchar(8),
cry_chr037 varchar(8),
cry_chr038 varchar(8),
cry_chr039 varchar(8),
cry_chr040 varchar(8),
cry_chr041 varchar(8),
cry_chr042 varchar(8),
cry_chr043 varchar(8),
cry_chr044 varchar(8),
cry_chr045 varchar(8),
cry_dat001 timestamp(0),
cry_dat002 timestamp(0),
cry_dat003 timestamp(0),
cry_dat004 timestamp(0),
cry_dat005 timestamp(0),
cry_dec001 decimal(18,6),
cry_dec002 decimal(18,6),
cry_dec003 decimal(18,6),
cry_dec004 decimal(18,6),
cry_dec005 decimal(18,6),
cry_dec006 numeric(10),
cry_dec007 numeric(10),
cry_dec008 numeric(10),
cry_dec009 numeric(10),
cry_dec010 numeric(10),
cry_dec011 decimal(14,2),
cry_dec012 decimal(14,2),
cry_dec013 decimal(14,2),
cry_dec014 decimal(14,2),
cry_dec015 decimal(14,2),
cry_dec016 decimal(14,2),
cry_dec017 decimal(14,2),
cry_dec018 decimal(14,2),
cry_dec019 decimal(14,2),
cry_dec020 decimal(14,2),
cry_dec021 decimal(14,2),
cry_dec022 decimal(14,2),
cry_dec023 decimal(14,2),
cry_dec024 decimal(14,2),
cry_dec025 decimal(14,2)
) server  options(schema 'LABCONF', table 'GLWKCRYS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glwkplem (
ple_keyemp numeric(38),
ple_keydep varchar(16),
ple_keypue varchar(16),
ple_keycen varchar(16),
ple_keycat varchar(16),
ple_nomemp varchar(60),
ple_nomcor varchar(20),
ple_domemp varchar(60),
ple_colemp varchar(40),
ple_cidemp varchar(20),
ple_pobemp varchar(20),
ple_munemp varchar(6),
ple_entemp varchar(2),
ple_codemp varchar(5),
ple_telemp varchar(10),
ple_regrfc varchar(13),
ple_recurp varchar(18),
ple_regims varchar(12),
ple_reginf varchar(12),
ple_cvesex varchar(1),
ple_keyims varchar(5),
ple_cvezon numeric(38),
ple_keypro numeric(38),
ple_cvetur numeric(38),
ple_tipemp varchar(6),
ple_tipsal varchar(1),
ple_status numeric(38),
ple_salhor decimal(12,6),
ple_saldia decimal(12,6),
ple_salmes decimal(12,2),
ple_salint decimal(12,6),
ple_salivc decimal(12,6),
ple_salinf decimal(12,6),
ple_intsin decimal(12,6),
ple_infsin decimal(12,6),
ple_varims decimal(12,6),
ple_varinf decimal(12,6),
ple_anthor decimal(12,6),
ple_antdia decimal(12,6),
ple_antmes decimal(12,6),
ple_antint decimal(12,6),
ple_antivc decimal(12,6),
ple_antinf decimal(12,6),
ple_antits decimal(12,6),
ple_antifs decimal(12,6),
ple_refcon varchar(20),
ple_cveban varchar(7),
ple_ctaban varchar(16),
ple_forpag varchar(2),
ple_diades numeric(38),
ple_numliq varchar(6),
ple_keyloc varchar(16),
ple_fecing timestamp(0),
ple_fecrei timestamp(0),
ple_fecven timestamp(0),
ple_fecpla timestamp(0),
ple_fecaum timestamp(0),
ple_peraum varchar(7),
ple_fecbaj timestamp(0),
ple_cvebaj varchar(4),
ple_jorlab varchar(1),
ple_unijor decimal(4,2),
ple_pering varchar(7),
ple_perbaj varchar(7),
ple_perdep varchar(7),
ple_perpue varchar(7),
ple_percat varchar(7),
ple_perpro varchar(7),
ple_fecaux timestamp(0),
ple_ca1aux varchar(10),
ple_ca2aux varchar(10),
ple_ca3aux varchar(10),
ple_ca4aux varchar(10),
ple_pctbec decimal(5,2),
ple_submov varchar(6),
ple_tipmov varchar(2),
ple_fectra timestamp(0),
ple_catego varchar(1),
ple_keyest varchar(3),
ple_keyplz numeric(38),
ple_tippla varchar(2),
ple_fecini timestamp(0),
ple_fecfin timestamp(0),
ple_diavig numeric(38),
ple_keyhor varchar(16),
ple_cveocu numeric(38),
ple_cverem numeric(38),
ple_fecmov timestamp(0),
ple_cosplz decimal(14,2),
ple_cp1aux varchar(16),
ple_cp2aux varchar(16),
ple_cp3aux varchar(16),
ple_nu1aux varchar(10),
ple_nu2aux varchar(10),
ple_nu3aux varchar(10),
ple_fe1aux varchar(10),
ple_fe2aux varchar(10),
ple_fe3aux timestamp(0),
ple_co1aux decimal(14,2),
ple_co2aux decimal(14,2),
ple_co3aux decimal(14,2),
ple_co4aux decimal(14,2),
ple_co5aux decimal(14,2),
ple_keysue varchar(4),
ple_sueniv numeric(38),
ple_subniv numeric(38),
ple_cobert varchar(2),
ple_keydpl decimal(16,6),
ple_fecocu timestamp(0),
ple_salplz decimal(12,6),
ple_titula numeric(38),
ple_origen varchar(2),
ple_valimp varchar(2),
ple_limocu timestamp(0),
ple_tiptab varchar(2),
ple_keyple decimal(16,6),
ple_stapro varchar(80),
ple_actprg varchar(3),
ple_keysoe varchar(10),
ple_keysoc varchar(10),
ple_keyreq varchar(10),
ple_cancon numeric(38),
ple_fecmod timestamp(0),
ple_hormod varchar(8),
ple_fecalt timestamp(0),
ple_bajfec timestamp(0),
ple_fecsal timestamp(0),
ple_perpag varchar(7),
ple_inifec timestamp(0),
ple_finfec timestamp(0)
) server  options(schema 'LABCONF', table 'GLWKPLEM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table glwkrang (
ran_nomrep varchar(10),
ran_idepcc varchar(15),
ran_keyusu numeric(10),
ran_keypro numeric(5),
ran_keyemp numeric(10),
ran_keycon varchar(3),
ran_keyper varchar(7),
ran_keydep varchar(16),
ran_keypue varchar(16),
ran_keynom numeric(5),
ran_keycat varchar(16),
ran_keycen varchar(16)
) server  options(schema 'LABCONF', table 'GLWKRANG', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table hist_datos (
hid_anio numeric(38) options (key 'true') not null,
hid_mes numeric(38) options (key 'true') not null,
hid_keypro numeric(38) options (key 'true') not null,
hid_keyemp numeric(38) options (key 'true') not null,
hid_keydep varchar(16),
hid_tpoemp numeric(38),
hid_vicrh varchar(16),
hid_viccon varchar(16),
hid_keyplz numeric(38),
hid_keypue varchar(16)
) server  options(schema 'LABCONF', table 'HIST_DATOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlocuem (
cue_keyemp numeric(5),
cue_rfcemp varchar(14),
cue_fecdis timestamp(0),
cue_keycur varchar(8),
cue_keygpo numeric(5),
cue_status varchar(2),
cue_fecsta timestamp(0),
cue_ca1aux varchar(10),
cue_ca2aux varchar(10),
cue_ca3aux varchar(10)
) server  options(schema 'LABCONF', table 'INLOCUEM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlocufc (
cuf_keycur varchar(8),
cuf_tipfte varchar(1),
cuf_keyemp numeric(5),
cuf_rfcfte varchar(14),
cuf_durcur varchar(5),
cuf_cos001 decimal(10,2),
cuf_cos002 decimal(10,2),
cuf_cos003 decimal(10,2)
) server  options(schema 'LABCONF', table 'INLOCUFC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlocupu (
cup_keypue varchar(16),
cup_keycur varchar(8)
) server  options(schema 'LABCONF', table 'INLOCUPU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlocurs (
cur_keycur varchar(8),
cur_descur varchar(40),
cur_descor varchar(16),
cur_tipcur varchar(2),
cur_subtip varchar(3),
cur_fecvig timestamp(0),
cur_objesp varchar(1),
cur_objgen varchar(1),
cur_observ varchar(40),
cur_nu1aux varchar(10),
cur_nu2aux varchar(10),
cur_nu3aux varchar(10)
) server  options(schema 'LABCONF', table 'INLOCURS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlodgpo (
dgp_keygpo numeric(5),
dgp_keycur varchar(8),
dgp_keyemp numeric(5),
dgp_rfcemp varchar(14),
dgp_tipasi varchar(6),
dgp_fecalt timestamp(0),
dgp_obseva varchar(1),
dgp_obscur varchar(1),
dgp_obsins varchar(1),
dgp_cveapr varchar(6),
dgp_status varchar(2),
dgp_fecsta timestamp(0)
) server  options(schema 'LABCONF', table 'INLODGPO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlodnca (
nca_keypca numeric(5),
nca_keyeta numeric(5),
nca_feccap timestamp(0),
nca_keyemp numeric(5),
nca_keydep varchar(16),
nca_keypue varchar(16),
nca_keypro numeric(5),
nca_keycur varchar(8),
nca_keysup numeric(5),
nca_cvesta varchar(6),
nca_codreq varchar(6),
nca_pricap varchar(6),
nca_intext varchar(2),
nca_cveins varchar(14),
nca_keygpo varchar(4),
nca_fecini timestamp(0),
nca_status varchar(2),
nca_fecact timestamp(0),
nca_obs001 varchar(50)
) server  options(schema 'LABCONF', table 'INLODNCA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlodwor (
dwo_keywor varchar(4),
dwo_numsec numeric(5),
dwo_tipdat varchar(1),
dwo_funcio varchar(2),
dwo_format varchar(30),
dwo_valorw varchar(60),
dwo_numsql numeric(5),
dwo_seccmp numeric(5)
) server  options(schema 'LABCONF', table 'INLODWOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlodwsq (
dws_keywor varchar(4),
dws_numsql numeric(5),
dws_numsec numeric(5),
dws_sqlaso numeric(5),
dws_seccmp numeric(5),
dws_descmp varchar(20)
) server  options(schema 'LABCONF', table 'INLODWSQ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inloetap (
eta_keypca numeric(5),
eta_keycia varchar(2),
eta_keyeta numeric(5),
eta_fecini timestamp(0),
eta_fecfin timestamp(0)
) server  options(schema 'LABCONF', table 'INLOETAP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inloevem (
vem_keyemp numeric(5),
vem_rfcemp varchar(14),
vem_keygpo numeric(5),
vem_keycur varchar(8),
vem_cvesec varchar(6),
vem_valeva decimal(5,2),
vem_feceva timestamp(0),
vem_tipeva varchar(1),
vem_status varchar(2),
vem_fecsta timestamp(0)
) server  options(schema 'LABCONF', table 'INLOEVEM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlofcap (
fca_keyfte varchar(13),
fca_tipfte varchar(1),
fca_nomfte varchar(40),
fca_domfte varchar(40),
fca_colfte varchar(20),
fca_cidfte varchar(20),
fca_munfte varchar(6),
fca_entfte varchar(2),
fca_codfte varchar(5),
fca_telfte varchar(30),
fca_faxfte varchar(30),
fca_con001 varchar(40),
fca_con002 varchar(40),
fca_con003 varchar(40),
fca_cli001 varchar(20),
fca_cli002 varchar(20),
fca_cli003 varchar(20),
fca_regsec varchar(20),
fca_ca1aux varchar(10),
fca_ca2aux varchar(10),
fca_ca3aux varchar(10)
) server  options(schema 'LABCONF', table 'INLOFCAP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlogpos (
gpo_keygpo numeric(5),
gpo_keycur varchar(8),
gpo_fecini timestamp(0),
gpo_fecfin timestamp(0),
gpo_tipfte varchar(1),
gpo_rfcfte varchar(14),
gpo_nomfte varchar(40),
gpo_keyemp numeric(5),
gpo_cupcur numeric(5),
gpo_obs001 varchar(50),
gpo_obs002 varchar(50),
gpo_obs003 varchar(50),
gpo_cos001 decimal(10,2),
gpo_cos002 decimal(10,2),
gpo_cos003 decimal(10,2),
gpo_status varchar(2),
gpo_fecsta timestamp(0),
gpo_keypgr numeric(5),
gpo_cveemp varchar(2),
gpo_numpla numeric(5),
gpo_numeta numeric(5),
gpo_rfcins varchar(13)
) server  options(schema 'LABCONF', table 'INLOGPOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlohigr (
hig_keycur varchar(8),
hig_keygpo numeric(5),
hig_durcur varchar(5),
hig_fecini timestamp(0),
hig_fecfin timestamp(0),
hig_tipfte varchar(1),
hig_rfcfte varchar(14),
hig_evains decimal(5,2),
hig_coscur decimal(10,2),
hig_status varchar(2)
) server  options(schema 'LABCONF', table 'INLOHIGR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlohisc (
inh_keyemp numeric(5),
inh_rfcemp varchar(14),
inh_keypro numeric(5),
inh_keydep varchar(16),
inh_keypue varchar(16),
inh_keycur varchar(8),
inh_keygpo varchar(4),
inh_cosalm decimal(10,2),
inh_evaalm decimal(5,2),
inh_evacur decimal(5,2),
inh_evains decimal(5,2),
inh_cveapr varchar(6),
inh_tipasi varchar(6)
) server  options(schema 'LABCONF', table 'INLOHISC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlohogr (
hog_keygpo numeric(5),
hog_keycur varchar(8),
hog_keylug varchar(8),
hog_fecdia timestamp(0),
hog_horini varchar(5),
hog_horfin varchar(5),
hog_status varchar(1),
hog_fecsta timestamp(0)
) server  options(schema 'LABCONF', table 'INLOHOGR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inloineq (
ine_keyequ varchar(16),
ine_desequ varchar(40),
ine_marca varchar(20),
ine_modelo varchar(20),
ine_numser varchar(16),
ine_status varchar(6),
ine_fecsta timestamp(0),
ine_ca1aux varchar(10),
ine_ca2aux varchar(10),
ine_ca3aux varchar(10),
ine_ca4aux varchar(10)
) server  options(schema 'LABCONF', table 'INLOINEQ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inloinst (
ins_keyfte varchar(13),
ins_keyins varchar(13),
ins_keyemp numeric(5),
ins_nomins varchar(40)
) server  options(schema 'LABCONF', table 'INLOINST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlokard (
kar_keyemp numeric(5),
kar_keycur varchar(8),
kar_keygpo numeric(5),
kar_keydep varchar(16),
kar_keypue varchar(16),
kar_califi decimal(8,4),
kar_aproba varchar(1),
kar_horcur varchar(5),
kar_keyfte varchar(13),
kar_fecact timestamp(0),
kar_horact varchar(8)
) server  options(schema 'LABCONF', table 'INLOKARD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlolugs (
lug_keylug varchar(8),
lug_nomlug varchar(40),
lug_nomcor varchar(20),
lug_nomcon varchar(30),
lug_domlug varchar(30),
lug_collug varchar(20),
lug_cidlug varchar(20),
lug_munlug varchar(6),
lug_entlug varchar(2),
lug_codlug varchar(5),
lug_tellug varchar(30),
lug_costo1 decimal(10,2),
lug_costo2 decimal(10,2),
lug_costo3 decimal(10,2),
lug_unicos varchar(6),
lug_abrlug varchar(5),
lug_cielug varchar(5),
lug_diahab varchar(20),
lug_faxlug varchar(30),
lug_ca1aux varchar(10),
lug_ca2aux varchar(10),
lug_ca3aux varchar(10)
) server  options(schema 'LABCONF', table 'INLOLUGS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlomacu (
mac_keycur varchar(8),
mac_keymat varchar(6),
mac_cantid decimal(10,2)
) server  options(schema 'LABCONF', table 'INLOMACU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlomoeq (
moe_keyequ varchar(16),
moe_fecsol timestamp(0),
moe_keydep varchar(16),
moe_keyloc varchar(16),
moe_keycen varchar(16),
moe_obspre varchar(60),
moe_status varchar(2),
moe_fecpro timestamp(0),
moe_fecdev timestamp(0),
moe_emprec numeric(5),
moe_empres numeric(5),
moe_obsdev varchar(60)
) server  options(schema 'LABCONF', table 'INLOMOEQ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlopcap (
pca_keypca numeric(5),
pca_keycia varchar(2),
pca_regpla varchar(25),
pca_fecini timestamp(0),
pca_fecfin timestamp(0),
pca_ca1aux varchar(10),
pca_ca2aux varchar(10),
pca_ca3aux varchar(10),
pca_tippla varchar(1)
) server  options(schema 'LABCONF', table 'INLOPCAP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlopgra (
pgr_keypgr numeric(5),
pgr_despgr varchar(30),
pgr_regpgr varchar(25),
pgr_tippgr varchar(1),
pgr_ca1aux varchar(10),
pgr_ca2aux varchar(10),
pgr_ca3aux varchar(10),
pgr_observ varchar(1),
pgr_keydep varchar(16),
pgr_keypue varchar(16)
) server  options(schema 'LABCONF', table 'INLOPGRA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inloppro (
ppr_keypca numeric(5),
ppr_keycia varchar(2),
ppr_keypgr numeric(5),
ppr_ca1aux varchar(10),
ppr_ca2aux varchar(10),
ppr_ca3aux varchar(10)
) server  options(schema 'LABCONF', table 'INLOPPRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inloprca (
prc_keycur varchar(8),
prc_keyprc numeric(5),
prc_ca1aux varchar(10),
prc_ca2aux varchar(10),
prc_ca3aux varchar(10)
) server  options(schema 'LABCONF', table 'INLOPRCA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inloword (
wor_keywor varchar(4),
wor_deswor varchar(40),
wor_docwor varchar(40)
) server  options(schema 'LABCONF', table 'INLOWORD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table inlowsql (
wsq_keywor varchar(4),
wsq_numsql numeric(38),
wsq_sqlsql varchar(2000)
) server  options(schema 'LABCONF', table 'INLOWSQL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table invinfo (
fund_id numeric,
inv varchar(40),
info varchar(500)
) server  options(schema 'LABCONF', table 'INVINFO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table invrequest (
ssn numeric,
fund_id numeric
) server  options(schema 'LABCONF', table 'INVREQUEST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table isnconf (
idconfig numeric(10),
con_anio numeric(4),
con_keyent varchar(2),
con_keycon varchar(3),
con_tipcon numeric(10),
con_tipope varchar(1)
) server  options(schema 'LABCONF', table 'ISNCONF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table isnentidades (
id numeric(10) not null,
ent_keyent varchar(2),
ent_desent varchar(70),
ent_porcen decimal(8,2),
ent_poradi decimal(8,2),
ent_keytab varchar(3),
ent_limeda numeric(4),
ent_anio numeric(4)
) server  options(schema 'LABCONF', table 'ISNENTIDADES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table isntotales (
isn_keyent varchar(2),
isn_keycia varchar(5),
isn_anio numeric(38),
isn_mes numeric(38),
isn_keyper varchar(7),
isn_porcen decimal(8,2),
isn_poradi decimal(8,2),
isn_keytab varchar(3),
isn_cuofij decimal(12,2),
isn_base decimal(12,2),
isn_totreg numeric(10),
isn_totemp numeric(10),
isn_impisn decimal(12,2),
isn_impadi decimal(12,2)
) server  options(schema 'LABCONF', table 'ISNTOTALES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table molocale (
cal_dborig numeric(5),
cal_dboper numeric(5),
cal_keycal numeric(5),
cal_anomes varchar(6),
cal_ultact timestamp(0),
cal_nivel varchar(2),
cal_valor varchar(16),
cal_cvetur numeric(5),
cal_tabcam varchar(20),
cal_diades varchar(7)
) server  options(schema 'LABCONF', table 'MOLOCALE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table moloconc (
con_dborig numeric(5),
con_dboper numeric(5),
con_keycon varchar(3),
con_descon varchar(50),
con_eqinom varchar(3),
con_tipcon varchar(1),
con_cardir varchar(20),
con_abodir varchar(20),
con_carind varchar(20),
con_aboind varchar(20),
con_proced varchar(10),
con_tipdia varchar(1),
con_frmenv varchar(1),
con_progra varchar(1),
con_valder varchar(1),
con_indmed varchar(1),
con_facpun varchar(1),
con_facasi varchar(1),
con_ca1aux varchar(10),
con_ca2aux varchar(10),
con_ca3aux varchar(10),
con_ca4aux varchar(10),
con_letkar varchar(1),
con_colkar varchar(12)
) server  options(schema 'LABCONF', table 'MOLOCONC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table molodcal (
dca_dborig numeric(5),
dca_dboper numeric(5),
dca_keycal numeric(5),
dca_fecdia timestamp(0),
dca_tipdia varchar(3),
dca_tabcam varchar(20),
dca_valor varchar(16)
) server  options(schema 'LABCONF', table 'MOLODCAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table molodiad (
dia_keyemp numeric(10),
dia_keycon varchar(10),
dia_diader numeric(10),
dia_fecini timestamp(0),
dia_feccad timestamp(0),
dia_diaant numeric(10),
dia_keyusu numeric(10),
dia_fecact timestamp(0)
) server  options(schema 'LABCONF', table 'MOLODIAD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table molotrpr (
trp_dborig numeric(5),
trp_dboper numeric(5),
trp_keyemp numeric(10),
trp_keycon varchar(3),
trp_fecini timestamp(0),
trp_fecfin timestamp(0),
trp_horini varchar(5),
trp_horfin varchar(5),
trp_duraci numeric(10),
trp_tipcon varchar(1),
trp_susreq varchar(1),
trp_import decimal(14,2),
trp_keypue varchar(16),
trp_keyplz numeric(5),
trp_keydep varchar(16),
trp_cvetur numeric(5),
trp_ca1aux varchar(10),
trp_ca2aux varchar(10),
trp_keytrp decimal(16,6),
trp_empsus numeric(10),
trp_depsus varchar(16),
trp_puesus varchar(16),
trp_tursus numeric(5),
trp_plzsus numeric(5),
trp_fecact timestamp(0),
trp_horact varchar(5),
trp_keyusu numeric(10),
trp_saldod numeric(10),
trp_keyjor varchar(4),
trp_keyhor varchar(16),
trp_salnom numeric(10),
trp_perini varchar(7),
trp_inccon varchar(1)
) server  options(schema 'LABCONF', table 'MOLOTRPR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table muconcen (
emp_keycen char(16),
emp_ca2aux char(10),
con_ctaref char(20),
his_keycon char(3),
con_descon char(30),
his_import decimal(10,2)
) server  options(schema 'LABCONF', table 'MUCONCEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nacimiento (
no_emp char(8),
nombre char(60),
importe decimal(18,6)
) server  options(schema 'LABCONF', table 'NACIMIENTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcalinci (
inc_keyper varchar(7),
inc_feclun timestamp(0),
inc_fecmar timestamp(0),
inc_fecmie timestamp(0),
inc_fecjue timestamp(0),
inc_fecvie timestamp(0),
inc_fecsab timestamp(0),
inc_fecdom timestamp(0)
) server  options(schema 'LABCONF', table 'NMCALINCI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcapims (
pim_numche varchar(20),
pim_fecche timestamp(0),
pim_keyban varchar(3),
pim_fecdep timestamp(0),
pim_ramche varchar(16),
pim_regims varchar(12),
pim_numinc varchar(14),
pim_recurp varchar(18),
pim_tipinc varchar(2),
pim_diasre numeric(38),
pim_imprec decimal(18,6),
pim_numpol varchar(10),
pim_observ varchar(50),
pim_impinc decimal(18,6),
pim_numpag numeric(38),
pim_diaant numeric(38),
pim_impant decimal(18,6),
pim_difere decimal(18,6),
pim_ca1aux varchar(20),
pim_ca2aux varchar(20),
pim_ca3aux varchar(20),
pim_ca4aux varchar(20),
pim_ca5aux varchar(20)
) server  options(schema 'LABCONF', table 'NMCAPIMS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcapinc (
inc_keyusu numeric(38) not null,
inc_keyemp numeric(38) not null,
inc_keysem numeric(38) not null,
inc_keyjor numeric(38) not null,
inc_keycco varchar(16) not null,
inc_feccap timestamp(0) not null,
inc_ddesc1 varchar(2),
inc_ddesc2 varchar(2),
inc_keypro numeric(38),
inc_xytech numeric(38)
) server  options(schema 'LABCONF', table 'NMCAPINC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcocvac (
vac_keyemp numeric(38) not null,
vac_antigu numeric(38) not null,
vac_diavac decimal(6,2),
vac_period varchar(10),
vac_fecini timestamp(0),
vac_fecfin timestamp(0),
vac_fecpre timestamp(0),
vac_dtomad decimal(6,2),
vac_salper decimal(6,2),
vac_status varchar(1),
vac_cosrea decimal(10,2)
) server  options(schema 'LABCONF', table 'NMCOCVAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcocval (
cva_nomvar varchar(3),
cva_keydep varchar(16),
cva_keyalt varchar(20)
) server  options(schema 'LABCONF', table 'NMCOCVAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcodeps (
dep_keydep varchar(16) not null,
dep_desdep varchar(47) not null,
dep_refcon varchar(52),
dep_keycen varchar(16),
dep_tipdep varchar(1),
dep_nu1aux varchar(10),
dep_nu2aux varchar(10),
dep_nu3aux varchar(10),
dep_nu4aux varchar(10),
dep_nu5aux varchar(10),
dep_ca1aux varchar(10),
dep_ca2aux varchar(10),
dep_ca3aux varchar(10),
dep_ca4aux varchar(10),
dep_ca5aux varchar(10)
) server  options(schema 'LABCONF', table 'NMCODEPS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcodfor (
for_keyfor varchar(16),
for_aplica varchar(1),
for_numsec numeric(5),
for_keytab varchar(8),
for_keycam varchar(16),
for_tipdat numeric(5),
for_tammax numeric(5),
for_format numeric(5),
for_alinea numeric(5),
for_renglo numeric(5),
for_column numeric(5),
for_imprim varchar(1),
for_parusu varchar(1),
for_camdep varchar(1),
for_condi1 varchar(20),
for_valco1 varchar(1),
for_condi2 varchar(20),
for_valco2 varchar(1),
for_entimp varchar(40),
for_sinimp varchar(40),
for_funcio varchar(6),
for_funca1 varchar(16),
for_funca2 varchar(16),
for_funnu1 numeric(5),
for_funnu2 numeric(5),
for_funtot varchar(6),
for_indtru varchar(1)
) server  options(schema 'LABCONF', table 'NMCODFOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcoempl_bak (
emp_keyemp numeric(10) not null,
emp_keydep varchar(16),
emp_keypue varchar(16),
emp_keycen varchar(16),
emp_keycat varchar(16),
emp_nomemp varchar(60) not null,
emp_nomcor varchar(20),
emp_domemp varchar(100),
emp_colemp varchar(100),
emp_cidemp varchar(20),
emp_pobemp varchar(20),
emp_munemp varchar(6),
emp_entemp varchar(2),
emp_codemp varchar(5),
emp_telemp varchar(60),
emp_regrfc varchar(13),
emp_recurp varchar(18),
emp_regims varchar(12),
emp_reginf varchar(12),
emp_cvesex varchar(1),
emp_keyims varchar(5),
emp_cvezon numeric(5),
emp_keypro numeric(5) not null,
emp_cvetur numeric(5),
emp_tipemp varchar(6),
emp_tipsal varchar(1),
emp_status numeric(5) not null,
emp_salhor decimal(12,6),
emp_saldia decimal(12,6),
emp_salmes decimal(12,2),
emp_salint decimal(12,6),
emp_salivc decimal(12,6),
emp_salinf decimal(12,6),
emp_intsin decimal(12,6),
emp_infsin decimal(12,6),
emp_varims decimal(12,6),
emp_varinf decimal(12,6),
emp_anthor decimal(12,6),
emp_antdia decimal(12,6),
emp_antmes decimal(12,2),
emp_antint decimal(12,6),
emp_antivc decimal(12,6),
emp_antinf decimal(12,6),
emp_antits decimal(12,6),
emp_antifs decimal(12,6),
emp_refcon varchar(20),
emp_cveban varchar(7),
emp_ctaban varchar(18),
emp_forpag varchar(2),
emp_diades numeric(5),
emp_numliq varchar(6),
emp_keyloc varchar(16),
emp_fecing timestamp(0),
emp_fecrei timestamp(0),
emp_fecven timestamp(0),
emp_fecpla timestamp(0),
emp_fecaum timestamp(0),
emp_peraum varchar(7),
emp_fecbaj timestamp(0),
emp_cvebaj varchar(4),
emp_jorlab varchar(1),
emp_unijor decimal(4,2),
emp_pering varchar(7),
emp_perbaj varchar(7),
emp_perdep varchar(7),
emp_perpue varchar(7),
emp_percat varchar(7),
emp_perpro varchar(7),
emp_fecaux timestamp(0),
emp_ca1aux varchar(10),
emp_ca2aux varchar(10),
emp_ca3aux varchar(10),
emp_ca4aux varchar(10),
emp_pctbec decimal(5,2),
emp_fecmod timestamp(0),
emp_hormod varchar(8),
emp_fecalt timestamp(0),
emp_bajfec timestamp(0),
emp_fecsal timestamp(0),
emp_perpag varchar(7),
emp_inifec timestamp(0),
emp_finfec timestamp(0),
emp_cobert varchar(2)
) server  options(schema 'LABCONF', table 'NMCOEMPL_BAK', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcoempl_sdw (
marca_act varchar(2),
cmd varchar(15),
old_emp_keyemp numeric(38),
old_emp_keydep varchar(16),
old_emp_keypue varchar(16),
old_emp_keycen varchar(16),
old_emp_nomemp varchar(60),
old_emp_regrfc varchar(13),
old_emp_recurp varchar(18),
old_emp_regims varchar(12),
old_emp_keypro numeric(38),
old_emp_status numeric(38),
old_emp_keyloc varchar(16),
old_emp_fecing timestamp(0),
old_emp_fecbaj timestamp(0),
old_emp_fecaux timestamp(0),
old_emp_ca2aux varchar(10),
new_emp_keyemp numeric(38),
new_emp_keydep varchar(16),
new_emp_keypue varchar(16),
new_emp_keycen varchar(16),
new_emp_nomemp varchar(60),
new_emp_regrfc varchar(13),
new_emp_recurp varchar(18),
new_emp_regims varchar(12),
new_emp_keypro numeric(38),
new_emp_status numeric(38),
new_emp_keyloc varchar(16),
new_emp_fecing timestamp(0),
new_emp_fecbaj timestamp(0),
new_emp_fecaux timestamp(0),
new_emp_ca2aux varchar(10),
orderid1 timestamp(0),
orderid2 numeric(10) options (key 'true') not null
) server  options(schema 'LABCONF', table 'NMCOEMPL_SDW', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcoestr (
est_nomvar varchar(3) not null,
est_nivjer numeric(5) not null,
est_cvecon varchar(20),
est_descri varchar(60) not null,
est_pref01 varchar(20),
est_pref02 varchar(20),
est_pref03 varchar(20),
est_pref04 varchar(20),
est_pref05 varchar(20)
) server  options(schema 'LABCONF', table 'NMCOESTR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcofalt (
fal_keyemp numeric(10) not null,
fal_fecini timestamp(0),
fal_fecexp timestamp(0),
fal_diainc numeric(38),
fal_coninc varchar(1),
fal_numinc varchar(14),
fal_tipims varchar(2),
fal_tipemp varchar(6),
fal_dianoa numeric(38),
fal_emiinc varchar(20),
fal_keyims varchar(5),
fal_codaux varchar(10),
fal_pertra varchar(7),
fal_contra varchar(3),
fal_perpag varchar(7),
fal_conpag varchar(3),
fal_recinc varchar(1),
fal_cirinc varchar(2),
fal_prorie varchar(1),
fal_tiprie varchar(1),
fal_tipdic varchar(1),
fal_porval decimal(6,2),
fal_folst1 numeric(38),
fal_folst2 numeric(38),
fal_folst3 numeric(38),
fal_folst4 numeric(38),
fal_codau2 varchar(10),
fal_codau3 varchar(10),
fal_codau4 varchar(10),
fal_codau5 varchar(10),
fal_keytrp decimal(16,6)
) server  options(schema 'LABCONF', table 'NMCOFALT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcoforp (
for_keyfor varchar(16),
for_desfor varchar(60),
for_renenc numeric(5),
for_rendet numeric(5),
for_rentot numeric(5),
for_renpie numeric(5),
for_column numeric(5),
for_numasc numeric(5),
for_totpag varchar(1),
for_ordena varchar(110),
for_keyusu numeric(10),
for_nomarc varchar(60)
) server  options(schema 'LABCONF', table 'NMCOFORP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcoinci (
inc_keyemp numeric(10) not null,
inc_keycon varchar(3) not null,
inc_keypro numeric(5) not null,
inc_keyper varchar(7) not null,
inc_keydep varchar(16),
inc_keypue varchar(16),
inc_fecmov timestamp(0) not null,
inc_cantid decimal(16,6),
inc_import decimal(12,2),
inc_diauno decimal(12,2),
inc_diados decimal(12,2),
inc_diatre decimal(12,2),
inc_diacua decimal(12,2),
inc_diacin decimal(12,2),
inc_diasei decimal(12,2),
inc_diasie decimal(12,2),
inc_keyinc decimal(16,6),
inc_numfol numeric(10)
) server  options(schema 'LABCONF', table 'NMCOINCI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmconcst (
cst_keycve numeric(38) not null,
cst_keycon char(3) not null
) server  options(schema 'LABCONF', table 'NMCONCST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcooana (
oan_nomvar varchar(3) not null,
oan_catalo varchar(10) not null,
oan_concep varchar(10) not null,
oan_alias numeric(5) not null,
oan_descri varchar(30) not null,
oan_nivjer numeric(5) not null,
oan_longit numeric(5) not null,
oan_pref01 numeric(5),
oan_pref02 numeric(5),
oan_pref03 numeric(5),
oan_pref04 numeric(5),
oan_pref05 numeric(5)
) server  options(schema 'LABCONF', table 'NMCOOANA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcopues (
pue_keypue varchar(16) not null,
pue_despue varchar(66) not null,
pue_refcon varchar(20),
pue_nu1aux varchar(10),
pue_nu2aux varchar(10),
pue_nu3aux varchar(10),
pue_nu4aux varchar(10),
pue_nu5aux varchar(10),
pue_ca1aux varchar(10),
pue_ca2aux varchar(10),
pue_ca3aux varchar(10),
pue_ca4aux varchar(10),
pue_ca5aux varchar(10),
pue_sueniv numeric(10),
pue_subniv numeric(10),
pue_keysue varchar(4),
pue_cobert varchar(2),
pue_arepue varchar(6),
pue_subare varchar(6),
pue_nivpue numeric(10),
pue_grppue varchar(16),
pue_subgrp varchar(16),
pue_tippue varchar(2)
) server  options(schema 'LABCONF', table 'NMCOPUES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcopvac (
pva_keypro numeric(38) not null,
pva_plapre decimal(4,2),
pva_connom varchar(3) not null,
pva_stapas varchar(1) not null
) server  options(schema 'LABCONF', table 'NMCOPVAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcorvac (
rva_keyemp numeric(38) options (key 'true') not null,
rva_antigu numeric(38) options (key 'true') not null,
rva_consec numeric(38) options (key 'true') not null,
rva_fecsol timestamp(0),
rva_period varchar(10),
rva_fecini timestamp(0),
rva_fecfin timestamp(0),
rva_diadis decimal(6,2),
rva_autori varchar(20),
rva_motivo varchar(18),
rva_keydep varchar(18),
rva_keycen varchar(18),
rva_numfol varchar(12),
rva_numusu numeric(38),
rva_feccap timestamp(0)
) server  options(schema 'LABCONF', table 'NMCORVAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcotarp (
arp_keyarp varchar(3),
arp_keyrep varchar(16),
arp_keytab varchar(8),
arp_keycam varchar(60),
arp_tabdep varchar(60),
arp_camdep varchar(60),
arp_tabapl varchar(1),
arp_tabpri varchar(2)
) server  options(schema 'LABCONF', table 'NMCOTARP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmcotvac (
ant_keypro varchar(1) not null,
ant_antigu numeric(38) not null,
ant_diavac numeric(38),
ant_facvac decimal(10,2)
) server  options(schema 'LABCONF', table 'NMCOTVAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmdescan (
des_nodes numeric(38) options (key 'true') not null,
des_desca1 char(16) not null,
des_desca2 char(16) not null
) server  options(schema 'LABCONF', table 'NMDESCAN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmdetinc (
inc_cvedia varchar(2),
inc_keyusu numeric(38),
inc_keyemp numeric(38),
inc_keysem numeric(38),
inc_ccosto varchar(16),
inc_horent varchar(5),
inc_horsal varchar(5),
inc_concep varchar(3),
inc_fecha timestamp(0),
inc_horas decimal(5,2),
inc_impor decimal(14,2),
inc_cveinc varchar(2),
inc_keypro numeric(38),
inc_keyper varchar(7)
) server  options(schema 'LABCONF', table 'NMDETINC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmencinc (
inc_keyusu numeric(38),
inc_keyemp numeric(38),
inc_keysem numeric(38),
inc_keyjor numeric(38),
inc_keycco varchar(16),
inc_feccap timestamp(0),
inc_ddesc1 varchar(2),
inc_ddesc2 varchar(2),
inc_keypro numeric(38),
inc_keyper varchar(7)
) server  options(schema 'LABCONF', table 'NMENCINC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmexeninci (
inc_keyemp numeric(38) not null,
inc_semana numeric(38) not null,
inc_keypro numeric(38) not null,
inc_keycon varchar(12) not null,
inc_exento decimal(12,2)
) server  options(schema 'LABCONF', table 'NMEXENINCI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmhisinc (
inc_keyusu numeric(38),
inc_feccap timestamp(0),
inc_keyemp numeric(38),
inc_keycon varchar(3),
inc_keycen varchar(16),
inc_keypue varchar(16),
inc_keycco varchar(16),
inc_cantid decimal(14,2),
inc_import decimal(14,2),
inc_keypro numeric(38),
inc_keyper varchar(7),
inc_costo decimal(14,2),
inc_semana numeric(38),
inc_sempro varchar(50)
) server  options(schema 'LABCONF', table 'NMHISINC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmhorast (
hor_nohor numeric(38) options (key 'true') not null,
hor_enthor1 char(5) not null,
hor_salhor1 char(5) not null,
hor_enthor2 char(5) not null,
hor_salhor2 char(5) not null
) server  options(schema 'LABCONF', table 'NMHORAST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmjorlab (
jor_keyjor numeric(38) options (key 'true') not null,
jor_hrsdia decimal(5,2) not null,
jor_hrssem decimal(5,2) not null
) server  options(schema 'LABCONF', table 'NMJORLAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloacum_bak (
acu_keyemp numeric(38) not null,
acu_keycon varchar(3) not null,
acu_keypro numeric(38),
acu_uniuno decimal(14,2),
acu_unidos decimal(14,2),
acu_unitre decimal(14,2),
acu_unicua decimal(14,2),
acu_unicin decimal(14,2),
acu_unisei decimal(14,2),
acu_unisie decimal(14,2),
acu_unioch decimal(14,2),
acu_uninue decimal(14,2),
acu_unidie decimal(14,2),
acu_unionc decimal(14,2),
acu_unidoc decimal(14,2),
acu_unitrc decimal(14,2),
acu_unicat decimal(14,2),
acu_uniqui decimal(14,2),
acu_impuno decimal(14,2),
acu_impdos decimal(14,2),
acu_imptre decimal(14,2),
acu_impcua decimal(14,2),
acu_impcin decimal(14,2),
acu_impsei decimal(14,2),
acu_impsie decimal(14,2),
acu_impoch decimal(14,2),
acu_impnue decimal(14,2),
acu_impdie decimal(14,2),
acu_imponc decimal(14,2),
acu_impdoc decimal(14,2),
acu_imptrc decimal(14,2),
acu_impcat decimal(14,2),
acu_impqui decimal(14,2),
acu_anioac numeric(4)
) server  options(schema 'LABCONF', table 'NMLOACUM_BAK', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloamor (
amo_keyemp numeric(10),
amo_keycon varchar(3),
amo_keypre decimal(16,6) not null,
amo_refere varchar(20),
amo_keypro numeric(5),
amo_keydep varchar(16),
amo_keypue varchar(16),
amo_keycat varchar(16),
amo_keyubi varchar(16),
amo_keyper varchar(7),
amo_keynom numeric(5),
amo_numpag numeric(5) not null,
amo_tiptra varchar(2),
amo_refpag varchar(10),
amo_fecpag timestamp(0),
amo_imppag decimal(12,2),
amo_unipag decimal(12,2),
amo_intpag decimal(12,2),
amo_porint decimal(6,4),
amo_conpro varchar(3),
amo_fecnom timestamp(0),
amo_ctreve varchar(16),
amo_ca1aux varchar(10),
amo_ca2aux varchar(10),
amo_uniope numeric(5)
) server  options(schema 'LABCONF', table 'NMLOAMOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloapov (
apo_keyemp numeric(10),
apo_tipmov varchar(1),
apo_fecmov timestamp(0),
apo_mesliq varchar(6),
apo_apovol decimal(12,6)
) server  options(schema 'LABCONF', table 'NMLOAPOV', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlobanc (
ban_keyban varchar(3) not null,
ban_desban varchar(30) not null,
ban_keysuc varchar(4) not null,
ban_dessuc varchar(30),
ban_cenreg varchar(4),
ban_dirsuc varchar(30),
ban_codpos varchar(6),
ban_ciudad varchar(20),
ban_estado varchar(20),
ban_nomleg varchar(40),
ban_rfcleg varchar(14),
ban_telleg varchar(15)
) server  options(schema 'LABCONF', table 'NMLOBANC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlobasc (
bas_keypro numeric(5),
bas_keynom numeric(5),
bas_keymne varchar(16),
bas_keycon varchar(3)
) server  options(schema 'LABCONF', table 'NMLOBASC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlobebe (
beb_keyemp numeric(10),
beb_keyben numeric(5),
beb_comfam numeric(5),
beb_tipben varchar(2),
beb_fecven timestamp(0),
beb_porpar decimal(7,4),
beb_forpag varchar(2),
beb_keycon varchar(3),
beb_perini varchar(7),
beb_perfin varchar(7),
beb_status varchar(1),
beb_impfij decimal(12,2),
beb_fecini timestamp(0)
) server  options(schema 'LABCONF', table 'NMLOBEBE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlobene (
ben_keyemp numeric(10),
ben_keyben numeric(5),
ben_comfam numeric(5),
ben_rfcben varchar(13),
ben_nomben varchar(60),
ben_fecnac timestamp(0),
ben_cvesex varchar(1),
ben_tippar varchar(2),
ben_keyban varchar(7),
ben_ctaban varchar(16),
ben_keydep varchar(16),
ben_keycen varchar(16),
ben_nomtut varchar(60),
ben_ca1aux varchar(10),
ben_ca2aux varchar(10)
) server  options(schema 'LABCONF', table 'NMLOBENE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlocalc (
cal_keyprg varchar(15),
cal_status varchar(1),
cal_fecmov timestamp(0),
cal_keypro numeric(5),
cal_keynom numeric(5),
cal_basdat varchar(10)
) server  options(schema 'LABCONF', table 'NMLOCALC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlocanr (
can_keyemp numeric(38) not null,
can_keypro numeric(5) not null,
can_perori varchar(7) not null,
can_percan varchar(7) not null
) server  options(schema 'LABCONF', table 'NMLOCANR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlocate (
cat_keycat varchar(16) not null,
cat_descat varchar(46) not null,
cat_refcon varchar(20),
cat_nu1aux varchar(10),
cat_nu2aux varchar(10),
cat_nu3aux varchar(10),
cat_nu4aux varchar(10),
cat_nu5aux varchar(10),
cat_ca1aux varchar(10),
cat_ca2aux varchar(10),
cat_ca3aux varchar(10),
cat_ca4aux varchar(10),
cat_ca5aux varchar(10)
) server  options(schema 'LABCONF', table 'NMLOCATE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloccol (
cco_keyrco varchar(8),
cco_numsec numeric(38),
cco_secope numeric(38),
cco_operan varchar(10),
cco_operad varchar(1),
cco_tipope varchar(1),
cco_uniimp varchar(1),
cco_peracu varchar(15)
) server  options(schema 'LABCONF', table 'NMLOCCOL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlocenc (
cen_keycen varchar(16) not null,
cen_descen varchar(46) not null,
cen_refcon varchar(20),
cen_nu1aux varchar(10),
cen_nu2aux varchar(10),
cen_nu3aux varchar(10),
cen_nu4aux varchar(10),
cen_nu5aux varchar(10),
cen_ca1aux varchar(10),
cen_ca2aux varchar(10),
cen_ca3aux varchar(10),
cen_ca4aux varchar(10),
cen_ca5aux varchar(10)
) server  options(schema 'LABCONF', table 'NMLOCENC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlocepro (
cen_keycen varchar(16) options (key 'true') not null,
cen_descen varchar(40),
cen_refcon varchar(20),
cen_status varchar(3),
cen_nu1aux varchar(3)
) server  options(schema 'LABCONF', table 'NMLOCEPRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlocfgn (
cfg_keycfg varchar(5),
cfg_keycia varchar(2),
cfg_keypro numeric(10),
cfg_descfg varchar(30),
cfg_keynom numeric(5),
cfg_tablat varchar(2),
cfg_fecreg timestamp(0),
cfg_fecact timestamp(0)
) server  options(schema 'LABCONF', table 'NMLOCFGN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlocias (
cia_keycia varchar(5),
cia_descia varchar(100),
cia_rfccia varchar(15),
cia_infcia varchar(15),
cia_dircia varchar(36),
cia_colcia varchar(20),
cia_cidcia varchar(20),
cia_pobcia varchar(30),
cia_muncia varchar(6),
cia_entcia varchar(2),
cia_codpos varchar(5),
cia_telcia varchar(25),
cia_repcia varchar(25),
cia_curcia varchar(25),
cia_reprfc varchar(13),
cia_ca1aux varchar(10),
cia_ca2aux varchar(10),
cia_ca3aux varchar(10),
cia_razsoc varchar(100),
cia_socied varchar(50)
) server  options(schema 'LABCONF', table 'NMLOCIAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlocier (
cie_keycie varchar(10),
cie_descie varchar(60),
cie_keynom numeric(38),
cie_mesini numeric(38),
cie_mesfin numeric(38),
cie_codame varchar(1),
cie_codaa2 varchar(1),
cie_codaa3 varchar(1),
cie_codaa4 varchar(1),
cie_perini varchar(7),
cie_perfin varchar(7),
cie_semini varchar(7),
cie_semfin varchar(7),
cie_datfij varchar(1),
cie_fecbaj timestamp(0),
cie_fecinc timestamp(0),
cie_fectra timestamp(0),
cie_ranpro varchar(200),
cie_ranims varchar(200)
) server  options(schema 'LABCONF', table 'NMLOCIER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlococo (
coc_keycfg varchar(5),
coc_etqcol varchar(16),
coc_numcol numeric(5),
coc_numren numeric(5),
coc_keycon varchar(3)
) server  options(schema 'LABCONF', table 'NMLOCOCO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloconc (
con_keycon varchar(3) not null,
con_descon varchar(37) not null,
con_descor varchar(16),
con_keyfor varchar(4),
con_leeinc varchar(1),
con_leedfi varchar(1),
con_leepre varchar(1),
con_leeacu varchar(1),
con_leedfc varchar(1),
con_codimp varchar(2),
con_codacu varchar(2),
con_codval varchar(2),
con_uniini decimal(12,2),
con_unifin decimal(12,2),
con_impini decimal(12,2),
con_impfin decimal(12,2),
con_ctaref varchar(20),
con_ctaaux varchar(20),
con_nu1aux varchar(10),
con_nu2aux varchar(10),
con_ca1aux varchar(10),
con_ca2aux varchar(10),
con_forval varchar(4),
con_porcen decimal(12,2),
con_leeaus varchar(1),
con_leeben varchar(1)
) server  options(schema 'LABCONF', table 'NMLOCONC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlocosa (
cos_keyims varchar(5),
cos_keyemp numeric(10),
cos_regpat varchar(11),
cos_regims varchar(11),
cos_regrfc varchar(13),
cos_recurp varchar(18),
cos_nombre varchar(50),
cos_tiptra varchar(1),
cos_tipjor varchar(1),
cos_fecalt varchar(10),
cos_salint decimal(12,6),
cos_cveubi varchar(17),
cos_numcre varchar(10),
cos_fecide varchar(10),
cos_tipdes varchar(1),
cos_valdes decimal(12,6)
) server  options(schema 'LABCONF', table 'NMLOCOSA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloctas (
cta_keypro numeric(38),
cta_keyemp numeric(38),
cta_ctaban varchar(18)
) server  options(schema 'LABCONF', table 'NMLOCTAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlocxpr (
cxp_keypro numeric(5) not null,
cxp_keynom numeric(5) not null,
cxp_numsec numeric(5),
cxp_keycon varchar(3) not null,
cxp_keyfor varchar(4),
cxp_leeinc varchar(1),
cxp_leedfi varchar(1),
cxp_leedfc varchar(1),
cxp_leepre varchar(1),
cxp_leeacu varchar(1),
cxp_codacu varchar(2),
cxp_codimp varchar(2),
cxp_codval varchar(2),
cxp_uniini decimal(12,2),
cxp_unifin decimal(12,2),
cxp_impini decimal(12,2),
cxp_impfin decimal(12,2),
cxp_forval varchar(4),
cxp_porcen decimal(12,2),
cxp_leeaus varchar(1),
cxp_leeben varchar(1)
) server  options(schema 'LABCONF', table 'NMLOCXPR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlodata (
dat_keyemp numeric(10) not null,
dat_keypar varchar(4) not null,
dat_valpar varchar(36)
) server  options(schema 'LABCONF', table 'NMLODATA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlodatn (
dat_keycfg varchar(5),
dat_keycia varchar(2),
dat_keypro numeric(10),
dat_keydep varchar(16),
dat_nomfor varchar(30),
dat_nomela varchar(30),
dat_nomaut varchar(30),
dat_visbue varchar(30)
) server  options(schema 'LABCONF', table 'NMLODATN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlodccf (
dcc_keycia varchar(5) not null,
dcc_keyper varchar(7) not null,
dcc_keynom numeric(38) not null,
dcc_fecini timestamp(0) not null,
dcc_fecfin timestamp(0) not null,
dcc_tipare varchar(1),
dcc_camare varchar(16),
dcc_tabare varchar(6),
dcc_tipcal varchar(1),
dcc_camcal varchar(16),
dcc_valcal varchar(2),
dcc_tipsin varchar(1),
dcc_camsin varchar(16),
dcc_tabsin varchar(6),
dcc_tipasi varchar(1),
dcc_camasi varchar(16),
dcc_tabasi varchar(6),
dcc_tipent varchar(1),
dcc_cament varchar(16),
dcc_tabent varchar(6),
dcc_datrf1 varchar(6),
dcc_datrf2 varchar(6),
dcc_datrf3 varchar(6),
dcc_tabrub varchar(6),
dcc_fecpre timestamp(0),
dcc_folpre varchar(16)
) server  options(schema 'LABCONF', table 'NMLODCCF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlodccn (
dcc_keycia varchar(5) not null,
dcc_keyper varchar(7) not null,
dcc_keyrub varchar(3) not null,
dcc_codimp varchar(2) not null,
dcc_keycon varchar(3) not null,
dcc_tipope varchar(1) not null
) server  options(schema 'LABCONF', table 'NMLODCCN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlodcde (
dcd_keyemp numeric(38) not null,
dcd_keycia varchar(5) not null,
dcd_keyper varchar(7) not null,
dcd_keyrub varchar(3) not null,
dcd_import numeric(38) not null
) server  options(schema 'LABCONF', table 'NMLODCDE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlodcem (
dce_keyemp numeric(38) not null,
dce_keycia varchar(5) not null,
dce_keyper varchar(7) not null,
dce_keydep varchar(16),
dce_keyloc varchar(16),
dce_mesini numeric(38) not null,
dce_mesfin numeric(38) not null,
dce_regrfc varchar(13) not null,
dce_recurp varchar(18),
dce_apepat varchar(30) not null,
dce_apemat varchar(30),
dce_nombre varchar(30) not null,
dce_aregeo varchar(2) not null,
dce_calanu varchar(2) not null,
dce_sindic varchar(2) not null,
dce_asimil varchar(2) not null,
dce_fedent varchar(2) not null,
dce_rfc001 varchar(13),
dce_rfc002 varchar(13),
dce_rfc003 varchar(13),
dce_apovol decimal(16,2),
dce_apoapl varchar(1),
dce_apoded decimal(16,2),
dce_apopat decimal(16,2),
dce_percep decimal(16,2)
) server  options(schema 'LABCONF', table 'NMLODCEM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlodfij (
dfi_keyemp numeric(10),
dfi_keycon varchar(3),
dfi_keypro numeric(5),
dfi_perini varchar(7),
dfi_perfin varchar(7),
dfi_keydep varchar(16),
dfi_keypue varchar(16),
dfi_fecmov timestamp(0),
dfi_cantid decimal(12,2),
dfi_import decimal(12,2),
dfi_ca1aux varchar(10),
dfi_ca2aux varchar(10)
) server  options(schema 'LABCONF', table 'NMLODFIJ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloenfm (
enf_keyfor varchar(9) not null,
enf_de1for varchar(40),
enf_de2for varchar(40),
enf_de3for varchar(40),
enf_idever varchar(15)
) server  options(schema 'LABCONF', table 'NMLOENFM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlofoco (
foc_keyfor varchar(16),
foc_forcon varchar(3),
foc_nomfoc varchar(20),
foc_aplica varchar(1),
foc_numsec numeric(5),
foc_ideuno varchar(2),
foc_varuno varchar(40),
foc_operad varchar(2),
foc_idedos varchar(2),
foc_vardos varchar(40),
foc_opeaux varchar(2),
foc_parabi varchar(15),
foc_parcer varchar(15)
) server  options(schema 'LABCONF', table 'NMLOFOCO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloform (
for_keyfor varchar(9) not null,
for_numins numeric(5),
for_opera1 varchar(16),
for_operad varchar(16),
for_opera2 varchar(16),
for_result varchar(16)
) server  options(schema 'LABCONF', table 'NMLOFORM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlohemp (
hem_keyemp numeric(10),
hem_keyper varchar(7),
hem_keydep varchar(16),
hem_keypue varchar(16),
hem_keycen varchar(16),
hem_keycat varchar(16),
hem_regrfc varchar(13),
hem_recurp varchar(18),
hem_regims varchar(12),
hem_reginf varchar(12),
hem_keyims varchar(5),
hem_cvezon numeric(5),
hem_keypro numeric(5),
hem_cvetur numeric(5),
hem_tipemp varchar(6),
hem_tipsal varchar(1),
hem_status numeric(6),
hem_salhor decimal(12,6),
hem_saldia decimal(12,6),
hem_salmes decimal(12,2),
hem_salint decimal(12,6),
hem_salivc decimal(12,6),
hem_salinf decimal(12,6),
hem_intsin decimal(12,6),
hem_infsin decimal(12,6),
hem_varims decimal(12,6),
hem_varinf decimal(12,6),
hem_refcon varchar(20),
hem_cveban varchar(7),
hem_ctaban varchar(18),
hem_forpag varchar(2),
hem_diades numeric(5),
hem_numliq varchar(20),
hem_keyloc varchar(16),
hem_fecing timestamp(0),
hem_fecrei timestamp(0),
hem_fecven timestamp(0),
hem_fecpla timestamp(0),
hem_fecaum timestamp(0),
hem_peraum varchar(7),
hem_fecbaj timestamp(0),
hem_cvebaj varchar(4),
hem_jorlab varchar(1),
hem_unijor decimal(4,2),
hem_fecaux timestamp(0),
hem_ca1aux varchar(10),
hem_ca2aux varchar(10),
hem_ca3aux varchar(10),
hem_ca4aux varchar(10),
hem_pctbec decimal(5,2),
hem_cobert varchar(2)
) server  options(schema 'LABCONF', table 'NMLOHEMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlohico (
hic_keypro numeric(5) not null,
hic_keycon varchar(3) not null,
hic_numper varchar(7),
hic_keynom numeric(5),
hic_cantid decimal(16,2),
hic_import decimal(16,2),
hic_keycia varchar(2),
hic_totemp numeric(10),
hic_keydep varchar(16),
hic_codimp varchar(2),
hic_mesacu numeric(5)
) server  options(schema 'LABCONF', table 'NMLOHICO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlohism_bak (
his_keyemp numeric(10) not null,
his_keycon varchar(3) not null,
his_keypro numeric(5) not null,
his_keydep varchar(16),
his_keypue varchar(16),
his_cantid decimal(16,2),
his_import decimal(16,2),
his_fecmov timestamp(0),
his_keyper varchar(7) not null,
his_keynom numeric(5),
his_codimp varchar(2),
his_codacu varchar(2),
his_ca1aux varchar(16),
his_ca2aux varchar(16),
his_rowide decimal(16,6),
his_uniope numeric(5),
his_keyplz numeric(38),
his_tipplz varchar(2),
his_keyben numeric(5),
his_comfam numeric(5)
) server  options(schema 'LABCONF', table 'NMLOHISM_BAK', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloimem (
ime_keyemp numeric(10),
ime_keydep varchar(16),
ime_keypue varchar(16),
ime_keycen varchar(16),
ime_keycat varchar(16),
ime_nomemp varchar(60),
ime_nomcor varchar(20),
ime_domemp varchar(30),
ime_colemp varchar(20),
ime_cidemp varchar(20),
ime_pobemp varchar(20),
ime_munemp varchar(6),
ime_entemp varchar(2),
ime_codemp varchar(5),
ime_telemp varchar(10),
ime_regrfc varchar(13),
ime_recurp varchar(18),
ime_regims varchar(12),
ime_reginf varchar(12),
ime_cvesex varchar(1),
ime_keyims varchar(5),
ime_cvezon numeric(5),
ime_keypro numeric(5),
ime_cvetur numeric(5),
ime_tipemp varchar(6),
ime_tipsal varchar(1),
ime_status numeric(5),
ime_salhor decimal(12,6),
ime_saldia decimal(12,6),
ime_salmes decimal(12,2),
ime_salint decimal(12,6),
ime_salivc decimal(12,6),
ime_salinf decimal(12,6),
ime_intsin decimal(12,6),
ime_infsin decimal(12,6),
ime_varims decimal(12,6),
ime_varinf decimal(12,6),
ime_anthor decimal(12,6),
ime_antdia decimal(12,6),
ime_antmes decimal(12,6),
ime_antint decimal(12,6),
ime_antivc decimal(12,6),
ime_antinf decimal(12,6),
ime_antits decimal(12,6),
ime_antifs decimal(12,6),
ime_refcon varchar(20),
ime_cveban varchar(7),
ime_ctaban varchar(16),
ime_forpag varchar(2),
ime_diades numeric(5),
ime_numliq varchar(6),
ime_keyloc varchar(16),
ime_fecing timestamp(0),
ime_fecrei timestamp(0),
ime_fecven timestamp(0),
ime_fecpla timestamp(0),
ime_fecaum timestamp(0),
ime_peraum varchar(7),
ime_fecbaj timestamp(0),
ime_cvebaj varchar(4),
ime_jorlab varchar(1),
ime_unijor decimal(4,2),
ime_pering varchar(7),
ime_perbaj varchar(7),
ime_perdep varchar(7),
ime_perpue varchar(7),
ime_percat varchar(7),
ime_perpro varchar(7),
ime_fecaux timestamp(0),
ime_ca1aux varchar(10),
ime_ca2aux varchar(10),
ime_ca3aux varchar(10),
ime_ca4aux varchar(10),
ime_pctbec decimal(5,2),
ime_fecmod timestamp(0),
ime_hormod varchar(8),
ime_fecalt timestamp(0),
ime_bajfec timestamp(0),
ime_fecsal timestamp(0),
ime_perpag varchar(7),
ime_inifec timestamp(0),
ime_finfec timestamp(0),
ime_cobert varchar(2)
) server  options(schema 'LABCONF', table 'NMLOIMEM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloimss (
ims_keyims varchar(5) not null,
ims_rfcims varchar(14),
ims_razsoc varchar(46),
ims_dirloc varchar(40),
ims_numext varchar(6),
ims_numint varchar(6),
ims_colloc varchar(20),
ims_codpos varchar(5),
ims_munloc varchar(6),
ims_entloc varchar(2),
ims_numban varchar(20),
ims_pririe decimal(12,6),
ims_tiprie varchar(12),
ims_luggui numeric(10),
ims_actloc varchar(24),
ims_keyban varchar(7),
ims_numcot numeric(5),
ims_bascal numeric(5),
ims_totpag numeric(5),
ims_keycia varchar(5),
ims_cveedi varchar(16),
ims_ca1aux varchar(30),
ims_ca2aux varchar(20),
ims_ca3aux varchar(20),
ims_ca4aux varchar(20),
ims_franum varchar(8)
) server  options(schema 'LABCONF', table 'NMLOIMSS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlolipr (
lip_keypro numeric(5),
lip_keynom numeric(5),
lip_keyprd numeric(5)
) server  options(schema 'LABCONF', table 'NMLOLIPR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlolocp (
loc_keyloc varchar(16),
loc_desloc varchar(40),
loc_domloc varchar(36),
loc_colloc varchar(20),
loc_ciuloc varchar(6),
loc_estloc varchar(6),
loc_codpos varchar(6),
loc_lardis varchar(5),
loc_teluno varchar(10),
loc_teldos varchar(10),
loc_teltre varchar(10),
loc_cvezon numeric(5),
loc_reggeo varchar(10),
loc_keyban varchar(3),
loc_keysuc varchar(4),
loc_ca1aux varchar(10),
loc_ca2aux varchar(10),
loc_ca3aux varchar(10),
loc_ca4aux varchar(10),
loc_ca5aux varchar(10),
loc_refcon varchar(30)
) server  options(schema 'LABCONF', table 'NMLOLOCP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlomasi (
mas_keymas numeric(10),
mas_desmas varchar(40),
mas_ideopc varchar(2),
mas_keynom numeric(5),
mas_ejecut varchar(1)
) server  options(schema 'LABCONF', table 'NMLOMASI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlomnem (
mne_keynem varchar(16) not null,
mne_keytab varchar(8),
mne_keycam varchar(16),
mne_condic varchar(16),
mne_tipdat varchar(1)
) server  options(schema 'LABCONF', table 'NMLOMNEM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlomrnm (
mrn_keynom numeric(38),
mrn_keyper varchar(7),
mrn_ordgen numeric(38),
mrn_idecam varchar(6),
mrn_valkey varchar(16),
mrn_mensaj varchar(60),
mrn_imprim varchar(1),
mrn_operad varchar(2),
mrn_estruc varchar(1)
) server  options(schema 'LABCONF', table 'NMLOMRNM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlomxpr (
mxp_keymas numeric(5),
mxp_keypro numeric(5),
mxp_grabar varchar(1),
mxp_tipemp varchar(1)
) server  options(schema 'LABCONF', table 'NMLOMXPR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlonomi (
nom_keynom numeric(5) not null,
nom_destip varchar(40) not null
) server  options(schema 'LABCONF', table 'NMLONOMI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlopas (
pas_keyemp numeric(38),
pas_keypas char(13)
) server  options(schema 'LABCONF', table 'NMLOPAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlopcol (
pco_keyrco varchar(8),
pco_numsec numeric(5),
pco_etqcol varchar(16)
) server  options(schema 'LABCONF', table 'NMLOPCOL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloperi (
per_keypro numeric(5) not null,
per_keynom numeric(5),
per_keyper varchar(7) not null,
per_fecini timestamp(0),
per_fecfin timestamp(0),
per_fecpag timestamp(0),
per_feccor timestamp(0),
per_nummes numeric(5),
per_acudos numeric(5),
per_acutre numeric(5),
per_acucua numeric(5),
per_nu1aux varchar(10),
per_nu2aux varchar(10),
per_nu3aux varchar(10),
per_nu4aux varchar(10),
per_nu5aux varchar(10),
per_keypol varchar(10),
per_impnom decimal(18,2),
per_totemp numeric(10),
per_fecact timestamp(0),
per_horact varchar(6),
per_persel varchar(1),
per_fecpol timestamp(0),
per_despol varchar(20),
per_anioa1 varchar(4),
per_anioa2 varchar(4),
per_anioa3 varchar(4),
per_anioa4 varchar(4)
) server  options(schema 'LABCONF', table 'NMLOPERI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlopres (
pre_keyemp numeric(10),
pre_keycon varchar(3),
pre_keypre decimal(16,6) not null,
pre_refere varchar(20),
pre_fecreg timestamp(0),
pre_tippre varchar(2),
pre_unipre decimal(12,2),
pre_imppre decimal(12,2),
pre_gastos decimal(12,2),
pre_plazop numeric(5),
pre_unides decimal(12,2),
pre_impdes decimal(12,2),
pre_porint decimal(6,4),
pre_perini varchar(7),
pre_fecini timestamp(0),
pre_fecaut timestamp(0),
pre_cveaut numeric(10),
pre_fechab timestamp(0),
pre_uniamo decimal(12,2),
pre_impamo decimal(12,2),
pre_unisal decimal(12,2),
pre_impsal decimal(12,2),
pre_uniult decimal(12,2),
pre_impult decimal(12,2),
pre_numpag numeric(5),
pre_intpag decimal(12,2),
pre_status varchar(1),
pre_ultact timestamp(0),
pre_refcon varchar(20),
pre_ctreve varchar(16),
pre_fe1aux timestamp(0),
pre_fe2aux timestamp(0),
pre_ca1aux varchar(10),
pre_ca2aux varchar(10),
pre_ca3aux varchar(16),
pre_ca4aux varchar(10),
pre_uniope numeric(5),
pre_keypro numeric(5),
pre_impnoa decimal(16,2),
pre_pernoa varchar(7)
) server  options(schema 'LABCONF', table 'NMLOPRES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloproc (
pro_keypro numeric(5) not null,
pro_despro varchar(26) not null,
pro_keycia varchar(5) not null,
pro_tipsal varchar(1),
pro_dirpag varchar(30),
pro_diaper numeric(5),
pro_perano numeric(5),
pro_faccon decimal(4,2),
pro_keynom numeric(5),
pro_pereje varchar(7),
pro_vercon numeric(5),
pro_nu1aux varchar(10),
pro_nu2aux varchar(10),
pro_nu3aux varchar(10),
pro_nu4aux varchar(10),
pro_nu5aux varchar(10),
pro_ca1aux varchar(10),
pro_ca2aux varchar(10),
pro_ca3aux varchar(10),
pro_ca4aux varchar(10),
pro_ca5aux varchar(10)
) server  options(schema 'LABCONF', table 'NMLOPROC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlorcon (
rco_keyrco varchar(8),
rco_desrco varchar(50),
rco_cam001 varchar(10),
rco_cam002 varchar(10),
rco_cam003 varchar(10),
rco_tipcam varchar(3),
rco_cor001 varchar(10),
rco_cor002 varchar(10),
rco_cor003 varchar(10),
rco_cor004 varchar(10),
rco_cor005 varchar(10),
rco_cor006 varchar(10),
rco_saltos varchar(6),
rco_tipcor varchar(6),
rco_tablaf varchar(1),
rco_consql varchar(100)
) server  options(schema 'LABCONF', table 'NMLORCON', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlorepc (
rep_keyrco varchar(8),
rep_keymen varchar(4),
rep_keyusu numeric(10),
rep_destin varchar(1),
rep_ran001 varchar(60),
rep_ran002 varchar(60),
rep_ran003 varchar(60),
rep_ran004 varchar(60),
rep_ran005 varchar(60),
rep_ran006 varchar(60),
rep_rancia varchar(60),
rep_ranpro varchar(60),
rep_randep varchar(60),
rep_ranemp varchar(60),
rep_ranpue varchar(60),
rep_rannom varchar(60),
rep_ranca1 varchar(60),
rep_ranca2 varchar(60),
rep_tipper varchar(1),
rep_ranper varchar(60),
rep_tipord varchar(3),
rep_estorg varchar(1),
rep_totrep numeric(5),
rep_corper varchar(1),
rep_depdat varchar(1)
) server  options(schema 'LABCONF', table 'NMLOREPC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlosuel (
sue_keysue varchar(4),
sue_dessue varchar(40),
sue_fecact timestamp(0),
sue_ca1aux varchar(10),
sue_ca2aux varchar(10),
sue_ca3aux varchar(10),
sue_ca4aux varchar(10),
sue_collst varchar(5),
sue_etqmin varchar(40),
sue_etq1qa varchar(40),
sue_etqmed varchar(40),
sue_etq3qa varchar(40),
sue_etqmax varchar(40)
) server  options(schema 'LABCONF', table 'NMLOSUEL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloswde (
swd_keycon varchar(3),
swd_numsec numeric(38),
swd_desswd varchar(40)
) server  options(schema 'LABCONF', table 'NMLOSWDE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloswit (
swi_keyemp numeric(10),
swi_keycon varchar(3),
swi_marcas varchar(80)
) server  options(schema 'LABCONF', table 'NMLOSWIT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlotabn (
tab_keytab varchar(9),
tab_sectab numeric(10),
tab_eleuno decimal(18,6),
tab_eledos decimal(18,6),
tab_eletre decimal(18,6),
tab_elecua decimal(18,6)
) server  options(schema 'LABCONF', table 'NMLOTABN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlotabs (
tab_keysue varchar(4),
tab_cobert varchar(2),
tab_tiptab varchar(2),
tab_sueniv numeric(10),
tab_subniv numeric(10),
tab_feccad timestamp(0),
tab_suemin decimal(12,2),
tab_sue1qa decimal(12,2),
tab_suemed decimal(12,2),
tab_sue3qa decimal(12,2),
tab_suemax decimal(12,2)
) server  options(schema 'LABCONF', table 'NMLOTABS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlotanu (
tan_keytab varchar(9),
tan_de1tab varchar(40),
tan_de2tab varchar(46),
tan_de3tab varchar(48),
tan_idever varchar(15)
) server  options(schema 'LABCONF', table 'NMLOTANU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlotipr (
tpe_keytpr varchar(2),
tpe_destpr varchar(40),
tpe_valpre varchar(1),
tpe_status varchar(1)
) server  options(schema 'LABCONF', table 'NMLOTIPR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmlotray (
tra_keyemp numeric(10) not null,
tra_fecmov timestamp(0),
tra_tipmov varchar(2),
tra_keydep varchar(16),
tra_keypue varchar(16),
tra_keycat varchar(16),
tra_keycen varchar(16),
tra_saldia decimal(12,6),
tra_salmes decimal(12,2),
tra_salint decimal(12,6),
tra_salivc decimal(12,6),
tra_salinf decimal(12,6),
tra_intsin decimal(12,6),
tra_infsin decimal(12,6),
tra_keyims varchar(5),
tra_keyper varchar(7),
tra_codloc varchar(16),
tra_keypla numeric(10),
tra_keypro numeric(10),
tra_jorlab varchar(1),
tra_unijor decimal(4,2),
tra_submov varchar(6),
tra_ca1aux varchar(10),
tra_ca2aux varchar(10),
tra_fecmod timestamp(0),
tra_hormod varchar(10)
) server  options(schema 'LABCONF', table 'NMLOTRAY', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmloverc (
ver_keyver numeric(5),
ver_ctacar varchar(20),
ver_refcta varchar(30),
ver_tipexc varchar(1),
ver_keycon varchar(3),
ver_ctaabo varchar(20),
ver_cveco1 varchar(8),
ver_cveop1 varchar(1),
ver_cveco2 varchar(8),
ver_cveop2 varchar(1),
ver_cveco3 varchar(8),
ver_cveop3 varchar(1),
ver_cveco4 varchar(8),
ver_cveop4 varchar(1),
ver_cveco5 varchar(8),
ver_cveop5 varchar(1),
ver_cveco6 varchar(8),
ver_cveop6 varchar(1),
ver_cveco7 varchar(8),
ver_cveop7 varchar(1),
ver_cveco8 varchar(8),
ver_cveop8 varchar(1),
ver_cveco9 varchar(8),
ver_cveop9 varchar(1),
ver_cveco0 varchar(8)
) server  options(schema 'LABCONF', table 'NMLOVERC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmmodusr (
usr_keyusr varchar(5),
usr_nomusr char(35),
usr_passwd char(10)
) server  options(schema 'LABCONF', table 'NMMODUSR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmpasinc (
inc_keyusu numeric(38),
inc_feccap timestamp(0),
inc_keyemp numeric(38),
inc_keycon varchar(3),
inc_keycen varchar(16),
inc_keypue varchar(16),
inc_keycco varchar(16),
inc_cantid decimal(6,2),
inc_import decimal(14,4),
inc_keypro numeric(38),
inc_keyper varchar(7),
inc_costo decimal(14,4),
inc_semana numeric(38),
inc_sempro varchar(50)
) server  options(schema 'LABCONF', table 'NMPASINC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmrecnom (
rec_nomrep varchar(10),
rec_idepcc varchar(15),
rec_keyusu numeric(10),
rec_keyemp numeric(10),
rec_nomemp varchar(60),
rec_desdep varchar(40),
rec_despue varchar(40),
rec_keyper varchar(7),
rec_fecini varchar(10),
rec_fecfin varchar(10),
rec_regcur varchar(18),
rec_regims varchar(13),
rec_dialab char(6),
rec_keyco1 varchar(3),
rec_desco1 varchar(40),
rec_canti1 decimal(12,2),
rec_impor1 decimal(12,2),
rec_keyco2 varchar(3),
rec_desco2 varchar(40),
rec_canti2 decimal(12,2),
rec_impor2 decimal(12,2),
rec_keyco3 varchar(3),
rec_desco3 varchar(40),
rec_canti3 decimal(12,2),
rec_impor3 decimal(12,2),
rec_keyco4 varchar(3),
rec_desco4 varchar(40),
rec_canti4 decimal(12,2),
rec_impor4 decimal(12,2),
rec_keyco5 varchar(3),
rec_desco5 varchar(40),
rec_canti5 decimal(12,2),
rec_impor5 decimal(12,2),
rec_keyco6 varchar(3),
rec_desco6 varchar(40),
rec_canti6 decimal(12,2),
rec_impor6 decimal(12,2),
rec_keyco7 varchar(3),
rec_desco7 varchar(40),
rec_canti7 decimal(12,2),
rec_impor7 decimal(12,2),
rec_keyco8 varchar(3),
rec_desco8 varchar(40),
rec_canti8 decimal(12,2),
rec_impor8 decimal(12,2),
rec_keyco9 varchar(3),
rec_desco9 varchar(40),
rec_canti9 decimal(12,2),
rec_impor9 decimal(12,2),
rec_keyc10 varchar(3),
rec_desc10 varchar(40),
rec_cant10 decimal(12,2),
rec_impo10 decimal(12,2),
rec_keyc11 varchar(3),
rec_desc11 varchar(40),
rec_cant11 decimal(12,2),
rec_impo11 decimal(12,2),
rec_saldo1 decimal(12,2),
rec_keyc12 varchar(3),
rec_desc12 varchar(40),
rec_cant12 decimal(12,2),
rec_impo12 decimal(12,2),
rec_saldo2 decimal(12,2),
rec_keyc13 varchar(3),
rec_desc13 varchar(40),
rec_cant13 decimal(12,2),
rec_impo13 decimal(12,2),
rec_saldo3 decimal(12,2),
rec_keyc14 varchar(3),
rec_desc14 varchar(40),
rec_cant14 decimal(12,2),
rec_impo14 decimal(12,2),
rec_saldo4 decimal(12,2),
rec_keyc15 varchar(3),
rec_desc15 varchar(40),
rec_cant15 decimal(12,2),
rec_impo15 decimal(12,2),
rec_saldo5 decimal(12,2),
rec_keyc16 varchar(3),
rec_desc16 varchar(40),
rec_cant16 decimal(12,2),
rec_impo16 decimal(12,2),
rec_saldo6 decimal(12,2),
rec_keyc17 varchar(3),
rec_desc17 varchar(40),
rec_cant17 decimal(12,2),
rec_impo17 decimal(12,2),
rec_saldo7 decimal(12,2),
rec_keyc18 varchar(3),
rec_desc18 varchar(40),
rec_cant18 decimal(12,2),
rec_impo18 decimal(12,2),
rec_saldo8 decimal(12,2),
rec_keyc19 varchar(3),
rec_desc19 varchar(40),
rec_cant19 decimal(12,2),
rec_impo19 decimal(12,2),
rec_saldo9 decimal(12,2),
rec_keyc20 varchar(3),
rec_desc20 varchar(40),
rec_cant20 decimal(12,2),
rec_impo20 decimal(12,2),
rec_sald10 decimal(12,2),
rec_fdoaho varchar(20),
rec_impfdo decimal(12,2),
rec_totper decimal(12,2),
rec_totded decimal(12,2),
rec_gratot decimal(12,2),
rec_totsal decimal(12,2),
rec_numsec numeric(10),
rec_numfol numeric(10),
rec_keypro numeric(5)
) server  options(schema 'LABCONF', table 'NMRECNOM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmstausu (
sta_keyusu numeric(38),
sta_keyubi varchar(1),
sta_status varchar(1),
sta_verusu varchar(300),
sta_activo varchar(5),
sta_keysem varchar(53),
sta_keysemq varchar(53)
) server  options(schema 'LABCONF', table 'NMSTAUSU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmtarjet (
tar_keyemp numeric(38) options (key 'true') not null,
tar_nohor numeric(38) not null,
tar_nodes numeric(38) not null
) server  options(schema 'LABCONF', table 'NMTARJET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmvistar (
vis_folio numeric(5) not null,
vis_keyemp numeric(10) not null,
vis_feccap timestamp(0),
vis_tipmov char(2),
vis_fecmov timestamp(0) not null,
vis_obser1 varchar(50),
vis_obser2 varchar(50),
vis_status char(1),
vis_keyusr varchar(5),
vis_cantid decimal(5,2),
vis_cctoan char(16),
vis_cctoac char(16),
vis_gpoant varchar(10),
vis_codact varchar(16),
vis_codant varchar(16),
vis_gpo varchar(10)
) server  options(schema 'LABCONF', table 'NMVISTAR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkcp10 (
cpr_nomrep varchar(16),
cpr_keyusu numeric(10),
cpr_mesini varchar(2),
cpr_mesfin varchar(2),
cpr_ejerci varchar(4),
cpr_s1rfct varchar(13),
cpr_s1curp varchar(18),
cpr_s1appa varchar(40),
cpr_s1apma varchar(40),
cpr_s1nomb varchar(60),
cpr_s1mar1 varchar(1),
cpr_s1mar2 varchar(1),
cpr_s1mar3 varchar(1),
cpr_s1mar4 varchar(1),
cpr_s1mar5 varchar(1),
cpr_s1entf varchar(2),
cpr_s1asim varchar(2),
cpr_s1pro1 varchar(4),
cpr_s1pro2 varchar(6),
cpr_s1pro3 varchar(4),
cpr_s1pro4 varchar(6),
cpr_s1pro5 varchar(4),
cpr_s1pro6 varchar(6),
cpr_s1pro7 varchar(4),
cpr_s1pro8 varchar(6),
cpr_s1pro9 varchar(4),
cpr_s1proa varchar(6),
cpr_s1rfp1 varchar(13),
cpr_s1rfp2 varchar(13),
cpr_s1rfp3 varchar(13),
cpr_s1odia varchar(14),
cpr_s1odib varchar(2),
cpr_s1odic varchar(14),
cpr_s1odid varchar(14),
cpr_s2amay varchar(16),
cpr_s2bmay varchar(16),
cpr_s2cmay varchar(16),
cpr_s2dmay varchar(16),
cpr_s2emay varchar(16),
cpr_s2fmay varchar(16),
cpr_s2gmay varchar(16),
cpr_s2hmay varchar(16),
cpr_s2imay varchar(16),
cpr_s2jmay varchar(16),
cpr_s2kmay varchar(16),
cpr_s2lmay varchar(16),
cpr_s2mmay varchar(16),
cpr_s3nmay varchar(16),
cpr_s3omay varchar(16),
cpr_s3pmay varchar(16),
cpr_s3qmay varchar(16),
cpr_s3rmay varchar(16),
cpr_s3smay varchar(16),
cpr_s3tmay varchar(16),
cpr_s3umay varchar(16),
cpr_s3vmay varchar(16),
cpr_s3wmay varchar(16),
cpr_s3xmay varchar(16),
cpr_s3ymay varchar(16),
cpr_s3zmay varchar(16),
cpr_s3amin varchar(16),
cpr_s3bmin varchar(16),
cpr_s3cmin varchar(16),
cpr_s3dmin varchar(16),
cpr_s3emin varchar(16),
cpr_s3fmin varchar(16),
cpr_s3gmin varchar(16),
cpr_s3hmin varchar(16),
cpr_s4imin varchar(16),
cpr_s4jmin varchar(16),
cpr_s4kmin varchar(16),
cpr_s4lmin varchar(16),
cpr_s4mmin varchar(16),
cpr_s4nmin varchar(16),
cpr_s5ogra varchar(16),
cpr_s5oexe varchar(16),
cpr_s5pgra varchar(16),
cpr_s5pexe varchar(16),
cpr_s5qgra varchar(16),
cpr_s5qexe varchar(16),
cpr_s5rgra varchar(16),
cpr_s5rexe varchar(16),
cpr_s5sgra varchar(16),
cpr_s5sexe varchar(16),
cpr_s5tgra varchar(16),
cpr_s5texe varchar(16),
cpr_s5ugra varchar(16),
cpr_s5uexe varchar(16),
cpr_s5vgra varchar(16),
cpr_s5vexe varchar(16),
cpr_s5wgra varchar(16),
cpr_s5wexe varchar(16),
cpr_s5xgra varchar(16),
cpr_s5xexe varchar(16),
cpr_s5ygra varchar(16),
cpr_s5yexe varchar(16),
cpr_s5zgra varchar(16),
cpr_s5zexe varchar(16),
cpr_s5a1gr varchar(16),
cpr_s5a1ex varchar(16),
cpr_s5b1gr varchar(16),
cpr_s5b1ex varchar(16),
cpr_s5c1gr varchar(16),
cpr_s5c1ex varchar(16),
cpr_s5d1gr varchar(16),
cpr_s5d1ex varchar(16),
cpr_s5e1gr varchar(16),
cpr_s5e1ex varchar(16),
cpr_s5f1gr varchar(16),
cpr_s5f1ex varchar(16),
cpr_s5g1gr varchar(16),
cpr_s5g1ex varchar(16),
cpr_s5h1gr varchar(16),
cpr_s5h1ex varchar(16),
cpr_s5i1gr varchar(16),
cpr_s5i1ex varchar(16),
cpr_s5j1gr varchar(16),
cpr_s5j1ex varchar(16),
cpr_s5k1gr varchar(16),
cpr_s5k1ex varchar(16),
cpr_s5l1gr varchar(16),
cpr_s5l1ex varchar(16),
cpr_s5m1gr varchar(16),
cpr_s5m1ex varchar(16),
cpr_s5n1gr varchar(16),
cpr_s5n1ex varchar(16),
cpr_s5o1gr varchar(16),
cpr_s5o1ex varchar(16),
cpr_s5p1gr varchar(16),
cpr_s5p1ex varchar(16),
cpr_s6q101 varchar(16),
cpr_s6r101 varchar(16),
cpr_s6s101 varchar(16),
cpr_s6t101 varchar(16),
cpr_s6u101 varchar(16),
cpr_s6v101 varchar(16),
cpr_s6w101 varchar(16),
cpr_s6x101 varchar(16),
cpr_s6y101 varchar(16),
cpr_s6z101 varchar(16),
cpr_s6a101 varchar(16),
cpr_s6b101 varchar(16),
cpr_s6c101 varchar(16),
cpr_s7rfc1 varchar(13),
cpr_s7cur1 varchar(18),
cpr_s7nom1 varchar(100),
cpr_s7rfc2 varchar(13),
cpr_s7cur2 varchar(18),
cpr_s7nom2 varchar(100),
cpr_fecsat varchar(10),
cpr_folope varchar(20),
cpr_sireac varchar(2)
) server  options(schema 'LABCONF', table 'NMWKCP10', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkcpr3 (
cpr_nomrep varchar(16),
cpr_keyusu numeric(38),
cpr_mesini varchar(2),
cpr_mesfin varchar(2),
cpr_ejerci varchar(4),
cpr_s1rfct varchar(13),
cpr_s1curp varchar(18),
cpr_s1nomb varchar(100),
cpr_s1mar1 varchar(1),
cpr_s1mar2 varchar(1),
cpr_s1mar3 varchar(1),
cpr_s1mar4 varchar(1),
cpr_s1entf varchar(2),
cpr_s1asim varchar(2),
cpr_s1pro1 varchar(4),
cpr_s1pro2 varchar(6),
cpr_s1pro3 varchar(4),
cpr_s1pro4 varchar(6),
cpr_s1pro5 varchar(4),
cpr_s1pro6 varchar(6),
cpr_s1pro7 varchar(4),
cpr_s1pro8 varchar(6),
cpr_s1pro9 varchar(4),
cpr_s1proa varchar(6),
cpr_s1rfp1 varchar(13),
cpr_s1rfp2 varchar(13),
cpr_s1rfp3 varchar(13),
cpr_s2amay varchar(16),
cpr_s2bmay varchar(16),
cpr_s2cmay varchar(16),
cpr_s2dmay varchar(16),
cpr_s2emay varchar(16),
cpr_s2fmay varchar(16),
cpr_s2gmay varchar(16),
cpr_s2hmay varchar(16),
cpr_s2imay varchar(16),
cpr_s2jmay varchar(16),
cpr_s2kmay varchar(16),
cpr_s2lmay varchar(16),
cpr_s2mmay varchar(16),
cpr_s3nmay varchar(16),
cpr_s3omay varchar(16),
cpr_s3pmay varchar(16),
cpr_s3qmay varchar(16),
cpr_s3rmay varchar(16),
cpr_s3smay varchar(16),
cpr_s3tmay varchar(16),
cpr_s3umay varchar(16),
cpr_s3vmay varchar(16),
cpr_s3wmay varchar(16),
cpr_s4xmay varchar(16),
cpr_s4ymay varchar(16),
cpr_s4zmay varchar(16),
cpr_s4amin varchar(16),
cpr_s4bmin varchar(16),
cpr_s4cmin varchar(16),
cpr_s4dmin varchar(16),
cpr_s4emin varchar(16),
cpr_s5fmin varchar(16),
cpr_s5gmin varchar(16),
cpr_s6hgra varchar(16),
cpr_s6hexe varchar(16),
cpr_s6igra varchar(16),
cpr_s6iexe varchar(16),
cpr_s6jgra varchar(16),
cpr_s6jexe varchar(16),
cpr_s6kgra varchar(16),
cpr_s6kexe varchar(16),
cpr_s6lgra varchar(16),
cpr_s6lexe varchar(16),
cpr_s6mgra varchar(16),
cpr_s6mexe varchar(16),
cpr_s6ngra varchar(16),
cpr_s6nexe varchar(16),
cpr_s6ogra varchar(16),
cpr_s6oexe varchar(16),
cpr_s6pgra varchar(16),
cpr_s6pexe varchar(16),
cpr_s6qgra varchar(16),
cpr_s6qexe varchar(16),
cpr_s6rgra varchar(16),
cpr_s6rexe varchar(16),
cpr_s6sgra varchar(16),
cpr_s6sexe varchar(16),
cpr_s6tgra varchar(16),
cpr_s6texe varchar(16),
cpr_s6ugra varchar(16),
cpr_s6uexe varchar(16),
cpr_s6vgra varchar(16),
cpr_s6vexe varchar(16),
cpr_s6wgra varchar(16),
cpr_s6wexe varchar(16),
cpr_s6xgra varchar(16),
cpr_s6xexe varchar(16),
cpr_s6ygra varchar(16),
cpr_s6yexe varchar(16),
cpr_s6zgra varchar(16),
cpr_s6zexe varchar(16),
cpr_s6a1gr varchar(16),
cpr_s6a1ex varchar(16),
cpr_s6b1gr varchar(16),
cpr_s6b1ex varchar(16),
cpr_s6c1gr varchar(16),
cpr_s6c1ex varchar(16),
cpr_s6d1gr varchar(16),
cpr_s6d1ex varchar(16),
cpr_s6e1gr varchar(16),
cpr_s6e1ex varchar(16),
cpr_s6f1gr varchar(16),
cpr_s6f1ex varchar(16),
cpr_s6g1gr varchar(16),
cpr_s6g1ex varchar(16),
cpr_s6h1gr varchar(16),
cpr_s6h1ex varchar(16),
cpr_s6i1gr varchar(16),
cpr_s6i1ex varchar(16),
cpr_s7j001 varchar(16),
cpr_s7k001 varchar(16),
cpr_s7l001 varchar(16),
cpr_s7m001 varchar(16),
cpr_s7n001 varchar(16),
cpr_s7o001 varchar(16),
cpr_s7p001 varchar(16),
cpr_s7q001 varchar(16),
cpr_s7r001 varchar(16),
cpr_s7s001 varchar(16),
cpr_s8rfc1 varchar(13),
cpr_s8cur1 varchar(18),
cpr_s8nom1 varchar(100),
cpr_s8rfc2 varchar(13),
cpr_s8cur2 varchar(18),
cpr_s8nom2 varchar(100),
cpr_fecsat varchar(10),
cpr_folope varchar(20),
cpr_sireac varchar(2)
) server  options(schema 'LABCONF', table 'NMWKCPR3', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkcpr4 (
cpr_nomrep varchar(16),
cpr_keyusu numeric(10),
cpr_mesini varchar(2),
cpr_mesfin varchar(2),
cpr_ejerci varchar(4),
cpr_s1rfct varchar(13),
cpr_s1curp varchar(18),
cpr_s1nomb varchar(100),
cpr_s1mar1 varchar(1),
cpr_s1mar2 varchar(1),
cpr_s1mar3 varchar(1),
cpr_s1mar4 varchar(1),
cpr_s1entf varchar(2),
cpr_s1asim varchar(2),
cpr_s1pro1 varchar(4),
cpr_s1pro2 varchar(6),
cpr_s1pro3 varchar(4),
cpr_s1pro4 varchar(6),
cpr_s1pro5 varchar(4),
cpr_s1pro6 varchar(6),
cpr_s1pro7 varchar(4),
cpr_s1pro8 varchar(6),
cpr_s1pro9 varchar(4),
cpr_s1proa varchar(6),
cpr_s1rfp1 varchar(13),
cpr_s1rfp2 varchar(13),
cpr_s1rfp3 varchar(13),
cpr_s2amay varchar(16),
cpr_s2bmay varchar(16),
cpr_s2cmay varchar(16),
cpr_s2dmay varchar(16),
cpr_s2emay varchar(16),
cpr_s2fmay varchar(16),
cpr_s2gmay varchar(16),
cpr_s2hmay varchar(16),
cpr_s2imay varchar(16),
cpr_s2jmay varchar(16),
cpr_s2kmay varchar(16),
cpr_s2lmay varchar(16),
cpr_s2mmay varchar(16),
cpr_s3nmay varchar(16),
cpr_s3omay varchar(16),
cpr_s3pmay varchar(16),
cpr_s3qmay varchar(16),
cpr_s3rmay varchar(16),
cpr_s3smay varchar(16),
cpr_s3tmay varchar(16),
cpr_s3umay varchar(16),
cpr_s3vmay varchar(16),
cpr_s3wmay varchar(16),
cpr_s4xmay varchar(16),
cpr_s4ymay varchar(16),
cpr_s4zmay varchar(16),
cpr_s4amin varchar(16),
cpr_s4bmin varchar(16),
cpr_s4cmin varchar(16),
cpr_s4dmin varchar(16),
cpr_s4emin varchar(16),
cpr_s5fmin varchar(16),
cpr_s5gmin varchar(16),
cpr_s6hgra varchar(16),
cpr_s6hexe varchar(16),
cpr_s6igra varchar(16),
cpr_s6iexe varchar(16),
cpr_s6jgra varchar(16),
cpr_s6jexe varchar(16),
cpr_s6kgra varchar(16),
cpr_s6kexe varchar(16),
cpr_s6lgra varchar(16),
cpr_s6lexe varchar(16),
cpr_s6mgra varchar(16),
cpr_s6mexe varchar(16),
cpr_s6ngra varchar(16),
cpr_s6nexe varchar(16),
cpr_s6ogra varchar(16),
cpr_s6oexe varchar(16),
cpr_s6pgra varchar(16),
cpr_s6pexe varchar(16),
cpr_s6qgra varchar(16),
cpr_s6qexe varchar(16),
cpr_s6rgra varchar(16),
cpr_s6rexe varchar(16),
cpr_s6sgra varchar(16),
cpr_s6sexe varchar(16),
cpr_s6tgra varchar(16),
cpr_s6texe varchar(16),
cpr_s6ugra varchar(16),
cpr_s6uexe varchar(16),
cpr_s6vgra varchar(16),
cpr_s6vexe varchar(16),
cpr_s6wgra varchar(16),
cpr_s6wexe varchar(16),
cpr_s6xgra varchar(16),
cpr_s6xexe varchar(16),
cpr_s6ygra varchar(16),
cpr_s6yexe varchar(16),
cpr_s6zgra varchar(16),
cpr_s6zexe varchar(16),
cpr_s6a1gr varchar(16),
cpr_s6a1ex varchar(16),
cpr_s6b1gr varchar(16),
cpr_s6b1ex varchar(16),
cpr_s6c1gr varchar(16),
cpr_s6c1ex varchar(16),
cpr_s6d1gr varchar(16),
cpr_s6d1ex varchar(16),
cpr_s6e1gr varchar(16),
cpr_s6e1ex varchar(16),
cpr_s6f1gr varchar(16),
cpr_s6f1ex varchar(16),
cpr_s6g1gr varchar(16),
cpr_s6g1ex varchar(16),
cpr_s6h1gr varchar(16),
cpr_s6h1ex varchar(16),
cpr_s6i1gr varchar(16),
cpr_s6i1ex varchar(16),
cpr_s7j001 varchar(16),
cpr_s7k001 varchar(16),
cpr_s7l001 varchar(16),
cpr_s7m001 varchar(16),
cpr_s7n001 varchar(16),
cpr_s7o001 varchar(16),
cpr_s7p001 varchar(16),
cpr_s7q001 varchar(16),
cpr_s7r001 varchar(16),
cpr_s7s001 varchar(16),
cpr_s8rfc1 varchar(13),
cpr_s8cur1 varchar(18),
cpr_s8nom1 varchar(100),
cpr_s8rfc2 varchar(13),
cpr_s8cur2 varchar(18),
cpr_s8nom2 varchar(100),
cpr_fecsat varchar(10),
cpr_folope varchar(20),
cpr_sireac varchar(2)
) server  options(schema 'LABCONF', table 'NMWKCPR4', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkcpr5 (
cpr_nomrep varchar(16),
cpr_keyusu numeric(10),
cpr_mesini varchar(2),
cpr_mesfin varchar(2),
cpr_ejerci varchar(4),
cpr_s1rfct varchar(13),
cpr_s1curp varchar(18),
cpr_s1appa varchar(40),
cpr_s1apma varchar(40),
cpr_s1nomb varchar(60),
cpr_s1mar1 varchar(1),
cpr_s1mar2 varchar(1),
cpr_s1mar3 varchar(1),
cpr_s1mar4 varchar(1),
cpr_s1mar5 varchar(1),
cpr_s1entf varchar(2),
cpr_s1asim varchar(2),
cpr_s1pro1 varchar(4),
cpr_s1pro2 varchar(6),
cpr_s1pro3 varchar(4),
cpr_s1pro4 varchar(6),
cpr_s1pro5 varchar(4),
cpr_s1pro6 varchar(6),
cpr_s1pro7 varchar(4),
cpr_s1pro8 varchar(6),
cpr_s1pro9 varchar(4),
cpr_s1proa varchar(6),
cpr_s1rfp1 varchar(13),
cpr_s1rfp2 varchar(13),
cpr_s1rfp3 varchar(13),
cpr_s2amay varchar(16),
cpr_s2bmay varchar(16),
cpr_s2cmay varchar(16),
cpr_s2dmay varchar(16),
cpr_s2emay varchar(16),
cpr_s2fmay varchar(16),
cpr_s2gmay varchar(16),
cpr_s2hmay varchar(16),
cpr_s2imay varchar(16),
cpr_s2jmay varchar(16),
cpr_s2kmay varchar(16),
cpr_s2lmay varchar(16),
cpr_s2mmay varchar(16),
cpr_s3nmay varchar(16),
cpr_s3omay varchar(16),
cpr_s3pmay varchar(16),
cpr_s3qmay varchar(16),
cpr_s3rmay varchar(16),
cpr_s3smay varchar(16),
cpr_s3tmay varchar(16),
cpr_s3umay varchar(16),
cpr_s3vmay varchar(16),
cpr_s3wmay varchar(16),
cpr_s3xmay varchar(16),
cpr_s3amin varchar(16),
cpr_s3bmin varchar(16),
cpr_s3cmin varchar(16),
cpr_s3dmin varchar(16),
cpr_s3emin varchar(16),
cpr_s3fmin varchar(16),
cpr_s3gmin varchar(16),
cpr_s3hmin varchar(16),
cpr_s4imin varchar(16),
cpr_s4jmin varchar(16),
cpr_s4kmin varchar(16),
cpr_s4lmin varchar(16),
cpr_s4mmin varchar(16),
cpr_s4nmin varchar(16),
cpr_s5ogra varchar(16),
cpr_s5oexe varchar(16),
cpr_s5pgra varchar(16),
cpr_s5pexe varchar(16),
cpr_s5qgra varchar(16),
cpr_s5qexe varchar(16),
cpr_s5rgra varchar(16),
cpr_s5rexe varchar(16),
cpr_s5sgra varchar(16),
cpr_s5sexe varchar(16),
cpr_s5tgra varchar(16),
cpr_s5texe varchar(16),
cpr_s5ugra varchar(16),
cpr_s5uexe varchar(16),
cpr_s5vgra varchar(16),
cpr_s5vexe varchar(16),
cpr_s5wgra varchar(16),
cpr_s5wexe varchar(16),
cpr_s5xgra varchar(16),
cpr_s5xexe varchar(16),
cpr_s5ygra varchar(16),
cpr_s5yexe varchar(16),
cpr_s5zgra varchar(16),
cpr_s5zexe varchar(16),
cpr_s5a1gr varchar(16),
cpr_s5a1ex varchar(16),
cpr_s5b1gr varchar(16),
cpr_s5b1ex varchar(16),
cpr_s5c1gr varchar(16),
cpr_s5c1ex varchar(16),
cpr_s5d1gr varchar(16),
cpr_s5d1ex varchar(16),
cpr_s5e1gr varchar(16),
cpr_s5e1ex varchar(16),
cpr_s5f1gr varchar(16),
cpr_s5f1ex varchar(16),
cpr_s5g1gr varchar(16),
cpr_s5g1ex varchar(16),
cpr_s5h1gr varchar(16),
cpr_s5h1ex varchar(16),
cpr_s5i1gr varchar(16),
cpr_s5i1ex varchar(16),
cpr_s5j1gr varchar(16),
cpr_s5j1ex varchar(16),
cpr_s5k1gr varchar(16),
cpr_s5k1ex varchar(16),
cpr_s5l1gr varchar(16),
cpr_s5l1ex varchar(16),
cpr_s5m1gr varchar(16),
cpr_s5m1ex varchar(16),
cpr_s5n1gr varchar(16),
cpr_s5n1ex varchar(16),
cpr_s5o1gr varchar(16),
cpr_s5o1ex varchar(16),
cpr_s5p1gr varchar(16),
cpr_s5p1ex varchar(16),
cpr_s6q101 varchar(16),
cpr_s6r101 varchar(16),
cpr_s6s101 varchar(16),
cpr_s6t101 varchar(16),
cpr_s6u101 varchar(16),
cpr_s6v101 varchar(16),
cpr_s6w101 varchar(16),
cpr_s6x101 varchar(16),
cpr_s6y101 varchar(16),
cpr_s6z101 varchar(16),
cpr_s6a101 varchar(16),
cpr_s6b101 varchar(16),
cpr_s7rfc1 varchar(13),
cpr_s7cur1 varchar(18),
cpr_s7nom1 varchar(100),
cpr_s7rfc2 varchar(13),
cpr_s7cur2 varchar(18),
cpr_s7nom2 varchar(100),
cpr_fecsat varchar(10),
cpr_folope varchar(20),
cpr_sireac varchar(2)
) server  options(schema 'LABCONF', table 'NMWKCPR5', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkcpr6 (
cpr_nomrep varchar(16),
cpr_keyusu numeric(10),
cpr_mesini varchar(2),
cpr_mesfin varchar(2),
cpr_ejerci varchar(4),
cpr_s1rfct varchar(13),
cpr_s1curp varchar(18),
cpr_s1appa varchar(40),
cpr_s1apma varchar(40),
cpr_s1nomb varchar(60),
cpr_s1mar1 varchar(1),
cpr_s1mar2 varchar(1),
cpr_s1mar3 varchar(1),
cpr_s1mar4 varchar(1),
cpr_s1mar5 varchar(1),
cpr_s1entf varchar(2),
cpr_s1asim varchar(2),
cpr_s1pro1 varchar(4),
cpr_s1pro2 varchar(6),
cpr_s1pro3 varchar(4),
cpr_s1pro4 varchar(6),
cpr_s1pro5 varchar(4),
cpr_s1pro6 varchar(6),
cpr_s1pro7 varchar(4),
cpr_s1pro8 varchar(6),
cpr_s1pro9 varchar(4),
cpr_s1proa varchar(6),
cpr_s1rfp1 varchar(13),
cpr_s1rfp2 varchar(13),
cpr_s1rfp3 varchar(13),
cpr_s2amay varchar(16),
cpr_s2bmay varchar(16),
cpr_s2cmay varchar(16),
cpr_s2dmay varchar(16),
cpr_s2emay varchar(16),
cpr_s2fmay varchar(16),
cpr_s2gmay varchar(16),
cpr_s2hmay varchar(16),
cpr_s2imay varchar(16),
cpr_s2jmay varchar(16),
cpr_s2kmay varchar(16),
cpr_s2lmay varchar(16),
cpr_s2mmay varchar(16),
cpr_s3nmay varchar(16),
cpr_s3omay varchar(16),
cpr_s3pmay varchar(16),
cpr_s3qmay varchar(16),
cpr_s3rmay varchar(16),
cpr_s3smay varchar(16),
cpr_s3tmay varchar(16),
cpr_s3umay varchar(16),
cpr_s3vmay varchar(16),
cpr_s3wmay varchar(16),
cpr_s3xmay varchar(16),
cpr_s3ymay varchar(16),
cpr_s3amin varchar(16),
cpr_s3bmin varchar(16),
cpr_s3cmin varchar(16),
cpr_s3dmin varchar(16),
cpr_s3emin varchar(16),
cpr_s3fmin varchar(16),
cpr_s3gmin varchar(16),
cpr_s3hmin varchar(16),
cpr_s4imin varchar(16),
cpr_s4jmin varchar(16),
cpr_s4kmin varchar(16),
cpr_s4lmin varchar(16),
cpr_s4mmin varchar(16),
cpr_s4nmin varchar(16),
cpr_s5ogra varchar(16),
cpr_s5oexe varchar(16),
cpr_s5pgra varchar(16),
cpr_s5pexe varchar(16),
cpr_s5qgra varchar(16),
cpr_s5qexe varchar(16),
cpr_s5rgra varchar(16),
cpr_s5rexe varchar(16),
cpr_s5sgra varchar(16),
cpr_s5sexe varchar(16),
cpr_s5tgra varchar(16),
cpr_s5texe varchar(16),
cpr_s5ugra varchar(16),
cpr_s5uexe varchar(16),
cpr_s5vgra varchar(16),
cpr_s5vexe varchar(16),
cpr_s5wgra varchar(16),
cpr_s5wexe varchar(16),
cpr_s5xgra varchar(16),
cpr_s5xexe varchar(16),
cpr_s5ygra varchar(16),
cpr_s5yexe varchar(16),
cpr_s5zgra varchar(16),
cpr_s5zexe varchar(16),
cpr_s5a1gr varchar(16),
cpr_s5a1ex varchar(16),
cpr_s5b1gr varchar(16),
cpr_s5b1ex varchar(16),
cpr_s5c1gr varchar(16),
cpr_s5c1ex varchar(16),
cpr_s5d1gr varchar(16),
cpr_s5d1ex varchar(16),
cpr_s5e1gr varchar(16),
cpr_s5e1ex varchar(16),
cpr_s5f1gr varchar(16),
cpr_s5f1ex varchar(16),
cpr_s5g1gr varchar(16),
cpr_s5g1ex varchar(16),
cpr_s5h1gr varchar(16),
cpr_s5h1ex varchar(16),
cpr_s5i1gr varchar(16),
cpr_s5i1ex varchar(16),
cpr_s5j1gr varchar(16),
cpr_s5j1ex varchar(16),
cpr_s5k1gr varchar(16),
cpr_s5k1ex varchar(16),
cpr_s5l1gr varchar(16),
cpr_s5l1ex varchar(16),
cpr_s5m1gr varchar(16),
cpr_s5m1ex varchar(16),
cpr_s5n1gr varchar(16),
cpr_s5n1ex varchar(16),
cpr_s5o1gr varchar(16),
cpr_s5o1ex varchar(16),
cpr_s5p1gr varchar(16),
cpr_s5p1ex varchar(16),
cpr_s6q101 varchar(16),
cpr_s6r101 varchar(16),
cpr_s6s101 varchar(16),
cpr_s6t101 varchar(16),
cpr_s6u101 varchar(16),
cpr_s6v101 varchar(16),
cpr_s6w101 varchar(16),
cpr_s6x101 varchar(16),
cpr_s6y101 varchar(16),
cpr_s6z101 varchar(16),
cpr_s6a101 varchar(16),
cpr_s6b101 varchar(16),
cpr_s6c101 varchar(16),
cpr_s7rfc1 varchar(13),
cpr_s7cur1 varchar(18),
cpr_s7nom1 varchar(100),
cpr_s7rfc2 varchar(13),
cpr_s7cur2 varchar(18),
cpr_s7nom2 varchar(100),
cpr_fecsat varchar(10),
cpr_folope varchar(20),
cpr_sireac varchar(2)
) server  options(schema 'LABCONF', table 'NMWKCPR6', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkdecl (
dec_keyemp numeric(10),
dec_impcat decimal(16,2),
dec_impmov decimal(16,2)
) server  options(schema 'LABCONF', table 'NMWKDECL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwketqc (
etq_nomrep varchar(10),
etq_idepcc varchar(15),
etq_keyusu numeric(10),
etq_nomcia varchar(60),
etq_titrep varchar(60),
etq_etq001 varchar(16),
etq_etq002 varchar(16),
etq_etq003 varchar(16),
etq_etq004 varchar(16),
etq_etq005 varchar(16),
etq_etq006 varchar(16),
etq_etq007 varchar(16),
etq_etq008 varchar(16),
etq_etq009 varchar(16),
etq_etq010 varchar(16),
etq_etq011 varchar(16),
etq_etq012 varchar(16),
etq_etq013 varchar(16),
etq_etq014 varchar(16),
etq_etq015 varchar(16),
etq_etq016 varchar(16),
etq_etq017 varchar(16),
etq_etq018 varchar(16),
etq_etq019 varchar(16),
etq_etq020 varchar(8),
etq_etq021 varchar(8),
etq_etq022 varchar(8),
etq_etq023 varchar(16),
etq_etq024 varchar(8),
etq_saltos varchar(6),
etq_despli varchar(8),
etq_fecreg timestamp(0),
etq_horreg varchar(8)
) server  options(schema 'LABCONF', table 'NMWKETQC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkhism (
his_keypro numeric(5),
his_keyemp numeric(10),
his_keycon varchar(3),
his_codimp varchar(2),
his_keyper varchar(7),
his_cantid decimal(16,2),
his_import decimal(16,2),
his_idepcc varchar(15)
) server  options(schema 'LABCONF', table 'NMWKHISM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwklstc (
lst_nomrep varchar(10),
lst_idepcc varchar(15),
lst_keyusu numeric(10),
lst_numsec numeric(10),
lst_cam001 varchar(15),
lst_cam002 varchar(35),
lst_cam003 varchar(25),
lst_cor001 varchar(16),
lst_cor002 varchar(16),
lst_cor003 varchar(16),
lst_cor004 varchar(16),
lst_cor005 varchar(16),
lst_cor006 varchar(16),
lst_des001 varchar(40),
lst_des002 varchar(40),
lst_des003 varchar(40),
lst_des004 varchar(40),
lst_des005 varchar(40),
lst_des006 varchar(40),
lst_imp001 decimal(12,2),
lst_imp002 decimal(12,2),
lst_imp003 decimal(12,2),
lst_imp004 decimal(12,2),
lst_imp005 decimal(12,2),
lst_imp006 decimal(12,2),
lst_imp007 decimal(12,2),
lst_imp008 decimal(12,2),
lst_imp009 decimal(12,2),
lst_imp010 decimal(12,2),
lst_imp011 decimal(12,2),
lst_imp012 decimal(12,2),
lst_imp013 decimal(12,2),
lst_niv001 varchar(4),
lst_niv002 varchar(4),
lst_niv003 varchar(4),
lst_niv004 varchar(4),
lst_niv005 varchar(4),
lst_niv006 varchar(4),
lst_niv007 varchar(4),
lst_niv008 varchar(4),
lst_niv009 varchar(4),
lst_niv010 varchar(4),
lst_niv011 varchar(4),
lst_niv012 varchar(4),
lst_niv013 varchar(4),
lst_niv014 varchar(4),
lst_niv015 varchar(4),
lst_niv016 varchar(4),
lst_niv017 varchar(4),
lst_niv018 varchar(4),
lst_niv019 varchar(4),
lst_niv020 varchar(4),
lst_keyper varchar(60),
lst_fecini timestamp(0),
lst_fecfin timestamp(0)
) server  options(schema 'LABCONF', table 'NMWKLSTC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkmofi (
mof_keyemp numeric(10),
mof_keyims varchar(5),
mof_nummes varchar(6),
mof_numinc varchar(14),
mof_fecini timestamp(0),
mof_fecfin timestamp(0),
mof_tipims varchar(2),
mof_dianoa numeric(5)
) server  options(schema 'LABCONF', table 'NMWKMOFI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkmosu (
mos_keyemp numeric(10),
mos_keyims varchar(5),
mos_tipmov varchar(2),
mos_ordmov numeric(5),
mos_fecmov timestamp(0),
mos_hormov varchar(8),
mos_mesliq varchar(6),
mos_nomemp varchar(60),
mos_tipemp varchar(6),
mos_tipjor varchar(1),
mos_regims varchar(12),
mos_rfcemp varchar(13),
mos_recurp varchar(18),
mos_reginf varchar(12),
mos_fecinf timestamp(0),
mos_tipamo varchar(1),
mos_facamo decimal(12,6),
mos_impamo decimal(12,6),
mos_salint decimal(12,6),
mos_salrdt decimal(12,6),
mos_saleym decimal(12,6),
mos_saliyv decimal(12,6),
mos_salrcv decimal(12,6),
mos_salgps decimal(12,6),
mos_salinf decimal(12,6),
mos_diaint numeric(5),
mos_diardt numeric(5),
mos_diaeym numeric(5),
mos_diaiyv numeric(5),
mos_diarcv numeric(5),
mos_diagps numeric(5),
mos_diainf numeric(5),
mos_diafal numeric(5),
mos_diainc numeric(5)
) server  options(schema 'LABCONF', table 'NMWKMOSU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkmovt (
mov_keyemp numeric(10),
mov_keycon varchar(3),
mov_keynom numeric(5),
mov_keydep varchar(16),
mov_keypue varchar(16),
mov_cantid decimal(16,2),
mov_import decimal(16,2),
mov_fecmov timestamp(0),
mov_keyper varchar(7),
mov_keypro numeric(5),
mov_keyfor varchar(4),
mov_codimp varchar(2),
mov_codacu varchar(2),
mov_rowide decimal(16,6),
mov_ca1aux varchar(16),
mov_ca2aux varchar(16),
mov_uniope numeric(5),
mov_keyplz numeric(38),
mov_tipplz varchar(2),
mov_keyben numeric(5),
mov_comfam numeric(5)
) server  options(schema 'LABCONF', table 'NMWKMOVT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkperc (
per_keyemp numeric(10),
per_grapos decimal(16,2),
per_graneg decimal(16,2),
per_exento decimal(16,2),
per_impcas decimal(16,2),
per_totper decimal(16,2),
per_totded decimal(16,2),
per_totind decimal(16,2)
) server  options(schema 'LABCONF', table 'NMWKPERC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkpoli (
pol_keypro numeric(5),
pol_numcta varchar(20),
pol_descta varchar(30),
pol_impcar decimal(16,2),
pol_impabo decimal(16,2),
pol_keycia varchar(2),
pol_keypol varchar(10),
pol_keycon varchar(3),
pol_codacu numeric(10),
pol_import decimal(16,2),
pol_keyver numeric(5)
) server  options(schema 'LABCONF', table 'NMWKPOLI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkpoli2 (
pol_keypro numeric(38),
pol_numcta varchar(30),
pol_descta varchar(30),
pol_impcar decimal(16,2),
pol_impabo decimal(16,2),
pol_keycia varchar(2),
pol_keypol varchar(10),
pol_keycon varchar(3),
pol_codacu numeric(38),
pol_import decimal(16,2),
pol_keyver numeric(38)
) server  options(schema 'LABCONF', table 'NMWKPOLI2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkreno (
rep_keycfg varchar(5),
rep_nomrep varchar(10),
rep_idepcc varchar(15),
rep_keyusu numeric(10),
rep_keyims varchar(5),
rep_keydep varchar(16),
rep_numreg numeric(10),
rep_consec numeric(5),
rep_enc001 varchar(40),
rep_enc002 varchar(2),
rep_enc003 varchar(60),
rep_enc004 numeric(5),
rep_enc005 varchar(20),
rep_enc006 varchar(7),
rep_enc007 timestamp(0),
rep_enc008 timestamp(0),
rep_enc009 varchar(30),
rep_enc010 varchar(30),
rep_enc011 varchar(40),
rep_enc012 varchar(5),
rep_enc013 varchar(40),
rep_enc014 timestamp(0),
rep_enc015 varchar(15),
rep_enc016 varchar(10),
rep_enc017 varchar(20),
rep_enc018 varchar(20),
rep_enc019 varchar(20),
rep_enc020 decimal(12,6),
rep_enc021 varchar(20),
rep_enc022 varchar(10),
rep_enc023 varchar(16),
rep_enc024 varchar(30),
rep_enc025 decimal(18,6),
rep_cor001 varchar(30),
rep_cor002 decimal(16,2),
rep_etq001 varchar(200),
rep_etq002 varchar(200),
rep_etq003 varchar(200),
rep_etq004 varchar(200),
rep_etq005 varchar(200),
rep_etq006 varchar(200),
rep_etq007 varchar(200),
rep_etq008 varchar(200),
rep_etq009 varchar(200),
rep_etq010 varchar(200),
rep_etq011 varchar(200),
rep_etq012 varchar(200),
rep_col001 varchar(20),
rep_col002 varchar(60),
rep_col003 numeric(5),
rep_col004 decimal(16,2),
rep_col005 decimal(16,2),
rep_col006 decimal(16,2),
rep_col007 decimal(16,2),
rep_col008 decimal(16,2),
rep_col009 decimal(16,2),
rep_col010 decimal(16,2),
rep_col011 decimal(16,2),
rep_col012 decimal(16,2),
rep_col013 decimal(16,2),
rep_col014 decimal(16,2),
rep_col015 decimal(16,2),
rep_col016 decimal(16,2),
rep_col017 decimal(16,2),
rep_col018 decimal(16,2),
rep_col019 varchar(16),
rep_tot001 decimal(16,2),
rep_tot002 decimal(16,2),
rep_tot003 decimal(16,2),
rep_tot004 decimal(16,2),
rep_tot005 decimal(16,2),
rep_tot006 decimal(16,2),
rep_tot007 decimal(16,2),
rep_tot008 decimal(16,2),
rep_tot009 decimal(16,2),
rep_tot010 decimal(16,2),
rep_tot011 decimal(16,2),
rep_tot012 decimal(16,2),
rep_tot013 decimal(16,2),
rep_tot014 decimal(16,2),
rep_est001 timestamp(0),
rep_est002 varchar(10)
) server  options(schema 'LABCONF', table 'NMWKRENO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table nmwkurno (
urn_keymen varchar(8),
urn_keycfg varchar(5),
urn_descfg varchar(30),
urn_keycia varchar(2),
urn_keypro numeric(10),
urn_keynom numeric(5),
urn_tablat varchar(2),
urn_keyper varchar(200),
urn_opcper varchar(1),
urn_ran001 varchar(200),
urn_ran002 varchar(200),
urn_tiprep varchar(1),
urn_meses varchar(40)
) server  options(schema 'LABCONF', table 'NMWKURNO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plcoento (
ent_keyusu numeric(10) not null,
ent_cveent varchar(60),
ent_modulo numeric(5)
) server  options(schema 'LABCONF', table 'PLCOENTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plloceld (
cel_keyhoj varchar(5),
cel_keycol varchar(10),
cel_keycon varchar(10),
cel_fbase varchar(250),
cel_freal varchar(250),
cel_fpres varchar(250),
cel_fesp varchar(250),
cel_msknu1 varchar(15),
cel_msknu2 varchar(15),
cel_islock numeric(1)
) server  options(schema 'LABCONF', table 'PLLOCELD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllochkf (
chk_keyest varchar(3),
chk_keydep varchar(16),
chk_exiope numeric(38)
) server  options(schema 'LABCONF', table 'PLLOCHKF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plloclxh (
clh_keyhoj varchar(5),
clh_keycol varchar(10),
clh_nivel numeric(5),
clh_padre varchar(5),
clh_ordenc numeric(5),
clh_ordvis numeric(5),
clh_sizcol numeric(5)
) server  options(schema 'LABCONF', table 'PLLOCLXH', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllocnxh (
cnh_keyhoj varchar(5),
cnh_keycon varchar(10),
cnh_nivel numeric(10),
cnh_padre varchar(5),
cnh_ordenc numeric(10)
) server  options(schema 'LABCONF', table 'PLLOCNXH', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllocols (
col_keycol varchar(5),
col_keyrub varchar(5),
col_descol varchar(40),
col_tipcol varchar(1),
col_natcol varchar(1),
col_format varchar(1),
col_consol varchar(1)
) server  options(schema 'LABCONF', table 'PLLOCOLS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plloconc (
con_keycon varchar(10),
con_keyrub varchar(5),
con_descon varchar(40),
con_natcon varchar(1),
con_tipcon numeric(5),
con_manper numeric(5)
) server  options(schema 'LABCONF', table 'PLLOCONC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllocver (
cve_keymin varchar(5),
cve_keyper numeric(10),
cve_keyver varchar(5),
cve_modcal varchar(4)
) server  options(schema 'LABCONF', table 'PLLOCVER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plloecol (
ecl_keyori varchar(5),
ecl_keyext varchar(20),
ecl_keycol varchar(10),
ecl_tipdat varchar(2),
ecl_tipcol varchar(1)
) server  options(schema 'LABCONF', table 'PLLOECOL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plloecon (
ecn_keyori varchar(5),
ecn_keyext varchar(20),
ecn_keycon varchar(10),
ecn_tipdat varchar(2),
ecn_tipcon varchar(1)
) server  options(schema 'LABCONF', table 'PLLOECON', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plloeper (
epe_keymin varchar(5),
epe_keyper varchar(10),
epe_keyori varchar(5),
epe_keyext varchar(20),
epe_aux001 varchar(16),
epe_aux002 varchar(16)
) server  options(schema 'LABCONF', table 'PLLOEPER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plloetqr (
etq_idepro varchar(10),
etq_idepcc varchar(15),
etq_keyusu numeric(10),
etq_nomcia varchar(60),
etq_keymin varchar(5),
etq_desmin varchar(30),
etq_keyest varchar(3),
etq_desest varchar(30),
etq_keylib varchar(5),
etq_deslib varchar(30),
etq_keyhoj varchar(5),
etq_deshoj varchar(30),
etq_fecreg timestamp(0),
etq_horreg varchar(8),
etq_col001 varchar(40),
etq_col002 varchar(40),
etq_col003 varchar(40),
etq_col004 varchar(40),
etq_col005 varchar(40),
etq_col006 varchar(40),
etq_col007 varchar(40),
etq_col008 varchar(40),
etq_col009 varchar(40),
etq_col010 varchar(40),
etq_col011 varchar(40),
etq_col012 varchar(40),
etq_col013 varchar(40),
etq_col014 varchar(40)
) server  options(schema 'LABCONF', table 'PLLOETQR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plloexmi (
exm_keymin varchar(5),
exm_keyest varchar(5)
) server  options(schema 'LABCONF', table 'PLLOEXMI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllohjpn (
pnl_keymin varchar(5),
pnl_keypnl varchar(5),
pnl_keyhoj varchar(5),
pnl_deshoj varchar(25),
pnl_sensib numeric(10),
pnl_coment varchar(250),
pnl_autorc varchar(30),
pnl_fechac timestamp(0),
pnl_precol varchar(3),
pnl_precon varchar(2),
pnl_hojinf varchar(5),
pnl_tiphoj varchar(1),
pnl_stadel varchar(1)
) server  options(schema 'LABCONF', table 'PLLOHJPN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllohoja (
hoj_keyhoj varchar(5),
hoj_deshoj varchar(50),
hoj_sizcol numeric(5),
hoj_sizrow numeric(5)
) server  options(schema 'LABCONF', table 'PLLOHOJA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllohxli (
hxl_keylib varchar(5),
hxl_keyhoj varchar(5),
hxl_orden numeric(10)
) server  options(schema 'LABCONF', table 'PLLOHXLI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plloinfo (
inf_keymin varchar(5),
inf_keyest varchar(3),
inf_keydep varchar(18),
inf_keylib varchar(5),
inf_keyhoj varchar(5),
inf_keycon varchar(10),
inf_keycol varchar(10),
inf_keyper numeric(10),
inf_keyver varchar(5),
inf_valinf decimal(18,2),
inf_status varchar(2)
) server  options(schema 'LABCONF', table 'PLLOINFO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllolibr (
lib_keylib varchar(5),
lib_deslib varchar(40),
lib_aux001 varchar(1)
) server  options(schema 'LABCONF', table 'PLLOLIBR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllolxmn (
lxm_keymin varchar(5),
lxm_keylib varchar(5)
) server  options(schema 'LABCONF', table 'PLLOLXMN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllominf (
min_keymin varchar(5),
min_desmin varchar(30),
min_auxi01 varchar(1)
) server  options(schema 'LABCONF', table 'PLLOMINF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plloorig (
ori_keyori varchar(5),
ori_desori varchar(30)
) server  options(schema 'LABCONF', table 'PLLOORIG', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllopanl (
pnl_keymin varchar(5),
pnl_keypnl varchar(5),
pnl_despnl varchar(25)
) server  options(schema 'LABCONF', table 'PLLOPANL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllopcel (
pce_keymin varchar(5),
pce_keypnl varchar(5),
pce_keyhoj varchar(5),
pce_keypcl varchar(10),
pce_keypcn varchar(10),
pce_formul varchar(800),
pce_fomato varchar(25),
pce_color varchar(1),
pce_natura varchar(1),
pce_stadel varchar(1)
) server  options(schema 'LABCONF', table 'PLLOPCEL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plloperi (
per_keyper numeric(10),
per_keymin varchar(5),
per_keytip numeric(5),
per_nivelp numeric(5),
per_desper varchar(60),
per_fecini timestamp(0),
per_fecfin timestamp(0),
per_ppadre numeric(10),
per_agrega varchar(2),
per_ordper numeric(5),
per_status numeric(5)
) server  options(schema 'LABCONF', table 'PLLOPERI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllopncl (
pcl_keymin varchar(5),
pcl_keypnl varchar(5),
pcl_keyhoj varchar(5),
pcl_keypcl varchar(10),
pcl_despcl varchar(20),
pcl_orden numeric(10),
pcl_origen varchar(1),
pcl_momppt varchar(1)
) server  options(schema 'LABCONF', table 'PLLOPNCL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllopncn (
pcn_keymin varchar(5),
pcn_keypnl varchar(5),
pcn_keyhoj varchar(5),
pcn_keypcn varchar(10),
pcn_despcn varchar(40),
pcn_orden numeric(10),
pcn_origen varchar(1)
) server  options(schema 'LABCONF', table 'PLLOPNCN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllorepo (
rep_idepro varchar(10),
rep_idepcc varchar(15),
rep_keyusu numeric(10),
rep_keydep varchar(18),
rep_desdep varchar(30),
rep_keyver varchar(5),
rep_desver varchar(30),
rep_numsec numeric(5),
rep_keycon varchar(10),
rep_descon varchar(20),
rep_keyper numeric(10),
rep_perini timestamp(0),
rep_perfin timestamp(0),
rep_col001 decimal(18,2),
rep_col002 decimal(18,2),
rep_col003 decimal(18,2),
rep_col004 decimal(18,2),
rep_col005 decimal(18,2),
rep_col006 decimal(18,2),
rep_col007 decimal(18,2),
rep_col008 decimal(18,2),
rep_col009 decimal(18,2),
rep_col010 decimal(18,2),
rep_col011 decimal(18,2),
rep_col012 decimal(18,2),
rep_col013 decimal(18,2),
rep_col014 decimal(18,2)
) server  options(schema 'LABCONF', table 'PLLOREPO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllorubr (
rub_keyrub varchar(5),
rub_desrub varchar(40)
) server  options(schema 'LABCONF', table 'PLLORUBR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllotabl (
tab_keytab varchar(5),
tab_destab varchar(20),
tab_rentab numeric(38),
tab_valor1 double precision,
tab_valor2 double precision,
tab_valor3 double precision,
tab_valor4 double precision
) server  options(schema 'LABCONF', table 'PLLOTABL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllotipe (
tip_keytip numeric(2),
tip_destip varchar(20),
tip_period numeric(5),
tip_perbas numeric(10),
tip_agrega varchar(2)
) server  options(schema 'LABCONF', table 'PLLOTIPE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllotmce (
cel_keyhoj varchar(5),
cel_keycol varchar(10),
cel_keycon varchar(10),
cel_fbase varchar(250),
cel_freal varchar(250),
cel_fpres varchar(250),
cel_fesp varchar(250),
cel_msknu1 varchar(15),
cel_msknu2 varchar(15),
cel_islock double precision
) server  options(schema 'LABCONF', table 'PLLOTMCE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllotmpc (
cel_keyhoj varchar(5),
cel_keycol varchar(10),
cel_keycon varchar(10),
cel_fbase varchar(250),
cel_freal varchar(250),
cel_fpres varchar(250),
cel_fesp varchar(250),
cel_msknu1 varchar(15),
cel_msknu2 varchar(15),
cel_islock double precision
) server  options(schema 'LABCONF', table 'PLLOTMPC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllovars (
var_keyvar varchar(5),
var_desvar varchar(25)
) server  options(schema 'LABCONF', table 'PLLOVARS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllovers (
ver_keyver varchar(5),
ver_desver varchar(30),
ver_caldef varchar(4),
ver_tipver numeric(5)
) server  options(schema 'LABCONF', table 'PLLOVERS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pllovxen (
vxe_keyvar varchar(5),
vxe_keymin varchar(5),
vxe_keyest varchar(3),
vxe_keydep varchar(16),
vxe_keyper numeric(10),
vxe_keyver varchar(5),
vxe_valvar decimal(12,6)
) server  options(schema 'LABCONF', table 'PLLOVXEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table plzapaso (
ora_noctvo numeric(38) not null,
plz_keyest varchar(3) not null,
plz_keydep varchar(16) not null,
plz_keypue varchar(16) not null,
plz_keyplz numeric(38) not null,
plz_keycat varchar(16),
plz_keyloc varchar(16),
plz_tippla varchar(2) not null,
plz_fecini timestamp(0) not null,
plz_fecfin timestamp(0),
plz_diavig numeric(38),
plz_turnop numeric(38),
plz_keyhor varchar(16),
plz_keyemp numeric(38) not null,
plz_cveuoc numeric(38),
plz_cverem numeric(38),
plz_fecmov timestamp(0),
plz_submov varchar(2),
plz_cosplz decimal(14,2),
plz_ca1aux varchar(16) not null,
plz_ca2aux varchar(16) not null,
plz_ca3aux varchar(16),
plz_nu1aux varchar(10),
plz_nu2aux varchar(10),
plz_nu3aux varchar(10),
plz_fe1aux varchar(10),
plz_fe2aux varchar(10),
plz_fe3aux timestamp(0),
plz_co1aux decimal(14,2),
plz_co2aux decimal(14,2),
plz_co3aux decimal(14,2),
plz_co4aux decimal(14,2),
plz_co5aux decimal(14,2),
plz_keysue varchar(4),
plz_sueniv numeric(38),
plz_subniv numeric(38),
plz_cobert varchar(2),
plz_keypro numeric(38) not null,
plz_keydpl decimal(16,6),
plz_fecocu timestamp(0),
plz_salplz decimal(12,2) not null,
plz_titula numeric(38),
plz_origen varchar(2),
plz_valimp varchar(2),
plz_limocu timestamp(0),
plz_tiptab varchar(2)
) server  options(schema 'LABCONF', table 'PLZAPASO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pplocias (
cia_keycia varchar(4),
cia_descri varchar(60)
) server  options(schema 'LABCONF', table 'PPLOCIAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pplovers (
ver_keycia char(4) options (key 'true') not null,
ver_anio numeric(38) options (key 'true') not null,
ver_mes numeric(38) options (key 'true') not null,
ver_keyver numeric(38) options (key 'true') not null,
ver_descri char(30) not null,
ver_status numeric(38) not null
) server  options(schema 'LABCONF', table 'PPLOVERS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table pppagrales (
gra_keysec numeric(38) not null,
gra_descri char(60) not null,
gra_valor char(255) not null
) server  options(schema 'LABCONF', table 'PPPAGRALES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table ps_tpw_msgxconcs (
msgs_keypro numeric(38),
msgs_keyper varchar(7),
msgs_keycon char(3),
msgs_tipocon numeric(5)
) server  options(schema 'LABCONF', table 'PS_TPW_MSGXCONCS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table rbosmsgs (
msg_keypro numeric(38) not null,
msg_keyper varchar(7) not null,
msg_keynom numeric(38) not null,
msg_nompar varchar(140) not null,
msg_folini varchar(16) not null,
msg_folfin varchar(16) not null
) server  options(schema 'LABCONF', table 'RBOSMSGS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table recibos_generacion (
id numeric(38),
eje_feceje timestamp not null,
eje_mensaj varchar(4000),
eje_error numeric(1) not null,
eje_keypro numeric(5),
eje_keyper varchar(7)
) server  options(schema 'LABCONF', table 'RECIBOS_GENERACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table recibos_interface (
id numeric(38),
eje_feceje timestamp not null,
eje_mensaj varchar(4000),
eje_error numeric(1) not null
) server  options(schema 'LABCONF', table 'RECIBOS_INTERFACE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table rpcodequ (
deq_keyrep varchar(16),
deq_defvar varchar(16),
deq_numsec numeric(38),
deq_detqry varchar(200)
) server  options(schema 'LABCONF', table 'RPCODEQU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table rpcoderp (
der_keyrep varchar(16),
der_keycam varchar(20),
der_numcam numeric(38),
der_keycor varchar(20),
der_posini numeric(38),
der_posfin numeric(38),
der_renglo numeric(38),
der_column numeric(38),
der_alinea numeric(38),
der_format numeric(38),
der_funcio numeric(38),
der_tiplet numeric(38),
der_posubi numeric(38),
der_oculta numeric(38),
der_valdes numeric(38),
der_clausu varchar(6),
der_ordcam varchar(4),
der_etique varchar(30)
) server  options(schema 'LABCONF', table 'RPCODERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table rpcoenqu (
enq_keyrep varchar(16),
enq_idepcc varchar(15),
enq_keyusu numeric(38),
enq_fecela timestamp(0),
enq_fecact timestamp(0),
enq_titrep varchar(80),
enq_status varchar(1),
enq_desrep varchar(60),
enq_usuexp varchar(1)
) server  options(schema 'LABCONF', table 'RPCOENQU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table rpcoenrp (
enr_keyrep varchar(16),
enr_orihoj varchar(1),
enr_linpag numeric(38),
enr_linepa numeric(38),
enr_letenc numeric(38),
enr_encab1 varchar(50),
enr_encab2 varchar(50),
enr_encab3 varchar(50),
enr_encab4 varchar(50),
enr_letdet numeric(38),
enr_espcol numeric(38),
enr_delimi varchar(1),
enr_letpie numeric(38),
enr_piepa1 varchar(30),
enr_piepa2 varchar(30),
enr_swipie varchar(5)
) server  options(schema 'LABCONF', table 'RPCOENRP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table rpcoetiq (
eti_keyrep varchar(16),
eti_keycam varchar(18),
eti_etique varchar(20)
) server  options(schema 'LABCONF', table 'RPCOETIQ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table rpcosegm (
seg_keyrep varchar(16),
seg_keymen varchar(4),
seg_repfor varchar(3),
seg_permen numeric(5)
) server  options(schema 'LABCONF', table 'RPCOSEGM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table rpcosegu (
seg_keyrep varchar(16),
seg_keymen varchar(4),
seg_repfor varchar(3),
seg_keyusu numeric(10),
seg_perusu numeric(5)
) server  options(schema 'LABCONF', table 'RPCOSEGU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table rpcospro (
spr_keyspr varchar(16),
spr_desspr varchar(60),
spr_parent varchar(200),
spr_keyrpt varchar(12),
spr_keytab varchar(18),
spr_iderep varchar(18),
spr_idepcc varchar(18),
spr_ideusu varchar(18),
spr_keyrep varchar(16),
spr_keyfor varchar(16)
) server  options(schema 'LABCONF', table 'RPCOSPRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table rpfmtcam (
cam_keyrep varchar(16),
cam_numsec numeric(38),
cam_keycam varchar(16),
cam_format varchar(100)
) server  options(schema 'LABCONF', table 'RPFMTCAM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sccobaja (
baj_keyemp numeric(5),
baj_fecbaj timestamp(0),
baj_feccap timestamp(0),
baj_cvebaj varchar(2),
baj_cvemot varchar(2),
baj_status varchar(2),
baj_keyusu numeric(5),
baj_fecims timestamp(0),
baj_numliq varchar(6),
baj_perbaj varchar(7),
baj_traemp numeric(38),
baj_trapro numeric(5)
) server  options(schema 'LABCONF', table 'SCCOBAJA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sccocoma (
com_keyplz numeric(5),
com_keyemp numeric(5),
com_fecmov timestamp(0),
com_tipmov varchar(2),
com_keyusu numeric(5),
com_feccap timestamp(0),
com_status varchar(2),
com_salcon decimal(12,6),
com_keyims varchar(5)
) server  options(schema 'LABCONF', table 'SCCOCOMA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sclodepu (
dep_tipfol varchar(2),
dep_keysoe varchar(10),
dep_regrfc varchar(13),
dep_nomsol varchar(60),
dep_domsol varchar(30),
dep_colsol varchar(20),
dep_cidsol varchar(20),
dep_pobsol varchar(20),
dep_munsol varchar(6),
dep_entsol varchar(2),
dep_codsol varchar(5),
dep_telsol varchar(10),
dep_cvesex varchar(1),
dep_uniope varchar(4),
dep_ubicon varchar(16),
dep_empres numeric(5),
dep_fecsol timestamp(0),
dep_horsol varchar(5),
dep_fecuac timestamp(0),
dep_horuac varchar(5),
dep_keyfue varchar(16),
dep_recurp varchar(18),
dep_regims varchar(12),
dep_keyemp numeric(5),
dep_diadis numeric(5),
dep_cvetur numeric(5),
dep_keyhor varchar(16),
dep_suesol decimal(12,2),
dep_puesol varchar(40),
dep_pueasi varchar(16),
dep_status varchar(2),
dep_fe1aux timestamp(0),
dep_fe2aux timestamp(0),
dep_fe3aux timestamp(0),
dep_fe4aux timestamp(0),
dep_ca1aux varchar(10),
dep_ca2aux varchar(10),
dep_ca3aux varchar(10),
dep_ca4aux varchar(10),
dep_ca5aux varchar(10),
dep_ca6aux varchar(10),
dep_keysoc varchar(10),
dep_tipmov varchar(4),
dep_tipemp varchar(1),
dep_keydep varchar(16),
dep_keypue varchar(16),
dep_keyplz numeric(5),
dep_keyreq varchar(10),
dep_fecven timestamp(0),
dep_tipjor varchar(1),
dep_tippla varchar(4),
dep_keycat varchar(16),
dep_keyloc varchar(16),
dep_keypro numeric(5),
dep_diavig numeric(5)
) server  options(schema 'LABCONF', table 'SCLODEPU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sclofact (
fac_keysoc varchar(10),
fac_keyfac varchar(6),
fac_valor numeric(5)
) server  options(schema 'LABCONF', table 'SCLOFACT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sclofure (
fur_keyfue varchar(16),
fur_fecreg timestamp(0),
fur_tipfue varchar(6),
fur_nomfue varchar(40),
fur_domfue varchar(60),
fur_edofue varchar(20),
fur_telfue varchar(40),
fur_nomag1 varchar(40),
fur_pueag1 varchar(40),
fur_nomag2 varchar(40),
fur_pueag2 varchar(40),
fur_nomag3 varchar(40),
fur_pueag3 varchar(40),
fur_status varchar(2),
fur_fecsta timestamp(0),
fur_faxfue varchar(20),
fur_horate varchar(20)
) server  options(schema 'LABCONF', table 'SCLOFURE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sclopeso (
pes_keysoe varchar(10),
pes_keypue varchar(16),
pes_keyemp numeric(5),
pes_keypes varchar(6),
pes_porcen varchar(6)
) server  options(schema 'LABCONF', table 'SCLOPESO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sclorequ (
req_keyreq varchar(10),
req_fecreq timestamp(0),
req_tipreq varchar(4),
req_keydep varchar(16),
req_keypue varchar(16),
req_cvetur numeric(5),
req_keyhor varchar(16),
req_keypla numeric(5),
req_tipplz varchar(2),
req_claplz varchar(2),
req_canreq numeric(5),
req_cancon numeric(5),
req_peraut varchar(20),
req_feccum timestamp(0),
req_diareq numeric(5),
req_status varchar(2),
req_uniope varchar(4),
req_ubicon varchar(16),
req_fecuac timestamp(0),
req_horuac varchar(8),
req_empres numeric(5),
req_fe1aux timestamp(0),
req_fe2aux timestamp(0),
req_fe3aux timestamp(0),
req_fe4aux timestamp(0),
req_ca1aux varchar(10),
req_ca2aux varchar(10),
req_ca3aux varchar(10),
req_ca4aux varchar(10),
req_ca5aux varchar(10),
req_ca6aux varchar(10)
) server  options(schema 'LABCONF', table 'SCLOREQU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sclosoco (
soc_keysoc varchar(10),
soc_fecsol timestamp(0),
soc_horsol varchar(5),
soc_tipmov varchar(4),
soc_keyemp numeric(5),
soc_nomsol varchar(60),
soc_regrfc varchar(13),
soc_regims varchar(12),
soc_tipemp varchar(1),
soc_keydep varchar(16),
soc_keypue varchar(16),
soc_keyplz numeric(5),
soc_cvetur numeric(5),
soc_keyhor varchar(16),
soc_keyfue varchar(16),
soc_suesol decimal(12,2),
soc_uniope varchar(4),
soc_ubicon varchar(16),
soc_empres numeric(5),
soc_fecuac timestamp(0),
soc_horuac varchar(5),
soc_keyreq varchar(10),
soc_fecven timestamp(0),
soc_status varchar(2),
soc_tipjor varchar(1),
soc_tipplz varchar(2),
soc_claplz varchar(2),
soc_keycat varchar(16),
soc_keyloc varchar(16),
soc_keypro numeric(5),
soc_fe1aux timestamp(0),
soc_fe2aux timestamp(0),
soc_fe3aux timestamp(0),
soc_fe4aux timestamp(0),
soc_ca1aux varchar(10),
soc_ca2aux varchar(10),
soc_ca3aux varchar(10),
soc_ca4aux varchar(10),
soc_ca5aux varchar(10),
soc_ca6aux varchar(10),
soc_recurp varchar(18),
soc_diavig numeric(5),
soc_ca7aux varchar(10),
soc_ca8aux varchar(10),
soc_ca9aux varchar(10),
soc_c10aux varchar(10),
soc_c11aux varchar(10),
soc_c12aux varchar(10),
soc_c13aux varchar(10),
soc_c14aux varchar(10),
soc_observ varchar(60),
soc_keysoe varchar(10)
) server  options(schema 'LABCONF', table 'SCLOSOCO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sclosoem (
soe_keysoe varchar(10),
soe_regrfc varchar(13),
soe_nomsol varchar(60),
soe_domsol varchar(30),
soe_colsol varchar(20),
soe_cidsol varchar(20),
soe_pobsol varchar(20),
soe_munsol varchar(6),
soe_entsol varchar(2),
soe_codsol varchar(5),
soe_telsol varchar(10),
soe_cvesex varchar(1),
soe_uniope varchar(4),
soe_ubicon varchar(16),
soe_empres numeric(5),
soe_fecsol timestamp(0),
soe_horsol varchar(5),
soe_fecuac timestamp(0),
soe_horuac varchar(5),
soe_keyfue varchar(16),
soe_recurp varchar(18),
soe_regims varchar(12),
soe_keyemp numeric(5),
soe_diadis numeric(5),
soe_cvetur numeric(5),
soe_keyhor varchar(16),
soe_suesol decimal(12,2),
soe_puesol varchar(40),
soe_pueasi varchar(16),
soe_status varchar(2),
soe_fe1aux timestamp(0),
soe_fe2aux timestamp(0),
soe_fe3aux timestamp(0),
soe_fe4aux timestamp(0),
soe_ca1aux varchar(10),
soe_ca2aux varchar(10),
soe_ca3aux varchar(10),
soe_ca4aux varchar(10),
soe_ca5aux varchar(10),
soe_ca6aux varchar(10),
soe_ca7aux varchar(10),
soe_ca8aux varchar(10),
soe_ca9aux varchar(10),
soe_c10aux varchar(10),
soe_c11aux varchar(10),
soe_c12aux varchar(10),
soe_c13aux varchar(10),
soe_c14aux varchar(10),
soe_observ varchar(60)
) server  options(schema 'LABCONF', table 'SCLOSOEM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table shloacci (
acc_keyemp numeric(10),
acc_regrfc varchar(13),
acc_numsup numeric(10),
acc_extnor varchar(1),
acc_fecate timestamp(0),
acc_horate varchar(5),
acc_ulttie varchar(1),
acc_incest numeric(10),
acc_fecalt timestamp(0),
acc_incesi numeric(10),
acc_fecali timestamp(0),
acc_diagno varchar(60),
acc_keydep varchar(16),
acc_keypue varchar(16),
acc_fecacc timestamp(0),
acc_horacc varchar(5),
acc_tiedes numeric(10),
acc_horext numeric(10),
acc_hortra numeric(10),
acc_diades numeric(10),
acc_trades varchar(60),
acc_desacc varchar(200),
acc_lesion varchar(200),
acc_accdef varchar(60),
acc_accfal varchar(60),
acc_accequ varchar(60),
acc_accacc varchar(60),
acc_accent varchar(60),
acc_acccon varchar(60),
acc_accfec timestamp(0),
acc_fecent timestamp(0),
acc_cosacc decimal(8,2),
acc_escola varchar(20),
acc_totant numeric(10),
acc_totact numeric(10),
acc_cosequ decimal(8,2),
acc_cosmat decimal(8,2),
acc_cosinc decimal(8,2),
acc_seg001 varchar(1),
acc_seg002 varchar(1),
acc_seg003 varchar(1),
acc_seg004 varchar(1),
acc_seg005 varchar(1),
acc_exp001 varchar(40),
acc_exp002 varchar(40),
acc_exp003 varchar(40),
acc_exp004 varchar(40),
acc_exp005 varchar(40),
acc_correc varchar(200),
acc_fecinv timestamp(0),
acc_trayec varchar(1),
acc_testig varchar(60),
acc_tiperd varchar(10),
acc_terseg varchar(60),
acc_saliop varchar(1),
acc_fecsal timestamp(0),
acc_horsal varchar(5),
acc_regrep varchar(1),
acc_fecreg timestamp(0),
acc_horreg varchar(5),
acc_prulab varchar(1),
acc_posmar varchar(1),
acc_poscoc varchar(1),
acc_posanf varchar(1)
) server  options(schema 'LABCONF', table 'SHLOACCI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table shlocodi (
cod_keyemp numeric,
cod_regrfc varchar(13),
cod_keydep varchar(16),
cod_keypue varchar(16),
cod_edaemp numeric(38),
cod_cvetur numeric(38),
cod_diainc numeric(38),
cod_feccon timestamp(0),
cod_diagno varchar(6),
cod_tratam varchar(6),
cod_tratex varchar(200)
) server  options(schema 'LABCONF', table 'SHLOCODI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table shlodeac (
dea_keyemp numeric,
dea_regrfc varchar(13),
dea_cvesec varchar(6),
dea_fecacc timestamp(0)
) server  options(schema 'LABCONF', table 'SHLODEAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table shlodecd (
dec_keyemp numeric,
dec_regrfc varchar(13),
dec_cveenf varchar(10),
dec_fecenf timestamp(0)
) server  options(schema 'LABCONF', table 'SHLODECD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table shlodehi (
deh_keyemp numeric,
deh_regrfc varchar(13),
deh_cvesec varchar(6)
) server  options(schema 'LABCONF', table 'SHLODEHI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table shloevme (
evm_keyfec timestamp(0),
evm_keyemp numeric(10),
evm_regrfc varchar(13),
evm_rspfun varchar(100),
evm_rsprad varchar(100),
evm_rspcli varchar(100),
evm_circli varchar(100),
evm_cirart varchar(60),
evm_cirvar varchar(6),
evm_cirecg varchar(60),
evm_ciresp varchar(60),
evm_cirbhc varchar(60),
evm_digcav varchar(6),
evm_digher varchar(6),
evm_digcli varchar(200),
evm_diglab varchar(100),
evm_digend varchar(100),
evm_gencli varchar(200),
evm_genlab varchar(200),
evm_nersen varchar(6),
evm_nerref varchar(6),
evm_nerfun varchar(6),
evm_nerobs varchar(200),
evm_visdal varchar(1),
evm_visagu varchar(1),
evm_viscod varchar(6),
evm_viscoi varchar(6),
evm_viscao varchar(6),
evm_vislod varchar(6),
evm_visloi varchar(6),
evm_vislao varchar(6),
evm_vishem varchar(50),
evm_viscam varchar(50),
evm_visper varchar(50),
evm_visref varchar(6),
evm_visaco varchar(6),
evm_vismot varchar(6),
evm_audaud varchar(50),
evm_audfre varchar(50),
evm_audizq varchar(50),
evm_audder varchar(50),
evm_audhbc varchar(50),
evm_audcli varchar(100),
evm_musart varchar(50),
evm_musmio varchar(50),
evm_musmov varchar(6),
evm_musfue varchar(6),
evm_muston varchar(6),
evm_musmar varchar(6),
evm_musano varchar(1),
evm_desmoa varchar(100),
evm_gcabez varchar(50),
evm_geojos varchar(50),
evm_gnariz varchar(50),
evm_ggarga varchar(50),
evm_gtorax varchar(50),
evm_gecara varchar(50),
evm_goidos varchar(50),
evm_geboca varchar(50),
evm_gcuell varchar(50),
evm_gcardi varchar(50),
evm_gcapul varchar(50),
evm_gmisup varchar(50),
evm_gmarch varchar(50),
evm_gcomen varchar(100),
evm_gimpdi varchar(100),
evm_gabdom varchar(50),
evm_gmiinf varchar(50),
evm_gconcl varchar(50)
) server  options(schema 'LABCONF', table 'SHLOEVME', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table shlohicl (
hic_keyemp numeric,
hic_regrfc varchar(13),
hic_chk001 varchar(1),
hic_chk002 varchar(1),
hic_chk003 varchar(1),
hic_chk004 varchar(1),
hic_chk005 varchar(1),
hic_chk006 varchar(1),
hic_chk007 varchar(1),
hic_chk008 varchar(1),
hic_chk009 varchar(1),
hic_chk010 varchar(1),
hic_chk011 varchar(1),
hic_chk012 varchar(1),
hic_chk013 varchar(1),
hic_chk014 varchar(1),
hic_chk015 varchar(1),
hic_chk016 varchar(1),
hic_chk017 varchar(1),
hic_chk018 varchar(1),
hic_chk019 varchar(1),
hic_chk020 varchar(1),
hic_chk021 varchar(1),
hic_chk022 varchar(1),
hic_rad002 varchar(1),
hic_rad009 varchar(1),
hic_rad012 varchar(1),
hic_rad013 varchar(1),
hic_rad017 varchar(1),
hic_rad021 varchar(1),
hic_rad028 varchar(1),
hic_rad032 varchar(1),
hic_rad036 varchar(1),
hic_rad040 varchar(1),
hic_rad041 varchar(1),
hic_rad045 varchar(1),
hic_rad049 varchar(1),
hic_txt001 varchar(40),
hic_txt003 varchar(40),
hic_txt004 varchar(2),
hic_txt005 varchar(40),
hic_txt006 varchar(90),
hic_txt007 varchar(90),
hic_txt008 varchar(2),
hic_txt009 varchar(90),
hic_txt010 varchar(90),
hic_txt011 varchar(90),
hic_txt012 varchar(10),
hic_txt013 varchar(10),
hic_txt014 varchar(10),
hic_txt015 varchar(10),
hic_txt016 varchar(10),
hic_txt017 varchar(10),
hic_txt018 varchar(10),
hic_txt019 varchar(10),
hic_txt020 varchar(200),
hic_txt026 varchar(20),
hic_txt027 varchar(40),
hic_txt028 varchar(20),
hic_txt029 varchar(40),
hic_txt030 varchar(90),
hic_txt031 varchar(90),
hic_txt032 varchar(90),
hic_txt033 varchar(90),
hic_txt034 varchar(90),
hic_txt035 varchar(90),
hic_txt036 varchar(90),
hic_txt037 varchar(10),
hic_txt038 varchar(10),
hic_txt039 varchar(10),
hic_txt040 varchar(10),
hic_txt041 varchar(10),
hic_txt042 varchar(10),
hic_txt043 varchar(10),
hic_txt044 varchar(10),
hic_txt045 varchar(10),
hic_txt046 varchar(10),
hic_txt047 varchar(10),
hic_txt048 varchar(10),
hic_txt049 varchar(10),
hic_txt050 varchar(10),
hic_txt051 varchar(10),
hic_txt052 varchar(10),
hic_txt053 varchar(10),
hic_txt054 varchar(10),
hic_txt055 varchar(10),
hic_txt056 varchar(10),
hic_txt057 varchar(10),
hic_txt00a varchar(100),
hic_txt00b varchar(100),
hic_txt00c varchar(500)
) server  options(schema 'LABCONF', table 'SHLOHICL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sipros_erp_caietu (
ape_keypol varchar(30),
ape_fecpol timestamp(0),
ape_despro varchar(40),
ape_tipfac varchar(8),
ape_tipmon varchar(3),
ape_tipcam numeric(38),
ape_terpag varchar(10),
ape_rfcban varchar(20),
ape_sucban varchar(20),
ape_totreg numeric(38),
ape_import decimal(16,2),
ape_source varchar(10),
ape_status varchar(1),
ape_keyemp numeric(38),
ape_keylot varchar(20),
ape_fecmod timestamp(0),
ape_auxnu1 numeric(38),
ape_auxca1 varchar(100),
ape_caietu numeric(38)
) server  options(schema 'LABCONF', table 'SIPROS_ERP_CAIETU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sipros_erp_det (
apd_keypol varchar(30),
apd_fecpol timestamp(0),
apd_numlin numeric(38),
apd_ciaemi varchar(3),
segment1 varchar(3),
apd_cveban varchar(20),
apd_cvecta varchar(1),
segment2 varchar(2),
segment3 varchar(3),
segment4 varchar(6),
segment5 varchar(8),
segment6 varchar(3),
segment7 varchar(1),
apd_tipmov varchar(1),
apd_import decimal(16,2),
apd_progas varchar(1),
apd_keyemp numeric(38),
apd_keylot varchar(20),
apd_auxnu1 numeric(38),
apd_auxca1 varchar(20),
apd_caietu numeric(38)
) server  options(schema 'LABCONF', table 'SIPROS_ERP_DET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sipros_erp_det_tmp (
apd_keypol varchar(30),
apd_fecpol timestamp(0),
apd_numlin numeric(38),
apd_ciaemi varchar(3),
apd_ciapag varchar(3),
apd_cveban varchar(20),
apd_cvecta varchar(1),
apd_cuenta varchar(3),
apd_subcta varchar(3),
apd_ssbcta varchar(3),
apd_codra1 varchar(3),
apd_codra2 varchar(4),
apd_cencos varchar(8),
apd_tipmov varchar(1),
apd_import decimal(16,2),
apd_progas varchar(1),
apd_keyemp numeric(38),
apd_keylot varchar(20),
apd_auxnu1 numeric(38),
apd_auxca1 varchar(20),
apd_caietu numeric(38)
) server  options(schema 'LABCONF', table 'SIPROS_ERP_DET_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table sipros_erp_enc (
ape_keypol varchar(30),
ape_fecpol timestamp(0),
ape_despro varchar(40),
ape_tipfac varchar(8),
ape_tipmon varchar(3),
ape_tipcam numeric(38),
ape_terpag varchar(10),
ape_rfcban varchar(20),
ape_sucban varchar(20),
ape_totreg numeric(38),
ape_import decimal(16,2),
ape_source varchar(10),
ape_status varchar(1),
ape_keyemp numeric(38),
ape_keylot varchar(20),
ape_fecmod timestamp(0),
ape_auxnu1 numeric(38),
ape_auxca1 varchar(100)
) server  options(schema 'LABCONF', table 'SIPROS_ERP_ENC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tmpconrec (
rec_keypro numeric(38),
rec_keyper varchar(7),
rec_keynom numeric(38),
rec_keycon varchar(3),
rec_codimp varchar(2),
rec_numrec varchar(10),
rec_agrupa varchar(10),
rec_secuen varchar(10),
rec_subtpo numeric(38),
rec_strcon varchar(300)
) server  options(schema 'LABCONF', table 'TMPCONREC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tmpconrec2 (
rec_keypro numeric(38),
rec_keyper varchar(7),
rec_keynom numeric(38),
rec_keycon varchar(3),
rec_codimp varchar(2),
rec_numrec varchar(10),
rec_agrupa varchar(10),
rec_secuen varchar(10),
rec_subtpo numeric(38),
rec_strcon varchar(80)
) server  options(schema 'LABCONF', table 'TMPCONREC2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tmprecibos (
field1 numeric(38),
field2 varchar(250),
field3 varchar(10),
field4 varchar(4),
dia numeric(38),
mes numeric(38)
) server  options(schema 'LABCONF', table 'TMPRECIBOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tmp_tvnivsue (
f0 numeric(38),
f1 varchar(7),
f2 varchar(13),
f3 varchar(18),
f4 varchar(60),
f5 varchar(4),
f6 varchar(2),
f7 varchar(2),
f8 numeric(38),
f9 numeric(38),
f10 numeric(38),
f11 numeric(38),
f12 numeric(38),
f13 numeric(38),
f14 numeric(38),
f15 numeric(38),
f16 numeric(38),
f17 numeric(38),
f18 numeric(38),
f19 numeric(38),
f20 numeric(38),
f21 numeric(38),
f22 numeric(38),
f23 numeric(38),
f24 numeric(38),
f25 numeric(38),
f26 numeric(38),
f27 numeric(38),
f28 numeric(38),
f29 numeric(38),
f30 numeric(38),
f31 numeric(38),
f32 numeric(38),
f33 numeric(38),
f34 numeric(38),
f35 numeric(38),
f36 numeric(38),
f37 numeric(38),
f38 numeric(38),
f39 numeric(38),
f40 numeric(38),
f41 numeric(38),
f42 numeric(38),
f43 numeric(38),
f44 numeric(38),
f45 numeric(38),
f46 numeric(38),
f47 numeric(38),
f48 numeric(38),
f49 numeric(38),
f50 numeric(38),
f51 numeric(38),
f52 numeric(38),
f53 numeric(38),
f54 numeric(38),
f55 numeric(38),
f56 numeric(38),
f57 numeric(38),
f58 numeric(38),
f59 numeric(38),
f60 numeric(38),
f61 numeric(38),
f62 numeric(38),
f63 numeric(38),
f64 numeric(38),
f65 numeric(38),
f66 numeric(38),
f67 numeric(38),
f68 numeric(38),
f69 numeric(38),
f70 numeric(38),
f71 numeric(38),
f72 varchar(1),
f73 numeric(38),
f74 numeric(38),
f75 numeric(38),
f76 numeric(38),
f77 numeric(38),
f78 numeric(38),
f79 numeric(38)
) server  options(schema 'LABCONF', table 'TMP_TVNIVSUE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table traypaso (
ora_noctvo numeric(38) not null,
ora_status varchar(2),
ora_fecmod timestamp(0),
tra_keyemp numeric(38),
tra_fecmov timestamp(0),
tra_tipmov varchar(2),
tra_keydep varchar(16),
tra_keypue varchar(16),
tra_keycat varchar(16),
tra_keycen varchar(16),
tra_saldia decimal(12,6),
tra_salmes decimal(12,2),
tra_salint decimal(12,6),
tra_salivc decimal(12,6),
tra_salinf decimal(12,6),
tra_intsin decimal(12,6),
tra_infsin decimal(12,6),
tra_keyims varchar(5),
tra_keyper varchar(7),
tra_codloc varchar(16),
tra_keypla numeric(38),
tra_keypro numeric(38),
tra_jorlab varchar(1),
tra_unijor decimal(4,2),
tra_submov varchar(6),
tra_ca1aux varchar(10),
tra_ca2aux varchar(10),
tra_fecmod timestamp(0),
tra_hormod varchar(8)
) server  options(schema 'LABCONF', table 'TRAYPASO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvcapdes (
pde_keyemp numeric(38) not null,
pde_recurp char(18) not null,
pde_fecmov timestamp(0) not null,
pde_capnew decimal(16,2) not null,
pde_fecant timestamp(0) not null,
pde_capant decimal(16,2) not null,
pde_status numeric(38) not null,
pde_horant char(10) not null,
pde_hormov char(10) not null
) server  options(schema 'LABCONF', table 'TVCAPDES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvcapdes_i (
movimiento varchar(10) not null,
marca varchar(2),
old_pde_keyemp numeric(38),
old_pde_recurp varchar(18),
old_pde_fecmov timestamp(0),
old_pde_capnew numeric(16),
old_pde_fecant timestamp(0),
old_pde_capant numeric(16),
old_pde_status numeric(38),
old_pde_horant varchar(10),
old_pde_hormov varchar(10),
new_pde_keyemp numeric(38),
new_pde_recurp varchar(18),
new_pde_fecmov timestamp(0),
new_pde_capnew numeric(16),
new_pde_fecant timestamp(0),
new_pde_capant numeric(16),
new_pde_status numeric(38),
new_pde_horant varchar(10),
new_pde_hormov varchar(10),
orderid1 timestamp(0),
orderid2 numeric(10) not null
) server  options(schema 'LABCONF', table 'TVCAPDES_I', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvconagp (
agp_numagr numeric(38) not null,
agp_keycon varchar(3) not null,
agp_desagp varchar(50)
) server  options(schema 'LABCONF', table 'TVCONAGP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvdiaobl (
dob_fecha timestamp(0) not null,
dob_descri varchar(50)
) server  options(schema 'LABCONF', table 'TVDIAOBL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvlobadi (
bad_keyemp numeric(38),
bad_comfam numeric(38),
bad_keyben numeric(38),
bad_domben varchar(100),
bad_numext varchar(100),
bad_numint varchar(100),
bad_colben varchar(100),
bad_pobben varchar(100),
bad_munben varchar(16),
bad_entben varchar(16),
bad_codben varchar(10),
bad_email varchar(100),
bad_tel1 varchar(12),
bad_tel2 varchar(12),
bad_numofi varchar(20),
bad_fecofi timestamp(0),
bad_juzgad varchar(100)
) server  options(schema 'LABCONF', table 'TVLOBADI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvlofacd (
fde_keyfac varchar(30) not null,
fde_numlin numeric(38) not null,
fde_cia varchar(3) not null,
fde_neg varchar(2) not null,
fde_cta varchar(3) not null,
fde_scta varchar(6) not null,
fde_cc varchar(8) not null,
fde_icia varchar(3) not null,
fde_top varchar(1) not null,
fde_ietu varchar(4) not null,
fde_keycon varchar(3),
fde_impcar decimal(16,2) not null,
fde_impabo decimal(16,2) not null
) server  options(schema 'LABCONF', table 'TVLOFACD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvloface (
fen_keypro numeric(5) not null,
fen_keyper varchar(7) not null,
fen_keyfac varchar(30) not null,
fen_fecpol timestamp(0) not null,
fen_keyban varchar(30),
fen_status varchar(1) not null,
fen_keyemp numeric(10) not null,
fen_descri varchar(100) not null,
fen_totreg numeric(38) not null,
fen_import decimal(16,2) not null,
fen_fecfon timestamp(0) not null,
fen_tipfac varchar(1) not null,
fen_refcon varchar(30)
) server  options(schema 'LABCONF', table 'TVLOFACE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvlofaem (
fae_keyfac varchar(30) not null,
fae_keyemp numeric(38) not null,
fae_keypro numeric(5) not null,
fae_keyper varchar(7) not null
) server  options(schema 'LABCONF', table 'TVLOFAEM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvlohalt (
hal_keypro numeric(38) not null,
hal_keyper varchar(7) not null,
hal_keynom numeric(38) not null,
hal_keydep varchar(16),
hal_keycen varchar(16),
hal_refcon varchar(9),
hal_tpoemp varchar(6),
hal_keyemp numeric(38),
hal_vicrh varchar(10),
hal_viccon varchar(10),
hal_keyplz numeric(38),
hal_salmes decimal(12,2),
hal_status numeric(38),
hal_fecaum timestamp(0)
) server  options(schema 'LABCONF', table 'TVLOHALT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvloverc (
ver_keyver numeric(9) not null,
ver_keycon varchar(3) not null,
ver_carcia varchar(3) not null,
ver_carneg varchar(2) not null,
ver_carcta varchar(3) not null,
ver_carscta varchar(6) not null,
ver_carcc varchar(8) not null,
ver_caricia varchar(3) not null,
ver_cartop varchar(1) not null,
ver_abocia varchar(3) not null,
ver_aboneg varchar(2) not null,
ver_abocta varchar(3) not null,
ver_aboscta varchar(6) not null,
ver_abocc varchar(8) not null,
ver_aboicia varchar(3) not null,
ver_abotop varchar(1) not null,
ver_ietu varchar(4) not null,
ver_ctaref varchar(26) not null,
ver_ctaaux varchar(26) not null
) server  options(schema 'LABCONF', table 'TVLOVERC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvlovxnom (
vxn_keynom numeric(9) not null,
vxn_keyver numeric(9) not null
) server  options(schema 'LABCONF', table 'TVLOVXNOM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvnomset (
mse_keylot varchar(15),
mse_keypro numeric(38),
mse_keyper varchar(7),
mse_keyemp numeric(38),
mse_nomemp varchar(120),
mse_cvebco varchar(5),
mse_ctaemp varchar(18),
mse_import decimal(16,2),
mse_ctapag varchar(18),
mse_fecdep timestamp(0),
mse_cvecia varchar(4),
mse_descia varchar(60),
mse_status varchar(1),
mse_fecgen timestamp(0),
mse_horgen varchar(8),
mse_dayset varchar(12),
mse_bcosel varchar(10),
mse_tipemp varchar(1),
mse_auxca1 varchar(60),
mse_auxca2 varchar(60),
mse_auxnu1 numeric(38),
mse_auxnu2 numeric(38)
) server  options(schema 'LABCONF', table 'TVNOMSET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvpbincc (
id numeric(10),
inc_keyemp numeric(10),
inc_diainc numeric(38),
inc_tipinc varchar(2),
inc_fecini timestamp(0),
inc_fecfin timestamp(0),
inc_fecmod timestamp(0)
) server  options(schema 'LABCONF', table 'TVPBINCC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvpbvacc (
id numeric(10),
vac_keyemp numeric(10),
vac_diavac numeric(38),
vac_fecini timestamp(0),
vac_fecfin timestamp(0),
vac_fecmod timestamp(0)
) server  options(schema 'LABCONF', table 'TVPBVACC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvpervac (
pva_keyemp numeric(38) not null,
pva_fecini timestamp(0),
pva_fecfin timestamp(0),
pva_dia decimal(3,2)
) server  options(schema 'LABCONF', table 'TVPERVAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvpmocaj (
oca_tipnom varchar(1) not null,
oca_keycia varchar(4) not null,
oca_keypro numeric(38) not null,
oca_keyper varchar(7) not null,
oca_keyemp numeric(38) not null,
oca_keypre numeric(38) not null,
oca_imppre decimal(16,2) not null,
oca_impdes decimal(16,2) not null,
oca_impsal decimal(16,2) not null,
oca_unipre decimal(16,2) not null,
oca_unides decimal(16,2) not null,
oca_unisal decimal(16,2) not null,
oca_fecini timestamp(0) not null,
oca_keyusu numeric(38) not null,
oca_idepcc varchar(15) not null,
oca_fecmod timestamp(0) not null,
oca_keycon varchar(3) not null
) server  options(schema 'LABCONF', table 'TVPMOCAJ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvprbita (
bit_keyusu numeric(38) not null,
bit_logusu char(15) not null,
bit_idepcc char(15) not null,
bit_fecmov timestamp(0) not null,
bit_hormov char(8) not null,
bit_tipmov char(2) not null,
bit_key001 char(18) not null,
bit_key002 char(18) not null,
bit_key003 numeric(38) not null,
bit_val001 char(18) not null,
bit_val002 char(18),
bit_val003 char(18),
bit_desmen char(36),
bit_ideniv numeric(38) not null,
bit_keypre decimal(16,6),
bit_ca1aux numeric(38)
) server  options(schema 'LABCONF', table 'TVPRBITA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvprdetb (
det_keyusu numeric(38) not null,
det_fecmov timestamp(0) not null,
det_hormov varchar(8) not null,
det_keytab varchar(18),
det_keycam varchar(18) not null,
det_valant varchar(40) not null,
det_valact varchar(40) not null
) server  options(schema 'LABCONF', table 'TVPRDETB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvpretar (
tar_keyemp numeric(38) options (key 'true') not null,
tar_tpopro numeric(38) options (key 'true') not null,
tar_status numeric(38) options (key 'true') not null,
tar_fecha char(10) not null,
tar_hora char(8) not null,
tar_importe decimal(12,2) not null,
tar_nombre varchar(70) not null,
tar_usuario numeric(38),
tar_auxc char(60),
tar_auxn numeric(38),
tar_idnnum numeric(38)
) server  options(schema 'LABCONF', table 'TVPRETAR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table tvwkpoli (
pol_keyemp numeric(10) not null,
pol_keypro numeric(5) not null,
pol_keycon varchar(3) not null,
pol_codacu numeric(10) not null,
pol_descta varchar(30),
pol_cia varchar(3),
pol_neg varchar(2) not null,
pol_cta varchar(3) not null,
pol_scta varchar(6) not null,
pol_cc varchar(8) not null,
pol_icia varchar(3) not null,
pol_top varchar(1) not null,
pol_ietu varchar(4) not null,
pol_impcar decimal(16,2) not null,
pol_impabo decimal(16,2) not null,
pol_keycia varchar(2) not null,
pol_keypol varchar(10) not null,
pol_cveban varchar(7),
pol_forpag varchar(2),
pol_keyben numeric(5),
pol_comfam numeric(5),
pol_tipo numeric(1) not null,
pol_fecmov timestamp(0)
) server  options(schema 'LABCONF', table 'TVWKPOLI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table weaccaut (
wea_idusua numeric(38) options (key 'true') not null,
wea_keyemp numeric(38) not null,
wea_keypro numeric(38) not null
) server  options(schema 'LABCONF', table 'WEACCAUT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table weaccemp (
wea_idusua numeric(38) options (key 'true') not null,
wea_keyemp varchar(50),
wea_clavea varchar(50),
wea_fecalt timestamp(0),
wea_idmenu numeric(38),
wea_estatu varchar(2)
) server  options(schema 'LABCONF', table 'WEACCEMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table weaccusu (
usu_keyemp numeric(38) options (key 'true') not null,
wea_keyemp varchar(50)
) server  options(schema 'LABCONF', table 'WEACCUSU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table webitacc (
wcc_idbacc numeric(38) options (key 'true') not null,
wcc_keyemp numeric(38) not null,
wcc_pcempl varchar(20) not null,
wcc_detall varchar(100) not null,
wcc_fecalt timestamp(0) not null
) server  options(schema 'LABCONF', table 'WEBITACC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table webitacora (
bit_keyemp numeric(38) not null,
bit_modulo varchar(50) not null,
bit_fecha timestamp(0),
bit_hora varchar(8),
bit_ip varchar(20)
) server  options(schema 'LABCONF', table 'WEBITACORA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table webitact (
wct_idbact numeric(38) options (key 'true') not null,
wcc_keyemp numeric(38) not null,
wcc_pcempl varchar(20),
wcc_modulo varchar(50) not null,
wcc_datset varchar(50) not null,
wcc_detall varchar(100) not null,
wcc_fecalt timestamp(0) not null
) server  options(schema 'LABCONF', table 'WEBITACT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table wecohipa (
hip_keyemp varchar(64) not null,
hip_numsec numeric(10),
hip_fecpas timestamp(0),
hip_keypas varchar(64)
) server  options(schema 'LABCONF', table 'WECOHIPA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table wecopass (
pas_keyemp varchar(50),
pas_keypas varchar(50)
) server  options(schema 'LABCONF', table 'WECOPASS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table wehispass (
weh_id numeric(38) options (key 'true') not null,
weh_keyemp varchar(50) not null,
weh_clavea varchar(50) not null,
weh_fecalt timestamp(0) not null
) server  options(schema 'LABCONF', table 'WEHISPASS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table wemail (
keyemp numeric(38),
email varchar(200)
) server  options(schema 'LABCONF', table 'WEMAIL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table wepardet (
det_cvedet numeric(38) options (key 'true') not null,
det_cvemen numeric(38),
det_cvepro numeric(38),
det_numpad numeric(38),
det_numpos numeric(38),
det_valper varchar(50)
) server  options(schema 'LABCONF', table 'WEPARDET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table weparmen (
wep_cvemen numeric(38) options (key 'true') not null,
wep_nommen varchar(20),
wep_status numeric(38)
) server  options(schema 'LABCONF', table 'WEPARMEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table weparpro (
pro_cvepro numeric(38) options (key 'true') not null,
pro_nompro varchar(40),
pro_tippro numeric(38),
pro_urlpro varchar(40),
pro_icopro varchar(40)
) server  options(schema 'LABCONF', table 'WEPARPRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table wesend (
id numeric(38) options (key 'true') not null,
keyemp numeric(38),
keysol decimal(16,6),
tipo numeric(38),
fecha_envio timestamp(0),
intentos numeric(38),
estatus numeric(38),
error varchar(200)
) server  options(schema 'LABCONF', table 'WESEND', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table wesuperv (
sup_cvesup numeric(38) options (key 'true') not null,
sup_keysup numeric(38) not null,
sup_keyemp numeric(38) not null
) server  options(schema 'LABCONF', table 'WESUPERV', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table wevaljef (
val_keyemp numeric(38),
val_keyjef numeric(38),
val_diaval timestamp(0)
) server  options(schema 'LABCONF', table 'WEVALJEF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xml_cfdi (
idcomprobanteemp numeric(38),
com_keyemp varchar(50),
com_keypro numeric(38),
com_keyper varchar(50),
xmlcfdi varchar(200),
timbrado numeric(38),
sociedad varchar(50),
error varchar(200),
cadenaoriginal varchar(200),
pac varchar(100),
uuid varchar(36),
sellosat varchar(200),
nocertificadosat varchar(50)
) server  options(schema 'LABCONF', table 'XML_CFDI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xxap_timbrado_viaticos_lab (
id_timbrado_viaticos numeric,
org_id numeric,
cod_num_empresa varchar(50),
cve_rfc_empresa varchar(50),
vendor_id numeric,
cod_concepto varchar(50),
des_concepto varchar(250),
cve_moneda varchar(10),
val_tipo_cambio_pago numeric,
val_tipo_cambio_docto numeric,
val_importe_mo numeric,
val_importe_mn numeric,
cod_impuesto varchar(50),
val_tasa_impuesto numeric,
val_impuesto_mo numeric,
val_impuesto_mn numeric,
val_importe_total_mo numeric,
val_importe_total_mn numeric,
id_dist_anticipo numeric,
val_importe_anticipo numeric,
employee_id numeric,
cod_num_empleado varchar(30),
des_nombre_empleado varchar(250),
invoice_payment_id numeric,
num_pago numeric,
fec_pago timestamp(0),
val_importe_pago_mo numeric,
val_importe_pago_mn numeric,
je_header_id numeric,
je_batch_id numeric,
num_poliza varchar(200),
invoice_id numeric,
invoice_num varchar(50),
des_tipo_nomina varchar(250),
num_proc_nomina varchar(20),
cve_periodo varchar(10),
cve_estatus varchar(250),
cve_tipo_movimiento varchar(50),
des_tipo_movimiento varchar(250),
fec_timbrado timestamp(0),
fec_contable timestamp(0),
num_iteracion numeric,
cve_uuid varchar(50),
request_id numeric,
cve_tipo_docto varchar(50),
num_agrupador numeric,
cve_es_saldo_favor varchar(50),
attribute_category varchar(100),
attribute1 varchar(250),
attribute2 varchar(250),
attribute3 varchar(250),
attribute4 varchar(250),
attribute5 varchar(250),
attribute6 varchar(250),
attribute7 varchar(250),
attribute8 varchar(250),
attribute9 varchar(250),
attribute10 varchar(250),
attribute11 varchar(250),
attribute12 varchar(250),
attribute13 varchar(250),
attribute14 varchar(250),
attribute15 varchar(250),
created_by numeric,
creation_date timestamp(0),
last_updated_by numeric,
last_update_date timestamp(0),
last_update_login numeric,
tim_cveori varchar(2),
tim_iddsap numeric
) server  options(schema 'LABCONF', table 'XXAP_TIMBRADO_VIATICOS_LAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xxap_timb_viaticos_ctrl_lab (
id_timbrado_viaticos numeric options (key 'true') not null,
agrupador varchar(255),
identificador varchar(255),
monto_mo numeric,
monto_mn numeric,
impuesto_mo numeric,
impuesto_mn numeric,
distribucion varchar(255),
concepto varchar(255),
invoice_num varchar(255),
estatus varchar(255),
uuid varchar(255),
attribute1 varchar(255),
attribute2 varchar(255),
attribute3 varchar(255),
attribute4 varchar(255),
attribute5 varchar(255),
attribute6 varchar(255),
attribute7 varchar(255),
attribute8 varchar(255),
attribute9 varchar(255),
attribute10 varchar(255)
) server  options(schema 'LABCONF', table 'XXAP_TIMB_VIATICOS_CTRL_LAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xxap_timb_viati_ctrl_dist_lab (
idregistro varchar(255) options (key 'true') not null,
monto_mo numeric,
monto_mn numeric,
impuesto_mo numeric,
impuesto_mn numeric,
anticipo varchar(255),
distribucion varchar(255),
remanente varchar(255),
estatusanticipo varchar(255),
estatususuario varchar(255),
estatusdistribucion varchar(255),
attribute1 varchar(255),
attribute2 varchar(255),
attribute3 varchar(255),
attribute4 varchar(255),
attribute5 varchar(255),
attribute6 varchar(255),
attribute7 varchar(255),
attribute8 varchar(255),
attribute9 varchar(255),
attribute10 varchar(255)
) server  options(schema 'LABCONF', table 'XXAP_TIMB_VIATI_CTRL_DIST_LAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xxap_timb_viati_ctrl_tmp_lab (
id_timbrado_viaticos numeric options (key 'true') not null,
agrupador varchar(255),
identificador varchar(255),
monto_mo numeric,
monto_mn numeric,
impuesto_mo numeric,
impuesto_mn numeric,
distribucion varchar(255),
concepto varchar(255),
invoice_num varchar(255),
estatus varchar(255),
uuid varchar(255),
attribute1 varchar(255),
attribute2 varchar(255),
attribute3 varchar(255),
attribute4 varchar(255),
attribute5 varchar(255),
attribute6 varchar(255),
attribute7 varchar(255),
attribute8 varchar(255),
attribute9 varchar(255),
attribute10 varchar(255)
) server  options(schema 'LABCONF', table 'XXAP_TIMB_VIATI_CTRL_TMP_LAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xxper_sipros_nmcodeps (
dep_keydep varchar(240),
dep_desdep varchar(240),
dep_refcnm varchar(60),
dep_refcnh varchar(60),
dep_keycen varchar(10),
dep_tipdep varchar(150),
dep_nu1aux varchar(10),
dep_nu2aux varchar(10),
dep_nu3aux varchar(10),
dep_nu4aux varchar(10),
dep_nu5aux varchar(10),
dep_ca1aux varchar(10),
dep_ca2aux varchar(10),
dep_ca3aux varchar(60),
dep_ca4aux varchar(60),
dep_ca5aux varchar(10),
ora_system varchar(30),
ora_transaction varchar(30),
ora_date timestamp(0),
ora_secuencia numeric,
ora_status varchar(2)
) server  options(schema 'LABCONF', table 'XXPER_SIPROS_NMCODEPS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xxper_sipros_nmcoempl (
emp_keyemp varchar(150),
emp_keydep varchar(240),
emp_keypue varchar(700),
emp_keypos varchar(240),
emp_keycen varchar(60),
emp_keycat varchar(16),
emp_nomemp varchar(240),
emp_nomcor varchar(20),
emp_domemp varchar(240),
emp_colemp varchar(240),
emp_cidemp varchar(30),
emp_pobemp varchar(30),
emp_munemp varchar(240),
emp_entemp varchar(120),
emp_codemp varchar(30),
emp_telemp varchar(60),
emp_regrfc varchar(30),
emp_recurp varchar(150),
emp_regims varchar(150),
emp_reginf varchar(150),
emp_cvesex varchar(30),
emp_keyims varchar(150),
emp_cvezon varchar(150),
emp_keypro varchar(60),
emp_cvetur varchar(150),
emp_tipemp varchar(150),
emp_tipsal varchar(150),
emp_status varchar(30),
emp_salhor numeric,
emp_saldia numeric,
emp_salmes numeric,
emp_salint numeric,
emp_salivc numeric,
emp_salinf numeric,
emp_intsin numeric,
emp_infsin numeric,
emp_varims numeric,
emp_varinf numeric,
emp_anthor numeric,
emp_antdia numeric,
emp_antmes numeric,
emp_antint numeric,
emp_antivc numeric,
emp_antinf numeric,
emp_antits numeric,
emp_antifs numeric,
emp_refcon varchar(30),
emp_cveban varchar(150),
emp_ctaban varchar(150),
emp_forpag varchar(150),
emp_diades numeric,
emp_numliq varchar(30),
emp_keyloc varchar(150),
emp_fecing timestamp(0),
emp_fecrei timestamp(0),
emp_fecven timestamp(0),
emp_fecpla timestamp(0),
emp_fecaum timestamp(0),
emp_peraum varchar(30),
emp_fecbaj timestamp(0),
emp_cvebaj varchar(30),
emp_jorlab varchar(30),
emp_unijor decimal(22,3),
emp_pering varchar(30),
emp_perbaj varchar(30),
emp_perdep varchar(30),
emp_perpue varchar(30),
emp_percat varchar(30),
emp_perpro varchar(30),
emp_fecaux timestamp(0),
emp_ca1aux varchar(150),
emp_ca2aux varchar(30),
emp_ca3aux varchar(150),
emp_ca4aux varchar(150),
emp_pctbec numeric,
emp_fecmod timestamp(0),
emp_hormod varchar(30),
emp_fecalt timestamp(0),
emp_bajfec timestamp(0),
emp_fecsal timestamp(0),
emp_perpag varchar(30),
emp_inifec timestamp(0),
emp_finfec timestamp(0),
emp_cobert varchar(30),
emp_keyper varchar(7),
ora_system varchar(30),
ora_transaction varchar(30),
ora_date timestamp(0),
ora_secuencia numeric,
ora_status varchar(2)
) server  options(schema 'LABCONF', table 'XXPER_SIPROS_NMCOEMPL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xxper_sipros_nmcoplzs (
plz_keyest varchar(3),
plz_keydep varchar(240),
plz_keypue varchar(240),
plz_keyplz varchar(240),
plz_keycat varchar(16),
plz_keyloc varchar(150),
plz_tippla varchar(30),
plz_fecini timestamp(0),
plz_fecfin timestamp(0),
plz_diavig numeric,
plz_turnop numeric,
plz_keyhor varchar(16),
plz_keyemp varchar(150),
plz_cveuoc numeric,
plz_cverem numeric,
plz_fecmov timestamp(0),
plz_submov varchar(2),
plz_cosplz varchar(150),
plz_ca1aux varchar(30),
plz_ca2aux varchar(150),
plz_ca3aux varchar(150),
plz_nu1aux varchar(150),
plz_nu2aux varchar(10),
plz_nu3aux varchar(240),
plz_fe1aux varchar(10),
plz_fe2aux varchar(10),
plz_fe3aux timestamp(0),
plz_co1aux numeric,
plz_co2aux numeric,
plz_co3aux numeric,
plz_co4aux numeric,
plz_co5aux numeric,
plz_keysue varchar(4),
plz_sueniv numeric,
plz_subniv numeric,
plz_cobert varchar(2),
plz_keypro numeric,
plz_keydpl numeric,
plz_fecocu timestamp(0),
plz_salplz numeric,
plz_titula numeric,
plz_origen varchar(2),
plz_valimp varchar(2),
plz_limocu timestamp(0),
plz_tiptab varchar(2),
ora_system varchar(30),
ora_transaction varchar(30),
ora_date timestamp(0),
ora_secuencia numeric,
ora_status varchar(2)
) server  options(schema 'LABCONF', table 'XXPER_SIPROS_NMCOPLZS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xxper_sipros_nmcopues (
pue_keypue varchar(240),
pue_despue varchar(240),
pue_refcon varchar(20),
pue_nu1aux varchar(10),
pue_nu2aux varchar(10),
pue_nu3aux varchar(10),
pue_nu4aux varchar(10),
pue_nu5aux varchar(10),
pue_ca1aux varchar(10),
pue_ca2aux varchar(10),
pue_ca3aux varchar(10),
pue_ca4aux varchar(10),
pue_ca5aux varchar(10),
pue_sueniv numeric,
pue_subniv numeric,
pue_keysue varchar(4),
pue_cobert varchar(2),
pue_arepue varchar(6),
pue_subare varchar(6),
pue_nivpue numeric,
pue_grppue varchar(16),
pue_subgrp varchar(16),
pue_tippue varchar(2),
ora_system varchar(30),
ora_transaction varchar(30),
ora_date timestamp(0),
ora_secuencia numeric,
ora_status varchar(2)
) server  options(schema 'LABCONF', table 'XXPER_SIPROS_NMCOPUES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xxper_sipros_nmlocenc (
cen_keycen varchar(60),
cen_descen varchar(240),
cen_refcon varchar(120),
cen_nu1aux varchar(10),
cen_nu2aux varchar(10),
cen_nu3aux varchar(10),
cen_nu4aux varchar(10),
cen_nu5aux varchar(10),
cen_ca1aux varchar(10),
cen_ca2aux varchar(10),
cen_ca3aux varchar(60),
cen_ca4aux varchar(60),
cen_ca5aux varchar(10),
ora_system varchar(30),
ora_transaction varchar(30),
ora_date timestamp(0),
ora_secuencia numeric,
ora_status varchar(2)
) server  options(schema 'LABCONF', table 'XXPER_SIPROS_NMLOCENC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xxper_sipros_nmlodata (
dat_keyemp varchar(150) not null,
dat_keypar varchar(2) not null,
dat_valpar varchar(100),
ora_system varchar(30),
ora_transaction varchar(30),
ora_date timestamp(0),
ora_secuencia numeric,
ora_status varchar(2)
) server  options(schema 'LABCONF', table 'XXPER_SIPROS_NMLODATA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labconf,oracle,dmap_extension,public;
create foreign  table xxper_sipros_nmlotray (
tra_keyemp varchar(30),
tra_fecmov timestamp(0),
tra_tipmov varchar(2),
tra_keydep varchar(30),
tra_keypue varchar(30),
tra_keycat varchar(30),
tra_keycen varchar(30),
tra_saldia varchar(20),
tra_salmes numeric,
tra_salint varchar(20),
tra_salivc varchar(20),
tra_salinf varchar(20),
tra_intsin varchar(20),
tra_infsin varchar(20),
tra_keyims varchar(30),
tra_keyper varchar(7),
tra_codloc varchar(30),
tra_keypla varchar(30),
tra_keypro varchar(30),
tra_jorlab varchar(30),
tra_unijor numeric,
tra_submov varchar(30),
tra_ca1aux varchar(20),
tra_ca2aux varchar(30),
tra_fecmod varchar(20),
tra_hormod varchar(8),
ora_system varchar(30),
ora_transaction varchar(30),
ora_date timestamp(0),
ora_secuencia numeric,
ora_status varchar(2)
) server  options(schema 'LABCONF', table 'XXPER_SIPROS_NMLOTRAY', readonly 'true');
