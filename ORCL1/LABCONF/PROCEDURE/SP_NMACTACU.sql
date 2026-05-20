CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_NMACTACU" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2,wn_key_pro IN  NUMBER,ws_acu_uno IN VARCHAR2,ws_acu_dos IN VARCHAR2,ws_acu_tre IN VARCHAR2,ws_acu_cua IN VARCHAR2,ws_acu_cin IN VARCHAR2,ws_acu_sei IN VARCHAR2,ws_acu_sie IN VARCHAR2,ws_acu_och IN VARCHAR2,ws_acu_nue IN VARCHAR2,ws_acu_die IN VARCHAR2,ws_acu_onc IN VARCHAR2,ws_acu_doc IN VARCHAR2,ws_acu_trc IN VARCHAR2,ws_per_ini IN VARCHAR2,ws_per_fin IN VARCHAR2,ws_cod_acu IN VARCHAR2,wn_che_eli IN  NUMBER ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_key_emp NUMBER(10);
		wn_aux_emp NUMBER(10);
		ws_key_con VARCHAR2(3);
		ws_set_eli VARCHAR2(500);
		wn_key_per VARCHAR2(7);
		wn_can_tid NUMBER(12,2);
		wn_imp_ort NUMBER(12,2);
		his_key_con VARCHAR2(3);
		his_key_per VARCHAR2(7);
		his_cod_acu VARCHAR2(2);
		his_can_tid NUMBER(12,2);
		his_imp_ort NUMBER(12,2);
		acu_uni_uno NUMBER(12,2);
		acu_uni_dos NUMBER(12,2);
		acu_uni_tre NUMBER(12,2);
		acu_uni_cua NUMBER(12,2);
		acu_uni_cin NUMBER(12,2);
		acu_uni_sei NUMBER(12,2);
		acu_uni_sie NUMBER(12,2);
		acu_uni_och NUMBER(12,2);
		acu_uni_nue NUMBER(12,2);
		acu_uni_die NUMBER(12,2);
		acu_uni_onc NUMBER(12,2);
		acu_uni_doc NUMBER(12,2);
		acu_uni_trc NUMBER(12,2);
		acu_uni_cat NUMBER(12,2);
		acu_uni_qui NUMBER(12,2);
		acu_imp_uno NUMBER(12,2);
		acu_imp_dos NUMBER(12,2);
		acu_imp_tre NUMBER(12,2);
		acu_imp_cua NUMBER(12,2);
		acu_imp_cin NUMBER(12,2);
		acu_imp_sei NUMBER(12,2);
		acu_imp_sie NUMBER(12,2);
		acu_imp_och NUMBER(12,2);
		acu_imp_nue NUMBER(12,2);
		acu_imp_die NUMBER(12,2);
		acu_imp_onc NUMBER(12,2);
		acu_imp_doc NUMBER(12,2);
		acu_imp_trc NUMBER(12,2);
		acu_imp_cat NUMBER(12,2);
		acu_imp_qui NUMBER(12,2);
		wn_uni_uno NUMBER(12,2);
		wn_uni_dos NUMBER(12,2);
		wn_uni_tre NUMBER(12,2);
		wn_uni_cua NUMBER(12,2);
		wn_uni_cin NUMBER(12,2);
		wn_uni_sei NUMBER(12,2);
		wn_uni_sie NUMBER(12,2);
		wn_uni_och NUMBER(12,2);
		wn_uni_nue NUMBER(12,2);
		wn_uni_die NUMBER(12,2);
		wn_uni_onc NUMBER(12,2);
		wn_uni_doc NUMBER(12,2);
		wn_uni_trc NUMBER(12,2);
		wn_imp_uno NUMBER(12,2);
		wn_imp_dos NUMBER(12,2);
		wn_imp_tre NUMBER(12,2);
		wn_imp_cua NUMBER(12,2);
		wn_imp_cin NUMBER(12,2);
		wn_imp_sei NUMBER(12,2);
		wn_imp_sie NUMBER(12,2);
		wn_imp_och NUMBER(12,2);
		wn_imp_nue NUMBER(12,2);
		wn_imp_die NUMBER(12,2);
		wn_imp_onc NUMBER(12,2);
		wn_imp_doc NUMBER(12,2);
		wn_imp_trc NUMBER(12,2);
		ban_der_pri NUMBER(5);
		wn_tot_reg NUMBER(10);
		wn_num_reg NUMBER(10);
		wn_pct_reg NUMBER(12,2);
		wn_pct_act NUMBER(10);
		ws_hor_act VARCHAR2(8);
		wd_fec_act DATE;
		wn_num_tem NUMBER(10);
		BEGIN
	BEGIN SELECT  COUNT(* ) alias1
	INTO wn_tot_reg FROM nmcoempl
	WHERE emp_keyemp IN (
	SELECT ran_keyemp FROM glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyemp IS NOT NULL );
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  sp_glfechor (wd_fec_act, ws_hor_act);
	INSERT INTO glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,wd_fec_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); COMMIT;
		wn_num_reg:=0;
	wn_pct_act:=1;
	wn_pct_reg:=(wn_tot_reg/10.0);
	ws_set_eli:='';
	IF (wn_che_eli=1 ) THEN
	FOR q_actualiza IN ( SELECT acu_uniuno, acu_impuno, acu_unidos, acu_impdos, acu_unitre, acu_imptre, acu_unicua, acu_impcua, acu_unicin, acu_impcin, acu_unisei, acu_impsei, acu_unisie, acu_impsie, acu_unioch, acu_impoch, acu_uninue, acu_impnue, acu_unidie, acu_impdie, acu_unionc, acu_imponc, acu_unidoc, acu_impdoc, acu_unitrc, acu_imptrc, acu_keycon, acu_keyemp FROM nmloacum
	WHERE acu_keyemp IN (
	SELECT ran_keyemp FROM glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyemp IS NOT NULL )
	AND acu_keycon IN (
	SELECT ran_keycon FROM glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keycon IS NOT NULL )
	AND acu_keypro = wn_key_pro
	ORDER BY acu_keyemp ) LOOP
		wn_uni_uno :=q_actualiza.acu_uniuno;
			wn_imp_uno :=q_actualiza.acu_impuno;
			wn_uni_dos :=q_actualiza.acu_unidos;
			wn_imp_dos :=q_actualiza.acu_impdos;
			wn_uni_tre :=q_actualiza.acu_unitre;
			wn_imp_tre :=q_actualiza.acu_imptre;
			wn_uni_cua :=q_actualiza.acu_unicua;
			wn_imp_cua :=q_actualiza.acu_impcua;
			wn_uni_cin :=q_actualiza.acu_unicin;
			wn_imp_cin :=q_actualiza.acu_impcin;
			wn_uni_sei :=q_actualiza.acu_unisei;
			wn_imp_sei :=q_actualiza.acu_impsei;
			wn_uni_sie :=q_actualiza.acu_unisie;
			wn_imp_sie :=q_actualiza.acu_impsie;
			wn_uni_och :=q_actualiza.acu_unioch;
			wn_imp_och :=q_actualiza.acu_impoch;
			wn_uni_nue :=q_actualiza.acu_uninue;
			wn_imp_nue :=q_actualiza.acu_impnue;
			wn_uni_die :=q_actualiza.acu_unidie;
			wn_imp_die :=q_actualiza.acu_impdie;
			wn_uni_onc :=q_actualiza.acu_unionc;
			wn_imp_onc :=q_actualiza.acu_imponc;
			wn_uni_doc :=q_actualiza.acu_unidoc;
			wn_imp_doc :=q_actualiza.acu_impdoc;
			wn_uni_trc :=q_actualiza.acu_unitrc;
			wn_imp_trc :=q_actualiza.acu_imptrc;
			ws_key_con :=q_actualiza.acu_keycon;
			wn_key_emp :=q_actualiza.acu_keyemp;
	IF (ws_acu_uno='S' ) THEN
	wn_uni_uno:=0;
	wn_imp_uno:=0;
	END IF;
	IF (ws_acu_dos='S' ) THEN
	wn_uni_dos:=0;
	wn_imp_dos:=0;
	END IF;
	IF (ws_acu_tre='S' ) THEN
	wn_uni_tre:=0;
	wn_imp_tre:=0;
	END IF;
	IF (ws_acu_cua='S' ) THEN
	wn_uni_cua:=0;
	wn_imp_cua:=0;
	END IF;
	IF (ws_acu_cin='S' ) THEN
	wn_uni_cin:=0;
	wn_imp_cin:=0;
	END IF;
	IF (ws_acu_sei='S' ) THEN
	wn_uni_sei:=0;
	wn_imp_sei:=0;
	END IF;
	IF (ws_acu_sie='S' ) THEN
	wn_uni_sie:=0;
	wn_imp_sie:=0;
	END IF;
	IF (ws_acu_och='S' ) THEN
	wn_uni_och:=0;
	wn_imp_och:=0;
	END IF;
	IF (ws_acu_nue='S' ) THEN
	wn_uni_nue:=0;
	wn_imp_nue:=0;
	END IF;
	IF (ws_acu_die='S' ) THEN
	wn_uni_die:=0;
	wn_imp_die:=0;
	END IF;
	IF (ws_acu_onc='S' ) THEN
	wn_uni_onc:=0;
	wn_imp_onc:=0;
	END IF;
	IF (ws_acu_doc='S' ) THEN
	wn_uni_doc:=0;
	wn_imp_doc:=0;
	END IF;
	IF (ws_acu_trc='S' ) THEN
	wn_uni_trc:=0;
	wn_imp_trc:=0;
	END IF;
	UPDATE nmloacum SET acu_uniuno=wn_uni_uno,acu_unidos=wn_uni_dos,acu_unitre=wn_uni_tre,acu_unicua=wn_uni_cua,acu_unicin=wn_uni_cin,acu_unisei=wn_uni_sei,acu_unisie=wn_uni_sie,acu_unioch=wn_uni_och,acu_uninue=wn_uni_nue,acu_unidie=wn_uni_die,acu_unionc=wn_uni_onc,acu_unidoc=wn_uni_doc,acu_unitrc=wn_uni_trc,acu_impuno=wn_imp_uno,acu_impdos=wn_imp_dos,acu_imptre=wn_imp_tre,acu_impcua=wn_imp_cua,acu_impcin=wn_imp_cin,acu_impsei=wn_imp_sei,acu_impsie=wn_imp_sie,acu_impoch=wn_imp_och,acu_impnue=wn_imp_nue,acu_impdie=wn_imp_die,acu_imponc=wn_imp_onc,acu_impdoc=wn_imp_doc,acu_imptrc=wn_imp_trc
	WHERE acu_keycon = ws_key_con
	AND acu_keyemp = wn_key_emp
	AND acu_keypro = wn_key_pro; COMMIT;
	END LOOP;
	ws_key_con:='*';
	wn_key_emp:=0;
	END IF;
		FOR q_empleados IN ( SELECT emp_keyemp FROM nmcoempl
	WHERE emp_keyemp IN (
	SELECT ran_keyemp FROM glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyemp IS NOT NULL ) ) LOOP
		wn_key_emp :=q_empleados.emp_keyemp;
			wn_num_reg:=(wn_num_reg+1);
	wn_num_tem:=(wn_pct_reg*wn_pct_act);
	IF (wn_num_reg>=wn_num_tem ) THEN
	UPDATE glcoresu SET res_numreg=wn_num_reg
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu
	AND res_fecini = wd_fec_act
	AND res_horreg = ws_hor_reg; COMMIT;
		wn_pct_act:=(wn_pct_act+1);
	END IF;
		wn_can_tid:=0;
	wn_imp_ort:=0;
	ban_der_pri:=0;
	ws_key_con:='*';
	his_key_con:='';
	acu_imp_uno:=0;
	acu_uni_uno:=0;
	acu_imp_dos:=0;
	acu_uni_dos:=0;
	acu_imp_tre:=0;
	acu_uni_tre:=0;
	acu_imp_cua:=0;
	acu_uni_cua:=0;
	acu_imp_cin:=0;
	acu_uni_cin:=0;
	acu_imp_sei:=0;
	acu_uni_sei:=0;
	acu_imp_sie:=0;
	acu_uni_sie:=0;
	acu_imp_och:=0;
	acu_uni_och:=0;
	acu_imp_nue:=0;
	acu_uni_nue:=0;
	acu_imp_die:=0;
	acu_uni_die:=0;
	acu_imp_onc:=0;
	acu_uni_onc:=0;
	acu_imp_doc:=0;
	acu_uni_doc:=0;
	acu_imp_trc:=0;
	acu_uni_trc:=0;
	acu_uni_cat:=0;
	acu_imp_cat:=0;
	acu_uni_qui:=0;
	acu_imp_qui:=0;
	FOR q_act IN ( SELECT his_keycon, his_keyper, his_cantid, his_import FROM nmlohism
	WHERE his_keycon IN (
	SELECT ran_keycon FROM glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keycon IS NOT NULL )
	AND his_keyper BETWEEN ws_per_ini AND ws_per_fin
	AND his_keyemp = wn_key_emp
	AND his_codacu = ws_cod_acu
	AND his_keypro = wn_key_pro
	ORDER BY his_keycon ) LOOP
		his_key_con :=q_act.his_keycon;
			his_key_per :=q_act.his_keyper;
			his_can_tid :=q_act.his_cantid;
			his_imp_ort :=q_act.his_import;
	IF ((ban_der_pri=0) ) THEN
	ws_key_con:=his_key_con;
	wn_key_per:=his_key_per;
	ban_der_pri:=1;
	END IF;
	IF (ws_key_con != his_key_con ) THEN
	wn_aux_emp:=0;
	BEGIN SELECT acu_uniuno, acu_impuno, acu_unidos, acu_impdos, acu_unitre, acu_imptre, acu_unicua, acu_impcua, acu_unicin, acu_impcin, acu_unisei, acu_impsei, acu_unisie, acu_impsie, acu_unioch, acu_impoch, acu_uninue, acu_impnue, acu_unidie, acu_impdie, acu_unionc, acu_imponc, acu_unidoc, acu_impdoc, acu_unitrc, acu_imptrc, acu_keyemp
	INTO wn_uni_uno, wn_imp_uno, wn_uni_dos, wn_imp_dos, wn_uni_tre, wn_imp_tre, wn_uni_cua, wn_imp_cua, wn_uni_cin, wn_imp_cin, wn_uni_sei, wn_imp_sei, wn_uni_sie, wn_imp_sie, wn_uni_och, wn_imp_och, wn_uni_nue, wn_imp_nue, wn_uni_die, wn_imp_die, wn_uni_onc, wn_imp_onc, wn_uni_doc, wn_imp_doc, wn_uni_trc, wn_imp_trc, wn_aux_emp FROM nmloacum
	WHERE acu_keyemp = wn_key_emp
	AND acu_keycon = ws_key_con
	AND acu_keypro = wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
	IF ((wn_aux_emp =0) OR (wn_aux_emp IS NULL) ) THEN
	INSERT INTO nmloacum( acu_keyemp,acu_keycon,acu_keypro,acu_uniuno,acu_impuno,acu_unidos,acu_impdos,acu_unitre,acu_imptre,acu_unicua,acu_impcua,acu_unicin,acu_impcin,acu_unisei,acu_impsei,acu_unisie,acu_impsie,acu_unioch,acu_impoch,acu_uninue,acu_impnue,acu_unidie,acu_impdie,acu_unionc,acu_imponc,acu_unidoc,acu_impdoc,acu_unitrc,acu_imptrc,acu_unicat,acu_impcat,acu_uniqui,acu_impqui)
		VALUES(wn_key_emp,ws_key_con,wn_key_pro,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0); COMMIT;
		END IF;
	IF (ws_acu_uno='S' ) THEN
	wn_uni_uno:=acu_uni_uno;
	wn_imp_uno:=acu_imp_uno;
	END IF;
	IF (ws_acu_dos='S' ) THEN
	wn_uni_dos:=acu_uni_dos;
	wn_imp_dos:=acu_imp_dos;
	END IF;
	IF (ws_acu_tre='S' ) THEN
	wn_uni_tre:=acu_uni_tre;
	wn_imp_tre:=acu_imp_tre;
	END IF;
	IF (ws_acu_cua='S' ) THEN
	wn_uni_cua:=acu_uni_cua;
	wn_imp_cua:=acu_imp_cua;
	END IF;
	IF (ws_acu_cin='S' ) THEN
	wn_uni_cin:=acu_uni_cin;
	wn_imp_cin:=acu_imp_cin;
	END IF;
	IF (ws_acu_sei='S' ) THEN
	wn_uni_sei:=acu_uni_sei;
	wn_imp_sei:=acu_imp_sei;
	END IF;
	IF (ws_acu_sie='S' ) THEN
	wn_uni_sie:=acu_uni_sie;
	wn_imp_sie:=acu_imp_sie;
	END IF;
	IF (ws_acu_och='S' ) THEN
	wn_uni_och:=acu_uni_och;
	wn_imp_och:=acu_imp_och;
	END IF;
	IF (ws_acu_nue='S' ) THEN
	wn_uni_nue:=acu_uni_nue;
	wn_imp_nue:=acu_imp_nue;
	END IF;
	IF (ws_acu_die='S' ) THEN
	wn_uni_die:=acu_uni_die;
	wn_imp_die:=acu_imp_die;
	END IF;
	IF (ws_acu_onc='S' ) THEN
	wn_uni_onc:=acu_uni_onc;
	wn_imp_onc:=acu_imp_onc;
	END IF;
	IF (ws_acu_doc='S' ) THEN
	wn_uni_doc:=acu_uni_doc;
	wn_imp_doc:=acu_imp_doc;
	END IF;
	IF (ws_acu_trc='S' ) THEN
	wn_uni_trc:=acu_uni_trc;
	wn_imp_trc:=acu_imp_trc;
	END IF;
	UPDATE nmloacum SET acu_uniuno=wn_uni_uno,acu_unidos=wn_uni_dos,acu_unitre=wn_uni_tre,acu_unicua=wn_uni_cua,acu_unicin=wn_uni_cin,acu_unisei=wn_uni_sei,acu_unisie=wn_uni_sie,acu_unioch=wn_uni_och,acu_uninue=wn_uni_nue,acu_unidie=wn_uni_die,acu_unionc=wn_uni_onc,acu_unidoc=wn_uni_doc,acu_impuno=wn_imp_uno,acu_impdos=wn_imp_dos,acu_imptre=wn_imp_tre,acu_impcua=wn_imp_cua,acu_impcin=wn_imp_cin,acu_impsei=wn_imp_sei,acu_impsie=wn_imp_sie,acu_impoch=wn_imp_och,acu_impnue=wn_imp_nue,acu_impdie=wn_imp_die,acu_imponc=wn_imp_onc,acu_impdoc=wn_imp_doc,acu_imptrc=wn_imp_trc
	WHERE acu_keyemp = wn_key_emp
	AND acu_keycon = ws_key_con
	AND acu_keypro = wn_key_pro; COMMIT;
		acu_imp_uno:=0;
	acu_uni_uno:=0;
	acu_imp_dos:=0;
	acu_uni_dos:=0;
	acu_imp_tre:=0;
	acu_uni_tre:=0;
	acu_imp_cua:=0;
	acu_uni_cua:=0;
	acu_imp_cin:=0;
	acu_uni_cin:=0;
	acu_imp_sei:=0;
	acu_uni_sei:=0;
	acu_imp_sie:=0;
	acu_uni_sie:=0;
	acu_imp_och:=0;
	acu_uni_och:=0;
	acu_imp_nue:=0;
	acu_uni_nue:=0;
	acu_imp_die:=0;
	acu_uni_die:=0;
	acu_imp_onc:=0;
	acu_uni_onc:=0;
	acu_imp_doc:=0;
	acu_uni_doc:=0;
	acu_imp_trc:=0;
	acu_uni_trc:=0;
	acu_imp_cat:=0;
	acu_imp_cat:=0;
	acu_uni_qui:=0;
	acu_uni_qui:=0;
	wn_can_tid:=his_can_tid;
	wn_imp_ort:=his_imp_ort;
	ws_key_con:=his_key_con;
	wn_key_per:=his_key_per;
	sp_ubicames(ws_cod_acu, wn_can_tid, wn_imp_ort, wn_key_pro, wn_key_per, acu_uni_uno, acu_uni_dos, acu_uni_tre, acu_uni_cua, acu_uni_cin, acu_uni_sei, acu_uni_sie, acu_uni_och, acu_uni_nue, acu_uni_die, acu_uni_onc, acu_uni_doc, acu_uni_trc, acu_uni_cat, acu_uni_qui, acu_imp_uno, acu_imp_dos, acu_imp_tre, acu_imp_cua, acu_imp_cin, acu_imp_sei, acu_imp_sie, acu_imp_och, acu_imp_nue, acu_imp_die, acu_imp_onc, acu_imp_doc, acu_imp_trc, acu_imp_cat, acu_imp_qui,acu_uni_uno , acu_uni_dos , acu_uni_tre , acu_uni_cua , acu_uni_cin , acu_uni_sei , acu_uni_sie , acu_uni_och , acu_uni_nue , acu_uni_die , acu_uni_onc , acu_uni_doc , acu_uni_trc , acu_uni_cat , acu_uni_qui , acu_imp_uno , acu_imp_dos , acu_imp_tre , acu_imp_cua , acu_imp_cin , acu_imp_sei , acu_imp_sie , acu_imp_och , acu_imp_nue , acu_imp_die , acu_imp_onc , acu_imp_doc , acu_imp_trc , acu_imp_cat , acu_imp_qui );
	 ELSE
	wn_can_tid:=his_can_tid;
	wn_imp_ort:=his_imp_ort;
	wn_key_per:=his_key_per;
	sp_ubicames(ws_cod_acu, wn_can_tid, wn_imp_ort, wn_key_pro, wn_key_per, acu_uni_uno, acu_uni_dos, acu_uni_tre, acu_uni_cua, acu_uni_cin, acu_uni_sei, acu_uni_sie, acu_uni_och, acu_uni_nue, acu_uni_die, acu_uni_onc, acu_uni_doc, acu_uni_trc, acu_uni_cat, acu_uni_qui, acu_imp_uno, acu_imp_dos, acu_imp_tre, acu_imp_cua, acu_imp_cin, acu_imp_sei, acu_imp_sie, acu_imp_och, acu_imp_nue, acu_imp_die, acu_imp_onc, acu_imp_doc, acu_imp_trc, acu_imp_cat, acu_imp_qui,acu_uni_uno , acu_uni_dos , acu_uni_tre , acu_uni_cua , acu_uni_cin , acu_uni_sei , acu_uni_sie , acu_uni_och , acu_uni_nue , acu_uni_die , acu_uni_onc , acu_uni_doc , acu_uni_trc , acu_uni_cat , acu_uni_qui , acu_imp_uno , acu_imp_dos , acu_imp_tre , acu_imp_cua , acu_imp_cin , acu_imp_sei , acu_imp_sie , acu_imp_och , acu_imp_nue , acu_imp_die , acu_imp_onc , acu_imp_doc , acu_imp_trc , acu_imp_cat , acu_imp_qui );
	END IF;
	END LOOP;
	IF (ws_key_con != '*' ) THEN
	wn_aux_emp:=0;
	BEGIN SELECT acu_uniuno, acu_impuno, acu_unidos, acu_impdos, acu_unitre, acu_imptre, acu_unicua, acu_impcua, acu_unicin, acu_impcin, acu_unisei, acu_impsei, acu_unisie, acu_impsie, acu_unioch, acu_impoch, acu_uninue, acu_impnue, acu_unidie, acu_impdie, acu_unionc, acu_imponc, acu_unidoc, acu_impdoc, acu_unitrc, acu_imptrc, acu_keyemp
	INTO wn_uni_uno, wn_imp_uno, wn_uni_dos, wn_imp_dos, wn_uni_tre, wn_imp_tre, wn_uni_cua, wn_imp_cua, wn_uni_cin, wn_imp_cin, wn_uni_sei, wn_imp_sei, wn_uni_sie, wn_imp_sie, wn_uni_och, wn_imp_och, wn_uni_nue, wn_imp_nue, wn_uni_die, wn_imp_die, wn_uni_onc, wn_imp_onc, wn_uni_doc, wn_imp_doc, wn_uni_trc, wn_imp_trc, wn_aux_emp FROM nmloacum
	WHERE acu_keyemp = wn_key_emp
	AND acu_keycon = ws_key_con
	AND acu_keypro = wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
	IF ((wn_aux_emp =0) OR (wn_aux_emp IS NULL) ) THEN
	INSERT INTO nmloacum( acu_keyemp,acu_keycon,acu_keypro,acu_uniuno,acu_impuno,acu_unidos,acu_impdos,acu_unitre,acu_imptre,acu_unicua,acu_impcua,acu_unicin,acu_impcin,acu_unisei,acu_impsei,acu_unisie,acu_impsie,acu_unioch,acu_impoch,acu_uninue,acu_impnue,acu_unidie,acu_impdie,acu_unionc,acu_imponc,acu_unidoc,acu_impdoc,acu_unitrc,acu_imptrc,acu_unicat,acu_impcat,acu_uniqui,acu_impqui)
		VALUES(wn_key_emp,ws_key_con,wn_key_pro,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0); COMMIT;
		END IF;
		wn_uni_uno:=0;
	wn_imp_uno:=0;
	wn_uni_dos:=0;
	wn_imp_dos:=0;
	wn_uni_tre:=0;
	wn_imp_tre:=0;
	wn_uni_cua:=0;
	wn_imp_cua:=0;
	wn_uni_cin:=0;
	wn_imp_cin:=0;
	wn_uni_sei:=0;
	wn_imp_sei:=0;
	wn_uni_sie:=0;
	wn_imp_sie:=0;
	wn_uni_och:=0;
	wn_imp_och:=0;
	wn_uni_nue:=0;
	wn_imp_nue:=0;
	wn_uni_die:=0;
	wn_imp_die:=0;
	wn_uni_onc:=0;
	wn_imp_onc:=0;
	wn_uni_doc:=0;
	wn_imp_doc:=0;
	wn_uni_trc:=0;
	wn_imp_trc:=0;
	BEGIN SELECT acu_uniuno, acu_unidos, acu_unitre, acu_unicua, acu_unicin, acu_unisei, acu_unisie, acu_unioch, acu_uninue, acu_unidie, acu_unionc, acu_unidoc, acu_impuno, acu_impdos, acu_imptre, acu_impcua, acu_impcin, acu_impsei, acu_impsie, acu_impoch, acu_impnue, acu_impdie, acu_imponc, acu_impdoc, acu_imptrc
	INTO wn_uni_uno, wn_uni_dos, wn_uni_tre, wn_uni_cua, wn_uni_cin, wn_uni_sei, wn_uni_sie, wn_uni_och, wn_uni_nue, wn_uni_die, wn_uni_onc, wn_uni_doc, wn_imp_uno, wn_imp_dos, wn_imp_tre, wn_imp_cua, wn_imp_cin, wn_imp_sei, wn_imp_sie, wn_imp_och, wn_imp_nue, wn_imp_die, wn_imp_onc, wn_imp_doc, wn_imp_trc FROM nmloacum
	WHERE acu_keyemp = wn_key_emp
	AND acu_keycon = ws_key_con
	AND acu_keypro = wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
	IF (ws_acu_uno='S' ) THEN
	wn_uni_uno:=acu_uni_uno;
	wn_imp_uno:=acu_imp_uno;
	END IF;
	IF (ws_acu_dos='S' ) THEN
	wn_uni_dos:=acu_uni_dos;
	wn_imp_dos:=acu_imp_dos;
	END IF;
	IF (ws_acu_tre='S' ) THEN
	wn_uni_tre:=acu_uni_tre;
	wn_imp_tre:=acu_imp_tre;
	END IF;
	IF (ws_acu_cua='S' ) THEN
	wn_uni_cua:=acu_uni_cua;
	wn_imp_cua:=acu_imp_cua;
	END IF;
	IF (ws_acu_cin='S' ) THEN
	wn_uni_cin:=acu_uni_cin;
	wn_imp_cin:=acu_imp_cin;
	END IF;
	IF (ws_acu_sei='S' ) THEN
	wn_uni_sei:=acu_uni_sei;
	wn_imp_sei:=acu_imp_sei;
	END IF;
	IF (ws_acu_sie='S' ) THEN
	wn_uni_sie:=acu_uni_sie;
	wn_imp_sie:=acu_imp_sie;
	END IF;
	IF (ws_acu_och='S' ) THEN
	wn_uni_och:=acu_uni_och;
	wn_imp_och:=acu_imp_och;
	END IF;
	IF (ws_acu_nue='S' ) THEN
	wn_uni_nue:=acu_uni_nue;
	wn_imp_nue:=acu_imp_nue;
	END IF;
	IF (ws_acu_die='S' ) THEN
	wn_uni_die:=acu_uni_die;
	wn_imp_die:=acu_imp_die;
	END IF;
	IF (ws_acu_onc='S' ) THEN
	wn_uni_onc:=acu_uni_onc;
	wn_imp_onc:=acu_imp_onc;
	END IF;
	IF (ws_acu_doc='S' ) THEN
	wn_uni_doc:=acu_uni_doc;
	wn_imp_doc:=acu_imp_doc;
	END IF;
	IF (ws_acu_trc='S' ) THEN
	wn_uni_trc:=acu_uni_trc;
	wn_imp_trc:=acu_imp_trc;
	END IF;
	UPDATE nmloacum SET acu_uniuno=wn_uni_uno,acu_impuno=wn_imp_uno,acu_unidos=wn_uni_dos,acu_impdos=wn_imp_dos,acu_unitre=wn_uni_tre,acu_imptre=wn_imp_tre,acu_unicua=wn_uni_cua,acu_impcua=wn_imp_cua,acu_unicin=wn_uni_cin,acu_impcin=wn_imp_cin,acu_unisei=wn_uni_sei,acu_impsei=wn_imp_sei,acu_unisie=wn_uni_sie,acu_impsie=wn_imp_sie,acu_unioch=wn_uni_och,acu_impoch=wn_imp_och,acu_uninue=wn_uni_nue,acu_impnue=wn_imp_nue,acu_unidie=wn_uni_die,acu_impdie=wn_imp_die,acu_unionc=wn_uni_onc,acu_imponc=wn_imp_onc,acu_unidoc=wn_uni_doc,acu_impdoc=wn_imp_doc,acu_unitrc=wn_uni_trc,acu_imptrc=wn_imp_trc
	WHERE acu_keyemp = wn_key_emp
	AND acu_keycon = ws_key_con
	AND acu_keypro = wn_key_pro; COMMIT;
		END IF;
	END LOOP;
	sp_glfechor (wd_fec_act, ws_hor_act);
	UPDATE glcoresu SET res_numreg=wn_num_reg,res_fecfin=wd_fec_act,res_horfin=ws_hor_act,res_status='T'
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu
	AND res_fecini = wd_fec_act
	AND res_horreg = ws_hor_reg; COMMIT;
		END;
/
