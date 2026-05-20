CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_INSERTAPRESTAMO_LOCAL" (ws_rec_urp in varchar, wn_tot_sol in number, wn_imp_des in number,
--wn_tot_int in number, wn_int_des in number, gd_uni_sal in number, ws_cve_cli in varchar, ws_cve_ref in varchar, ws_key_con in varchar,
wn_tot_int in number, wn_int_des in number, ws_cve_cli in varchar, ws_cve_ref in varchar, ws_key_con in varchar,
wn_res_pue out number) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--ws_rec_urp  CURP del empleado
--wn_tot_sol  Monto Total Solicitado
--wn_imp_des  Monto a descontar
--wn_tot_int  Total Intereses
--wn_int_des  Intereses a descontar por periodo
--ws_cve_cli  Clave de Cliente
--ws_cve_ref  Clave de Prestamo SAF
--ws_key_con  Clave del concepto
--gd_uni_sal  ... saldo
  wn_key_emp NUMBER;
  ws_key_dep VARCHAR(16);
  ws_key_pue VARCHAR(16);
  wn_key_pro NUMBER;
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
  wn_imp_des_validado NUMBER;
BEGIN
  wn_res_pue:=0;
  --1. Buscar Empleado
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
  --2. Buscar el Pr?stamo
  SELECT COUNT(*) INTO wn_tot_reg FROM LABPROD.nmlopres
  WHERE pre_refere = ws_cve_ref
  AND pre_keyemp = wn_key_emp
  AND pre_ca2aux = 1
  AND pre_keycon = ws_key_con;
  IF wn_tot_reg > 0 THEN
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
     --4. Buscar Concepto
  SELECT COUNT(*) INTO wn_tot_reg FROM LABPROD.nmloconc
  WHERE con_keycon = ws_key_con;
  IF wn_tot_reg = 0 THEN
    wn_res_pue := 4;
    RETURN;
  END IF;
     --5. Buscar Periodo de N?mina Inicial de descuento
		SELECT MIN(per_keyper) INTO ws_per_act FROM LABPROD.nmloperi
		WHERE per_keypro = wn_key_pro
        AND per_keynom IN( 1, 26 )
		AND per_fecact IS NULL;
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
  ---------------------------------------------
  --error en calendarios
  --incapacitados:
select count(*) into wn_tot_reg From LABPROD.nmlopres
Where pre_keyemp = wn_key_emp
AND pre_status = '2'
AND pre_keycon IN ('307','308','309')
AND trunc(sysdate) >= pre_fecini
AND trunc(sysdate) <= pre_fe1aux;
     --6. incapacitado
  IF wn_tot_reg > 0 THEN
    wn_res_pue := 6;
    RETURN;
  END IF;
  -------------------------------------------
  --Solicitud Concepto 89A
select count(*) into wn_tot_reg From LABPROD.glcopams
where pam_keypar = 'SAFF' and pam_folini = ws_key_con;
  IF wn_tot_reg > 0 THEN
    wn_imp_des_validado := 0;
  ELSE
    wn_imp_des_validado := wn_imp_des;
  END IF;
  -------------------------------------------
		select pam_nompar, pam_folini, pam_folfin into ws_per_act, wd_fec_ini ,wd_fec_fin  from LABPROD.glcopams
		where pam_keypar = ws_cve_cal
		and pam_nompar = (SELECT MIN(per_keyper) FROM nmloperi
		WHERE per_keypro = wn_key_pro
        AND per_keynom IN( 1, 26 )
		AND per_fecact IS NULL);
	IF (trunc(SYSDATE) > wd_fec_ini AND trunc(SYSDATE) < wd_fec_fin) THEN
		if to_number(substr(ws_per_act, 5, 3)) = floor(365/wn_dia_per) then
			ws_per_act := to_char(to_number(substr(ws_per_act, 1, 4))+1) || '001';
		else
			ws_per_act := to_char(to_number(ws_per_act) + 1);
     end if;
	END IF;
  --Campos a Insertar
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
		  'N', wn_tot_int, wn_tot_sol, 0, 0,
		  wn_int_des, wn_imp_des_validado, 0, ws_per_act, wd_fec_per,
		  NULL, NULL, NULL, 0, 0,
		  --gd_uni_sal, wn_tot_sol, 0, 0, 0,
		  0, wn_tot_sol, 0, 0, 0,
		  0, 1, SYSDATE, NULL, NULL,
		  NULL, NULL, NULL, 1, wn_imp_des + wn_int_des,
		  wn_key_pro, 1, wn_key_pro, NULL, NULL);
  -- mandar llamar a sp_capdes despu?s de insertar
  --Igneos.I
  LABPROD.sp_capdes(wn_key_emp, wn_cap_des);
  -----------------------------------------------
  wn_res_pue := 0;
END;
/
