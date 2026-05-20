CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_ACTUALIZAPRESTAMO_LOCAL" (ws_rec_urp in varchar, ws_cve_ref in varchar, ws_key_con in varchar,
wn_res_pue out number) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--Igneos.I
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
  hoy DATE;
  prueba BOOLEAN;
BEGIN
--1. Buscar datos del Empleado
  wn_key_emp :=0;
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
  SELECT COUNT(*) INTO wn_tot_reg FROM LABPROD.nmlopres
  WHERE pre_refere = ws_cve_ref
  AND pre_keyemp = wn_key_emp
  AND pre_keycon = ws_key_con
  AND pre_ca2aux = 1
  AND pre_status = 1;
  IF wn_tot_reg = 0 THEN
    wn_res_pue := 3;
    RETURN;
  END IF;
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
		and pam_nompar = (SELECT MIN(per_keyper) FROM nmloperi
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
  --hoy := trunc(SYSDATE);
  --boolean := (SYSDATE > wd_fec_ini AND SYSDATE < wd_fec_fin);
	IF (trunc(SYSDATE) > wd_fec_ini AND trunc(SYSDATE) < wd_fec_fin) THEN
    wn_res_pue := 4;
    RETURN;
  ELSE
   --actualiza
    UPDATE LABPROD.nmlopres SET pre_status = 2
    WHERE pre_refere = ws_cve_ref
    AND pre_keyemp = wn_key_emp
    AND pre_keycon = ws_key_con;
  END IF;
 wn_res_pue :=0;
END;
/
