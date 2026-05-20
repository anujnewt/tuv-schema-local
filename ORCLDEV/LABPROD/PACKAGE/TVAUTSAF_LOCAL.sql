CREATE OR REPLACE NONEDITIONABLE PACKAGE "LABPROD"."TVAUTSAF_LOCAL" IS
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
  FUNCTION ObtenEquivalencia (cveban in LABPROD.nmcoempl.emp_cveban%TYPE)
  RETURN VARCHAR;
  FUNCTION AntiguedadValida (fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE)
  RETURN INTEGER;
  FUNCTION NombreMunicipio (munemp in LABPROD.nmcoempl.emp_munemp%TYPE)
  RETURN VARCHAR;
END TVAUTSAF_LOCAL;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "LABPROD"."TVAUTSAF_LOCAL" IS
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
  wn_tot_reg NUMBER;
  ws_cve_cte VARCHAR(5);
  gl_rec_urp VARCHAR(20);
  ws_rec_urp VARCHAR(20);
  wn_dia_per NUMBER;
  ws_cve_cal VARCHAR(1);
  ws_cta_ban VARCHAR(18);
  ws_tpo_con VARCHAR(50);
  wn_sal_mes NUMBER;
  ws_cve_ban VARCHAR(18);
  wd_fec_mov DATE;
  paterno VARCHAR(50);
  materno VARCHAR(50);
  nombre VARCHAR(100);
  claveban VARCHAR(3);
  existe NUMBER;
  valido NUMBER;
BEGIN
  wn_res_pue:=' ';
  wd_fec_mov:= SYSDATE;
  --wd_fec_mov:= TO_CHAR (SYSDATE, 'yyyymmdd');
	--o
	--empleado activo
   IF status <> 1 THEN
    wn_res_pue := wn_res_pue || '0';
	--  RETURN;
   END IF;
  --1. Buscar Clientes
   SELECT pam_cvesec, NVL(pam_folini,'T') INTO ws_cve_cte, ws_tpo_con
   FROM LABPROD.glcopams
   WHERE pam_keypar = 'SDGT'
   AND pam_folfin = 'C';
--Igneos.I
  --2. Validar Tipo de Contrato
  IF ws_tpo_con <> 'T' then
	  IF instr(ws_tpo_con, ca2aux) = 0 THEN
		wn_res_pue := wn_res_pue || '2';
	  --  RETURN;
	  END IF;
  END IF;
  --3. Validar Procesos
  SELECT COUNT(*) INTO wn_tot_reg FROM LABPROD.glcopams
  WHERE pam_keypar = 'SAF'
  AND pam_folfin = 'tviaesnt'
  AND pam_folini = keypro;
  IF wn_tot_reg > 0 THEN
    wn_res_pue := wn_res_pue || '3';
    --RETURN;
  END IF;
  --4.	Validar empleados con m?s de una clave en SAF
  BEGIN
    select pam_nompar INTO gl_rec_urp from LABPROD.glcopams
    where pam_keypar = 'CEFI'
    and pam_folini = keyemp;
  EXCEPTION
	  WHEN NO_DATA_FOUND THEN gl_rec_urp := ' ';
  END;
  IF gl_rec_urp <> ' ' THEN
    ws_rec_urp := gl_rec_urp;
  ELSE
    ws_rec_urp := recurp;
  END IF;
  --5.	Validar Registros en la tabla aux_acum3
  SELECT COUNT(*) INTO wn_tot_reg
   FROM LABPROD.aux_acum3
   WHERE keycon = 'tviaesnt'
   AND keyemp = keyemp;
   IF wn_tot_reg <> 0 THEN
    wn_res_pue := wn_res_pue || '5';
  --  RETURN;
  END IF;
-- Validaciones en la inserci?n
-- Buscar el Calendario del Proceso (Notar que s?lo se considera 7, 10, 15)
  SELECT pro_diaper INTO wn_dia_per FROM LABPROD.nmloproc
  WHERE pro_keypro = keypro;
	IF wn_dia_per = 7 THEN ws_cve_cal := 'S';
    ElSIF wn_dia_per = 10 THEN ws_cve_cal := 'D';
    ElSIF wn_dia_per = 15 THEN ws_cve_cal := 'Q';
    ELSE wn_res_pue := wn_res_pue || '6';
	END IF;
-- Buscar la Clave de Banco y la Cuenta Bancaria
--Validar la n?mina confidencial
  BEGIN
    SELECT cta_ctaban INTO ws_cta_ban
    FROM LABPROD.nmloctas
    WHERE cta_keyemp = keyemp
    AND cta_keypro = keypro;
  EXCEPTION
	  WHEN NO_DATA_FOUND THEN wn_res_pue := wn_res_pue || '9';
  END;
  IF keypro = 6 THEN
    wn_sal_mes := 15000;
  ELSE
    wn_sal_mes := salmes;
  END IF;
  ws_cve_ban := cveban;
  IF forpag = 1 OR forpag = 4 THEN
    ws_cve_ban := '000';
    ws_cta_ban := '000000000000000000';
  END IF;
  nombre := trim(sp_delimitador(nomemp,'/',3));
  paterno := trim(NVL(sp_delimitador(nomemp,'/',1), ' '));
  materno := trim(NVL(sp_delimitador(nomemp,'/',2), ' '));
  IF AntiguedadValida(fecaux) = 0 THEN
    wn_res_pue := wn_res_pue || '9';
  END IF;
  INSERT INTO LABPROD.datosgenerales_errsaf values (keyemp, 'UPDATE', SYSDATE,
  wn_res_pue || ' prueba caja ahorro CA');
  IF wn_res_pue = ' ' THEN
    sp_datosgenerales_ca_aut(ws_cve_cte, to_char(keyemp), recurp, nombre, paterno, materno, nvl(domemp, ' '), nvl(colemp, ' '),
      nvl(cidemp, ' '), NombreMunicipio(munemp), nvl(entemp, ' '), nvl(codemp, ' '), nvl(telemp, ' '), ws_cve_ban, ws_cta_ban, SP_TOVARCHAR2(wn_sal_mes), fecaux,
      ws_cve_cal, nvl(forpag, ' '), nvl(ca2aux, ' '), keypro, keyloc, status, wd_fec_mov);
  END IF;
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
  BEGIN
    SELECT 	COUNT(*)
    INTO 		existe_empleado
    FROM 		SAF_DGCA
    WHERE 	"NumCliente" = cliente
    AND  		"NumNomina" = keyemp;
  EXCEPTION
    WHEN OTHERS THEN
      insert into LABPROD.datosgenerales_errsaf values (keyemp, 'SELECT', SYSDATE,
      ' SELECT COUNT(*) FROM SAF_DGCA cliente, empleado '
      );
      existe_empleado := 0;
      COMMIT;
  END;
  BEGIN
    SELECT COUNT(*) INTO existe_curp
    FROM SAF_DGCA
    where "NumCliente" = cliente and "Clave" = recurp;
  EXCEPTION
    WHEN OTHERS THEN
      insert into LABPROD.datosgenerales_errsaf values (keyemp, 'SELECT', SYSDATE,
     ' SELECT COUNT(*) FROM SAF_DGCA cliente, curp'
     );
    existe_curp := 0;
    COMMIT;
  END;
  IF existe_empleado > 0  THEN
    BEGIN
      UPDATE	SAF_DGCA
      SET			"Clave" = recurp,
              "Nombre" = nombre, "ApPaterno" = paterno, "ApMaterno" = materno, "Domicilio" = domicilio, "Colonia" = colonia,
              "Ciudad" = ciudad, "MuniDele" = municipio, "IdEstado" = entidad, "CodPostal" = codigopostal, "Telefono" = telefono,
              "IdBanco" = clavebanco, "CLABE" = cuentabanco, "Salario" = salariomensual, "FechaIngreso" = fechaingreso, "IdTipoPago" = tipopago,
              "MetodoPago" = metodopago, "IdTipoContratacion" = tipocontrato, "IdEmpresa" = proceso, "IdUbicacion" = localidad, "IdEstatus" = status,
              "Exito" = 'N', "FechaSol" = fecha
      WHERE		"NumCliente" = cliente
      AND			"NumNomina" = keyemp;
    EXCEPTION
      WHEN OTHERS THEN
      insert into LABPROD.datosgenerales_errsaf values (keyemp, 'UP_CAJ', SYSDATE,
      ' existe empleado > 0'
      );
    END;
    COMMIT;
  ELSE
    IF existe_curp > 0  THEN
      BEGIN
        UPDATE SAF_DGCA set "NumNomina" = keyemp,
              "Nombre" = nombre, "ApPaterno" = paterno, "ApMaterno" = materno, "Domicilio" = domicilio, "Colonia" = colonia,
              "Ciudad" = ciudad, "MuniDele" = municipio, "IdEstado" = entidad, "CodPostal" = codigopostal, "Telefono" = telefono,
              "IdBanco" = clavebanco, "CLABE" = cuentabanco, "Salario" = salariomensual, "FechaIngreso" = fechaingreso, "IdTipoPago" = tipopago,
              "MetodoPago" = metodopago, "IdTipoContratacion" = tipocontrato, "IdEmpresa" = proceso, "IdUbicacion" = localidad, "IdEstatus" = status,
               "Exito" = 'N', "FechaSol" = fecha
              WHERE "NumCliente" = cliente AND "Clave" = recurp;
      EXCEPTION
        WHEN OTHERS THEN
        INSERT INTO LABPROD.datosgenerales_errsaf values (keyemp, 'UP_CAJ', SYSDATE,
          ' existe curp > 0'
        );
      END;
      COMMIT;
    ELSE
      BEGIN
        INSERT INTO SAF_DGCA VALUES
              (' ', cliente, recurp, keyemp, nombre, paterno, materno, domicilio, colonia,
              ciudad, municipio, entidad, codigopostal, telefono, clavebanco, cuentabanco, salariomensual, fechaingreso,
              tipopago, metodopago, tipocontrato, proceso, localidad, status, 'N', fecha, fecha);
      EXCEPTION
        WHEN OTHERS THEN
        NULL;
      END;
      COMMIT;
    END IF;
  END IF;
END SP_DATOSGENERALES_CA_AUT;
--FONDO DE AHORRO
PROCEDURE SP_DATOSGENERALES_FA
				(recurp in LABPROD.nmcoempl.emp_recurp%TYPE, keyemp in LABPROD.nmcoempl.emp_keyemp%TYPE, nomemp in LABPROD.nmcoempl.emp_nomemp%TYPE, keypro in LABPROD.nmcoempl.emp_keypro%TYPE,
				cveban in LABPROD.nmcoempl.emp_cveban%TYPE, fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE, domemp in LABPROD.nmcoempl.emp_domemp%TYPE, colemp in LABPROD.nmcoempl.emp_colemp%TYPE,
				munemp in LABPROD.nmcoempl.emp_munemp%TYPE, entemp in LABPROD.nmcoempl.emp_entemp%TYPE, codemp in LABPROD.nmcoempl.emp_codemp%TYPE, telemp in LABPROD.nmcoempl.emp_telemp%TYPE,
				cidemp in LABPROD.nmcoempl.emp_cidemp%TYPE, salmes in LABPROD.nmcoempl.emp_salmes%TYPE, keyloc in LABPROD.nmcoempl.emp_keyloc%TYPE, forpag in LABPROD.nmcoempl.emp_forpag%TYPE,
				ca2aux in LABPROD.nmcoempl.emp_ca2aux%TYPE, status in LABPROD.nmcoempl.emp_status%TYPE, ca4aux in LABPROD.nmcoempl.emp_ca4aux%TYPE) IS
  wn_res_pue LABPROD.DATOSGENERALES.GEN_VALIDA%TYPE;
  wn_tot_reg NUMBER;
  ws_cve_cte VARCHAR(5);
  gl_rec_urp VARCHAR(20);
  ws_rec_urp VARCHAR(20);
  wn_dia_per NUMBER;
  ws_cve_cal VARCHAR(1);
  ws_cta_ban VARCHAR(18);
  ws_tpo_con VARCHAR(50);
  wn_sal_mes NUMBER;
  ws_cve_ban VARCHAR(18);
  wd_fec_mov DATE;
  paterno VARCHAR(50);
  materno VARCHAR(50);
  nombre VARCHAR(100);
  claveban VARCHAR(3);
  existe NUMBER;
  valido NUMBER;
BEGIN
  wn_res_pue:=' ';
  wd_fec_mov:= SYSDATE;
   IF ca4aux <> 'F' THEN
    wn_res_pue := wn_res_pue || '8';
  --  RETURN;
   END IF;
   IF status <> 1 THEN
    wn_res_pue := wn_res_pue || '0';
  --  RETURN;
   END IF;
  --1. Buscar Clientes
   SELECT pam_cvesec, NVL(pam_folini,'T') INTO ws_cve_cte, ws_tpo_con
   FROM LABPROD.glcopams
   WHERE pam_keypar = 'SAFN'
   AND pam_folfin = 'F';
  --2. Validar Tipo de Contrato
  IF ws_tpo_con <> 'T' then
	  IF instr(ws_tpo_con, ca2aux) = 0 THEN
		wn_res_pue := wn_res_pue || '2';
	  --  RETURN;
	  END IF;
  END IF;
  --3. Validar Procesos
  SELECT COUNT(*) INTO wn_tot_reg FROM LABPROD.glcopams
    WHERE pam_keypar = 'SAF'
      AND pam_folfin = 'tviaefah'
      AND pam_folini = keypro;
  IF wn_tot_reg > 0 THEN
    wn_res_pue := wn_res_pue || '3';
    --RETURN;
  END IF;
  --4.	Validar empleados con m?s de una clave en SAF
  BEGIN
    select pam_nompar INTO gl_rec_urp from LABPROD.glcopams
    where pam_keypar = 'CEFI'
    and pam_folini = keyemp;
  EXCEPTION
	  WHEN NO_DATA_FOUND THEN gl_rec_urp := ' ';
  END;
  IF gl_rec_urp <> ' ' THEN
    ws_rec_urp := gl_rec_urp;
  ELSE
    ws_rec_urp := recurp;
  END IF;
  --5.	Validar Registros en la tabla aux_acum3
  SELECT COUNT(*) INTO wn_tot_reg
   FROM LABPROD.aux_acum3
   WHERE keycon = 'tviaesnt'
   AND keyemp = keyemp;
  IF wn_tot_reg <> 0 THEN
    wn_res_pue := wn_res_pue || '5';
  END IF;
-- Validaciones en la inserci?n
-- Buscar el Calendario del Proceso (Notar que s?lo se considera 7, 10, 15)
  SELECT pro_diaper INTO wn_dia_per FROM LABPROD.nmloproc
  WHERE pro_keypro = keypro;
	IF wn_dia_per = 7 THEN ws_cve_cal := 'S';
    ElSIF wn_dia_per = 10 THEN ws_cve_cal := 'D';
    ElSIF wn_dia_per = 15 THEN ws_cve_cal := 'Q';
    ELSE wn_res_pue := wn_res_pue || '6';
	END IF;
-- Buscar la Clave de Banco y la Cuenta Bancaria
--Validar la n?mina confidencial
  BEGIN
    SELECT cta_ctaban INTO ws_cta_ban
    FROM LABPROD.nmloctas
    WHERE cta_keyemp = keyemp
    AND cta_keypro = keypro;
  EXCEPTION
	  WHEN NO_DATA_FOUND THEN wn_res_pue := wn_res_pue || '9';
  END;
  IF keypro = 6 THEN
    wn_sal_mes := 15000;
  ELSE
    wn_sal_mes := salmes;
  END IF;
  ws_cve_ban := cveban;
  IF forpag = 1 OR forpag = 4 THEN
    ws_cve_ban := '000';
    ws_cta_ban := '000000000000000000';
  END IF;
  nombre := trim(LABPROD.sp_delimitador(nomemp,'/',3));
  paterno := trim(NVL(LABPROD.sp_delimitador(nomemp,'/',1), ' '));
  materno := trim(NVL(LABPROD.sp_delimitador(nomemp,'/',2), ' '));
  IF AntiguedadValida(fecaux) = 0 THEN
    wn_res_pue := wn_res_pue || '9';
  END IF;
  insert into LABPROD.datosgenerales_errsaf values (keyemp, 'UPDATE', SYSDATE,
    wn_res_pue || ' prueba fondo ahorro 2711_respue' || wn_res_pue);
  IF wn_res_pue = ' ' THEN
    sp_datosgenerales_fa_aut(ws_cve_cte, to_char(keyemp), recurp, nombre, paterno, materno, nvl(domemp, ' '), nvl(colemp, ' '),
      nvl(cidemp, ' '), NombreMunicipio(munemp), nvl(entemp, ' '), nvl(codemp, ' '), nvl(telemp, ' '), ws_cve_ban, ws_cta_ban, SP_TOVARCHAR2(wn_sal_mes), fecaux,
      ws_cve_cal, nvl(forpag, ' '), nvl(ca2aux, ' '), keypro, keyloc, status, wd_fec_mov);
  END IF;
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
  BEGIN
    SELECT COUNT(*) INTO existe_empleado
    FROM SAF_DGFA
    where "NumCliente" = cliente and "NumNomina" = keyemp;
  EXCEPTION
    WHEN OTHERS THEN
      insert into LABPROD.datosgenerales_errsaf values (keyemp, 'SELECT', SYSDATE,
      ' SELECT COUNT(*) FROM SAF_DGCA cliente, empleado '
      );
     existe_empleado := 0;
     COMMIT;
  END;
  BEGIN
    SELECT COUNT(*) INTO existe_curp
    FROM SAF_DGFA
    WHERE "NumCliente" = cliente AND "Clave" = recurp;
  EXCEPTION
    WHEN OTHERS THEN
      insert into LABPROD.datosgenerales_errsaf values (keyemp, 'SELECT', SYSDATE,
      ' SELECT COUNT(*) FROM SAF_DGCA cliente, curp'
      );
     existe_curp := 0;
     COMMIT;
  END;
  IF existe_empleado > 0  THEN
    BEGIN
      UPDATE SAF_DGFA SET "Clave" = recurp,
      "Nombre" = nombre, "ApPaterno" = paterno, "ApMaterno" = materno, "Domicilio" = domicilio, "Colonia" = colonia,
      "Ciudad" = ciudad, "MuniDele" = municipio, "IdEstado" = entidad, "CodPostal" = codigopostal, "Telefono" = telefono,
      "IdBanco" = clavebanco, "CLABE" = cuentabanco, "Salario" = salariomensual, "FechaIngreso" = fechaingreso, "IdTipoPago" = tipopago,
      "MetodoPago" = metodopago, "IdTipoContratacion" = tipocontrato, "IdEmpresa" = proceso, "IdUbicacion" = localidad, "IdEstatus" = status,
      "Exito" = 'N', "FechaSol" = fecha
      WHERE "NumCliente" = cliente AND "NumNomina" = keyemp;
    EXCEPTION
      WHEN OTHERS THEN
        insert into LABPROD.datosgenerales_errsaf values (keyemp, 'UP_CAJ', SYSDATE,
        ' existe empleado > 0'
        );
    END;
    COMMIT;
  ELSE
    IF existe_curp > 0  THEN
      BEGIN
        UPDATE SAF_DGFA SET "NumNomina" = keyemp,
          "Nombre" = nombre, "ApPaterno" = paterno, "ApMaterno" = materno, "Domicilio" = domicilio, "Colonia" = colonia,
          "Ciudad" = ciudad, "MuniDele" = municipio, "IdEstado" = entidad, "CodPostal" = codigopostal, "Telefono" = telefono,
          "IdBanco" = clavebanco, "CLABE" = cuentabanco, "Salario" = salariomensual, "FechaIngreso" = fechaingreso, "IdTipoPago" = tipopago,
          "MetodoPago" = metodopago, "IdTipoContratacion" = tipocontrato, "IdEmpresa" = proceso, "IdUbicacion" = localidad, "IdEstatus" = status,
           "Exito" = 'N', "FechaSol" = fecha
          WHERE "NumCliente" = cliente AND "Clave" = recurp;
      EXCEPTION
        WHEN OTHERS THEN
          insert into LABPROD.datosgenerales_errsaf values (keyemp, 'UP_CAJ', SYSDATE,
          ' existe curp > 0'
          );
      END;
      COMMIT;
    ELSE
      BEGIN
        INSERT INTO SAF_DGFA VALUES
            (' ', cliente, recurp, keyemp, nombre, paterno, materno, domicilio, colonia,
            ciudad, municipio, entidad, codigopostal, telefono, clavebanco, cuentabanco, salariomensual, fechaingreso,
            tipopago, metodopago, tipocontrato, proceso, localidad, status, 'N', fecha, fecha);
      EXCEPTION
        WHEN OTHERS THEN
              NULL;
      END;
      COMMIT;
    END IF;
  END IF;
END SP_DATOSGENERALES_FA_AUT;
---pasivos
--PASIVOS DE FONDO DE AHORRO
PROCEDURE SP_DATOSGENERALES_PA
				(recurp in LABPROD.nmcoempl.emp_recurp%TYPE, keyemp in LABPROD.nmcoempl.emp_keyemp%TYPE, nomemp in LABPROD.nmcoempl.emp_nomemp%TYPE, keypro in LABPROD.nmcoempl.emp_keypro%TYPE,
				cveban in LABPROD.nmcoempl.emp_cveban%TYPE, fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE, domemp in LABPROD.nmcoempl.emp_domemp%TYPE, colemp in LABPROD.nmcoempl.emp_colemp%TYPE,
				munemp in LABPROD.nmcoempl.emp_munemp%TYPE, entemp in LABPROD.nmcoempl.emp_entemp%TYPE, codemp in LABPROD.nmcoempl.emp_codemp%TYPE, telemp in LABPROD.nmcoempl.emp_telemp%TYPE,
				cidemp in LABPROD.nmcoempl.emp_cidemp%TYPE, salmes in LABPROD.nmcoempl.emp_salmes%TYPE, keyloc in LABPROD.nmcoempl.emp_keyloc%TYPE, forpag in LABPROD.nmcoempl.emp_forpag%TYPE,
				ca2aux in LABPROD.nmcoempl.emp_ca2aux%TYPE, status in LABPROD.nmcoempl.emp_status%TYPE, ca4aux in LABPROD.nmcoempl.emp_ca4aux%TYPE) IS
  wn_res_pue LABPROD.DATOSGENERALES.GEN_VALIDA%TYPE;
   --Igneos.I
  wn_tot_reg NUMBER;
  ws_cve_cte VARCHAR(5);
  gl_rec_urp VARCHAR(20);
  ws_rec_urp VARCHAR(20);
  wn_dia_per NUMBER;
  ws_cve_cal VARCHAR(1);
  ws_cta_ban VARCHAR(18);
  ws_tpo_con VARCHAR(50);
  wn_sal_mes NUMBER;
  ws_cve_ban VARCHAR(18);
  wd_fec_mov DATE;
  paterno VARCHAR(50);
  materno VARCHAR(50);
  nombre VARCHAR(100);
  existe NUMBER;
  valido NUMBER;
BEGIN
  wn_res_pue:=' ';
  wd_fec_mov:= SYSDATE;
  IF ca4aux <> 'F' THEN
  wn_res_pue := wn_res_pue || '8';
  END IF;
  IF ca2aux IS NULL or ca2aux = ' ' THEN
    wn_res_pue := wn_res_pue || '8';
  END IF;
  --1. Buscar Clientes
   SELECT pam_cvesec, NVL(pam_folini,'T') INTO ws_cve_cte, ws_tpo_con
   FROM LABPROD.glcopams
   WHERE pam_keypar = 'SAFN'
   AND pam_folfin = 'P';
  --2. Validar Tipo de Contrato
  IF ws_tpo_con <> 'T' then
	  SELECT COUNT(*) INTO wn_tot_reg FROM LABPROD.nmcoempl
	  WHERE emp_keyemp = keyemp
	  AND emp_ca2aux IN (ws_tpo_con);
	  IF wn_tot_reg = 0 THEN
      wn_res_pue := wn_res_pue || '2';
	  END IF;
  END IF;
  --3. Validar Procesos
	SELECT COUNT(*) INTO wn_tot_reg FROM LABPROD.glcopams
	WHERE pam_keypar = 'SAF'
	AND pam_folfin = 'tviaefah'
	AND pam_folini = keypro;
  IF wn_tot_reg > 0 THEN
    wn_res_pue := wn_res_pue || '3';
  END IF;
  --4.	Validar empleados con m?s de una clave en SAF
  BEGIN
    SELECT pam_nompar INTO gl_rec_urp from LABPROD.glcopams
    WHERE pam_keypar = 'CEFI'
    AND pam_folini = keyemp;
  EXCEPTION
	  WHEN NO_DATA_FOUND THEN gl_rec_urp := ' ';
  END;
  IF gl_rec_urp <> ' ' THEN
    ws_rec_urp := gl_rec_urp;
  ELSE
    ws_rec_urp := recurp;
  END IF;
  --5.	Validar Registros en la tabla aux_acum3
  SELECT COUNT(*) INTO wn_tot_reg
   FROM LABPROD.aux_acum3
   WHERE keycon = 'tviaesnt'
   AND keyemp = keyemp;
   IF wn_tot_reg <> 0 THEN
    wn_res_pue := wn_res_pue || '5';
  END IF;
-- Validaciones en la inserci?n
-- Buscar el Calendario del Proceso (Notar que s?lo se considera 7, 10, 15)
  SELECT pro_diaper INTO wn_dia_per FROM LABPROD.nmloproc
  WHERE pro_keypro = keypro;
	IF wn_dia_per = 7 THEN ws_cve_cal := 'S';
    ElSIF wn_dia_per = 10 THEN ws_cve_cal := 'D';
    ElSIF wn_dia_per = 15 THEN ws_cve_cal := 'Q';
    ELSE wn_res_pue := wn_res_pue || '6';
	END IF;
  -- Buscar la Clave de Banco y la Cuenta Bancaria
  BEGIN
    SELECT cta_ctaban INTO ws_cta_ban
    FROM LABPROD.nmloctas
    WHERE cta_keyemp = keyemp
    AND cta_keypro = keypro;
  EXCEPTION
	  WHEN NO_DATA_FOUND THEN wn_res_pue := wn_res_pue || '9';
  END;
  IF keypro = 6 THEN
    wn_sal_mes := 15000;
  ELSE
    wn_sal_mes := salmes;
  END IF;
  ws_cve_ban := cveban;
  IF forpag = 1 OR forpag = 4 THEN
    ws_cve_ban := '000';
    ws_cta_ban := '000000000000000000';
  END IF;
  nombre := trim(LABPROD.sp_delimitador(nomemp,'/',3));
  paterno := trim(NVL(LABPROD.sp_delimitador(nomemp,'/',1), ' '));
  materno := trim(NVL(LABPROD.sp_delimitador(nomemp,'/',2), ' '));
  IF AntiguedadValida(fecaux) = 0 THEN
    wn_res_pue := wn_res_pue || '9';
  END IF;
  insert into LABPROD.datosgenerales_errsaf values (keyemp, 'UPDATE', SYSDATE,
    wn_res_pue || ' prueba pasivos ahorro');
  IF wn_res_pue = ' ' THEN
    sp_datosgenerales_pa_aut(ws_cve_cte, to_char(keyemp), recurp, nombre, paterno, materno, nvl(domemp, ' '), nvl(colemp, ' '),
      nvl(cidemp, ' '), NombreMunicipio(munemp), nvl(entemp, ' '), nvl(codemp, ' '), nvl(telemp, ' '), ws_cve_ban, ws_cta_ban, SP_TOVARCHAR2(wn_sal_mes), fecaux,
      ws_cve_cal, nvl(forpag, ' '), nvl(ca2aux, ' '), keypro, keyloc, status, wd_fec_mov);
  END IF;
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
  BEGIN
    SELECT COUNT(*) INTO existe_empleado
    FROM SAF_DGFA
    WHERE "NumCliente" = cliente AND "NumNomina" = keyemp;
  EXCEPTION
    WHEN OTHERS THEN
      insert into LABPROD.datosgenerales_errsaf values (keyemp, 'SELECT', SYSDATE,
      ' SELECT COUNT(*) FROM SAF_DGCA cliente, empleado '
      );
      COMMIT;
      existe_empleado := 0;
      COMMIT;
  END;
  BEGIN
    SELECT COUNT(*) INTO existe_curp
    FROM SAF_DGFA
    WHERE "NumCliente" = cliente AND "Clave" = recurp;
  EXCEPTION
    WHEN OTHERS THEN
      insert into LABPROD.datosgenerales_errsaf values (keyemp, 'SELECT', SYSDATE,
      ' SELECT COUNT(*) FROM SAF_DGCA cliente, curp'
      );
      COMMIT;
      existe_curp := 0;
  END;
  IF existe_empleado > 0  THEN
    BEGIN
      UPDATE SAF_DGFA SET "Clave" = recurp,
      "Nombre" = nombre, "ApPaterno" = paterno, "ApMaterno" = materno, "Domicilio" = domicilio, "Colonia" = colonia,
      "Ciudad" = ciudad, "MuniDele" = municipio, "IdEstado" = entidad, "CodPostal" = codigopostal, "Telefono" = telefono,
      "IdBanco" = clavebanco, "CLABE" = cuentabanco, "Salario" = salariomensual, "FechaIngreso" = fechaingreso, "IdTipoPago" = tipopago,
      "MetodoPago" = metodopago, "IdTipoContratacion" = tipocontrato, "IdEmpresa" = proceso, "IdUbicacion" = localidad, "IdEstatus" = status,
      "Exito" = 'N', "FechaSol" = fecha
      WHERE "NumCliente" = cliente AND "NumNomina" = keyemp;
    EXCEPTION
      WHEN OTHERS THEN
        insert into LABPROD.datosgenerales_errsaf values (keyemp, 'UP_CAJ', SYSDATE,
        'existe empleado > 0'
        );
    END;
    COMMIT;
  ELSE
    IF existe_curp > 0  THEN
      BEGIN
        UPDATE SAF_DGFA SET "NumNomina" = keyemp,
        "Nombre" = nombre, "ApPaterno" = paterno, "ApMaterno" = materno, "Domicilio" = domicilio, "Colonia" = colonia,
        "Ciudad" = ciudad, "MuniDele" = municipio, "IdEstado" = entidad, "CodPostal" = codigopostal, "Telefono" = telefono,
        "IdBanco" = clavebanco, "CLABE" = cuentabanco, "Salario" = salariomensual, "FechaIngreso" = fechaingreso, "IdTipoPago" = tipopago,
        "MetodoPago" = metodopago, "IdTipoContratacion" = tipocontrato, "IdEmpresa" = proceso, "IdUbicacion" = localidad, "IdEstatus" = status,
         "Exito" = 'N', "FechaSol" = fecha
        WHERE "NumCliente" = cliente AND "Clave" = recurp;
      EXCEPTION
        WHEN OTHERS THEN
          insert into LABPROD.datosgenerales_errsaf values (keyemp, 'UP_CAJ', SYSDATE,
          ' existe curp > 0');
      END;
      COMMIT;
    ELSE
      BEGIN
        INSERT INTO SAF_DGFA VALUES
        (' ', cliente, recurp, keyemp, nombre, paterno, materno, domicilio, colonia,
        ciudad, municipio, entidad, codigopostal, telefono, clavebanco, cuentabanco, salariomensual, fechaingreso,
        tipopago, metodopago, tipocontrato, proceso, localidad, status, 'N', fecha, fecha);
      EXCEPTION
          WHEN OTHERS THEN
          NULL;
      END;
      COMMIT;
    END IF;
  END IF;
END SP_DATOSGENERALES_PA_AUT;
--NOMINA CON CAUSA
PROCEDURE SP_DATOSGENERALES_NC
				(recurp in LABPROD.nmcoempl.emp_recurp%TYPE, keyemp in LABPROD.nmcoempl.emp_keyemp%TYPE, nomemp in LABPROD.nmcoempl.emp_nomemp%TYPE, keypro in LABPROD.nmcoempl.emp_keypro%TYPE,
				cveban in LABPROD.nmcoempl.emp_cveban%TYPE, fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE, domemp in LABPROD.nmcoempl.emp_domemp%TYPE, colemp in LABPROD.nmcoempl.emp_colemp%TYPE,
				munemp in LABPROD.nmcoempl.emp_munemp%TYPE, entemp in LABPROD.nmcoempl.emp_entemp%TYPE, codemp in LABPROD.nmcoempl.emp_codemp%TYPE, telemp in LABPROD.nmcoempl.emp_telemp%TYPE,
				cidemp in LABPROD.nmcoempl.emp_cidemp%TYPE, salmes in LABPROD.nmcoempl.emp_salmes%TYPE, keyloc in LABPROD.nmcoempl.emp_keyloc%TYPE, forpag in LABPROD.nmcoempl.emp_forpag%TYPE,
				ca2aux in LABPROD.nmcoempl.emp_ca2aux%TYPE, status in LABPROD.nmcoempl.emp_status%TYPE) IS
  wn_res_pue LABPROD.DATOSGENERALES.GEN_VALIDA%TYPE;
   --Igneos.I
  wn_tot_reg NUMBER;
  ws_cve_cte VARCHAR(5);
  gl_rec_urp VARCHAR(20);
  ws_rec_urp VARCHAR(20);
  wn_dia_per NUMBER;
  ws_cve_cal VARCHAR(1);
  ws_cta_ban VARCHAR(18);
  ws_tpo_con VARCHAR(50);
  wn_sal_mes NUMBER;
  ws_cve_ban VARCHAR(18);
  wd_fec_mov DATE;
  paterno VARCHAR(50);
  materno VARCHAR(50);
  nombre VARCHAR(100);
  existe NUMBER;
  valido NUMBER;
BEGIN
  wn_res_pue:=' ';
  wd_fec_mov:= SYSDATE;
  IF status <> 1 THEN
    wn_res_pue := wn_res_pue || '0';
  END IF;
  --1. Buscar Clientes
  SELECT pam_cvesec, NVL(pam_folini,'T') INTO ws_cve_cte, ws_tpo_con
  FROM LABPROD.glcopams
  WHERE pam_keypar = 'ESAC'
  AND pam_folfin = 'C' and pam_cvesec = '1003';
  --2. Validar Tipo de Contrato
  IF ws_tpo_con <> 'T' then
	  SELECT COUNT(*) INTO wn_tot_reg FROM LABPROD.nmcoempl
	  WHERE emp_keyemp = keyemp
	  AND emp_ca2aux IN (ws_tpo_con);
	  IF wn_tot_reg = 0 THEN
      wn_res_pue := wn_res_pue || '2';
	  END IF;
  END IF;
  --3. Validar Procesos
  SELECT COUNT(*) INTO wn_tot_reg FROM LABPROD.glcopams
  WHERE pam_keypar = 'SAF'
  AND pam_folfin = 'tviaesaf'
  AND pam_folini = keypro;
  IF wn_tot_reg > 0 THEN
    wn_res_pue := wn_res_pue || '3';
    --RETURN;
  END IF;
  --4.	Validar empleados con m?s de una clave en SAF
  BEGIN
    SELECT pam_nompar INTO gl_rec_urp FROM LABPROD.glcopams
    WHERE pam_keypar = 'CEFI'
    AND pam_folini = keyemp;
  EXCEPTION
	  WHEN NO_DATA_FOUND THEN gl_rec_urp := ' ';
  END;
  IF gl_rec_urp <> ' ' THEN
    ws_rec_urp := gl_rec_urp;
  ELSE
    ws_rec_urp := recurp;
  END IF;
  --5.	Validar Registros en la tabla aux_acum3
  SELECT COUNT(*) INTO wn_tot_reg
   FROM LABPROD.aux_acum3
   WHERE keycon = 'tviaesnt'
   AND keyemp = keyemp;
  IF wn_tot_reg <> 0 THEN
    wn_res_pue := wn_res_pue || '5';
  --  RETURN;
  END IF;
-- Buscar el Calendario del Proceso (Notar que s?lo se considera 7, 10, 15)
  SELECT pro_diaper INTO wn_dia_per FROM LABPROD.nmloproc
  WHERE pro_keypro = keypro;
	IF wn_dia_per = 7 THEN ws_cve_cal := 'S';
    ElSIF wn_dia_per = 10 THEN ws_cve_cal := 'D';
    ElSIF wn_dia_per = 15 THEN ws_cve_cal := 'Q';
    ELSE wn_res_pue := wn_res_pue || '6';
	END IF;
  -- Buscar la Clave de Banco y la Cuenta Bancaria
  BEGIN
    SELECT cta_ctaban INTO ws_cta_ban
    FROM LABPROD.nmloctas
    WHERE cta_keyemp = keyemp
    AND cta_keypro = keypro;
  EXCEPTION
	  WHEN NO_DATA_FOUND THEN wn_res_pue := wn_res_pue || '9';
  END;
  IF keypro = 6 THEN
    wn_sal_mes := 15000;
  ELSE
    wn_sal_mes := salmes;
  END IF;
  ws_cve_ban := cveban;
  IF forpag = 1 OR forpag = 4 THEN
    ws_cve_ban := '000';
    ws_cta_ban := '000000000000000000';
  END IF;
  nombre := trim(LABPROD.sp_delimitador(nomemp,'/',3));
  paterno := trim(NVL(LABPROD.sp_delimitador(nomemp,'/',1), ' '));
  materno := trim(NVL(LABPROD.sp_delimitador(nomemp,'/',2), ' '));
  IF AntiguedadValida(fecaux) = 0 THEN
    wn_res_pue := wn_res_pue || '9';
  END IF;
  insert into LABPROD.datosgenerales_errsaf values (keyemp, 'UPDATE', SYSDATE,
    wn_res_pue || ' prueba nomina con causa ' || wn_res_pue || '.');
  IF wn_res_pue = ' ' THEN
    sp_datosgenerales_nc_aut(ws_cve_cte, to_char(keyemp), recurp, nombre, paterno, materno, nvl(domemp, ' '), nvl(colemp, ' '),
      nvl(cidemp, ' '), NombreMunicipio(munemp), nvl(entemp, ' '), nvl(codemp, ' '), nvl(telemp, ' '), ws_cve_ban, ws_cta_ban, SP_TOVARCHAR2(wn_sal_mes), fecaux,
      ws_cve_cal, nvl(forpag, ' '), nvl(ca2aux, ' '), keypro, keyloc, status, wd_fec_mov);
  END IF;
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
  BEGIN
    SELECT COUNT(*) INTO existe_empleado
    FROM SAF_DGNC
    WHERE "NumCliente" = cliente AND "NumNomina" = keyemp;
  EXCEPTION
    WHEN OTHERS THEN
      insert into LABPROD.datosgenerales_errsaf values (keyemp, 'SELECT', SYSDATE,
      ' SELECT COUNT(*) FROM SAF_DGCA cliente, empleado '
      );
      existe_empleado := 0;
      COMMIT;
  END;
  BEGIN
    SELECT COUNT(*) INTO existe_curp
    FROM SAF_DGNC
    WHERE "NumCliente" = cliente AND "Clave" = recurp;
  EXCEPTION
    WHEN OTHERS THEN
      insert into LABPROD.datosgenerales_errsaf values (keyemp, 'SELECT', SYSDATE,
      ' SELECT COUNT(*) FROM SAF_DGCA cliente, curp'
      );
    existe_curp := 0;
    COMMIT;
  END;
  IF existe_empleado > 0  THEN
    BEGIN
      UPDATE SAF_DGNC SET "Clave" = recurp,
      "Nombre" = nombre, "ApPaterno" = paterno, "ApMaterno" = materno, "Domicilio" = domicilio, "Colonia" = colonia,
      "Ciudad" = ciudad, "MuniDele" = municipio, "IdEstado" = entidad, "CodPostal" = codigopostal, "Telefono" = telefono,
      "IdBanco" = clavebanco, "CLABE" = cuentabanco, "Salario" = salariomensual, "FechaIngreso" = fechaingreso, "IdTipoPago" = tipopago,
      "MetodoPago" = metodopago, "IdTipoContratacion" = tipocontrato, "IdEmpresa" = proceso, "IdUbicacion" = localidad, "IdEstatus" = status,
       "Exito" = 'N', "FechaSol" = fecha
      WHERE "NumCliente" = cliente AND "NumNomina" = keyemp;
    EXCEPTION
      WHEN OTHERS THEN
        insert into LABPROD.datosgenerales_errsaf values (keyemp, 'UP_CAJ', SYSDATE,
        ' existe empleado > 0'
        );
    END;
    COMMIT;
  ELSE
    IF existe_curp > 0  THEN
      BEGIN
        UPDATE SAF_DGNC SET "NumNomina" = keyemp,
        "Nombre" = nombre, "ApPaterno" = paterno, "ApMaterno" = materno, "Domicilio" = domicilio, "Colonia" = colonia,
        "Ciudad" = ciudad, "MuniDele" = municipio, "IdEstado" = entidad, "CodPostal" = codigopostal, "Telefono" = telefono,
        "IdBanco" = clavebanco, "CLABE" = cuentabanco, "Salario" = salariomensual, "FechaIngreso" = fechaingreso, "IdTipoPago" = tipopago,
        "MetodoPago" = metodopago, "IdTipoContratacion" = tipocontrato, "IdEmpresa" = proceso, "IdUbicacion" = localidad, "IdEstatus" = status,
         "Exito" = 'N', "FechaSol" = fecha
        WHERE "NumCliente" = cliente AND "Clave" = recurp;
      EXCEPTION
        WHEN OTHERS THEN
          insert into LABPROD.datosgenerales_errsaf values (keyemp, 'UP_CAJ', SYSDATE,
          ' existe curp > 0'
          );
      END;
      COMMIT;
    ELSE
      BEGIN
        INSERT INTO SAF_DGNC VALUES
        (' ', cliente, recurp, keyemp, nombre, paterno, materno, domicilio, colonia,
        ciudad, municipio, entidad, codigopostal, telefono, clavebanco, cuentabanco, salariomensual, fechaingreso,
        tipopago, metodopago, tipocontrato, proceso, localidad, status, 'N', fecha, fecha);
      EXCEPTION
        WHEN OTHERS THEN
        NULL;
      END;
      COMMIT;
    END IF;
  END IF;
END SP_DATOSGENERALES_NC_AUT;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--APORTACIONES SAF
PROCEDURE SP_APORTACIONES
(keyper in LABPROD.nmloamor.amo_keyper%TYPE, keypro in LABPROD.nmloamor.amo_keypro%TYPE) IS
  wn_res_pue LABPROD.AMORTIZACIONES.AMO_VALIDA%TYPE;
   --Igneos.I
  wn_tot_reg NUMBER;
  wn_cve_emp NUMBER;
  ws_cve_con VARCHAR(3);
  wn_ref_ere NUMBER(16,6);
  wn_imp_ort NUMBER(12,2);
  ws_cve_conceptos VARCHAR(100);
  ws_cve_cte VARCHAR(5);
  wd_fec_mov DATE;
  wn_dia_per NUMBER;
  importe VARCHAR2(12);
  proceso number;
  refere varchar(2);
  foliolabora VARCHAR(30);
  tipopago VARCHAR(10);
BEGIN
  wn_res_pue:='';
  wd_fec_mov:= SYSDATE;
  tipopago := ' ';
  SELECT pro_diaper INTO wn_dia_per
    FROM LABPROD.nmloproc
    WHERE pro_keypro = keypro;
	IF wn_dia_per = 7 Then
		tipopago := 'SEMANA';
	Elsif wn_dia_per = 10 Then
		tipopago := 'DECENA';
	ElsIf wn_dia_per = 15 Then
		tipopago := 'QUINCENA';
	END IF;
  -- aportaciones caja de ahorro
  SELECT trim(pam_cvesec) INTO ws_cve_cte from LABPROD.glcopams
  WHERE pam_keypar = 'SAFT'
  AND pam_folfin = 'C';
  FOR reg IN (SELECT his_keyemp, to_char(his_keypro,'FM00') his_keypro, emp_recurp, his_keycon, his_import, his_fecmov
          FROM LABPROD.nmlohism
          INNER JOIN LABPROD.nmcoempl on (his_keyemp = emp_keyemp)
          Where his_import > 0
          AND his_keyper = keyper
          AND his_keypro = keypro
          AND his_keycon IN (SELECT pam_folini FROM LABPROD.glcopams
                             where pam_keypar = (SELECT pam_folini FROM LABPROD.glcopams
                                                 WHERE pam_cvesec = 'iaasaf'
                                                 AND pam_keypar = '00')
                              AND pam_folfin = 'APO' || ws_cve_cte)
            )
  LOOP
    importe := SP_TOVARCHAR2(reg.his_import);
    foliolabora := keyper || reg.his_keypro || reg.his_keyemp || reg.his_keycon || importe;
    BEGIN
      select count(*) into wn_tot_reg from SAF_APCA
      where "IdFolioLABORA" = foliolabora;
      if wn_tot_reg = 0 then
        INSERT INTO SAF_APCA
        ("IdFolioLABORA", "Sesion", "NumCliente", "CveEmpleado", "NumNomina", "Cuenta", "Aportacion", "TipoMov",
         "FechaSol", "FechaApl", "IdEstatus", "Nota", "TipoPago", "Proceso", "Periodo")
         VALUES
        ( foliolabora ,' ', ws_cve_cte , reg.emp_recurp, reg.his_keyemp, reg.his_keycon, importe, 'AP',
        reg.his_fecmov, wd_fec_mov, 15008, ' ', tipopago, reg.his_keypro,keyper);
      end if;
      commit;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END LOOP;
  --aportaciones n?mina con causa
  select trim(pam_cvesec)
  INTO ws_cve_cte from LABPROD.glcopams
	where pam_keypar = 'SAFT'
	and pam_folfin = 'N';
  FOR reg IN (SELECT his_keyemp, to_char(his_keypro,'FM00') his_keypro, emp_recurp, his_keycon, his_import, his_fecmov
            FROM LABPROD.nmlohism
            INNER JOIN LABPROD.nmcoempl on (his_keyemp = emp_keyemp)
            Where his_import > 0
            AND his_keyper = keyper
            AND his_keypro = keypro
            AND his_keycon IN (SELECT pam_folini FROM LABPROD.glcopams
                               where pam_keypar = (SELECT pam_folini FROM LABPROD.glcopams
                                                   WHERE pam_cvesec = 'iaasaf'
                                                   AND pam_keypar = '00')
                                AND pam_folfin = 'APO' || ws_cve_cte)
            )
  LOOP
    importe := SP_TOVARCHAR2(reg.his_import);
    foliolabora := keyper || reg.his_keypro || reg.his_keyemp || reg.his_keycon || importe;
    BEGIN
      select count(*) into wn_tot_reg from SAF_APNC
      where "IdFolioLABORA" = foliolabora;
      if wn_tot_reg = 0 then
        INSERT INTO SAF_APNC
        ("IdFolioLABORA", "Sesion", "NumCliente", "CveEmpleado", "NumNomina", "Cuenta", "Aportacion", "TipoMov",
         "FechaSol", "FechaApl", "IdEstatus", "Nota", "TipoPago","Proceso","Periodo")
         VALUES
        ( foliolabora ,' ', ws_cve_cte , reg.emp_recurp, reg.his_keyemp, reg.his_keycon, importe, 'AP',
        reg.his_fecmov, wd_fec_mov, 15008, ' ', tipopago, reg.his_keypro, keyper);
      end if;
      commit;
    EXCEPTION
    WHEN OTHERS THEN
      NULL;
    END;
  END LOOP;
  --aportaciones fondo de ahorro
  select trim(pam_cvesec) INTO ws_cve_cte from LABPROD.glcopams
    where pam_keypar = 'SAFT'
    and pam_folfin = 'F';
  FOR reg IN ( SELECT his_keyemp, to_char(his_keypro,'FM00') his_keypro, emp_recurp, mapeo.pam_folini his_keycon, his_import, his_fecmov
          FROM LABPROD.nmlohism
          INNER JOIN LABPROD.nmcoempl on (his_keyemp = emp_keyemp)
          inner join (SELECT distinct regexp_substr(pam_nompar,'[^,]+', 1, level) concepto, pam_folini from ( select * FROM LABPROD.glcopams
                    where pam_keypar = (SELECT pam_folini FROM LABPROD.glcopams WHERE pam_cvesec = 'iaasaf' AND pam_keypar = '00')
                    AND pam_folfin = 'APO' || ws_cve_cte)
                    connect by regexp_substr(pam_nompar,'[^,]+', 1, level) is not null) mapeo on mapeo.concepto = his_keycon
          Where his_import > 0
          AND his_tipplz = 'F'
          AND his_keyper = keyper
          AND his_keypro = keypro
          AND his_keycon IN (
                    SELECT regexp_substr(pam_nompar,'[^,]+', 1, level) from ( select * FROM LABPROD.glcopams
                    where pam_keypar = (SELECT pam_folini FROM LABPROD.glcopams WHERE pam_cvesec = 'iaasaf' AND pam_keypar = '00')
                    AND pam_folfin = 'APO' || ws_cve_cte)
                    connect by regexp_substr(pam_nompar,'[^,]+', 1, level) is not null
                            )
          )
  LOOP
    importe := SP_TOVARCHAR2(reg.his_import);
    foliolabora := keyper || reg.his_keypro || reg.his_keyemp || reg.his_keycon || importe;
    BEGIN
      select count(*) into wn_tot_reg from SAF_APFA
      where "IdFolioLABORA" = foliolabora;
      if wn_tot_reg = 0 then
        INSERT INTO SAF_APFA
        ("IdFolioLABORA", "Sesion", "NumCliente", "CveEmpleado", "NumNomina", "Cuenta", "Aportacion", "TipoMov",
         "FechaSol", "FechaApl", "IdEstatus", "Nota", "TipoPago", "Proceso", "Periodo")
         VALUES
        ( foliolabora ,' ', ws_cve_cte , reg.emp_recurp, reg.his_keyemp, reg.his_keycon, importe, 'AP',
        reg.his_fecmov, wd_fec_mov, 15008, ' ', tipopago, reg.his_keypro, keyper);
      end if;
      commit;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END LOOP;
END SP_APORTACIONES;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--AMORTIZACIONES SAF
PROCEDURE SP_AMORTIZACIONES
				(keyper in LABPROD.nmloamor.amo_keyper%TYPE, keypro in LABPROD.nmloamor.amo_keypro%TYPE) IS
  wn_res_pue LABPROD.AMORTIZACIONES.AMO_VALIDA%TYPE;
   --Igneos.I
  wn_tot_reg NUMBER;
  wn_cve_emp NUMBER;
  ws_cve_con VARCHAR(3);
  wn_ref_ere NUMBER(16,6);
  wn_imp_ort NUMBER(12,2);
  ws_cve_conceptos VARCHAR(100);
  ws_cve_cte VARCHAR(5);
  wd_fec_mov DATE;
  wn_dia_per NUMBER;
  importe VARCHAR2(12);
  proceso number;
  refere varchar(2);
  foliolabora VARCHAR(30);
  tipopago VARCHAR(10);
  BEGIN
  wn_res_pue:='';
  wd_fec_mov:= SYSDATE;
  tipopago := ' ';
	select trim(pam_cvesec) INTO ws_cve_cte from LABPROD.glcopams
	where pam_keypar = 'SAFT'
	and pam_folfin = 'C';
  SELECT pro_diaper INTO wn_dia_per
    FROM LABPROD.nmloproc
    WHERE pro_keypro = keypro;
	IF wn_dia_per = 7 Then
		tipopago := 'SEMANA';
	Elsif wn_dia_per = 10 Then
		tipopago := 'DECENA';
	ElsIf wn_dia_per = 15 Then
		tipopago := 'QUINCENA';
	END IF;
  FOR reg IN (SELECT amo_keyemp, to_char(amo_keypro,'FM00') amo_keypro, emp_recurp, amo_keycon, amo_keypre, amo_imppag, amo_unipag, to_char(pre_refere,'FM000') pre_refere,
                      nvl(substr(pam_nompar,1,50), ' ') descripcion, amo_ctreve, to_char(amo_numpag,'FM000') amo_numpag, amo_fecpag
            FROM LABPROD.nmloamor
            INNER JOIN LABPROD.nmcoempl on (amo_keyemp = emp_keyemp)
            INNER JOIN LABPROD.nmlopres on ( amo_keyemp = pre_keyemp and amo_keycon = pre_keycon and amo_keypre = pre_keypre)
            left outer join LABPROD.glcopams on (pam_keypar = 'AM' and pam_cvesec = amo_tiptra)
            Where pre_ca2aux = '1'
            AND amo_imppag > 0
            AND amo_keyper = keyper
            AND amo_keypro = keypro
            AND amo_tiptra = 'C'
            AND amo_keycon IN (SELECT pam_folini FROM LABPROD.glcopams
                               where pam_keypar = (SELECT pam_folini FROM LABPROD.glcopams
                                                   WHERE pam_cvesec = 'iaasaf'
                                                   AND pam_keypar = '00')
                                AND pam_folfin = 'AMO' || ws_cve_cte)
            )
  LOOP
    importe := SP_TOVARCHAR2(reg.amo_imppag);
    foliolabora := keyper || reg.amo_keypro || reg.amo_keyemp || reg.amo_keycon || reg.amo_numpag || reg.pre_refere ;
    BEGIN
      select count(*) into wn_tot_reg from SAF_AMCA
      where "IdFolioLABORA" = foliolabora;
      if wn_tot_reg = 0 then
        INSERT INTO SAF_AMCA
        ("IdFolioLABORA", "Sesion", "NumCliente", "CveEmpleado", "NumNomina", "IdPrestamo", "MontoPago",
         "Interes", "FechaSol", "FechaApl", "Comentario", "IdEstatus", "CtrlEventos", "Nota", "Codigo2", "TipoPago", "Proceso", "Periodo")
         VALUES
        ( foliolabora ,' ', ws_cve_cte , reg.emp_recurp, reg.amo_keyemp, reg.pre_refere, importe,
        reg.amo_unipag, reg.amo_fecpag, wd_fec_mov, reg.descripcion, 15008, reg.amo_ctreve, ' ', reg.amo_keycon, tipopago, reg.amo_keypro, keyper);
      end if;
      commit;
    --EXCEPTION
    --  WHEN OTHERS THEN
    --    NULL;
    END;
  END LOOP;
END SP_AMORTIZACIONES;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- incidencias saf
PROCEDURE SP_INCIDENCIA_CA ( wn_key_emp in NUMBER, ws_cve_ref in varchar, wn_tot_sol in number, wn_imp_des in number,
					gn_fec_ini in varchar, wn_imp_sal in number, wn_uni_pre in number, wn_uni_des in number, wn_uni_sal in number, ws_key_con in varchar,
					ws_per_saf in varchar, wn_res_pue out number) IS
  ws_key_dep VARCHAR(16);
  ws_key_pue VARCHAR(16);
  wn_key_pro NUMBER;
  wn_key_cia NUMBER;
  wn_sta_tus NUMBER;
  wn_dia_per NUMBER;
   --Igneos.I
  wn_tot_reg NUMBER;
  ws_cve_cal VARCHAR(3);
  ws_per_act VARCHAR(7);
  wd_fec_ini DATE;
  wd_fec_fin DATE;
  wd_fec_per DATE;
   --Igneos.I
  wn_cap_des NUMBER;
  wn_key_pre NUMBER;
  --Igneos.I
  gn_key_emp NUMBER;
BEGIN
--0. Inicializar Variables
  incidencia.wn_key_emp := wn_key_emp; incidencia.ws_cve_ref := ws_cve_ref; incidencia.wn_tot_sol := wn_tot_sol; incidencia.wn_imp_des := wn_imp_des;
	incidencia.gn_fec_ini := gn_fec_ini; incidencia.wn_imp_sal := wn_imp_sal; incidencia.wn_uni_pre := wn_uni_pre; incidencia.wn_uni_des := wn_uni_des;
	incidencia.wn_uni_sal := wn_uni_sal; incidencia.ws_key_con := ws_key_con; incidencia.ws_per_saf := ws_per_saf;
  wn_res_pue:=0;
  -------------------------------------------
  --1. Buscar Empleado
  gn_key_emp :=0;
  FOR q_empleado IN
    (SELECT emp_keyemp,emp_keydep,emp_keypue,emp_keypro,emp_status
       FROM LABPROD.nmcoempl
       WHERE emp_keyemp = wn_key_emp
       ORDER BY emp_status) LOOP
    gn_key_emp := q_empleado.emp_keyemp;
    ws_key_dep := q_empleado.emp_keydep;
    ws_key_pue := q_empleado.emp_keypue;
    wn_key_pro := q_empleado.emp_keypro;
    wn_sta_tus := q_empleado.emp_status;
    EXIT;
  END LOOP;
--No existe el empleado
  IF gn_key_emp = 0 THEN
    wn_res_pue := 1;
    BITACORA_INCIDENCIA (incidencia, wn_res_pue, NULL, NULL, 0);
    RETURN;
  END IF;
--2. Buscar el Calendario del Proceso
--Notar que s?lo se considera 7, 10, 15
  SELECT pro_diaper, pro_keycia INTO wn_dia_per, wn_key_cia
    FROM LABPROD.nmloproc WHERE pro_keypro = wn_key_pro;
	IF wn_dia_per = 7 Then ws_cve_cal := 'CPS';
	Elsif wn_dia_per = 10 Then ws_cve_cal := 'CPD';
	ElsIf wn_dia_per = 15 Then ws_cve_cal := 'CPQ';
	END IF;
  BEGIN
  --3. Buscar el Periodo Actual
      select pam_nompar, pam_folini, pam_folfin into ws_per_act, wd_fec_ini ,wd_fec_fin  from LABPROD.glcopams
      where pam_keypar = ws_cve_cal
      and pam_nompar = (SELECT MIN(per_keyper) FROM LABPROD.nmloperi
      WHERE per_keypro = wn_key_pro
          AND per_keynom IN( 1, 26 )
      AND per_fecact IS NULL);
  EXCEPTION
      WHEN OTHERS THEN
      wn_res_pue := 4;
      BITACORA_INCIDENCIA (incidencia, wn_res_pue, NULL, wn_key_pro, 0);
      RETURN;
  END;
	--Asignar el siguiente si la n?mina se est? calculando
	IF (trunc(SYSDATE) > wd_fec_ini AND trunc(SYSDATE) < wd_fec_fin) THEN
		if to_number(substr(ws_per_act, 5, 3)) = floor(365/wn_dia_per) then
			ws_per_act := to_char(to_number(substr(ws_per_act, 1, 4))+1) || '001';
		else
			ws_per_act := to_char(to_number(ws_per_act) + 1);
     end if;
	END IF;
	--Si el empleado est? dado de baja, termina la ejecuci?n
  IF wn_sta_tus = 2 THEN
    wn_res_pue := 2;
    BITACORA_INCIDENCIA (incidencia, wn_res_pue, ws_per_act, wn_key_pro, 0);
    RETURN;
  END IF;
	--valida que exista registro en calendarios
  select count(*) into wn_tot_reg from LABPROD.glcopams
  where pam_keypar = ws_cve_cal
  and pam_nompar = (SELECT MIN(per_keyper) FROM LABPROD.nmloperi
  WHERE per_keypro = wn_key_pro
      AND per_keynom IN( 1, 26 )
  AND per_fecact IS NULL);
	--. Error en calendario
  IF wn_tot_reg = 0 THEN
    wn_res_pue := 4;
    BITACORA_INCIDENCIA (incidencia, wn_res_pue, ws_per_act, wn_key_pro, 0);
    RETURN;
  END IF;
	--4. Buscar Concepto
  SELECT COUNT(*) INTO wn_tot_reg FROM LABPROD.nmloconc
  WHERE con_keycon = ws_key_con;
  IF wn_tot_reg = 0 THEN
    wn_res_pue := 3;
    BITACORA_INCIDENCIA (incidencia, wn_res_pue, ws_per_act, wn_key_pro, 0);
    RETURN;
  END IF;
	--validaci?n de periodo enviado contra periodo de aplicaci?n
  IF ws_per_saf <> ws_per_act THEN
    wn_res_pue := 19;
    BITACORA_INCIDENCIA (incidencia, wn_res_pue, ws_per_act, wn_key_pro, 0);
    RETURN;
  END IF;
  --6. Buscar el Pr?stamo
  SELECT COUNT(*) INTO wn_tot_reg FROM LABPROD.nmlopres
  WHERE pre_refere = ws_cve_ref
  AND pre_keyemp = wn_key_emp
  AND pre_status = 2
  AND pre_impsal > 0
  AND pre_keycon = ws_key_con;
  IF wn_tot_reg > 0 THEN
    UPDATE LABPROD.nmlopres SET pre_impdes = wn_imp_des, pre_impsal = wn_imp_sal,
      pre_unipre = wn_uni_pre, pre_unides = wn_uni_des, pre_unisal = wn_uni_sal
    WHERE pre_refere = ws_cve_ref
    AND pre_keyemp = wn_key_emp
    AND pre_keycon = ws_key_con;
    BITACORA_INCIDENCIA (incidencia, wn_res_pue, ws_per_act, wn_key_pro, 1);
  ELSE
    select per_fecini into wd_fec_per from LABPROD.nmloperi
    where per_keyper = ws_per_act
    and per_keypro = wn_key_pro;
    SELECT LABPROD.NMLOPRES_SEQ.NEXTVAL into wn_key_pre FROM dual;
    wn_key_pre := (wn_key_pre * 0.000001) + to_number(to_char(sysdate, 'YYMMDD'));
    INSERT INTO LABPROD.nmlopres
      (pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
      pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
      pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
      pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
      pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
      pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
      pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
      pre_ca4aux, pre_uniope, pre_keypro, pre_impnoa, pre_pernoa)
    VALUES(
      wn_key_emp, ws_key_con, wn_key_pre , ws_cve_ref, SYSDATE,
      'N', wn_uni_pre, wn_tot_sol, 0, 0,
      wn_uni_des, wn_imp_des, 0, ws_per_act, wd_fec_per,
      NULL, NULL, NULL, 0, 0,
      --gd_uni_sal, wn_tot_sol, 0, 0, 0,
      wn_uni_sal, wn_imp_sal, 0, 0, 0,
      0, 2, SYSDATE, NULL, NULL,
      NULL, NULL, NULL, 1, wn_imp_des + wn_uni_des,
      wn_key_pro, 1, wn_key_pro, NULL, NULL);
     BITACORA_INCIDENCIA (incidencia, wn_res_pue, ws_per_act, wn_key_pro, 2);
  END IF;
  LABPROD.sp_capdes(wn_key_emp, wn_cap_des);
  wn_res_pue := 0;
END SP_INCIDENCIA_CA;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------bit?cora de INcidencia AQU?
PROCEDURE BITACORA_INCIDENCIA (inc IN tipo_incidencia, resultado IN NUMBER, periodo in varchar, proceso in number, tipo IN NUMBER) IS
   BEGIN
  SELECT COUNT(*) INTO total FROM LABPROD.tvincsaf
  WHERE inc_cveref = inc.ws_cve_ref
  AND inc_keyemp = inc.wn_key_emp
  and inc_persaf = inc.ws_per_saf
  and inc_perlab = periodo
  AND inc_keycon = inc.ws_key_con;
  BEGIN
    if total = 0 then
      INSERT INTO LABPROD.tvincsaf VALUES
       (inc.wn_key_emp, inc.ws_cve_ref, inc.wn_tot_sol, inc.wn_imp_des, inc.gn_fec_ini,
        inc.wn_imp_sal, inc.wn_uni_pre, inc.wn_uni_des, inc.wn_uni_sal, inc.ws_key_con,
        inc.ws_per_saf, resultado, periodo, proceso, tipo, SYSDATE);
    else
       update LABPROD.tvincsaf set
        inc_totsol = inc.wn_tot_sol, inc_impdes = inc.wn_imp_des, inc_impsal = inc.wn_imp_sal,
        inc_unipre = inc.wn_uni_pre, inc_unides = inc.wn_uni_des, inc_unisal = inc.wn_uni_sal
        WHERE inc_cveref = inc.ws_cve_ref
        AND inc_keyemp = inc.wn_key_emp
        and inc_perlab = periodo
        AND inc_keycon = inc.ws_key_con;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      NULL; RETURN;
  END;
END BITACORA_INCIDENCIA;
FUNCTION ObtenEquivalencia (cveban in LABPROD.nmcoempl.emp_cveban%TYPE) RETURN VARCHAR IS
   BEGIN
   -- Buscar Equivalencia Bancaria
  banco := cveban;
  FOR catalogo IN
    (SELECT pam_folini FROM LABPROD.glcopams
       WHERE pam_keypar = 'CBL' AND pam_cvesec = cveban) LOOP
    banco := catalogo.pam_folini;
    EXIT;
  END LOOP;
  RETURN banco;
END ObtenEquivalencia;
 FUNCTION AntiguedadValida (fecaux in LABPROD.nmcoempl.emp_fecaux%TYPE) RETURN INTEGER IS
BEGIN
    -- Bandera
    IF fecaux < SYSDATE THEN
        bandera := 1;
    ELSE
        bandera := 0;
    END IF;
    RETURN bandera;
END AntiguedadValida;
FUNCTION NombreMunicipio (munemp in LABPROD.nmcoempl.emp_munemp%TYPE) RETURN VARCHAR IS
BEGIN
   -- Buscar Equivalencia Bancaria
  nombre_ := ' ';
  FOR catalogo IN
    (SELECT pam_nompar FROM LABPROD.glcopams
       where pam_keypar = 'MU' and pam_cvesec = munemp) LOOP
    nombre_ := catalogo.pam_nompar;
    EXIT;
  END LOOP;
  RETURN nombre_;
END NombreMunicipio;
END TVAUTSAF_LOCAL;
--------------------------------------------------------
/;
