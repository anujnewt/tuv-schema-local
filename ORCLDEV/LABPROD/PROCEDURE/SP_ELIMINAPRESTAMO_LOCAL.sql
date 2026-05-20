CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_ELIMINAPRESTAMO_LOCAL" (ws_rec_urp IN VARCHAR, ws_cve_ref IN VARCHAR, ws_key_con IN VARCHAR,
wn_res_pue OUT NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  wn_tot_reg NUMBER;
  wn_key_emp NUMBER;
  ws_key_dep VARCHAR(16);
  ws_key_pue VARCHAR(16);
  wn_key_pro NUMBER;
  wn_sta_tus NUMBER;
  wn_dia_per NUMBER;
  ws_cve_cal VARCHAR(3);
  ws_per_act VARCHAR(7);
  wd_fec_ini DATE;
  wd_fec_fin DATE;
   --Igneos.I
  wn_cap_des NUMBER;
  pr_sta_tus NUMBER;
BEGIN
--Inicializar
  wn_key_emp :=0;
--1. Buscar datos del Empleado
  FOR q_empleado IN
    (SELECT emp_keyemp,emp_keydep,emp_keypue,emp_keypro,emp_status
       FROM LABPROD.nmcoempl
       WHERE emp_recurp = ws_rec_urp
       ORDER BY emp_status) LOOP
    wn_key_emp := q_empleado.emp_keyemp;
    ws_key_dep := q_empleado.emp_keydep;
    ws_key_pue := q_empleado.emp_keypue;
    wn_key_pro := q_empleado.emp_keypro;
    wn_sta_tus := q_empleado.emp_status;
    EXIT;
  END LOOP;
  IF wn_key_emp = 0 THEN
    wn_res_pue := 1;
    RETURN;
  END IF;
  IF wn_sta_tus = 2 THEN
    wn_res_pue := 2;
    RETURN;
  END IF;
--2. Buscar Pr?stamo
--se asume que los pr?stamos son ?nicos [ref+emp+con] con ca2aux =1
BEGIN
  SELECT pre_status INTO pr_sta_tus FROM LABPROD.nmlopres
  WHERE pre_refere = ws_cve_ref
  AND pre_keyemp = wn_key_emp
  AND pre_keycon = ws_key_con
  AND pre_ca2aux = 1;
  --AND pre_status = 1;
EXCEPTION
	  WHEN NO_DATA_FOUND THEN
      wn_res_pue := 3;
      RETURN;
END;
--3.
     --3. Buscar el Calendario del Proceso
  --Notar que s?lo se considera 7, 10, 15
  SELECT pro_diaper INTO wn_dia_per
    FROM LABPROD.nmloproc
    WHERE pro_keypro = wn_key_pro;
	IF wn_dia_per = 7 Then
		ws_cve_cal := 'CPS';
	Elsif wn_dia_per = 10 Then
		ws_cve_cal := 'CPD';
	ElsIf wn_dia_per = 15 Then
		ws_cve_cal := 'CPQ';
	END IF;
     --4. Buscar calendario para periodo abierto
  ---------------------------------------------
  --error en calendarios
  	select count(*) into wn_tot_reg from LABPROD.glcopams
		where pam_keypar = ws_cve_cal
		and pam_nompar = (SELECT MIN(per_keyper) FROM LABPROD.nmloperi
		WHERE per_keypro = wn_key_pro
        AND per_keynom IN( 1, 26 )
		AND per_fecact IS NULL);
     --5. Error en calendario
  IF wn_tot_reg = 0 THEN
    wn_res_pue := 5;
    RETURN;
  END IF;
  --error en calendarios
  ---------------------------------------------
		select pam_nompar, pam_folini, pam_folfin into ws_per_act, wd_fec_ini ,wd_fec_fin  from LABPROD.glcopams
		where pam_keypar = ws_cve_cal
		and pam_nompar = (SELECT MIN(per_keyper) FROM nmloperi
		WHERE per_keypro = wn_key_pro
        AND per_keynom IN( 1, 26 )
		AND per_fecact IS NULL);
	IF (trunc(SYSDATE) > wd_fec_ini AND trunc(SYSDATE) < wd_fec_fin) AND pr_sta_tus = 2 THEN
    wn_res_pue := 4;
    RETURN;
  END IF;
      --eliminar
      DELETE FROM LABPROD.nmlopres
      WHERE pre_refere = ws_cve_ref
      AND pre_keyemp = wn_key_emp
      AND pre_keycon = ws_key_con
      AND pre_ca2aux = 1;
      --AND pre_status = 1;
-- mandar llamar a sp_capdes despu?s de insertar
  --Igneos.I
    LABPROD.sp_capdes_local(wn_key_emp, wn_cap_des);
    wn_res_pue :=0;
END;
/
