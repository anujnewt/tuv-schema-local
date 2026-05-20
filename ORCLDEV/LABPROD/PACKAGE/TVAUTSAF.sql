CREATE OR REPLACE NONEDITIONABLE PACKAGE "LABPROD"."TVAUTSAF" IS
   ---------------------------------
  TYPE tipo_incidencia IS RECORD (
    wn_key_emp LABPROD.TVINCSAF.INC_KEYEMP%TYPE, ws_cve_ref LABPROD.TVINCSAF.INC_CVEREF%TYPE, wn_tot_sol LABPROD.TVINCSAF.INC_TOTSOL%TYPE, wn_imp_des LABPROD.TVINCSAF.INC_IMPDES%TYPE,
    gn_fec_ini LABPROD.TVINCSAF.INC_FECINI%TYPE, wn_imp_sal LABPROD.TVINCSAF.INC_IMPSAL%TYPE, wn_uni_pre LABPROD.TVINCSAF.INC_UNIPRE%TYPE, wn_uni_des LABPROD.TVINCSAF.INC_UNIDES%TYPE,
    wn_uni_sal LABPROD.TVINCSAF.INC_UNISAL%TYPE, ws_key_con LABPROD.TVINCSAF.INC_KEYCON%TYPE, ws_per_saf LABPROD.TVINCSAF.INC_PERSAF%TYPE);
-- DATOS GENERALES SAF
  PROCEDURE SP_DATOSGENERALES_CA
  (recurp in LABPROD.nmcoempl.emp_recurp%TYPE, keyemp in LABPROD.nmcoempl.emp_keyemp%TYPE, nomemp in LABPROD.nmcoempl.emp_nomemp%TYPE, keypro in LABPROD.nmcoempl.emp_keypro%TYPE,
  cveban in LABPROD.nmcoempl.emp_cveban%TYPE, fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE, domemp in LABPROD.nmcoempl.emp_domemp%TYPE, colemp in LABPROD.nmcoempl.emp_colemp%TYPE,
  munemp in LABPROD.nmcoempl.emp_munemp%TYPE, entemp in LABPROD.nmcoempl.emp_entemp%TYPE, codemp in LABPROD.nmcoempl.emp_codemp%TYPE, telemp in LABPROD.nmcoempl.emp_telemp%TYPE,
  cidemp in LABPROD.nmcoempl.emp_cidemp%TYPE, salmes in LABPROD.nmcoempl.emp_salmes%TYPE, keyloc in LABPROD.nmcoempl.emp_keyloc%TYPE, forpag in LABPROD.nmcoempl.emp_forpag%TYPE,
  ca2aux in LABPROD.nmcoempl.emp_ca2aux%TYPE, status in LABPROD.nmcoempl.emp_status%TYPE);
  PROCEDURE SP_DATOSGENERALES_CA_AUT
  (cliente in VARCHAR2,keyemp in varchar2, recurp in nmcoempl.emp_recurp%TYPE,
  nombre in VARCHAR2, paterno in VARCHAR2, materno in VARCHAR2, domicilio in VARCHAR2, colonia in VARCHAR2,
  ciudad in VARCHAR2, municipio in VARCHAR2, entidad in VARCHAR2, codigopostal in VARCHAR2, telefono in VARCHAR2,
  clavebanco in VARCHAR2, cuentabanco in VARCHAR2, salariomensual in VARCHAR2, fechaingreso in DATE,
  tipopago in VARCHAR2, metodopago in VARCHAR2, tipocontrato in VARCHAR2, proceso in VARCHAR2,
  localidad in VARCHAR2, status in VARCHAR2, fecha in DATE);
  --considera ca4aux
  PROCEDURE SP_DATOSGENERALES_FA
  (recurp in LABPROD.nmcoempl.emp_recurp%TYPE, keyemp in LABPROD.nmcoempl.emp_keyemp%TYPE, nomemp in LABPROD.nmcoempl.emp_nomemp%TYPE, keypro in LABPROD.nmcoempl.emp_keypro%TYPE,
  cveban in LABPROD.nmcoempl.emp_cveban%TYPE, fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE, domemp in LABPROD.nmcoempl.emp_domemp%TYPE, colemp in LABPROD.nmcoempl.emp_colemp%TYPE,
  munemp in LABPROD.nmcoempl.emp_munemp%TYPE, entemp in LABPROD.nmcoempl.emp_entemp%TYPE, codemp in LABPROD.nmcoempl.emp_codemp%TYPE, telemp in LABPROD.nmcoempl.emp_telemp%TYPE,
  cidemp in LABPROD.nmcoempl.emp_cidemp%TYPE, salmes in LABPROD.nmcoempl.emp_salmes%TYPE, keyloc in LABPROD.nmcoempl.emp_keyloc%TYPE, forpag in LABPROD.nmcoempl.emp_forpag%TYPE,
  ca2aux in LABPROD.nmcoempl.emp_ca2aux%TYPE, status in LABPROD.nmcoempl.emp_status%TYPE, ca4aux in LABPROD.nmcoempl.emp_ca4aux%TYPE);
  PROCEDURE SP_DATOSGENERALES_FA_AUT
  (cliente in VARCHAR2,keyemp in varchar2, recurp in nmcoempl.emp_recurp%TYPE,
  nombre in VARCHAR2, paterno in VARCHAR2, materno in VARCHAR2, domicilio in VARCHAR2, colonia in VARCHAR2,
  ciudad in VARCHAR2, municipio in VARCHAR2, entidad in VARCHAR2, codigopostal in VARCHAR2, telefono in VARCHAR2,
  clavebanco in VARCHAR2, cuentabanco in VARCHAR2, salariomensual in VARCHAR2, fechaingreso in DATE,
  tipopago in VARCHAR2, metodopago in VARCHAR2, tipocontrato in VARCHAR2, proceso in VARCHAR2,
  localidad in VARCHAR2, status in VARCHAR2, fecha in DATE);
  PROCEDURE SP_DATOSGENERALES_PA
  (recurp in LABPROD.nmcoempl.emp_recurp%TYPE, keyemp in LABPROD.nmcoempl.emp_keyemp%TYPE, nomemp in LABPROD.nmcoempl.emp_nomemp%TYPE, keypro in LABPROD.nmcoempl.emp_keypro%TYPE,
  cveban in LABPROD.nmcoempl.emp_cveban%TYPE, fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE, domemp in LABPROD.nmcoempl.emp_domemp%TYPE, colemp in LABPROD.nmcoempl.emp_colemp%TYPE,
  munemp in LABPROD.nmcoempl.emp_munemp%TYPE, entemp in LABPROD.nmcoempl.emp_entemp%TYPE, codemp in LABPROD.nmcoempl.emp_codemp%TYPE, telemp in LABPROD.nmcoempl.emp_telemp%TYPE,
  cidemp in LABPROD.nmcoempl.emp_cidemp%TYPE, salmes in LABPROD.nmcoempl.emp_salmes%TYPE, keyloc in LABPROD.nmcoempl.emp_keyloc%TYPE, forpag in LABPROD.nmcoempl.emp_forpag%TYPE,
  ca2aux in LABPROD.nmcoempl.emp_ca2aux%TYPE, status in LABPROD.nmcoempl.emp_status%TYPE, ca4aux in LABPROD.nmcoempl.emp_ca4aux%TYPE);
  PROCEDURE SP_DATOSGENERALES_PA_AUT
  (cliente in VARCHAR2,keyemp in varchar2, recurp in nmcoempl.emp_recurp%TYPE,
  nombre in VARCHAR2, paterno in VARCHAR2, materno in VARCHAR2, domicilio in VARCHAR2, colonia in VARCHAR2,
  ciudad in VARCHAR2, municipio in VARCHAR2, entidad in VARCHAR2, codigopostal in VARCHAR2, telefono in VARCHAR2,
  clavebanco in VARCHAR2, cuentabanco in VARCHAR2, salariomensual in VARCHAR2, fechaingreso in DATE,
  tipopago in VARCHAR2, metodopago in VARCHAR2, tipocontrato in VARCHAR2, proceso in VARCHAR2,
  localidad in VARCHAR2, status in VARCHAR2, fecha in DATE);
  PROCEDURE SP_DATOSGENERALES_NC
  (recurp in LABPROD.nmcoempl.emp_recurp%TYPE, keyemp in LABPROD.nmcoempl.emp_keyemp%TYPE, nomemp in LABPROD.nmcoempl.emp_nomemp%TYPE, keypro in LABPROD.nmcoempl.emp_keypro%TYPE,
  cveban in LABPROD.nmcoempl.emp_cveban%TYPE, fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE, domemp in LABPROD.nmcoempl.emp_domemp%TYPE, colemp in LABPROD.nmcoempl.emp_colemp%TYPE,
  munemp in LABPROD.nmcoempl.emp_munemp%TYPE, entemp in LABPROD.nmcoempl.emp_entemp%TYPE, codemp in LABPROD.nmcoempl.emp_codemp%TYPE, telemp in LABPROD.nmcoempl.emp_telemp%TYPE,
  cidemp in LABPROD.nmcoempl.emp_cidemp%TYPE, salmes in LABPROD.nmcoempl.emp_salmes%TYPE, keyloc in LABPROD.nmcoempl.emp_keyloc%TYPE, forpag in LABPROD.nmcoempl.emp_forpag%TYPE,
  ca2aux in LABPROD.nmcoempl.emp_ca2aux%TYPE, status in LABPROD.nmcoempl.emp_status%TYPE);
  PROCEDURE SP_DATOSGENERALES_NC_AUT
  (cliente in VARCHAR2,keyemp in varchar2, recurp in nmcoempl.emp_recurp%TYPE,
  nombre in VARCHAR2, paterno in VARCHAR2, materno in VARCHAR2, domicilio in VARCHAR2, colonia in VARCHAR2,
  ciudad in VARCHAR2, municipio in VARCHAR2, entidad in VARCHAR2, codigopostal in VARCHAR2, telefono in VARCHAR2,
  clavebanco in VARCHAR2, cuentabanco in VARCHAR2, salariomensual in VARCHAR2, fechaingreso in DATE,
  tipopago in VARCHAR2, metodopago in VARCHAR2, tipocontrato in VARCHAR2, proceso in VARCHAR2,
  localidad in VARCHAR2, status in VARCHAR2, fecha in DATE);
  PROCEDURE SP_APORTACIONES
  (keyper in LABPROD.nmloamor.amo_keyper%TYPE, keypro in LABPROD.nmloamor.amo_keypro%TYPE);
  PROCEDURE SP_AMORTIZACIONES
  (keyper in LABPROD.nmloamor.amo_keyper%TYPE, keypro in LABPROD.nmloamor.amo_keypro%TYPE);
  PROCEDURE SP_INCIDENCIA_CA ( wn_key_emp in NUMBER, ws_cve_ref in varchar, wn_tot_sol in number, wn_imp_des in number,
  gn_fec_ini in varchar, wn_imp_sal in number, wn_uni_pre in number, wn_uni_des in number, wn_uni_sal in number, ws_key_con in varchar,
  ws_per_saf in varchar, wn_res_pue out number);
  PROCEDURE BITACORA_INCIDENCIA (inc IN tipo_incidencia, resultado IN NUMBER, periodo in varchar, proceso in number, tipo IN NUMBER);
  --FUNCTION ObtenEquivalencia (cveban in LABPROD.nmcoempl.emp_cveban%TYPE) RETURN VARCHAR;
  --FUNCTION AntiguedadValida (fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE) RETURN INTEGER;
  --FUNCTION NombreMunicipio (munemp in LABPROD.nmcoempl.emp_munemp%TYPE) RETURN VARCHAR;
END TVAUTSAF;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "LABPROD"."TVAUTSAF" IS
-- Private Global Variables --------------------------------------------
	prueba NUMBER;
	banco LABPROD.glcopams.pam_folini%TYPE;
	bandera INTEGER;
	nombre_ LABPROD.glcopams.pam_nompar%TYPE;
	incidencia tipo_incidencia;
	total integer;
  --PROCEDIMIENTO
  --CAJA DE AHORRO
PROCEDURE SP_DATOSGENERALES_CA
			 (recurp in LABPROD.nmcoempl.emp_recurp%TYPE, keyemp in LABPROD.nmcoempl.emp_keyemp%TYPE,
			  nomemp in LABPROD.nmcoempl.emp_nomemp%TYPE, keypro in LABPROD.nmcoempl.emp_keypro%TYPE,
				cveban in LABPROD.nmcoempl.emp_cveban%TYPE, fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE,
				domemp in LABPROD.nmcoempl.emp_domemp%TYPE, colemp in LABPROD.nmcoempl.emp_colemp%TYPE,
				munemp in LABPROD.nmcoempl.emp_munemp%TYPE, entemp in LABPROD.nmcoempl.emp_entemp%TYPE,
				codemp in LABPROD.nmcoempl.emp_codemp%TYPE, telemp in LABPROD.nmcoempl.emp_telemp%TYPE,
				cidemp in LABPROD.nmcoempl.emp_cidemp%TYPE, salmes in LABPROD.nmcoempl.emp_salmes%TYPE,
				keyloc in LABPROD.nmcoempl.emp_keyloc%TYPE, forpag in LABPROD.nmcoempl.emp_forpag%TYPE,
				ca2aux in LABPROD.nmcoempl.emp_ca2aux%TYPE, status in LABPROD.nmcoempl.emp_status%TYPE) IS
  wn_res_pue LABPROD.DATOSGENERALES.GEN_VALIDA%TYPE;
   --Igneos.I
BEGIN
RETURN;
END SP_DATOSGENERALES_CA;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--aut CA
PROCEDURE SP_DATOSGENERALES_CA_AUT
(cliente in VARCHAR2,keyemp in varchar2, recurp in nmcoempl.emp_recurp%TYPE,
nombre in VARCHAR2, paterno in VARCHAR2, materno in VARCHAR2, domicilio in VARCHAR2, colonia in VARCHAR2,
ciudad in VARCHAR2, municipio in VARCHAR2, entidad in VARCHAR2, codigopostal in VARCHAR2, telefono in VARCHAR2,
clavebanco in VARCHAR2, cuentabanco in VARCHAR2, salariomensual in VARCHAR2, fechaingreso in DATE,
tipopago in VARCHAR2, metodopago in VARCHAR2, tipocontrato in VARCHAR2, proceso in VARCHAR2,
localidad in VARCHAR2, status in VARCHAR2, fecha in DATE)  IS
   PRAGMA AUTONOMOUS_TRANSACTION;
   existe_curp INTEGER;
   existe_empleado INTEGER;
BEGIN
RETURN;
END SP_DATOSGENERALES_CA_AUT;
--FONDO DE AHORRO
PROCEDURE SP_DATOSGENERALES_FA
				(recurp in LABPROD.nmcoempl.emp_recurp%TYPE, keyemp in LABPROD.nmcoempl.emp_keyemp%TYPE, nomemp in LABPROD.nmcoempl.emp_nomemp%TYPE, keypro in LABPROD.nmcoempl.emp_keypro%TYPE,
				cveban in LABPROD.nmcoempl.emp_cveban%TYPE, fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE, domemp in LABPROD.nmcoempl.emp_domemp%TYPE, colemp in LABPROD.nmcoempl.emp_colemp%TYPE,
				munemp in LABPROD.nmcoempl.emp_munemp%TYPE, entemp in LABPROD.nmcoempl.emp_entemp%TYPE, codemp in LABPROD.nmcoempl.emp_codemp%TYPE, telemp in LABPROD.nmcoempl.emp_telemp%TYPE,
				cidemp in LABPROD.nmcoempl.emp_cidemp%TYPE, salmes in LABPROD.nmcoempl.emp_salmes%TYPE, keyloc in LABPROD.nmcoempl.emp_keyloc%TYPE, forpag in LABPROD.nmcoempl.emp_forpag%TYPE,
				ca2aux in LABPROD.nmcoempl.emp_ca2aux%TYPE, status in LABPROD.nmcoempl.emp_status%TYPE, ca4aux in LABPROD.nmcoempl.emp_ca4aux%TYPE) IS
BEGIN
RETURN;
END SP_DATOSGENERALES_FA;
--fa aut
PROCEDURE SP_DATOSGENERALES_FA_AUT
				(cliente in VARCHAR2,keyemp in varchar2, recurp in nmcoempl.emp_recurp%TYPE,
				nombre in VARCHAR2, paterno in VARCHAR2, materno in VARCHAR2, domicilio in VARCHAR2, colonia in VARCHAR2,
				ciudad in VARCHAR2, municipio in VARCHAR2, entidad in VARCHAR2, codigopostal in VARCHAR2, telefono in VARCHAR2,
				clavebanco in VARCHAR2, cuentabanco in VARCHAR2, salariomensual in VARCHAR2, fechaingreso in DATE,
				tipopago in VARCHAR2, metodopago in VARCHAR2, tipocontrato in VARCHAR2, proceso in VARCHAR2,
				localidad in VARCHAR2, status in VARCHAR2, fecha in DATE)  IS
   PRAGMA AUTONOMOUS_TRANSACTION;
   existe_curp INTEGER;
   existe_empleado INTEGER;
BEGIN
RETURN;
END SP_DATOSGENERALES_FA_AUT;
---pasivos
--PASIVOS DE FONDO DE AHORRO
PROCEDURE SP_DATOSGENERALES_PA
				(recurp in LABPROD.nmcoempl.emp_recurp%TYPE, keyemp in LABPROD.nmcoempl.emp_keyemp%TYPE, nomemp in LABPROD.nmcoempl.emp_nomemp%TYPE, keypro in LABPROD.nmcoempl.emp_keypro%TYPE,
				cveban in LABPROD.nmcoempl.emp_cveban%TYPE, fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE, domemp in LABPROD.nmcoempl.emp_domemp%TYPE, colemp in LABPROD.nmcoempl.emp_colemp%TYPE,
				munemp in LABPROD.nmcoempl.emp_munemp%TYPE, entemp in LABPROD.nmcoempl.emp_entemp%TYPE, codemp in LABPROD.nmcoempl.emp_codemp%TYPE, telemp in LABPROD.nmcoempl.emp_telemp%TYPE,
				cidemp in LABPROD.nmcoempl.emp_cidemp%TYPE, salmes in LABPROD.nmcoempl.emp_salmes%TYPE, keyloc in LABPROD.nmcoempl.emp_keyloc%TYPE, forpag in LABPROD.nmcoempl.emp_forpag%TYPE,
				ca2aux in LABPROD.nmcoempl.emp_ca2aux%TYPE, status in LABPROD.nmcoempl.emp_status%TYPE, ca4aux in LABPROD.nmcoempl.emp_ca4aux%TYPE) IS
BEGIN
RETURN;
END SP_DATOSGENERALES_PA;
--pasivos
PROCEDURE SP_DATOSGENERALES_PA_AUT
				(cliente in VARCHAR2,keyemp in varchar2, recurp in nmcoempl.emp_recurp%TYPE,
				nombre in VARCHAR2, paterno in VARCHAR2, materno in VARCHAR2, domicilio in VARCHAR2, colonia in VARCHAR2,
				ciudad in VARCHAR2, municipio in VARCHAR2, entidad in VARCHAR2, codigopostal in VARCHAR2, telefono in VARCHAR2,
				clavebanco in VARCHAR2, cuentabanco in VARCHAR2, salariomensual in VARCHAR2, fechaingreso in DATE,
				tipopago in VARCHAR2, metodopago in VARCHAR2, tipocontrato in VARCHAR2, proceso in VARCHAR2,
				localidad in VARCHAR2, status in VARCHAR2, fecha in DATE)  IS
   PRAGMA AUTONOMOUS_TRANSACTION;
   existe_curp INTEGER;
   existe_empleado INTEGER;
BEGIN
RETURN;
END SP_DATOSGENERALES_PA_AUT;
--NOMINA CON CAUSA
PROCEDURE SP_DATOSGENERALES_NC
				(recurp in LABPROD.nmcoempl.emp_recurp%TYPE, keyemp in LABPROD.nmcoempl.emp_keyemp%TYPE, nomemp in LABPROD.nmcoempl.emp_nomemp%TYPE, keypro in LABPROD.nmcoempl.emp_keypro%TYPE,
				cveban in LABPROD.nmcoempl.emp_cveban%TYPE, fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE, domemp in LABPROD.nmcoempl.emp_domemp%TYPE, colemp in LABPROD.nmcoempl.emp_colemp%TYPE,
				munemp in LABPROD.nmcoempl.emp_munemp%TYPE, entemp in LABPROD.nmcoempl.emp_entemp%TYPE, codemp in LABPROD.nmcoempl.emp_codemp%TYPE, telemp in LABPROD.nmcoempl.emp_telemp%TYPE,
				cidemp in LABPROD.nmcoempl.emp_cidemp%TYPE, salmes in LABPROD.nmcoempl.emp_salmes%TYPE, keyloc in LABPROD.nmcoempl.emp_keyloc%TYPE, forpag in LABPROD.nmcoempl.emp_forpag%TYPE,
				ca2aux in LABPROD.nmcoempl.emp_ca2aux%TYPE, status in LABPROD.nmcoempl.emp_status%TYPE) IS
BEGIN
RETURN;
END SP_DATOSGENERALES_NC;
--Nomina con Causa aut
PROCEDURE SP_DATOSGENERALES_NC_AUT
				(cliente in VARCHAR2,keyemp in varchar2, recurp in nmcoempl.emp_recurp%TYPE,
				nombre in VARCHAR2, paterno in VARCHAR2, materno in VARCHAR2, domicilio in VARCHAR2, colonia in VARCHAR2,
				ciudad in VARCHAR2, municipio in VARCHAR2, entidad in VARCHAR2, codigopostal in VARCHAR2, telefono in VARCHAR2,
				clavebanco in VARCHAR2, cuentabanco in VARCHAR2, salariomensual in VARCHAR2, fechaingreso in DATE,
				tipopago in VARCHAR2, metodopago in VARCHAR2, tipocontrato in VARCHAR2, proceso in VARCHAR2,
				localidad in VARCHAR2, status in VARCHAR2, fecha in DATE)  IS
   PRAGMA AUTONOMOUS_TRANSACTION;
   existe_curp INTEGER;
   existe_empleado INTEGER;
BEGIN
RETURN;
END SP_DATOSGENERALES_NC_AUT;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--APORTACIONES SAF
PROCEDURE SP_APORTACIONES
(keyper in LABPROD.nmloamor.amo_keyper%TYPE, keypro in LABPROD.nmloamor.amo_keypro%TYPE) IS
BEGIN
TVAUTSAF_LOCAL.SP_APORTACIONES(keyper, keypro);
END SP_APORTACIONES;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--AMORTIZACIONES SAF
PROCEDURE SP_AMORTIZACIONES
				(keyper in LABPROD.nmloamor.amo_keyper%TYPE, keypro in LABPROD.nmloamor.amo_keypro%TYPE) IS
BEGIN
TVAUTSAF_LOCAL.SP_AMORTIZACIONES(keyper, keypro);
END SP_AMORTIZACIONES;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- incidencias saf
PROCEDURE SP_INCIDENCIA_CA ( wn_key_emp in NUMBER, ws_cve_ref in varchar, wn_tot_sol in number, wn_imp_des in number,
					gn_fec_ini in varchar, wn_imp_sal in number, wn_uni_pre in number, wn_uni_des in number, wn_uni_sal in number, ws_key_con in varchar,
					ws_per_saf in varchar, wn_res_pue out number) IS
BEGIN
  --busca el empleado en tvnomdes
    SELECT count(*) into total from glcopams where pam_keypar = 'SEPB' and pam_cvesec = (select emp_keypro from nmcoempl where emp_keyemp = wn_key_emp);
    IF (total < 1) THEN
      TVAUTSAF_LOCAL.SP_INCIDENCIA_CA (wn_key_emp, ws_cve_ref, wn_tot_sol, wn_imp_des, gn_fec_ini, wn_imp_sal, wn_uni_pre, wn_uni_des, wn_uni_sal, ws_key_con, ws_per_saf, wn_res_pue);
    /*
    APSI 231017
    ELSE
      TVAUTSAF_LOCAL.SP_INCIDENCIA_CA@RTELECOM (wn_key_emp, ws_cve_ref, wn_tot_sol, wn_imp_des, gn_fec_ini, wn_imp_sal, wn_uni_pre, wn_uni_des, wn_uni_sal, ws_key_con, ws_per_saf, wn_res_pue);
    */
    END IF;
END SP_INCIDENCIA_CA;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------bit?cora de INcidencia AQU?
PROCEDURE BITACORA_INCIDENCIA (inc IN tipo_incidencia, resultado IN NUMBER, periodo in varchar, proceso in number, tipo IN NUMBER) IS
BEGIN
  RETURN;
END BITACORA_INCIDENCIA;
--FUNCTION ObtenEquivalencia (cveban in LABPROD.nmcoempl.emp_cveban%TYPE) RETURN VARCHAR IS BEGIN RETURN; END ObtenEquivalencia;
--FUNCTION AntiguedadValida (fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE) RETURN INTEGER IS BEGIN RETURN; END AntiguedadValida;
--FUNCTION NombreMunicipio (munemp in LABPROD.nmcoempl.emp_munemp%TYPE) RETURN VARCHAR IS BEGIN RETURN; END NombreMunicipio;
END TVAUTSAF;
/;
