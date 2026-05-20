CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_EOESTRUC" (ws_nvo_nom IN VARCHAR2,ws_nom_ant IN VARCHAR2,ws_sub_mov IN VARCHAR2,wf_fec_mov IN  DATE,ws_est_ant IN VARCHAR2,ws_est_act IN VARCHAR2,ws_est_ope IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_key_emp NUMBER(10);
		ws_tip_mov VARCHAR2(2);
		ws_key_dep VARCHAR2(16);
		ws_key_pue VARCHAR2(16);
		ws_key_cat VARCHAR2(16);
		ws_key_cen VARCHAR2(16);
		wn_sal_dia NUMBER(12,6);
		wn_sal_mes NUMBER(12,6);
		wn_sal_int NUMBER(12,6);
		wn_sal_ivc NUMBER(12,6);
		wn_sal_inf NUMBER(12,6);
		wn_int_sin NUMBER(12,6);
		wn_inf_sin NUMBER(12,6);
		ws_key_ims VARCHAR2(5);
		ws_key_loc VARCHAR2(4);
		ws_key_per VARCHAR2(7);
		wn_key_pla NUMBER(10);
		wn_key_pro NUMBER(5);
		wn_jor_lab VARCHAR2(1);
		wn_uni_jor NUMBER(4,2);
		ws_ca1_aux VARCHAR2(10);
		ws_ca2_aux VARCHAR2(10);
		ws_des_dep VARCHAR2(40);
		ws_ref_con VARCHAR2(20);
		ws_tip_dep VARCHAR2(1);
		ws_nu1_aux VARCHAR2(10);
		ws_nu2_aux VARCHAR2(10);
		ws_nu3_aux VARCHAR2(10);
		ws_nu4_aux VARCHAR2(10);
		ws_nu5_aux VARCHAR2(10);
		ws_ca3_aux VARCHAR2(10);
		ws_ca4_aux VARCHAR2(10);
		ws_ca5_aux VARCHAR2(10);
		ws_ubi_cac VARCHAR2(20);
		ws_sta_tus VARCHAR2(1);
		ws_per_iod VARCHAR2(7);
		ws_max_per VARCHAR2(7);
		BEGIN
	UPDATE eocorede SET red_hijdep=ws_nvo_nom
	WHERE red_hijdep=ws_nom_ant; COMMIT;
	UPDATE eocorede SET red_paddep=ws_nvo_nom
	WHERE red_paddep=ws_nom_ant; COMMIT;
	IF (ws_est_ope='1' ) THEN
	FOR c_emple IN ( SELECT emp_keyemp, emp_keypue, emp_keycat, emp_keycen, emp_saldia, emp_salmes, emp_salint, emp_salivc, emp_salinf, emp_intsin, emp_infsin, emp_keyims, emp_keyloc, emp_keypro, emp_jorlab, emp_unijor, emp_ca1aux, emp_ca2aux FROM nmcoempl
	WHERE emp_keydep=ws_nom_ant ) LOOP
		wn_key_emp :=c_emple.emp_keyemp;
			ws_key_pue :=c_emple.emp_keypue;
			ws_key_cat :=c_emple.emp_keycat;
			ws_key_cen :=c_emple.emp_keycen;
			wn_sal_dia :=c_emple.emp_saldia;
			wn_sal_mes :=c_emple.emp_salmes;
			wn_sal_int :=c_emple.emp_salint;
			wn_sal_ivc :=c_emple.emp_salivc;
			wn_sal_inf :=c_emple.emp_salinf;
			wn_int_sin :=c_emple.emp_intsin;
			wn_inf_sin :=c_emple.emp_infsin;
			ws_key_ims :=c_emple.emp_keyims;
			ws_key_loc :=c_emple.emp_keyloc;
			wn_key_pro :=c_emple.emp_keypro;
			wn_jor_lab :=c_emple.emp_jorlab;
			wn_uni_jor :=c_emple.emp_unijor;
			ws_ca1_aux :=c_emple.emp_ca1aux;
			ws_ca2_aux :=c_emple.emp_ca2aux;
	IF (wn_key_emp IS NULL ) THEN
	wn_key_emp:=0;
	END IF;
	IF (ws_key_pue IS NULL ) THEN
	ws_key_pue:=' ';
	END IF;
	IF (ws_key_cat IS NULL ) THEN
	ws_key_cat:=' ';
	END IF;
	IF (ws_key_cen IS NULL ) THEN
	ws_key_cen:=' ';
	END IF;
	IF (wn_sal_dia IS NULL ) THEN
	wn_sal_dia:=0;
	END IF;
	IF (wn_sal_mes IS NULL ) THEN
	wn_sal_mes:=0;
	END IF;
	IF (wn_sal_int IS NULL ) THEN
	wn_sal_int:=0;
	END IF;
	IF (wn_sal_ivc IS NULL ) THEN
	wn_sal_ivc:=0;
	END IF;
	IF (wn_sal_inf IS NULL ) THEN
	wn_sal_inf:=0;
	END IF;
	IF (wn_int_sin IS NULL ) THEN
	wn_int_sin:=0;
	END IF;
	IF (wn_inf_sin IS NULL ) THEN
	wn_inf_sin:=0;
	END IF;
	IF (ws_key_ims IS NULL ) THEN
	ws_key_ims:=' ';
	END IF;
	IF (ws_key_loc IS NULL ) THEN
	ws_key_loc:=' ';
	END IF;
	IF (wn_key_pro IS NULL ) THEN
	wn_key_pro:=0;
	END IF;
	IF (wn_jor_lab IS NULL ) THEN
	wn_jor_lab:=0;
	END IF;
	IF (wn_uni_jor IS NULL ) THEN
	wn_uni_jor:=0;
	END IF;
	IF (ws_ca1_aux IS NULL ) THEN
	ws_ca1_aux:=' ';
	END IF;
	IF (ws_ca2_aux IS NULL ) THEN
	ws_ca2_aux:=' ';
	END IF;
		FOR c_keydep IN ( SELECT  MIN(per_keyper ) alias1 FROM nmloperi
	WHERE per_keypro=wn_key_pro
	AND per_keynom=1
	AND per_fecact IS NULL ) LOOP
		ws_key_per :=c_keydep.alias1;
			ws_key_per:=ws_key_per;
	END LOOP;
	IF (ws_key_per IS NULL ) THEN
	ws_key_per:='0';
	END IF;
		INSERT INTO nmlotray( tra_fecmov,tra_tipmov,tra_keydep,tra_submov,tra_keyper,tra_keyemp,tra_keypue,tra_keycat,tra_keycen,tra_saldia,tra_salmes,tra_salint,tra_salivc,tra_salinf,tra_intsin,tra_infsin,tra_keyims,tra_codloc,tra_keypro,tra_jorlab,tra_unijor,tra_ca1aux,tra_ca2aux)
		VALUES(wf_fec_mov,'8',ws_nvo_nom,ws_sub_mov,ws_key_per,wn_key_emp,ws_key_pue,ws_key_cat,ws_key_cen,wn_sal_dia,wn_sal_mes,wn_sal_int,wn_sal_ivc,wn_sal_inf,wn_int_sin,wn_inf_sin,ws_key_ims,ws_key_loc,wn_key_pro,wn_jor_lab,wn_uni_jor,ws_ca1_aux,ws_ca2_aux); COMMIT;
	END LOOP;
	UPDATE nmcoempl SET emp_keydep=ws_nvo_nom
	WHERE emp_keydep=ws_nom_ant; COMMIT;
	UPDATE nmcoinci SET inc_keydep=ws_nvo_nom
	WHERE inc_keydep=ws_nom_ant; COMMIT;
	UPDATE nmlodfij SET dfi_keydep=ws_nvo_nom
	WHERE dfi_keydep=ws_nom_ant; COMMIT;
	UPDATE nmloamor SET amo_keydep=ws_nvo_nom
	WHERE amo_keydep=ws_nom_ant; COMMIT;
		END IF;
	UPDATE eocoplza SET plz_keydep=ws_nvo_nom
	WHERE plz_keyest=ws_est_ant
	AND plz_keydep=ws_nom_ant; COMMIT;
	UPDATE eolosolc SET sol_keydep=ws_nvo_nom
	WHERE sol_keyest=ws_est_ant
	AND sol_keydep=ws_nom_ant; COMMIT;
		END;
/
