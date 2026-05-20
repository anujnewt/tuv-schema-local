CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMINCEM1" (
	wn_key_pro IN NUMBER, ws_key_per IN VARCHAR2,  ws_key_men IN VARCHAR2, ws_des_pro OUT VARCHAR2,
	ws_des_nom OUT VARCHAR2, ws_per_ant OUT VARCHAR2, wd_fec_ini OUT DATE, wd_fec_fin OUT DATE,
	wn_key_nom OUT NUMBER )
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  wn_tot_reg NUMBER(10) := 0;
BEGIN
  ws_des_pro := NULL;
  ws_des_nom := NULL;
  wd_fec_ini := NULL;
  wd_fec_fin := NULL;
  ws_per_ant := ws_key_per;
  wn_key_nom := NULL;
  wn_tot_reg := 0;
  SELECT COUNT(*) INTO wn_tot_reg
  FROM glcodats
    WHERE dat_keymen = ws_key_men
      AND dat_idecam = 'keypro';
  IF wn_tot_reg > 0 THEN
	SELECT pro_despro INTO ws_des_pro FROM nmloproc
	WHERE pro_keypro = wn_key_pro
	AND pro_keypro IN
		( SELECT dat_valore FROM glcodats
		  WHERE dat_keymen = ws_key_men
		         AND dat_idecam = 'keypro' );
  ELSE
	SELECT pro_despro INTO ws_des_pro  FROM nmloproc
	WHERE pro_keypro = wn_key_pro;
  END IF;
   SELECT count(*) INTO wn_tot_reg FROM nmloperi
    WHERE per_keyper = ws_key_per
      AND per_keypro = wn_key_pro
      AND per_fecact IS NULL;
  IF wn_tot_reg > 0 THEN
	 wn_key_nom := NULL;
	SELECT per_keynom, per_fecini, per_fecfin
		INTO wn_key_nom,wd_fec_ini,wd_fec_fin
	FROM nmloperi
	WHERE per_keypro = wn_key_pro
	      AND per_keyper = ws_key_per;
	SELECT COUNT(*) INTO wn_tot_reg FROM glcodats
	WHERE dat_keymen = ws_key_men
	      AND dat_idecam = 'keynom';
	IF (wn_tot_reg > 0) THEN
		SELECT nom_destip INTO ws_des_nom  FROM nmlonomi
		WHERE nom_keynom = wn_key_nom
			AND nom_keynom IN
			( SELECT dat_valore FROM glcodats
			  WHERE dat_keymen = ws_key_men
			        AND dat_idecam = 'keynom' );
	ELSE
		SELECT nom_destip INTO ws_des_nom  FROM nmlonomi
		WHERE nom_keynom = wn_key_nom;
  	END IF;
  ELSE
	 ws_per_ant := '?';
  END IF;
  IF ws_des_pro is NULL THEN
  	 ws_des_pro := '?';
  END IF;
  IF ws_des_nom is  NULL THEN
  	ws_des_nom := '?';
  END IF;
  IF ws_key_per is NULL THEN
    ws_per_ant := ws_key_per;
  END IF;
  IF wn_key_nom is NULL THEN
  	wn_key_nom := -1;
  END IF;
END;
/
