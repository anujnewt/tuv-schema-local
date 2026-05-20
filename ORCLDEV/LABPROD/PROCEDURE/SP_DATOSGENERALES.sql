CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_DATOSGENERALES" 
(recurp in nmcoempl.emp_recurp%TYPE, keyemp in nmcoempl.emp_keyemp%TYPE, nomemp in nmcoempl.emp_nomemp%TYPE, keypro in nmcoempl.emp_keypro%TYPE,
cveban in nmcoempl.emp_cveban%TYPE, fecaux in nmcoempl.emp_fecaux%TYPE, domemp in nmcoempl.emp_domemp%TYPE, colemp in nmcoempl.emp_colemp%TYPE,
munemp in nmcoempl.emp_munemp%TYPE, entemp in nmcoempl.emp_entemp%TYPE, codemp in nmcoempl.emp_codemp%TYPE, telemp in nmcoempl.emp_telemp%TYPE,
cidemp in nmcoempl.emp_cidemp%TYPE, salmes in nmcoempl.emp_salmes%TYPE, keyloc in nmcoempl.emp_keyloc%TYPE, forpag in nmcoempl.emp_forpag%TYPE,
ca2aux in nmcoempl.emp_ca2aux%TYPE, status in nmcoempl.emp_status%TYPE) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  wn_res_pue DATOSGENERALES.GEN_VALIDA%TYPE;
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
  --1. Buscar Clientes
   SELECT pam_cvesec, NVL(pam_folini,'T') INTO ws_cve_cte, ws_tpo_con
   FROM glcopams
   WHERE pam_keypar = 'SDGI'
   AND pam_folfin <> 'D';
  --2. Validar Tipo de Contrato
  --SELECT COUNT(*) INTO wn_tot_reg FROM nmcoempl
--WHERE emp_keyemp = empleado
  --AND emp_ca2aux IN (ws_tpo_con);
  IF wn_tot_reg = 0 THEN
    wn_res_pue := wn_res_pue || '2';
  --  RETURN;
  END IF;
  --3. Validar Procesos
SELECT COUNT(*) INTO wn_tot_reg FROM glcopams
WHERE pam_keypar = 'IINT'
AND pam_folfin = 'tviaesnt'
AND pam_folini = keypro;
  IF wn_tot_reg > 0 THEN
    wn_res_pue := wn_res_pue || '3';
    --RETURN;
  END IF;
  --4.	Validar empleados con m?s de una clave en SAF
  BEGIN
    select pam_nompar INTO gl_rec_urp from glcopams
    where pam_keypar = 'CEFI'
    and pam_folini = keyemp;
  EXCEPTION
	  WHEN NO_DATA_FOUND THEN
          gl_rec_urp := ' ';
  END;
  IF gl_rec_urp <> ' ' THEN
    ws_rec_urp := gl_rec_urp;
  ELSE
    ws_rec_urp := recurp;
  END IF;
  --5.	Validar Registros en la tabla aux_acum3
  SELECT COUNT(*) INTO wn_tot_reg
   FROM aux_acum3
   WHERE keycon = 'tviaesnt'
   AND keyemp = keyemp;
   IF wn_tot_reg <> 0 THEN
    wn_res_pue := wn_res_pue || '5';
  --  RETURN;
  END IF;
-- Validaciones en la inserci?n
-- Buscar el Calendario del Proceso (Notar que s?lo se considera 7, 10, 15)
  SELECT pro_diaper INTO wn_dia_per FROM nmloproc
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
FROM nmloctas
WHERE cta_keyemp = keyemp
AND cta_keypro = keypro;
  EXCEPTION
	  WHEN NO_DATA_FOUND THEN
          wn_res_pue := wn_res_pue || '9';
  END;
IF keypro = 6 THEN
  wn_sal_mes := 15000;
ELSE
  wn_sal_mes := salmes;
END IF;
IF forpag = 1 OR forpag = 4 THEN
	ws_cve_ban := '000';
	ws_cta_ban := '000000000000000000';
END IF;
nombre := trim(sp_delimitador(nomemp,'/',3));
paterno := trim(NVL(sp_delimitador(nomemp,'/',1), ' '));
materno := trim(NVL(sp_delimitador(nomemp,'/',2), ' '));
claveban := substr(cveban,1, 3);
-- AQUI VA EL DISPARO PARA INSERTAR O ACTUALIZAR EN SAF
--(Sesion, 	NumCliente,	Clave, NumNomina, 	Nombre, 	ApPaterno, 	ApMaterno, 	Domicilio, 	Colonia,
--Ciudad, 	MuniDele, 	IdEstado, 	CodPostal, 	Telefono, 	IdBanco, 	CLABE, 	Salario, 	FechaIngreso,
--IdTipoPago, 	MetodoPago, 	IdTipoContratacion, 	IdEmpresa, 	IdUbicacion, 	IdEstatus, 	Exito, 	FechaSol, 	FechaApl)
--INSERT INTO FoEmpleadosLABORA VALUES
--(' ', ws_cve_cte, keyemp, ws_rec_urp, nombre, paterno, materno, domemp, colemp,
--cidemp, munemp, entemp, codemp, telemp, claveban, ws_cta_ban, salmes, fecaux,
--'Q', forpag, ca2aux, keypro, keyloc, status, 'E', wd_fec_mov, wd_fec_mov);
-- verificar si existe el registro
  --5.	Validar Registros en la tabla aux_acum3
--WHERE "NumCliente" = ws_cve_cte
--AND "NumNomina" = keyemp
--and "Clave" = recurp;
--existe := 0;
--SP_TOVARCHAR2(salmes)
  IF wn_res_pue = ' ' THEN
    sp_datosgenerales_aut(ws_cve_cte, to_char(keyemp), recurp, nombre, paterno, materno, nvl(domemp, ' '), nvl(colemp, ' '),
      nvl(cidemp, ' '), nvl(munemp, ' '), nvl(entemp, ' '), nvl(codemp, ' '), nvl(telemp, ' '), claveban, ws_cta_ban, SP_TOVARCHAR2(wn_sal_mes), fecaux,
      ws_cve_cal, nvl(forpag, ' '), nvl(ca2aux, ' '), keypro, keyloc, status, wd_fec_mov);
  END IF;
--INSERT INTO FoEmpleadosLABORA VALUES
--(' ', 1, 8888, '8888', 'nombre', 'paterno', 'materno', 'domemp', 'colemp',
--'cidemp', 'munemp', 'entemp', '99999', 'telemp', 'claveban', 'ws_cta_ban', 1, '01/01/2001',
--'Q', 'forpag', 'ca2aux', '8', 'keyloc', 1, 'N', '01/01/2013', '01/01/2013');
-- AQUI VA EL DISPARO PARA INSERTAR O ACTUALIZAR EN SAF
INSERT INTO DATOSGENERALES
(GEN_RECURP, GEN_KEYEMP, GEN_NOMEMP, GEN_APEPAT, GEN_APEMAT,
GEN_KEYPRO, GEN_PERPAG, GEN_CVEBAN, GEN_CTABAN, GEN_FECANT, GEN_DOMEMP, GEN_COLEMP,
GEN_MUNEMP, GEN_ENTEMP, GEN_CODEMP, GEN_TELEMP, GEN_CIDEMP, GEN_SALMES, GEN_KEYLOC, GEN_FORPAG, GEN_TPOCON, GEN_STATUS, GEN_NUMCTE, GEN_VALIDA) VALUES
(ws_rec_urp, keyemp, trim(sp_delimitador(nomemp,'/',3)), trim(NVL(sp_delimitador(nomemp,'/',1), ' ')), trim(NVL(sp_delimitador(nomemp,'/',2), ' ')),
keypro, ws_cve_cal, substr(cveban,1, 3), ws_cta_ban, fecaux, domemp, colemp,
 munemp, entemp, codemp, telemp, cidemp, wn_sal_mes, keyloc, forpag, ca2aux, status, ws_cve_cte, wn_res_pue);
END;
/
