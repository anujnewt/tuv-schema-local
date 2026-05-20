CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMLSTPTT" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	ws_pam_key VARCHAR2(4);
		ws_pam_cve VARCHAR2(6);
		ws_pam_nom VARCHAR2(50);
		ws_pam_ini VARCHAR2(16);
		ws_pam_fin VARCHAR2(16);
		ws_des_key VARCHAR2(40);
		ws_des_cve VARCHAR2(40);
		ws_des_nom VARCHAR2(60);
		ws_des_ini VARCHAR2(40);
		ws_des_fin VARCHAR2(40);
		ws_des_cor VARCHAR2(60);
		ws_tab_ant VARCHAR2(4);
		ws_des_lis VARCHAR2(50);
		ws_key_cam VARCHAR2(10);
		ws_des_etq VARCHAR2(10);
		ws_etq_001 VARCHAR2(10);
		ws_etq_002 VARCHAR2(10);
		ws_etq_003 VARCHAR2(10);
		ws_etq_004 VARCHAR2(10);
		ws_etq_005 VARCHAR2(10);
		ws_etq_006 VARCHAR2(40);
		ws_etq_007 VARCHAR2(40);
		ws_dsp_cam VARCHAR2(20);
		wn_dsp_001 NUMBER(5);
		wn_dsp_002 NUMBER(5);
		wn_dsp_003 NUMBER(5);
		wn_dsp_004 NUMBER(5);
		wn_dsp_005 NUMBER(5);
		wn_dsp_006 NUMBER(5);
		wn_tot_reg NUMBER(10);
		wn_num_reg NUMBER(10);
		wn_pct_reg NUMBER(6,2);
		wn_pct_act NUMBER(5);
		ws_hor_act VARCHAR2(8);
		ws_dia_act DATE;
		wn_num_tem NUMBER(10);
		BEGIN
	SELECT  COUNT(* ) alias1
	INTO wn_tot_reg FROM glcopams
	WHERE pam_keypar IN (
	SELECT pam_folini FROM glcopams
	WHERE pam_keypar='00')
	AND pam_keypar IN (
	SELECT ran_keypue FROM glwkrang
	WHERE ran_nomrep=ws_nom_rep
	AND ran_idepcc=ws_ide_pcc
	AND ran_keyusu=wn_key_usu
	AND ran_keypue IS NOT NULL );
		sp_glfechor(ws_dia_act, ws_hor_act);
	INSERT INTO glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_dia_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); COMMIT;
		DELETE FROM glwkcrys
	WHERE cry_nomrep=ws_nom_rep
	AND cry_idepcc=ws_ide_pcc
	AND cry_keyusu=wn_key_usu; COMMIT;
		ws_des_cor:='CORPORATIVO NO REGISTRADO';
	SELECT cor_razsoc
	INTO ws_des_cor FROM glcocorp;
		ws_des_lis:='No existe nombre del Reporte';
	SELECT lis_deslis
	INTO ws_des_lis FROM glcolist
	WHERE lis_keylis=ws_nom_rep;
		ws_etq_001:='........';
	ws_etq_002:='........';
	ws_etq_003:='........';
	ws_etq_004:='........';
	ws_etq_005:='........';
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor FROM glcocamp
	WHERE cam_keytab='glcopams' ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
	IF (ws_key_cam='pam_keypar' ) THEN
	ws_etq_001:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pam_cvesec' ) THEN
	ws_etq_002:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pam_nompar' ) THEN
	ws_etq_003:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pam_folini' ) THEN
	ws_etq_004:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pam_folfin' ) THEN
	ws_etq_005:=ws_des_etq;
	END IF;
		END IF;
		END IF;
		END IF;
		END IF;
	END LOOP;
	wn_dsp_001:=0;
	wn_dsp_002:=0;
	wn_dsp_003:=0;
	wn_dsp_004:=0;
	wn_dsp_005:=0;
	wn_dsp_006:=0;
	sp_glNewDsp('glcopams', 'pam_keypar', ws_key_men,wn_dsp_001);
	sp_glNewDsp('glcopams', 'pam_cvesec', ws_key_men,wn_dsp_002);
	sp_glNewDsp('glcopams', 'pam_nompar', ws_key_men,wn_dsp_003);
	sp_glNewDsp('glcopams', 'pam_folini', ws_key_men,wn_dsp_004);
	sp_glNewDsp('glcopams', 'pam_folfin', ws_key_men,wn_dsp_005);
	ws_tab_ant:='@@@';
	wn_num_reg:=0;
	wn_pct_act:=1;
	wn_pct_reg:=(wn_tot_reg/10.0);
	ws_etq_006:='Nada';
	FOR c_nmlstptt IN ( SELECT pam_keypar, pam_cvesec, pam_nompar, pam_folini, pam_folfin FROM glcopams
	WHERE pam_keypar IN (
	SELECT pam_folini FROM glcopams
	WHERE pam_keypar='00')
	AND pam_keypar IN (
	SELECT ran_keypue FROM glwkrang
	WHERE ran_nomrep=ws_nom_rep
	AND ran_idepcc=ws_ide_pcc
	AND ran_keyusu=wn_key_usu
	AND ran_keypue IS NOT NULL )
	ORDER BY pam_keypar,pam_cvesec ) LOOP
		ws_pam_key :=c_nmlstptt.pam_keypar;
			ws_pam_cve :=c_nmlstptt.pam_cvesec;
			ws_pam_nom :=c_nmlstptt.pam_nompar;
			ws_pam_ini :=c_nmlstptt.pam_folini;
			ws_pam_fin :=c_nmlstptt.pam_folfin;
			wn_num_reg:=(wn_num_reg+1);
	wn_num_tem:=(wn_pct_reg*wn_pct_act);
	IF (wn_num_reg>=wn_num_tem ) THEN
	UPDATE glcoresu SET res_numreg=wn_num_reg
	WHERE res_idepro=ws_nom_rep
	AND res_idepcc=ws_ide_pcc
	AND res_fecini=ws_dia_act
	AND res_keyusu=wn_key_usu
	AND res_horreg=ws_hor_reg; COMMIT;
		END IF;
	IF (ws_pam_key IS NULL ) THEN
	ws_etq_006:='No Existe Nombre ..';
	ws_etq_007:=0;
	 ELSE
	IF (ws_tab_ant!=ws_pam_key ) THEN
	ws_etq_006:='No Existe Nombre ..';
	ws_etq_007:=0;
	SELECT pam_nompar, pam_cvesec
	INTO ws_etq_006, ws_etq_007 FROM glcopams
	WHERE pam_keypar ='00'
	AND pam_folini=ws_pam_key;
		ws_tab_ant:=ws_pam_key;
	END IF;
		END IF;
	IF (wn_dsp_001=1 ) THEN
	ws_pam_key:=NULL;
	END IF;
	IF (wn_dsp_002=1 ) THEN
	ws_pam_cve:=NULL;
	END IF;
	IF (wn_dsp_003=1 ) THEN
	ws_pam_nom:=NULL;
	END IF;
	IF (wn_dsp_004=1 ) THEN
	ws_pam_ini:=NULL;
	END IF;
	IF (wn_dsp_005=1 ) THEN
	ws_pam_fin:=NULL;
	END IF;
		INSERT INTO glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr002,cry_chr015,cry_chr004,cry_chr005,cry_chr006,cry_chr007,cry_chr008,cry_chr009,cry_chr010,cry_chr011,cry_chr012,cry_chr013,cry_dat001,cry_chr014,cry_chr003)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,ws_pam_key,ws_pam_cve,ws_pam_nom,ws_pam_ini,ws_pam_fin,ws_etq_006,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_hor_act,ws_dia_act,ws_etq_007,ws_des_lis); COMMIT;
	END LOOP;
	sp_glfechor(ws_dia_act, ws_hor_act);
	UPDATE glcoresu SET res_numreg=wn_num_reg,res_fecfin=ws_dia_act,res_horfin=ws_hor_act,res_status='T'
	WHERE res_idepro=ws_nom_rep
	AND res_idepcc=ws_ide_pcc
	AND res_keyusu=wn_key_usu
	AND res_fecini=ws_dia_act
	AND res_horreg=ws_hor_reg; COMMIT;
		END;
/
